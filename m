Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <410913D4.2050204@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] braindead adapters (sco)
References: <41090B25.6090806@xmission.com> <1091112872.12651.50.camel@pegasus>
In-Reply-To: <1091112872.12651.50.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 29 Jul 2004 09:12:20 -0600

Marcel

thanks for the quick reply. well, it looks like I'm good.

# hciconfig hci0 revision
hci0:   Type: USB
         BD Address: 00:03:7A:0B:44:B3 ACL MTU: 192:8  SCO MTU: 64:8
         HCI 16.4
         Chip version: BlueCore02
         Max key size: 56 bit
         SCO mapping:  HCI

next I will try the rework of the snd-bt-sco patch by Niko Berger. It's 
good to see it's possibly working for someone...

Brad

> Hi Brad,
> 
> 
>>I've been trying to get snd-bt-sco to work. I'm told that one possible 
>>reason it's not working is if the bluetooth dongle is routing incoming 
>>SCO data to PCM rather than HCI. I'm using the internal bluetooth (usb) 
>>on a Toshiba Portege m200. How can I tell if it's doing sco properly?
> 
> 
> check with "hciconfig hci0 revision" as root.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 
Brad


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
