Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Message-ID: <000301c3f191$14e80dd0$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-devel] Missing data in ACL packets from CSR chip
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
Date: Thu, 12 Feb 2004 09:53:11 -0800

I posted the following message in a CSR forum yesterday and haven't =
received
a response yet. So I thought I'd try this list because there seems to be
some CSR experience here.

I'm 99% certain it's a bug in CSR firmware or hardware... So that's why =
I
didn't post it here in the first place.

Has anyone seen this kind of behaviour with CSR chips?

-Daryl.

----------Original message below----------

Hi,

Not sure if this is the right list, but I'll try anyway. :)

I'm testing a Taiyo Yuden bluetooth module (EYSF2CAXX) running HCI =
firmware
16.4 in our application. I opened up a damaged one, and the CSR chip is
labeled:
CSR
BC212
015BE
306AG

It appears that some ACL packets sent from the module to the host are
missing data. I've checked that it is not a UART overrun problem in the =
host
by sniffing the HCI link with another PC and decoding the packets by =
hand.
Both the host and the sniffing PC show the same corruption.

The module is connected to a UART with hardware flow control (automated =
in
the UART's hardware) at 921600bps. The sniffer doesn't have any flow
control. I see the problem when the there are multiple RFCOMM =
connections
with large amounts of data being sent to the remote devices. I haven't =
seen
the problem if the data rate is lowered to 460800bps.

The result of the lost data is that the host looses sync with the HCI =
data,
and then bad things happen...

Below is a data dump from the sniffing PC (this is just data from the =
module
to the host):

0536640 01 2d 00 01 00 04 13 05 01 2d 00 03 00 02 2d 20
0536660 09 00 05 00 40 00 21 ff 01 03 9c 04 13 05 01 2d
0536700 00 02 00 04 13 05 01 2d 00 01 00 04 13 05 01 2d
0536720 00 03 00 04 13 05 01 2d 00 01 00 04 13 05 01 2d
0536740 00 01 00 04 13 05 01 2d 00 01 00 04 13 05 01 2d
0536760 00 01 00 04 13 05 01 2d 00 02 00 04 13 05 01 2d
0537000 00 01 00 04 13 05 01 2d 00 01 00 02 2d 20 09 00
0537020 05 00 40 00 21 ff 01 01 9c 02 2d 20 09 00 05 00
0537040 40 00 21 ff 01 9c 02 2d 20 09 00 05 00 40 00 21
0537060 ff 01 03 9c 04 13 05 01 2d 00 01 00 04 13 05 01
0537100 2d 00 01 00 04 13 05 01 2d 00 01 00 04 13 05 01
0537120 2d 00 01 00 02 2d 20 08 00 04 00 40 00 21 53 01
0537140 49 04 13 05 01 2d 00 01 00 04 13 05 01 2d 00 01
0537160 00 02 2d 20 08 00 04 00 40 00 03 73 01 d7 04 13
0537200 05 01 2d 00 01 00 02 2d 20 0c 00 08 00 01 00 07
0537220 03 04 00 56 00 40 00

I just noticed that the index is octal... sorry about that.

Here's my decode:

Starting at index 536645:

0536645: 04 13 05 01 2d 00 03 00
HCI event: Number of completed packets

0536655: 02 2d 20 09 00 05 00 40 00 21 ff 01 03 9c
Valid ACL data packet.

0536673 - 0537012
More Number of completed packets events

0537013: 02 2d 20 09 00 05 00 40 00 21 ff 01 01 9c
Valid ACL data packet

0537031: 02 2d 20 09 00 05 00 40 00 21 ff 01 9c 02
Corrupt packet.

The 02 at the end of the packet above is really the start of another ACL
data packet. It is at this point that the stack on the host complains =
about
unkonwn HCI packet types: 2d, 20, 09, 00, 05, etc.

Just to be clear, the above data was captured on a separate PC from the =
one
running the stack. The stack's HCI sniff log and it's HCI error messages
match exactly with the above data. It is extremely unlikely that both
machines would overrun at exactly the same place. The UART on the host
doesn't show any overrun errors.

Is this a known problem? And is there any workaround?

Thanks,

-Daryl.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
