Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Matthias =?utf-8?b?QnJ1bsOp?= <matthiasbrune@gmx.de>
Message-ID: <loom.20050125T171228-190@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Bypass for L2CAP packets
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
Date: Tue, 25 Jan 2005 16:25:45 +0000 (UTC)

Hi, 

I removed the the l2cap module by using:
1. rmmod -w (-f) l2cap
2. modprobe -r l2cap

But after starting my program it is always reloaded.
Is there any other command that prevents this reloading permanently?

Many thanks

Matthias


The Trace:
L2CAP
In/Out: From own program to mobile phone
L2CAP: (Logical Link Control and Adaptation Protocol)
	Length: 0x0008 (8 bytes)
	CID: 0x0001 (Signalling Channel)
	Code: 0x02 (Connection Request)
		Identifier: 0x01
		Length: 0x0004 (4 bytes)
		PSM: 0x0003 (RFCOMM)
		Source CID: 0x005d (Connection-oriented Data Channel)
	DataDump:
	08 00 01 00 02 01 04 00 03 00 5d 00               ..........].

L2CAP
In/Out: Incoming from phone
L2CAP: (Logical Link Control and Adaptation Protocol)
	Length: 0x000c (12 bytes)
	CID: 0x0001 (Signalling Channel)
	Code: 0x03 (Connection Response)
		Identifier: 0x01
		Length: 0x0008 (8 bytes)
		Destination CID: 0x0040 (Connection-oriented Data Channel)
		Source CID: 0x005d (Connection-oriented Data Channel)
		Result: 0x0000 (Connection successful)
		Status: 0x0000 (No further information available)
	DataDump:
	0c 00 01 00 03 01 08 00 40 00 5d 00 00 00 00 00   ........@.].....

L2CAP
In/Out: Incoming from phone
L2CAP: (Logical Link Control and Adaptation Protocol)
	Length: 0x000c (12 bytes)
	CID: 0x0001 (Signalling Channel)
	Code: 0x04 (Configuration Request)
		Identifier: 0x0e
		Length: 0x0008 (8 bytes)
		Destination CID: 0x005d (Connection-oriented Data Channel)
		Flags: .... ...0 [Not set] (Continuation flag not set)
		Option Type: .000 0001 [0x1] (Maximum Transmission Unit (MTU))
			Option Type: 0... .... [Not set] (Option must be 
recognized; refuse the configuration request)
			Length: 0x02 (2 bytes)
			Maximum Transmission Unit: 0x8004 (32772 bytes)
	DataDump:
	0c 00 01 00 04 0e 08 00 5d 00 00 00 01 02 04 80   ........].......

L2CAP
In/Out: From BlueZ to mobile phone
L2CAP: (Logical Link Control and Adaptation Protocol)
	Length: 0x0006 (6 bytes)
	CID: 0x0001 (Signalling Channel)
	Code: 0x01 (Command Reject)
		Identifier: 0x01
		Length: 0x0002 (2 bytes)
		Reason: 0x0000 (Command not understood)
	DataDump:
	06 00 01 00 01 01 02 00 00 00                     ..........

L2CAP
In/Out: From BlueZ to mobile phone
L2CAP: (Logical Link Control and Adaptation Protocol)
	Length: 0x0006 (6 bytes)
	CID: 0x0001 (Signalling Channel)
	Code: 0x01 (Command Reject)
		Identifier: 0x0e
		Length: 0x0002 (2 bytes)
		Reason: 0x0000 (Command not understood)
	DataDump:
	06 00 01 00 01 0e 02 00 00 00                     ..........




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
