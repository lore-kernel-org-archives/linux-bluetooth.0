Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <426E1B8F.8030901@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] auto pairing between client & server
References: <2621d9af05042213064d0df1dc@mail.gmail.com>	 <426ABEBD.5060701@gmx.ch> <2621d9af0504250729e34a2aa@mail.gmail.com>	 <426D00CB.7060508@gmx.ch> <2621d9af0504260302e1c13c7@mail.gmail.com>
In-Reply-To: <2621d9af0504260302e1c13c7@mail.gmail.com>
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
Date: Tue, 26 Apr 2005 12:44:31 +0200

N. I. wrote:
> Hi Marco,
> 
> I ran a test with the new configuration and found out the bluetooth
> devices which has this config modified accepted any device coming. The
> pairing window is not poped up anymore, but the link_key is not
> updated (still 0 byte).

yes. because no link key is created.

> As my understanding, this config ignores the pairing and pin code. It
> accepts all devices connecting to my device, no authentication. Is
> that it?

yes. you can't use security mode 3 for what you're trying to reach. you 
need security mode 2 (application based autentication/encryption).

> What I want is to avoid the pin popup for certain bluetooth devices
> (know specific BD_ADDR). When those allowed devices connect to my
> device, then I will try to provide "silently" the PIN (no popups) and
> the pairing should be done from there. If other device which BD_ADDR
> does not belong to the list of addresses that my device has, it should
> not be rejected.

I don't think this is possible because you don't know the remote BD_ADDR 
until the device has connected to your device. And if it has already 
connected, it's too late for bluteooth based autentication/encryption. So 
you might implement an own authentication/encryption algorithm for your 
purpose.
Please note that I'm not an expert. Maybee this works and I just don't know it.


regards
Marco

> Any help please?
> 
> N.I.
> 
> On 4/25/05, Marco Trudel <mtrudel@gmx.ch> wrote:
> 
>>change to security mode 1. that means to comment out:
>>#auth enable;
>>#encrypt enable;
>>
>>you can keep "security auto".
>>
>>regards
>>Marco
>>
>>
>>N. I. wrote:
>>
>>>In the hcid.conf file, I have:
>>>security auto;
>>>auth enable;
>>>
>>>Is that what you meant I should change to be off?
>>>
>>>
>>>
>>>On 4/23/05, Marco Trudel <mtrudel@gmx.ch> wrote:
>>>
>>>
>>>>N. I. wrote:
>>>>
>>>>
>>>>>I have a laptop which runs my application as server, and another
>>>>>cellphone as client. Both of them communicate to each other using
>>>>>Bluetooth (Bluez implementation).
>>>>
>>>>do you really mean the mobile phone is using bluez?
>>>>what for a mobilephone is this?
>>>>
>>>>
>>>>
>>>>>What should I do in order to perform automatic pairing between these 2
>>>>>devices (knowing the BD_ADDR) inside my application?
>>>>>
>>>>>How can I detect if the pairing had been done between these
>>>>>client-server devices inside my application? And from that, how to do
>>>>>pairing using the "givepin" script?
>>>>>
>>>>>I want to avoid the pop-ups window asking for entering the PIN.
>>>>
>>>>disable authentication/encryption. you won't be asked for a pin because no
>>>>one is needed. you haven't to change the default bluez configuration to
>>>>reach this.
>>>>if you use java on your mobile phone, be shure to program the security
>>>>correctly.
>>>>
>>>>regards
>>>>Marco
>>>>
>>>>
>>>>
>>>>>Please help,
>>>>>
>>>>>Thanks
>>>>>
>>>>>N.I.
>>>>>
>>>>>
>>>>>-------------------------------------------------------
>>>>>SF email is sponsored by - The IT Product Guide
>>>>>Read honest & candid reviews on hundreds of IT Products from real users.
>>>>>Discover which products truly live up to the hype. Start reading now.
>>>>>http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
>>>>>_______________________________________________
>>>>>Bluez-users mailing list
>>>>>Bluez-users@lists.sourceforge.net
>>>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>>>
>>>>>
>>>>
>>>>-------------------------------------------------------
>>>>SF email is sponsored by - The IT Product Guide
>>>>Read honest & candid reviews on hundreds of IT Products from real users.
>>>>Discover which products truly live up to the hype. Start reading now.
>>>>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>>>>_______________________________________________
>>>>Bluez-users mailing list
>>>>Bluez-users@lists.sourceforge.net
>>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>>
>>>
>>>
>>>
>>>-------------------------------------------------------
>>>SF email is sponsored by - The IT Product Guide
>>>Read honest & candid reviews on hundreds of IT Products from real users.
>>>Discover which products truly live up to the hype. Start reading now.
>>>http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
>>>_______________________________________________
>>>Bluez-users mailing list
>>>Bluez-users@lists.sourceforge.net
>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>>
>>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now.
>>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
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
