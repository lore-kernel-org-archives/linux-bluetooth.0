Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150228.142135.470339626705046722.davem@davemloft.net>
References: <1424977624-649-1-git-send-email-eyal.birger@gmail.com>
	<1424977624-649-5-git-send-email-eyal.birger@gmail.com>
	<20150228.142135.470339626705046722.davem@davemloft.net>
Date: Sat, 28 Feb 2015 21:39:34 +0200
Message-ID: <CAHsH6Guq33N755dcuNEmzgP06O=PBdy2Tzt5vSr-iRFoj4uGtw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/7] net: packet: use skb->dev as storage for
 skb orig len instead of skb->cb[]
From: Eyal Birger <eyal.birger@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Feb 28, 2015 at 9:21 PM, David Miller <davem@davemloft.net> wrote:
> From: Eyal Birger <eyal.birger@gmail.com>
> Date: Thu, 26 Feb 2015 21:07:01 +0200
>
>> As part of an effort to move skb->dropcount to skb->cb[], 4 bytes
>> of additional room are needed in skb->cb[] in packet sockets.
>>
>> Store the skb original length in skb->dev instead of skb->cb[] for
>> this purpose.
>>
>> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
>
> I'm a little confused, why is this even needed?
>
> packet_skb_cb is 24 bytes by my calculations, which is much
> smaller than the cb[] size which is 48 bytes.

Note the BUILD_BUG_ON in packet_rcv().

packet_skb_cb may contain an address as large as MAX_ADDR_LEN (32)
Therefore the required space is sizeof(packet_skb_cb) + MAX_ADDR_LEN - 8
which is 48 bytes before this change.

Regards,
Eyal.
