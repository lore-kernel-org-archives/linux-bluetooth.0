Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Didier Alves" <dsas@mega.ist.utl.pt>
To: <bluez-devel@lists.sourceforge.net>
Message-ID: <000c01c3fc6b$95a62620$318388c1@zedidas>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [Bluez-devel] Widcomm BlueConnect and Bluez
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
Date: Thu, 26 Feb 2004 13:22:24 -0000

Hi,

Does anybody tried to connect a TDK CSR usb dongle using bluez and a PDA
with Widcomm Blueconnect 3.0 springboard? I can create rfcomm links
without any problem but after some time (2-10 seconds) the springboard
stop receiving data. The problem occurs when I try to send a stream of
data from the PC with bluez. It looks like there is a buffer overrun on
the receiver. I know that the problem is from the PDA but since that
Widcomm stopped working on BlueConnect, I can't get any help from them.
So if anybody has any ideia about what the problem is and how to resolve
it, please help.

Thanks.

Didier




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
