Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Stephane Travostino <neuromancer@paranoici.org>
Message-ID: <loom.20060210T014446-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Motorola V620 phone and bluetooth PIN pairing
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
Date: Fri, 10 Feb 2006 01:08:26 +0000 (UTC)

Hello,
I have a Motorola V620 phone which provides Bluetooth support, and a working
Bluetooth USB dongle.
Phone -> PC and PC -> Phone transfers work correctly, but whenever I try to
create a rfcomm connection to the phone, I get a "Connection refused" error
message.
This is how I setup the RFCOMM:

$ sudo rfcomm bind 0 00:15:A8:3B:EA:F0 1
$ sudo rfcomm
rfcomm0: 00:15:A8:3B:EA:F0 channel 1 clean

When I try to do a simple command on /dev/rfcomm0 the command freezes, or 
I get a "connection refused" message.

$ echo AT > /dev/rfcomm0
(After waiting some time, I press Ctrl-C)
bash: /dev/rfcomm0: Interrupted system call

or

$ cat /dev/rfcomm0
cat: /dev/rfcomm0: Connection refused

I tried to do a hcidump and it stucks on the line:

-> HCI Event: Link Key Request (0x17) plen 6

when the command freezes, or

-> HCI Event: Link Key Request (0x17) plen 6
<- HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
-> HCI Event: Command Complete (0x0e) plen 10
-> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
<- ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
<- ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
-> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
<- ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
-> HCI Event: Number of Completed Packets (0x13) plen 5
-> HCI Event: Number of Completed Packets (0x13) plen 5
-> HCI Event: Number of Completed Packets (0x13) plen 5
-> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
-> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Command rej: reason 2 dcid 0x0040 scid 0x0040
      Invalid CID in request
<- HCI Command: Disconnect (0x01|0x0006) plen 3
-> HCI Event: Command Status (0x0f) plen 4
-> HCI Event: Disconn Complete (0x05) plen 4

when the connection gets refused.

The only way to make it working is to remove the detected computer on the phone,
and execute the command (echo, cat, wvdial, whatever) so the phone asks you the
pairing PIN (because once asked, the phone saves it and doesn't ask you anymore,
and no way to change this behaviour).

The strange thing is that if I run wvdial many times, I don't have to do this,
but I can't run multiple times the "echo AT > /dev/rfcomm0" without repairing
the devices.

On Windows I can make it work without any problem.

My configuration is the following:
rfcomm 2.20
bluez-utils 2.20-0ubuntu3
Kernel 2.6.12-10-386
Ubuntu 5.10 Breezy Badger

Thanks, and sorry for my bad English :-)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
