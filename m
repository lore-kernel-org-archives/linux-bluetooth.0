Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FAB8963.9070600@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8F301.4000008@zappa.cx> <1068041709.1288.36.camel@pegasus>	 <3FA90A1E.5000505@zappa.cx> <1068162514.25166.90.camel@pegasus>	 <3FAB6E18.2070601@zappa.cx> <1068204314.25163.104.camel@pegasus>	 <3FAB8332.7080602@zappa.cx> <1068205278.25167.108.camel@pegasus>
In-Reply-To: <1068205278.25167.108.camel@pegasus>
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
Date: Fri, 07 Nov 2003 13:00:35 +0100

Marcel Holtmann wrote:
> Hi Andreas,
> 
> 
>>It looks like this with my changes from my last mail apllied.
>>This is done with the switch on the notebook in the "Off" position.
> 
> 
> and how do it look with the switch in "On" position?
This is when I have successfully enabled bluetooth and USB has noticed 
that the dongle has been plugged in.

root@swe248:/proc/acpi/toshiba# cat bluetooth
bluetooth_available:     15
wireless_switch:         705
bluetooth_on:            1

By accident I noticed that when I changed the switched from Off to On it 
went up to 577 so I that is now the highest number I've seen without the 
bluetooth dongle actually working.

Since I'm not used to "research" these kind of things I might not be 
doing it the most efficient way, if you suggest that I shall try things 
in a specific order and document it I can do it for you..

> 
>>I'm afraid I don't have a 802.b module in my computer, it's an option 
>>and currently I'm using BT as a cheap alternative :)
>>
>>Maybe someonelse on the list have access to a Toshiba with wlan card in it?
> 
> 
> I really need this information :(
I hope that someone will notice this thread and fill in the blanks for 
this.. The topic/subject is not the best though..

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
