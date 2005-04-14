Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425E857D.30005@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] dongles won't initialize
References: <425D8196.2090608@gmx.ch> <1113425483.15359.2.camel@pegasus>
In-Reply-To: <1113425483.15359.2.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 14 Apr 2005 17:00:13 +0200

Hello Marcel

There's not yet(?) a patch for the 2.6.12 kernel on bluez.org.
Or are these patches only improvements/bugfixes for the available bluetooth 
support that's already in the kernel?

regards
Marco


Marcel Holtmann wrote:
> Hi Marco,
> 
> 
>>maybe someone has an idea:
>>
>>On my PC, I have:
>>Kernel 2.6.8-24.14-default
>>bluez-utils and bluez-libs 2.15
>>
>>this is exactly the same setup as on my laptop where everything works 
>>perfectly fine.
>>the same dongle(s) used in the laptop refuse to work with the pc.
>>
>>I made several (>20) tries with reboot and hcid reload.
>>hcitool dev and hciconfig -a:
>>- mostly showed nothing (no devices)
>>- about two times showed the dongles correctly but hciconfig -a failed with 
>>a timeout (hciconfig hci0 revision as well)
>>- once, the dongle wasn't up. doing hciconfig hci0 up freezed
>>- lsusb [-b] freezed
>>- dmesg, /var/log/messages didn't get any entries
>>
>>I strongly assume this has something to to with the usb port. maybee it's 
>>broken or i'm missing something important (software)...
> 
> 
> try to use a 2.6.12-rc2 kernel.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
