Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FAB8332.7080602@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>	 <3FAB6E18.2070601@zappa.cx> <1068204314.25163.104.camel@pegasus>
In-Reply-To: <1068204314.25163.104.camel@pegasus>
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
Date: Fri, 07 Nov 2003 12:34:10 +0100

Marcel Holtmann wrote:
> The problem here are the information about these values. Try to play a
> little bit with the switch on your notebook and get the values of the
> wireless_switch and bluetooth_available registers for Bluetooth on/off
> and Wirless LAN on/off.
> 
> Maybe this register could also be used to switch the Wireless LAN card
> on/off and so I tend to rename the complete proc entry to wireless and
> redo some parts of the patch.

I played with it in all possible ways on my notebook and the highest 
value I saw without bluetooth getting enabled was 576, and that was when 
I tried to enable bluetooth without first flipping the switch on the 
side of the notebook.

It looks like this with my changes from my last mail apllied.
This is done with the switch on the notebook in the "Off" position.

root@swe248:/proc/acpi/toshiba# cat bluetooth ; echo "bluetooth_on:1" > 
bluetooth ; cat bluetooth

bluetooth_available:     15
wireless_switch:         512
bluetooth_on:            0
bluetooth_available:     15
wireless_switch:         576
bluetooth_on:            0

I'm afraid I don't have a 802.b module in my computer, it's an option 
and currently I'm using BT as a cheap alternative :)

Maybe someonelse on the list have access to a Toshiba with wlan card in it?

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
