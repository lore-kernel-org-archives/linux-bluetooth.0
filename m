Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <441211DA.4060600@fillibach.de>
From: Kosta Welke <kosta@fillibach.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] set/read flush timeout
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
Date: Sat, 11 Mar 2006 00:55:06 +0100

Hi!

I'm trying to do VoIP over PAN, and thus need to set (and read) the ACL 
flush timeout. I tried modifying Albert Huang example code, but it does 
not seem to work. Could someone give me a small hint what is wrong?

http://lastpageofthe.net/setflush.c

Disclamer: I'm a complete noob when it comes to HCI requests, so please 
forgive this "Help! Fix my problem!"-Mail. On the positive side, as soon 
as it works, I want to put it into hcitool.

Yours,
Kosta


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
