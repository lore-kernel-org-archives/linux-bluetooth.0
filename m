Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN between BlueZ and WindowsXP SP 2
From: Marcel Holtmann <marcel@holtmann.org>
To: "Pering, Trevor" <trevor.pering@intel.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   "Light, John" <john.light@intel.com>
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA938703F60CE5@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA938703F60CE5@scsmsx401.amr.corp.intel.com>
Content-Type: multipart/mixed; boundary="=-0VK2vHgyEDoDAkym8r9d"
Message-Id: <1091088059.12651.16.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Jul 2004 10:00:59 +0200


--=-0VK2vHgyEDoDAkym8r9d
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi John,

> The problem is that after successful connection between the Windows
> Bluetooth stack and the Linux Bluez stack, no packets from the device
> ever reach the PC running Windows XP Service Pack 2.  That is, a ping
> from the PC never receives a response, and a ping from BlueZ never
> reaches the PC (as shown by the PC packet statistics.)  Linux packet
> statistics (ifconfig) show that PC packets are received, but all return
> traffic seems to be routed over the lo interface.
> 
> Immediately after creating the BNEP connection with Bluez, the Windows
> Bluetooth stack sends a BNEP_FILTER_NET_TYPE_SET_MSG with an effective
> length of zero.  Bluez interprets this message (in
> bluetooth/bnep/core.c) to mean that no filter ranges should be allowed.
> Specifically, the code in bnep_ctrl_set_netfilter zeros the first entry
> in the filter list, which is interpreted by bnep_net_proto_filter in
> netdev.c as meaning that no ranges of acceptable packets are available.
> This interpretation leads to all packets being rejected by BNEP.
> 
> The Bluetooth BNEP specification clearly states the following:
> 
> The length (in octets) of this message is 4+4*N, where N is the number
> of disjoint ranges of Networking protocol types that form the complete
> set. Note that N=0 (empty set) denotes a reset to default filters (if
> any) supported by the remote device. 
> 
> Instead of resetting to default filters, Bluez eliminates all filters,
> disallowing all traffic.
> 
> Since the proper solution involves reorganizing the default filter
> initialization code, I am leaving to more capable hands the actual code
> changes to make the code operate according to the specification.
> 
> I supply the following one line hack for those interested in running
> with the Windows Bluetooth stack until the proper fix is available.
> Change the line in bnep_ctrl_set_netfilter from
> 
>             if (i < BNEP_MAX_PROTO_FILTERS)
> 
> to
> 
>             if (i > 0 && i < BNEP_MAX_PROTO_FILTERS)
> 
> 
> This works as long as explicit filters have not previously overridden
> the defaults.

why do you need a workaround like this ;)

The proper fix is not really hard, because we already set the default
filters at device creation and we only have to redo this here if N=0. A
patch for that is attached. Please report back if this work for you.

Regards

Marcel


--=-0VK2vHgyEDoDAkym8r9d
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

===== net/bluetooth/bnep/core.c 1.30 vs edited =====
--- 1.30/net/bluetooth/bnep/core.c	2004-07-26 19:46:35 +02:00
+++ edited/net/bluetooth/bnep/core.c	2004-07-29 09:46:45 +02:00
@@ -61,7 +61,7 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "1.0"
+#define VERSION "1.1"
 
 static LIST_HEAD(bnep_session_list);
 static DECLARE_RWSEM(bnep_session_sem);
@@ -113,6 +113,23 @@
 	return bnep_send(s, &rsp, sizeof(rsp));
 }
 
+#ifdef CONFIG_BT_BNEP_PROTO_FILTER
+static inline void bnep_set_default_proto_filter(struct bnep_session *s)
+{
+	memset(s->proto_filter, 0, sizeof(struct bnep_proto_filter) * BNEP_MAX_PROTO_FILTERS);
+
+	/* (IPv4, ARP)  */
+	s->proto_filter[0].start = htons(0x0800);
+	s->proto_filter[0].end   = htons(0x0806);
+	/* (RARP, AppleTalk) */
+	s->proto_filter[1].start = htons(0x8035);
+	s->proto_filter[1].end   = htons(0x80F3);
+	/* (IPX, IPv6) */
+	s->proto_filter[2].start = htons(0x8137);
+	s->proto_filter[2].end   = htons(0x86DD);
+}
+#endif
+
 static int bnep_ctrl_set_netfilter(struct bnep_session *s, u16 *data, int len)
 {
 	int n;
@@ -131,18 +148,21 @@
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 	n /= 4;
 	if (n <= BNEP_MAX_PROTO_FILTERS) {
-		struct bnep_proto_filter *f = s->proto_filter;
-		int i;
+		if (n > 0) {
+			struct bnep_proto_filter *f = s->proto_filter;
+			int i;
+
+			for (i = 0; i < n; i++) {
+				f[i].start = get_unaligned(data++);
+				f[i].end   = get_unaligned(data++);
 
-		for (i = 0; i < n; i++) {
-			f[i].start = get_unaligned(data++);
-			f[i].end   = get_unaligned(data++);
-
-			BT_DBG("proto filter start %d end %d",
-				f[i].start, f[i].end);
-		}
-		if (i < BNEP_MAX_PROTO_FILTERS)
-			memset(f + i, 0, sizeof(*f));
+				BT_DBG("proto filter start %d end %d",
+							f[i].start, f[i].end);
+			}
+			if (i < BNEP_MAX_PROTO_FILTERS)
+				memset(f + i, 0, sizeof(*f));
+		} else
+			bnep_set_default_proto_filter(s);
 
 		bnep_send_rsp(s, BNEP_FILTER_NET_TYPE_RSP, BNEP_SUCCESS);
 	} else {
@@ -547,18 +566,9 @@
 	
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 	/* Set default protocol filter */
-
-	/* (IPv4, ARP)  */
-	s->proto_filter[0].start = htons(0x0800);
-	s->proto_filter[0].end   = htons(0x0806);
-	/* (RARP, AppleTalk) */
-	s->proto_filter[1].start = htons(0x8035);
-	s->proto_filter[1].end   = htons(0x80F3);
-	/* (IPX, IPv6) */
-	s->proto_filter[2].start = htons(0x8137);
-	s->proto_filter[2].end   = htons(0x86DD);
+	bnep_set_default_proto_filter(s);
 #endif
-	
+
 	err = register_netdev(dev);
 	if (err) {
 		goto failed;

--=-0VK2vHgyEDoDAkym8r9d--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
