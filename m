Return-Path: <cyrus@holtmann.org>
Message-ID: <47AB8D55.9030307@teamboyce.co.uk>
Date: Thu, 07 Feb 2008 22:59:33 +0000
From: Rod Boyce <bluez@teamboyce.co.uk>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47AB5665.8040101@wurmsdobler.org>	<d89ddf300802071149x4e36a56ajac12896abda9d7cc@mail.gmail.com>
	<47AB899D.7060609@wurmsdobler.org>
In-Reply-To: <47AB899D.7060609@wurmsdobler.org>
Subject: Re: [Bluez-users] Headset, ALSA and other issues
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Peter,

You are going to have problems emptying the UART FIFO's fast enough on 
your target hardware at a baud rate fast enough to transfer audio I know 
I have seen these issues before.
You would be better using another medium for the transport USB or SPI or 
something other than a UART.

Regards.
Rod Boyce

Peter Wurmsdobler wrote:
> Hello,
>   
>> 115k is probably too slow to be workable for audio. That's one reason
>> it's more common to connect the adapter to the pc over  usb.
>>     
> you are right in principal. One thing I neglected to mention, however, 
> is that the target hardware is based on the imx27 ADS board. We are 
> going to use the hardware facilities, i.e. UART to the BC4-ROM for 
> control, and PCM over SSI. How this is going to work in terms of routing 
> the signals through ALSA and the Linux kernel, I hope to find out soon.
>
> peter
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
