Return-Path: <mfrey@pepper.com>
In-Reply-To: <1092262282.4564.256.camel@pegasus>
References: <1090054739.4558.2.camel@pegasus> <1090759952.4791.91.camel@pegasus> <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com> <1090864026.29589.1.camel@pegasus> <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com> <1090865790.29589.5.camel@pegasus> <76F28965-DF34-11D8-B83A-00039390D626@pepper.com> <1090875679.10807.1.camel@pegasus> <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com> <1090916301.4650.9.camel@pegasus> <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com> <1090940516.4845.19.camel@pegasus> <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com> <1090941847.4845.29.camel@pegasus> <86089F56-DFE5-11D8-BE76-00039390D626@pepper.com> <1091375871.27018.18.camel@pegasus> <225072EC-EBDC-11D8-B1A2-00039390D626@pepper.com> <1092262282.4564.256.camel@pegasus>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0F5DF2CE-ED4E-11D8-ABB4-00039390D626@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
From: Michael Frey <mfrey@pepper.com>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
Date: Fri, 13 Aug 2004 13:27:32 -0400
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

I now see what is going on.  I checked the system log and found these 
messages when the problem occurs.
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset

What exactly does this mean?

Michael

On Aug 11, 2004, at 6:11 PM, Marcel Holtmann wrote:

> Hi Michael,
>
>> OK -- I am using the new patches and all is well except for one thing.
>> My keyboard seems to not be able to re-connect after it goes to sleep
>> about 5 times.  It is almost like connections are left open and the
>> hidd server does not allow the keyboard to re-connect.
>>
>> The only way I get it back is to restart hidd.
>
> this sounds very weird. Please run "hcidump -x" as root and show it to
> us. What is the content of /proc/bluetooth/l2cap at that time? Do
> "hcitool con" show any connections?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
