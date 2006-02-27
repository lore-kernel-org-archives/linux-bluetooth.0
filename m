Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060227005919.48143.qmail@web31814.mail.mud.yahoo.com>
From: Manu <seatmanu@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060227005507.B98C988712@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] problem with Sony W600i
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
Date: Sun, 26 Feb 2006 16:59:19 -0800 (PST)


Hi 

I am having a problem using the HCID part of the of
the bluetooth. I am using ubuntu breezy. 

The issue is that I can transfer file (image, hid,
vcf) to my cellphone but when I try to use the
remoting services it connect but fails on the
passcode.

I have configured the /etc/bluetooth/pin to use a
simple pass code and it does not work (1234) :) 

I tried changing the hcid.conf to use
 security none;

and still it asking a passcode.

I am relatively new in using bluetooth on linux but
have played with different program hciconfig, hcidtool
and bluez-pin

Any idea what am I doing wrong or missing? Is there a
way to completely disable the security mode?

Manu

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
