Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: <bluez-devel@lists.sourceforge.net>
Date: Tue, 12 Feb 2008 17:01:20 +0100
Message-ID: <000e01c86d90$827b5c60$87721520$@de>
MIME-Version: 1.0
Subject: [Bluez-devel] FW: Loss concealment with SBC codec
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Dear developers,

I am considering to include the BlueZ SBC codec into Ekiga in order to
support music over Internet Telephony. I have not understood the SBC codec
fully therefore I need a clarification on the following issues.

If the CRC8 is wrong, does sbc_decode function conceals the lost frame? If
not, did you hear anything about a packet loss concealment algorithm for
SBC? Any work on that?

Thanks for your help

 Christian Hoene



--------------------------------------------------------
Dr.-Ing. Christian Hoene
Computer Networks and Internet, University of T=FCbingen
Sand 13, 72076 T=FCbingen, Germany, Phone +49 7071 2970532
http://net.informatik.uni-tuebingen.de/~hoene




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
