Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BasiliX-1.1.0-110650969041f3ff7a67af4@postaci.ug.bilkent.edu.tr>
From: <farukk@ug.bilkent.edu.tr>
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] help probable l2cap problems
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
Date: Sun, 23 Jan 2005 21:48:10 EET


im really sorry if this is a duplicate but i could not find anything on the web about my problem,
my main aim is to send a few bytes of data over bluetooth and decided to use Bluez. i am using mandrake 9.2 (kernel 2.4.22) and downloaded the bluez libs utils and everything from www.bluez.org, installed them regarding the README files included in the packages. now i have two Ericsson BT development Kits attached via usb to my toshiba satellite a15. hciconfig tells that both of them are up and i can connect them to eachother using hcitool. to accomplish my main goal, i decided to use the l2test.c file in the directory bluez-utils-2.14/test. The file first did not compile (with error undefined ref. to str2ba) but i did a gcc l2test.c -lbluetooth and it did compile. now when i try to run the executable i get the following error:

l2test[3255]: Can't create socket: No such file or directory (2)

why does this happen and can anybody help me please.

Another thing is that i need a beginner's guide to programming with bluez, if any of you have any link for such a source(examples) please inform me, i would be grateful.
Sorry for being a newbie :)
--  
Ömer Faruk KAYA
Bilkent University
EE - 4


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
