Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3E6E22B3.8E6E87FA@esk.fhg.de>
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
References: <5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030306125429.02687aa0@mail1.qualcomm.com>
	<5.1.0.14.2.20030307165419.01bb5668@mail1.qualcomm.com>
Subject: [Bluez-devel] Support for Clock offset event
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 Mar 2003 18:53:55 +0100
Content-Type: multipart/mixed; boundary="=-5sAek87oPuTZ73gqRVHa"


--=-5sAek87oPuTZ73gqRVHa
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mailgw2.fraunhofer.de id h2BHrxc10396
Content-Type: text/plain; CHARSET=iso-8859-1

Hello,

I added support for the clock offset event to bluez-kernel. The
attached patch is very simple and applies cleanly to bluez-kernel-2.3.
If you like, you can commit it. Then bluez gets one more step more
complete.
The clock information in the corresponding
entry of the inquiry cache is updated in case of a clock offset event.

Clock offset is important for very fast connection establishment.

Regards

--=20
Fraunhofer Einrichtung f=FCr Systeme der Kommunikationstechnik (ESK)

Wolfgang Heidrich        	  	Hansastra=DFe 32
Dipl.-Ing.                      	80686 M=FCnchen / Germany
                                  	Phone :  +49(0)89-547088-376
E-Mail: wolfgang.heidrich@esk.fhg.de   	Fax   :  +49(0)89-547088-221
--=-5sAek87oPuTZ73gqRVHa
Content-Disposition: inline; filename="patch_clk_offset"
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; CHARSET=us-ascii; NAME=patch_clk_offset

diff -Naur bluez-kernel-2.3/core/hci_event.c bluez-kernel-2.3-new/core/hci_event.c
--- bluez-kernel-2.3/core/hci_event.c	Fri Nov  1 18:48:51 2002
+++ bluez-kernel-2.3-new/core/hci_event.c	Tue Mar 11 18:28:31 2003
@@ -711,6 +711,28 @@
 	hci_dev_unlock(hdev);
 }
 
+/* New clock offset */
+static inline void hci_clock_offset_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	evt_clock_offset *eco=(evt_clock_offset *) skb->data;
+	struct hci_conn *conn = NULL;
+	__u16 handle = __le16_to_cpu(eco->handle);
+        struct inquiry_entry *e;
+
+	BT_DBG("%s status %d", hdev->name, eco->status);
+
+	hci_dev_lock(hdev);
+
+	conn = conn_hash_lookup_handle(hdev, handle);
+	if (conn && (!eco->status) && ( e = inquiry_cache_lookup(hdev, &conn->dst) ) ) {
+	/* update only existing entries, because we only get the clock offset without further information */
+		e->info.clock_offset=eco->offset;
+		e->timestamp = jiffies;
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	hci_event_hdr *he = (hci_event_hdr *) skb->data;
@@ -757,6 +779,10 @@
 
 	case EVT_ENCRYPT_CHANGE:
 		hci_encrypt_change_evt(hdev, skb);
+		break;
+
+	case EVT_CLOCK_OFFSET:
+		hci_clock_offset_evt(hdev, skb);
 		break;
 
 	case EVT_CMD_STATUS:
diff -Naur bluez-kernel-2.3/include/hci.h bluez-kernel-2.3-new/include/hci.h
--- bluez-kernel-2.3/include/hci.h	Fri Nov  1 18:48:51 2002
+++ bluez-kernel-2.3-new/include/hci.h	Tue Mar 11 18:30:15 2003
@@ -567,6 +567,14 @@
 } __attribute__ ((packed)) evt_link_key_notify;
 #define EVT_LINK_KEY_NOTIFY_SIZE 23
 
+#define EVT_CLOCK_OFFSET	0x1C
+typedef struct {
+	__u8	status;
+	__u16	handle;
+	__u16	offset;
+} __attribute__ ((packed)) evt_clock_offset;
+#define EVT_CLOCK_OFFSET_SIZE 5
+
 #define EVT_READ_REMOTE_FEATURES_COMPLETE 0x0B
 typedef struct {
 	__u8    status;

--=-5sAek87oPuTZ73gqRVHa--
