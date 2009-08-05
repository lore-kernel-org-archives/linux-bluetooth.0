Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1249405306.3094.18.camel@localhost.localdomain>
References: <20090803.132924.151782729.davem@davemloft.net>
	 <1249343666.3094.12.camel@localhost.localdomain>
	 <20090803.191916.75688176.davem@davemloft.net>
	 <20090803.211136.00343745.davem@davemloft.net>
	 <1249405306.3094.18.camel@localhost.localdomain>
Date: Wed, 5 Aug 2009 13:16:59 +0800
Message-ID: <a8e1da0908042216u16037395k96cce0746baa504e@mail.gmail.com>
Subject: Re: [PATCH]bluetooth: rfcomm_init bug fix
From: Dave Young <hidave.darkstar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Miller <davem@davemloft.net>, oliver@hartkopp.net, alan@lxorguk.ukuu.org.uk,
	netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Aug 5, 2009 at 1:01 AM, Marcel Holtmann<marcel@holtmann.org> wrote:
> Hi Dave,
>
>> >> do you mind at least waiting for an ACK from my side. I haven't even
>> >> looked at the final patch.
>> >
>> > Sure, I haven't pushed it out yet, so now's your chance :)
>>
>> Grumble, I accidently pushed my net-2.6 queue out before you
>> had a chance to reply, sorry :-(
>
> not a big deal. Just have to send a cleanup patch. The patch itself is
> fine, but from a style perspective it is different than everything else
> in the Bluetooth subsystem and I would have liked to fix that before
> pushing it. I wait with that for 2.6.32 since it is not important.

Marcel, could you publish the bluetooth subsystem coding style
somewhere? People including me are confused about it. I remembered I
asked it from you, but it is still not very clear for me.

>
> The other Dave, please send patches to linux-bluetooth only and lets
> follow the normal path to get them merged into Linus' tree. Skipping
> bluetooth-2.6 is not an option. You have to use the same process than
> everybody else.

Why linux-bluetooth only? IMHO there could be more people to comment
and review  if I send patches to both lkml and subsystem mailing list.

>
> Regards
>
> Marcel
>
>
>



-- 
Regards
dave
