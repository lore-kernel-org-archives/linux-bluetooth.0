Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <517CF7F08A05D4118C380000E869BFA4BDED83@emg_ntserv2>
From: R.Schade@tu-braunschweig.de
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Bluez-users] missing include-files with debian
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 8 Sep 2004 10:20:10 +0200

Hello,

I had installed Debian-stable (2.4.20) with the bluez-debian-packages (I did
not compile the bluez-sources myself). My USB-bluetooth-dongle works fine.
Now, I want code some little application. So I have include the
bluetooth-headerfiles:

#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h> 

The standard include-directory is /usr/include. Directory "bluetooth" exists
there, but contains only one headerfile (bnep.h). Why are missing the other
bluez-headerfiles there? 
Is this a debian-"problem" with the package and I have to install/copy/link
the files manually? I had found the missing files at the kernel-sources and
at the bluez-sources.

Thank you for your help.

Ciao, Ralf


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
