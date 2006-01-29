Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43DD1E98.5010907@darkmetatron.de>
From: =?UTF-8?B?U2ViYXN0aWFuIEJlw59sZXI=?= <webmaster@darkmetatron.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <4348E48C.5070305@darkmetatron.de>
In-Reply-To: <4348E48C.5070305@darkmetatron.de>
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] Boot Protocol Problem with Microsoft Keyboard/Mouse
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 29 Jan 2006 20:59:20 +0100

Hello,

I bought myself the Microsoft Optical Desktop Elite for Bluetooth
Package with Keyboard and Mouse some time ago. At first I had some
Problems with "boot-protocol-only" until somebody told me to apply the
patch. After that all works nearly perfect. But now I upgraded to Kernel
2.6.15 and I can't find the kernelpatch for that. First I thought that
maybe it was applied to the kernel-tree and build the Kernel with my old
config.

But now I'm there were I started:

DarkMetatron metatron # hidd
00:0D:3A:A2:92:28 HID Boot Device [045e:0099] connected [boot-protocol]

I have tried it both with an older ALLNET ALL1575 and the brand-new
Microsoft Bluetooth Tranciever 2.0 that was shipped with the package.

My question now is:
Is there a kernel-patch to come for 2.6.15 or what should/could I do to
get it work again? I don't wanna downgrade to <2.6.15 if it isn't really
necessary.

Greetings

Sebastian Be=C3=9Fler





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
