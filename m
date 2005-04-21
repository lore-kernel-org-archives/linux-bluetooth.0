Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001b01c546b6$57a63630$0401a8c0@NBVICTOR>
From: "Victor Shcherbatyuk" <victor@win.tue.nl>
To: <bluez-devel@lists.sourceforge.net>
References: <42663B80.6070309@nokia.com> <1114000772.2469.168.camel@pegasus>
Subject: Re: [Bluez-devel] [PATCH] RFCOMM does not call tty_hangup() whenDCD is de-asserted
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 21 Apr 2005 23:09:01 +0200

Hi Marcel,

I've tried this patch on some of the phones, it is turned to be useful when 
using DUN profile of Windows CE phones, pppd used go to some weird state 
after an incoming call is picked up on that kind of phones, so it had to be 
killed and restarted to make it work again, with this patch it detects hang 
up and exits when the call is picked up, which makes the life simpler, no 
pppd - no connection - easy to detect...

Regards,
  Victor.

P.S. for other phones I didn't see any strange behaviour yet...

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-devel@lists.sourceforge.net>
Sent: Wednesday, April 20, 2005 14:39
Subject: Re: [Bluez-devel] [PATCH] RFCOMM does not call tty_hangup() whenDCD 
is de-asserted


> Hi Timo,
>
>> It seems that RFCOMM does not handle properly the de-assertation of CD
>> signal. It should call tty_hangup() to work properly.
>>
>> One side effect is that data calls that are hanged up from remote side
>> are not detected as being hanged up.
>>
>> I've made a very quick patch for this. In my case this patch enabled the
>> detection carried detect signal de-assertation. But since I'm not an
>> expert on RFCOMM stuff there might be some cases where tty_hangup()
>> should not be called. In serial side the DCD change is handled by
>> uart_handle_dcd_change() defined in include/linux/serial_core.h and it
>> has some extra checks there as well.
>>
>> So could some one wiser there check what actually has to be done for the
>> hangup mechanism to work properly. Or if my patch looks good enough feel
>> free to commit it.
>
> from my part this patch looks fine, but I don't like the modem emulation
> part of RFCOMM in general. For me it is only a stream. Nothing less and
> nothing more. So if this patch is useful I am going to apply it.
>
>> + if ((dev->modem_status & TIOCM_CD) &&
>> +     !(v24_sig & RFCOMM_V24_DV)) {
>
> You must comply with the coding style here. So change it into
>
> if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {
>
> And don't forget to add a Signed-off-by: line when you resend it.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime 
> info,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
