Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <419E805D.7010503@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] AVDTP socket?
References: <418DB442.2050801@uen.org> <41925793.3050404@xmission.com>	 <1100113055.25879.73.camel@pegasus> <419543B3.8050601@xmission.com>	 <1100306337.7349.29.camel@pegasus> <41957BC1.507@xmission.com>	 <1100351199.7349.50.camel@pegasus> <41970F25.4020902@xmission.com>	 <1100446172.21403.16.camel@pegasus> <419B7292.9080706@xmission.com>	 <cbf0aec9041118052714481128@mail.gmail.com>	 <1100822368.7164.98.camel@pegasus>  <419DB6E1.8000203@xmission.com>	 <1100864484.7213.19.camel@pegasus>  <419E20C3.7@xmission.com>	 <1100883199.7213.27.camel@pegasus>  <1100885959.7213.31.camel@pegasus>	 <1100897144.7213.63.camel@pegasus>  <419E6AD8.7050104@xmission.com> <1100901846.7213.101.camel@pegasus>
In-Reply-To: <1100901846.7213.101.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 19 Nov 2004 16:23:09 -0700

Marcel,

Shouldn't this work to send the header in a separate write() and have a 
struct for it?

I thought everything ended up being little-endian on the wire, but

     buf[2] = seq_num >> 8;
     buf[3] = seq_num & 0xff;

looks big endian to me (00 then 01 for 0x0001). When my code writes to 
sequence_number, it comes out little endian (01 then 00 for 0x0001).

Brad

    while(!terminate) {
-    memset(buf, 0, 12);
-    buf[0] = 0x80;
-    buf[2] = seq_num >> 8;
-    buf[3] = seq_num & 0xff;
-    buf[12] = 0xff;
-    buf[13] = 0xff;
-    size = read(fd, buf + 14, mtu - 14);
+    memset(&packet_header, 0, sizeof(packet_header));
+    packet_header.cc = 8;
+    packet_header.sequence_number = htobs(seq_num);
+    packet_header.csrc[0] = htobl(0xffff0000);
+
+    //    dump_packet(&packet_header, sizeof(packet_header)); exit(0);
+
+    size = read(fd, buf, mtu - sizeof(packet_header));
      seq_num++;
      if(size <= 0) {
        terminate = 1;
      } else {
-      // framing, fragmenting, a2dp headers: avdtp p.45 and a2dp spec p.23
-      write(streamfd, buf, size + 14);
+      // avdtp p.45
+      write(streamfd, &packet_header, sizeof(packet_header));
+      // what about framing, fragmenting, a2dp headers (a2dp spec p.23)
+      write(streamfd, buf, size);
      }
    }
    close(fd);



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
