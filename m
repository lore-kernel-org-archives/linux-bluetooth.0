Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45A56361.5000004@odi.ch>
Date: Wed, 10 Jan 2007 23:06:25 +0100
From: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Mighty Mouse
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Dear hackers,

The scroll ball of my Bluetooth Mighty Mouse doesn't seem to work as it 
should. As I understand the kernel/bluez architecture it is the job of 
hidd to translate the data from the mouse into button events. Therefore 
hidd would be the place to make the appropriate quirks.

I see that there are specific quirks for the USB version of the Mighty 
Mouse in the Kernel (usbhid.c, hid-core.c). But I don't see a way how 
those could possibly be used for the bt version, as they are enabled by 
looking at the USB device ID.

Can you enlighten me as to if I am correct in my assumptions?

Cheers

Ortwin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
