Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Installing bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1127311478.4331687601b7b@student.up.ac.za>
References: <1127311478.4331687601b7b@student.up.ac.za>
Content-Type: text/plain
Message-Id: <1127401561.12287.0.camel@blade>
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
Date: Thu, 22 Sep 2005 17:06:01 +0200

Hi Reinier,

> I have some trouble running a bluetooth app. I tried to contact the developers
> of the app for help, but they couldn't/wouldn't help me. Apparently I need to
> install my bluetooth devices (I'm using a usb dongle to connect to my mobile
> phone) to be able to run the app. "rfcomm -a" from the console returns an empty
> list (in fact it returns nothing at all). I suppose this means that I have no
> bluetooth devices installed, but I am able to execute "hcitool scan" which
> returns the correct mac address of my phone. I'm not sure what to make of this.I
> got error messages like 
> 
>  open /dev/bluetooth/rfcomm0, No such file or directory
>  bt_rfcomm_config failed
>  unable to create rfcomm connection
> 
> I've heard that I have to configure my dongle some how using "rfcomm". I've
> tried some bluetooth appz which came with my distro ( Suse9.3 ) and I'm able to
> communicate with certain types of phones. I'm rather new to bluez, so a detailed
> answer would be much appreciated!

why don't you tell us what application you are using? However using
"rfcomm bind ..." could be the solution for your problem.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
