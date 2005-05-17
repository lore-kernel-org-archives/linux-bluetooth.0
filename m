Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 3COM PCMCIA Bluetooth question
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <B7A120329D087840A54E2A221FCCE8D0747321@PSCMAIL01.rochester.itsphoenix.com>
References: 
	 <B7A120329D087840A54E2A221FCCE8D0747321@PSCMAIL01.rochester.itsphoenix.com>
Content-Type: text/plain
Message-Id: <1116329290.10063.42.camel@pegasus>
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
Date: Tue, 17 May 2005 13:28:10 +0200

Hi John,

> Can anyone provide some insight/directions/help getting the 3COM
> Bluetooth PCMCIA
> card ( 3CRWB6096B  ver3 ) to work with Debian Linux at kernel version
> 2.4.27.vrs1 running
> on an arm-linux platform (PXA255 Xscale w/ SA1111 I/O processor).
> Should this device 'just work' at this kernel level provided config
> files are correct??

do you see another ttySx device when you call dmesg after you plugged in
this card? Check your syslog to see what happens.

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
