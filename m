Return-Path: <mfrey@pepper.com>
In-Reply-To: <1090916301.4650.9.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus> <76F28965-DF34-11D8-B83A-00039390D626@pepper.com> <1090875679.10807.1.camel@pegasus> <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com> <1090916301.4650.9.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Tue, 27 Jul 2004 10:53:07 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>


On Jul 27, 2004, at 4:18 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>> ok, got it working.  However -- when typing fast on my keyboard I get
>> incorrect characters.  This does not happen when using bthid.  Also,
>> my mouse does not work,  where using bthid it does.
>
> try to add
>
> 	input_event(dev, EV_RST, 0, 0);
This seems to help with the incorrect characters.  But still no mouse.

>
> at the end of hidp_input_report() and see if this helps out for your
> keyboard and mouse problems. What do "hidd -l" say after you have
> connected the devices? What devices do you use?

root@(none):~# hidd -l
00:02:72:40:8A:97 HID Boot Device [0000:0000] connected

I am using a Keyboard with integrated mouse.  So I guess it is 
technically one device.  The mouse is a track ball embedded in the 
keyboard.  The keyboard is made by BlueLogic.

Michael
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
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
