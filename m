Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Sundstrom <sunkan@zappa.cx>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FAB8963.9070600@zappa.cx>
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>
	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>
	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>
	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>
	 <3FAB6E18.2070601@zappa.cx> <1068204314.25163.104.camel@pegasus>
	 <3FAB8332.7080602@zappa.cx> <1068205278.25167.108.camel@pegasus>
	 <3FAB8963.9070600@zappa.cx>
Content-Type: text/plain
Message-Id: <1068207133.25163.117.camel@pegasus>
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
Date: Fri, 07 Nov 2003 13:12:14 +0100

Hi Andreas,

> This is when I have successfully enabled bluetooth and USB has noticed 
> that the dongle has been plugged in.
> 
> root@swe248:/proc/acpi/toshiba# cat bluetooth
> bluetooth_available:     15
> wireless_switch:         705
> bluetooth_on:            1
> 
> By accident I noticed that when I changed the switched from Off to On it 
> went up to 577 so I that is now the highest number I've seen without the 
> bluetooth dongle actually working.

don't think of highest number. You should start thinking in which bit is
set and which is not. It seems that the bluetooth_available register
will always be 15 and can be ignored at this point. The important part
is the value of wireless_switch.

It seems that we have some variables to fill in.

	The hardware switch on/off
	Bluetooth activated/deactivated through software
	Bluetooth dongle found/disabled by USB subsystem

So you should make a table with all possible combinations and fill in
the values (in hex) for it. This is what I need to see which bit gets
toggled and which not.

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
