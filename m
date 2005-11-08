Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Stefan Quandt <Stefan.Quandt@bardenheuer.de>
Message-ID: <dkqb18$cek$1@sea.gmane.org>
References: <dkq0na$agk$1@sea.gmane.org> <1131454229.5824.163.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: flooded with "SCO data: handle 0 dlen 0"
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
Date: Tue, 08 Nov 2005 15:00:07 +0100

Hi Marcel,

>> As soon as I connect my Bluetooth-Dongle (Abe UB 20S, BlueSoleil) my
>> syslog are flooded with empty SCO packets.
> check if this is a Silicon Wave based dongle.
How may I do this?

http://www.holtmann.org/linux/bluetooth/features.html 
says the manufacturer is RTX Telecom.

Maybe this helps:
/sys/bus/usb/devices/1-1/idProduct contains 080a
/sys/bus/usb/devices/1-1/idVendor contains  0400

Thanks
   Stefan




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
