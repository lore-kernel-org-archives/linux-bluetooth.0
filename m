Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] AVDTP socket?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1100883199.7213.27.camel@pegasus>
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>
	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>
	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>
	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>
	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>
	 <cbf0aec9041118052714481128@mail.gmail.com>
	 <1100822368.7164.98.camel@pegasus>  <419DB6E1.8000203@xmission.com>
	 <1100864484.7213.19.camel@pegasus>  <419E20C3.7@xmission.com>
	 <1100883199.7213.27.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-LxEMjgy/pELEVww4BTaK"
Message-Id: <1100885959.7213.31.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 19 Nov 2004 18:39:19 +0100


--=-LxEMjgy/pELEVww4BTaK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Brad,

> > I still have to break the stream into chunks and put the payload header 
> > on them (a2dp p.24).
> 
> but the boundary don't cares. I see that in the trace. You can break the
> SBC file where you want and add the media header.

actually like with the attached patch. Most of the example *.sbc files
are working. Some of them are not working and this is maybe because the
frame header information don't matches the SBC configuration. Or maybe
hcidump is decoding this wrong.

Regards

Marcel


--=-LxEMjgy/pELEVww4BTaK
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: a2play.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/a2play.c,v
retrieving revision 1.10
diff -u -r1.10 a2play.c
--- a2play.c	19 Nov 2004 08:50:54 -0000	1.10
+++ a2play.c	19 Nov 2004 17:32:36 -0000
@@ -285,7 +285,7 @@
   return psm;
 }
 
-int do_connect(char *svr, int psm, int linger, int reliable)
+int do_connect(char *svr, int psm, int linger, int reliable, uint16_t *mtu)
 {
   struct sockaddr_l2 rem_addr, loc_addr;
   struct l2cap_options opts;
@@ -359,6 +359,9 @@
   fprintf(stderr, "Connected [imtu %d, omtu %d, flush_to %d]\n",
          opts.imtu, opts.omtu, opts.flush_to);
   
+  if (mtu)
+    *mtu = opts.omtu;
+
   return s;
 }
 
@@ -482,6 +485,7 @@
   bdaddr_t local;
   bdaddr_t bdaddr;
   int psm_cmd, psm_stream;
+  uint16_t mtu, seq_num;
 
   char *addrstr;
   char *filename;
@@ -538,7 +542,7 @@
   sigaction(SIGCHLD, &sa, NULL);
   sigaction(SIGPIPE, &sa, NULL);
   
-  s = do_connect(addrstr, psm_cmd, 0, 0);
+  s = do_connect(addrstr, psm_cmd, 0, 0, NULL);
   if(s < 0) {
     fprintf(stderr, "cannot open psm_cmd = %d\n", psm_cmd);
     exit(-1);
@@ -572,7 +576,8 @@
 
   // open the stream l2cap
 
-  streamfd = do_connect(addrstr, psm_stream, 0, 0);
+  mtu = 48;
+  streamfd = do_connect(addrstr, psm_stream, 0, 0, &mtu);
   if(streamfd < 0) {
     fprintf(stderr, "cannot open psm_stream = %d\n", psm_stream);
     exit(-1);
@@ -607,16 +612,38 @@
 
   char buf[BUFS];
 
+  if (mtu > BUFS)
+    mtu = BUFS;
+
   // TODO remove
-  terminate = 1;
+  terminate = 0;
+
+  seq_num = 1;
+  memset(buf, 0, 12);
+  buf[0] = 0x80;
+  buf[2] = seq_num >> 8;
+  buf[3] = seq_num & 0xff;
+  buf[12] = 0x0ff;
+  buf[13] = 0x0ff;
+  memcpy(buf + 14, &sbc_info, sizeof(sbc_info));
+  size = read(fd, buf + 14 + sizeof(sbc_info), mtu - sizeof(sbc_info) - 14);
+  write(streamfd, buf, size + 14 + sizeof(sbc_info));
+  seq_num++;
 
   while(!terminate) {
-    size = read(fd, &buf, BUFS);
+    memset(buf, 0, 12);
+    buf[0] = 0x80;
+    buf[2] = seq_num >> 8;
+    buf[3] = seq_num & 0xff;
+    buf[12] = 0xff;
+    buf[13] = 0xff;
+    size = read(fd, buf + 14, mtu - 14);
+    seq_num++;
     if(size <= 0) {
       terminate = 1;
     } else {
       // framing, fragmenting, a2dp headers: avdtp p.45 and a2dp spec p.23
-      write(streamfd, buf, size);
+      write(streamfd, buf, size + 14);
     }
   }
 

--=-LxEMjgy/pELEVww4BTaK--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
