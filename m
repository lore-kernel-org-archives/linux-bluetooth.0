Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
To: bluez-devel@lists.sourceforge.net
Cc: Thor Egil Skaug <tskaug@eecs.wsu.edu>
Content-Type: text/plain
Message-Id: <1077562741.3445.17.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] [Fwd: hci_sock.c problem]
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 10:59:01 -0800

-----Forwarded Message-----
From: Thor Egil Skaug <tskaug@eecs.wsu.edu>
To: maxk@qualcomm.com
Subject: hci_sock.c problem
Date: Sat, 21 Feb 2004 14:14:53 -0800

Maxim,

Please reply to this message only if you have time.

I am a graduate student at Washington State University, and I am doing
some research on Bluetooth.
What I am currently trying to do is use your hci_sock implementation
with a Belkin USB device, sort of in the
same way as the BlueZ-HCITool package uses it.

This works fine, to some extent, but I have a few questions.

I recently installed the linux 2.6.3 kernel, and it seems as though the
version of hci_sock.c there is 1.4.
However, I have found version 1.5 on the internet. Which is the latest
release, and what kernel patch of BlueZ should I use
to get this?

The problem occurs when I want to send some hci commands through the
socket. The hci_sec_filter filters out a lot of them.
What is the purpose of this? For example, it filters out the HCI_Reset
command in 1.4, but not in 1.5, as far as I can read from the code.

Also, I noticed that the OGF_STATUS commands seem to be filtered out in
version 1.5, but not 1.4. This means that HCI_Read_Link_Quality, and
HCI_Read_RSSI are not possible anymore. Why? This is of importance to
me, since my research area is on adaptation and compensation in wireless
networks.

The reason for this email is really to figure out which is the latest
stable release of BlueZ, and if it does not include what I need, I will
go and remove the security filter from it.

Thanks,

Thor Egil Skaug
M.S. student, Washington State University




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
