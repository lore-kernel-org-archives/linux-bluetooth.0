Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SOLVED: Dell Inspiron 8600 was: 'hciconfig -a'
	ok, but 'hcitools scan' shows no devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <33016.80.146.4.18.1102847912.squirrel@schrell.de>
References: <35275.80.146.4.18.1102802831.squirrel@schrell.de>
	 <1102804861.8750.2.camel@pegasus>
	 <50745.80.146.4.18.1102837718.squirrel@schrell.de>
	 <1102838764.8750.32.camel@pegasus>
	 <33016.80.146.4.18.1102847912.squirrel@schrell.de>
Content-Type: text/plain
Message-Id: <1102851736.8750.34.camel@pegasus>
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
Date: Sun, 12 Dec 2004 12:42:16 +0100

Hi Andreas,

> thanks a lot for your help.
> 
> SUMMARY:
> 
> hciconfig -a         looked right
> hcitool scan         did not show any devices
> 
> RESOLUTION:
> 
> Bluetooth was diabled under Windows!
> There was no way to start it from Linux as far as I know.
> 
> After booting Windows and activation Bluetooth (right click on icon in
> task bar, then activate) it works under Linux. Nothing to do with <FN-F2>.
> Now the blue Bluetooth LED is on even on Linux startup.

do you still get vendor event with hcidump?

Maybe they have a special VM application running on the Bluetooth chip
that can enable/disable the antenna or whatever. What Windows stack did
you used?

> Thank You, Marcel, for your help!

You are welcome.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
