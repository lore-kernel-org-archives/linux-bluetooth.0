Return-Path: <rjmx@rjmx.net>
Message-ID: <429286B4.3030208@rjmx.net>
Date: Mon, 23 May 2005 21:43:16 -0400
From: Ron Murray <rjmx@rjmx.net>
Reply-To: rjmx@rjmx.net
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>, pavouk@pavouk.org
CC: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Ambicom BT-2000CF doesn't want to work with	kernel
 2.6.11.8
References: <4291146C.4000603@rjmx.net>	 <200505230949.01287.pavouk@pavouk.org> <1116843358.30044.47.camel@pegasus>
In-Reply-To: <1116843358.30044.47.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi Pavel,
> 
> 
>>I don't know, if it is exactly your problem, but some bluetooth
>>PCMCIA (CF) cards have problems with kernel 2.6. Specially
>>New SOCKET or Billionton card.
>>There exists patch for kernel 2.6.11, which resolve problems with
>>these cards. Look at this page for instruction:
>>http://www.summet.com/x31/socket.html
>>
>>Find in archive mail with subject "Billionton(?) CF card - success".
> 
> 
> Pavel Machek posted the commands to get the Billionton card working to
> the LKML. I verified it and maybe the same will work the Ambicom.
> 
> And depending on if it is a 2000C or 2000E it has a CSR or an Ericsson
> chip inside. Guess who is who.

    It's a 2000E, with an Ericsson chip in it. I found that out a year 
ago when I was playing around with the bt950 driver on my Zaurus.

    Anyway, thanks for the help, folks, but it still doesn't work. 
Doesn't seem to have made any difference as far as I can see. If 
nobody's got any more ideas, I'll trace the bt950 driver through and 
compare it to the current one. Perhaps that'll give me a handle on 
what's happening.

Thanks,

  .....Ron


-- 
Ron Murray   (rjmx@rjmx.net)
http://www.rjmx.net/~ron
GPG Public Key Fingerprint: F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 
D86C 74DE
