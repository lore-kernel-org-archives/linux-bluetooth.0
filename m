Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <442F3085.3020809@sharpmind.de>
From: =?ISO-8859-1?Q?Frank_Schr=F6der?= <frank-bluez@sharpmind.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] connect on SCO socket fails with Connection refused on Nokia 6680
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
Date: Sun, 02 Apr 2006 04:01:41 +0200

Hi,

I'm trying to open a SCO socket via a USB bluetooth dongle to my Nokia 
6680 but the connect fails with "Connection refused (111)". I'm running 
Suse 9.3. I've stripped my testprogram down to the do_connect() method 
of the scotest.c program from the bluez-util-2.25 package and I get a 
connection with a Motorola Razr V3.

I realize that this suggests that the Nokia is buggy but the question is 
what is happening here? Because - if this wouldn't work you couldn't 
connect any headset to this thing, would you?

I've been banging my head against this wall for the last eight hours 
straight and any help, idea, hint, clue is highly appreciated.

Thanks

-- 
  Frank Schröder
   IT Architect
   sharpmind.de



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
