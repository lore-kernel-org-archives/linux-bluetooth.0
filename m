Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <460C24E2.7040809@thebmwz3.co.uk>
Date: Thu, 29 Mar 2007 21:43:14 +0100
From: Andy <andy@thebmwz3.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Pairing without dbus
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi All,
I'm having some major problems on a CF-based linux system based on Debian.
Basically, I need to do a pairing without using DBUS/passkey-agent, so 
want to somehow populate the linkkeys file manually.
Can anyone advise on how to do this? (I have the address of the device, 
and the pin it requires to pair).

The reason is that on the basic install I've got bluetooth utils are 
broken, and without compilers, etc I cannot build working copies, so 
continually get:

Mar 29 17:20:29 voyage hcid[3247]: pin_code_request 
(sba=00:15:83:xx:xx:xx, dba=00:80:37:xx:xx:xx)
Mar 29 17:20:29 voyage hcid[3247]: Calling PasskeyAgent.Request: 
name=:1.6, path=/org/bluez/passke
Mar 29 17:20:29 voyage hcid[3247]: Passkey agent replied with an error: 
org.freedesktop.DBus.Errorhod "Request" with signature "ss" on interface 
"org.bluez.PasskeyAgent" doesn't exist


Can anyone advise on how to generate the linkkeys file manually? It's 
the 128-bit code that I've not found the information on how to create!

Thanks in advance.

-- 
Andy
e: andy @ thebmwz3.co.uk


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
