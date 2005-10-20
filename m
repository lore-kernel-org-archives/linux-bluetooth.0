Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Philippe Berini <pypm@free.fr>
Message-ID: <20051020135234.GC28731@loulou-becane>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Buetooth and SAMSUNG SGH-E340
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
Date: Thu, 20 Oct 2005 13:52:38 +0000 (UTC)

Hi all,

I have a new phone (SAMSUNG SGH-E340) and I am trying to send photos
from the phone to my PC. I am a complete newbie to bluetooth.

My configuration:
- Debian Sid, kernel 2.6.12.
- USB dongle: D-Link DBT-122 (checked with Windows, it is working)

My phone is seen:

# hcitool scan
Scanning ...
        00:12:47:AB:AF:46       SAMSUNG SGH-E340

and the phone sees the PC.

I can connect to the mobile:

# hcitool cc 00:12:47:AB:AF:46
# hcitool con          
Connections:
        < ACL 00:12:47:AB:AF:46 handle 6 state 1 lm MASTER 

I can connect with obexftp:

# obexftp -b
Scanning ...
Using   00:12:47:AB:AF:46       SAMSUNG SGH-E340
Browsing 00:12:47:AB:AF:46 ...
Channel: 7
Nothing to do. Use --help for help.

I add Channel 7:

# sdptool add --channel=7 OPUSH
OBEX Object Push service registered

But I don't know what to do then. If I try to list the folders on the
mobile, I get:

# obexftp -b -l
Scanning ...
Using   00:12:47:AB:AF:46       SAMSUNG SGH-E340
Browsing 00:12:47:AB:AF:46 ...
Channel: 7
No custom transport
Connecting...bt: -1
failed: connect
Still trying to connect
Connecting...bt: -1
failed: connect

I must have forgotten something or done something wrong.
Any idea or pointer ?

-- 
Philippe Berini                



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
