Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] ISSC USB Dongle does not work with current bluez?
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Krause <Andreas.Krause@web.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200407230649.28305.Andreas.Krause@web.de>
References: <200407222124.44032.Andreas.Krause@web.de>
	 <1090529272.21828.41.camel@pegasus>
	 <200407230649.28305.Andreas.Krause@web.de>
Content-Type: text/plain
Message-Id: <1090570478.21828.47.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Jul 2004 10:14:39 +0200

Hi Andreas,

> > > I've got a Bluetooth USB Dongle, Vendor ID 0x1131 (ISSC, Integrated
> > > System Solution Corp.), Product ID 0x1001, Revision 3.115. 
> > where do you got these dongle?
> 
> http://cgi.ebay.de/ws/eBayISAPI.dll?ViewItem&item=5709740304

is there anyone who will donate one of these?

> hciconfig -a says the same as in my original posting.
> 
> > Run "hcidump -x" and show it to us while executing these commands.
> 
> The following dump is the output of 'hcidump -x' while running 'hciconfig -a'. 
> Running 'hcitool inq' or 'hcitool scan' does not trigger any output from 
> 'hcidump -x'!

That is the problem here, because the kernel thinks that the dongle is
already in inquiry mode and won't start another one. Please stop hcid
and sdpd. Unplug your dongle and replug it. Run "hcidump -x" and then
call "hciconfig hci0 up".

Regards

Marcel





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
