Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050713170258.12182.qmail@web33507.mail.mud.yahoo.com>
From: Vinod <geekvinod@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Obex file transfer from ipaq
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
Date: Wed, 13 Jul 2005 10:02:58 -0700 (PDT)

Hi All.

I have ipaq 3870 running familiar linux v0.8.2 with
kernel 2.4.19. I want to send files to a desktop
running windows and a usb bluetooth dongle.

The bluetooth on my ipaq is detected and i can use
hcitool to find the other device. My question is how
to send files from the ipaq to the other bluetooth
device?

I found a page
http://www.caside.lancs.ac.uk/java_bt.php

which uses obex transfer. But a tool they use
'ussp-push' is not avialable to install through ipkg
and i cant compile usng make on my ipaq due to no gcc
compiler.
Is there any other way i can do this file transfer?
I can detect a obex service on the other machine.

i installed obexftp_0.10.3-r0_arm.ipk to see if i can
use this. However i am unure of how to use it.

# ipkg install openobex-apps_1.0.0-r0_arm.ipk
Installing openobex-apps (1.0.0-r0) to root...
Configuring openobex-apps
root@h3600:/etc/bluetooth# obexftp
-sh: obexftp: not found

Would appreciate any pointers.

Thanks,
Vinod

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
