Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A3FD27.6060400@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	 <20041123033429.132bf84b.henryk@ploetzli.ch>	 <41A2B331.4010001@xmission.com>	 <20041123070621.50569968.henryk@ploetzli.ch>	 <41A3471C.4000602@xmission.com>	 <20041123203836.046fb4f4.henryk@ploetzli.ch>	 <41A3ACE2.4030501@xmission.com> <1101246735.27351.45.camel@pegasus>
In-Reply-To: <1101246735.27351.45.camel@pegasus>
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
Date: Tue, 23 Nov 2004 20:16:55 -0700

Guys,

If I'm understanding right, the payload should include the sbc_info 
header. I thought all along that was just for the purpose of storing the 
sbc in a file, but it sounds like the headset needs it.

Is this closer? It doesn't sound right yet, but maybe we really do need 
to load up the packet to be closer to the mtu in order for the headset 
to be happy.

                 memcpy(buf + sizeof(packet_header), &payload_header, 
sizeof(payload_header));
-               size = read(fd, buf + sizeof(packet_header) + 
sizeof(payload_header), frame_len);
+               memcpy(buf + sizeof(packet_header) + 
sizeof(payload_header), &sbc_info, sizeof(sbc_info));
+               size = read(fd, buf + sizeof(packet_header) + 
sizeof(payload_header) + sizeof(sbc_info), frame_len);
                 seq_num++;
                 if (size != frame_len) {
                         terminate = 1;
                 } else {
-                       write(streamfd, buf, size + 
sizeof(packet_header) + sizeof(payload_header));
+                       write(streamfd, buf, size + 
sizeof(packet_header) + sizeof(payload_header) + sizeof(sbc_info));
                 }

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
