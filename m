Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Sundstrom <sunkan@zappa.cx>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FAB6E18.2070601@zappa.cx>
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>
	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>
	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>
	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>
	 <3FAB6E18.2070601@zappa.cx>
Content-Type: text/plain
Message-Id: <1068204314.25163.104.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 07 Nov 2003 12:25:14 +0100

Hi Andreas,

> Ok, first of all I want to say that it works ok for me. I have tried
> everything except the "keys" proc entry.

this is good to hear, so I don't break anything else ;)

> Which means that when you have learnd how they function you should be
> able to guess what to do with the bluetooth entry if it for example
> looked like this:
> #cat bluetooth
> bluetooth_available:     15
> wireless_switch:         512
> bluetooth_on:            0
> 
> I have here changed the parameter to echo into "bluetooth" from
> bluetooth to bluetooth_on, and added an entry that shows the status of
> it. This makes it easy to guess that "echo bluetooth_on:1 > bluetooth"
> should enable the device if you know how the other entris work.
> Without this you want be able to guess that "bluetooth:1/0" is used
> for enabling/disabling the device.

The problem here are the information about these values. Try to play a
little bit with the switch on your notebook and get the values of the
wireless_switch and bluetooth_available registers for Bluetooth on/off
and Wirless LAN on/off.

Maybe this register could also be used to switch the Wireless LAN card
on/off and so I tend to rename the complete proc entry to wireless and
redo some parts of the patch.

Regards

Marcel





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
