Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SOLVED: Internal Bluetooth on dell latitude d610
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42931C81.2010104@logicacmg.com>
References: <4291DFA9.6010401@logicacmg.com>
	 <1116857742.30044.88.camel@pegasus>  <4292E9B9.7080907@logicacmg.com>
	 <1116925311.30044.134.camel@pegasus> <4292EEF8.80102@logicacmg.com>
	 <42931C81.2010104@logicacmg.com>
Content-Type: text/plain
Message-Id: <1116937973.30044.144.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 24 May 2005 14:32:53 +0200

Hi Thomas,

> Kernel 2.6.12-pre4 fixed the problem.

a newer USB subsystem always helps ;)

Please post content of /proc/bus/usb/devices and the output of
"hciconfig hci0 revision" (as root).

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
