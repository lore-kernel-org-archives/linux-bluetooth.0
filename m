Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FAB9C82.906@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>	 <3FAB6E18.2070601@zappa.cx> <1068204314.25163.104.camel@pegasus>	 <3FAB8332.7080602@zappa.cx> <1068205278.25167.108.camel@pegasus>	 <3FAB8963.9070600@zappa.cx> <1068207133.25163.117.camel@pegasus>
In-Reply-To: <1068207133.25163.117.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 07 Nov 2003 14:22:10 +0100

Marcel Holtmann wrote:
> Hi Andreas,
> 
> 
>>This is when I have successfully enabled bluetooth and USB has noticed 
>>that the dongle has been plugged in.
>>
>>root@swe248:/proc/acpi/toshiba# cat bluetooth
>>bluetooth_available:     15
>>wireless_switch:         705
>>bluetooth_on:            1
>>
>>By accident I noticed that when I changed the switched from Off to On it 
>>went up to 577 so I that is now the highest number I've seen without the 
>>bluetooth dongle actually working.
> 
> 
> don't think of highest number. You should start thinking in which bit is
> set and which is not. It seems that the bluetooth_available register
> will always be 15 and can be ignored at this point. The important part
> is the value of wireless_switch.
> 
> It seems that we have some variables to fill in.
> 
> 	The hardware switch on/off
> 	Bluetooth activated/deactivated through software
> 	Bluetooth dongle found/disabled by USB subsystem
> 
> So you should make a table with all possible combinations and fill in
> the values (in hex) for it. This is what I need to see which bit gets
> toggled and which not.

Now I've done some testing, and with hex numbers it seems to clarify a bit.

When the notebook is freshly booted I get the following values:
sw-off: 0x200
sw-on:  0x201

After I have sent a bluetooth_on:1 the values changes to:
sw-off: 0x240
sw-on:  0x241

When the switch is on and bluetooth is enabled (plugged in):
sw-on bt-on: 0x2c1

If I then move the switch back to off it goes back to 0x240

This is essentially the same numbers as earlier but in hex form, but it 
seems to me that the first bit is responsible for reporting if the 
switch is on or off. If I convert it to binary I get the following:

sw-off bt-off
1000000000
1001000000

sw-on bt-off
1000000001
1001000001

sw-on bt-on
1011000001

I'm not sure if I answered all your (three) questions, if not.. please 
explain a bit further beacause then I didn't understand it.

/Andreas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
