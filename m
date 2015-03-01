Return-Path: <cyrus@holtmann.org>
Date: Sun, 01 Mar 2015 00:31:43 -0500 (EST)
Message-Id: <20150301.003143.1281961486875434872.davem@davemloft.net>
To: eyal.birger@gmail.com
Cc: willemb@google.com, edumazet@google.com, shmulik.ladkani@gmail.com,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: packet: use skb->dev as storage
 for skb orig len instead of skb->cb[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHsH6Gv8Dh3RQ0V7KURcca9bzZGY0FwiqGj-mP9oKA_Vv72nUA@mail.gmail.com>
References: <CAHsH6GvvQxHbt4JJrotn3y=BG172Wbw4NrMD+gTUA_R=jbPDTw@mail.gmail.com>
	<20150228.160047.214686672558902639.davem@davemloft.net>
	<CAHsH6Gv8Dh3RQ0V7KURcca9bzZGY0FwiqGj-mP9oKA_Vv72nUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eyal Birger <eyal.birger@gmail.com>
Date: Sun, 1 Mar 2015 07:09:54 +0200

> Ok. Another suggestion I received was to delay the preparation of the full
> sockaddr_ll until it is needed, and store the skb original length in the first
> two fields (sll_protocol and sll_family) as they can be derived later on from
> the skb.
> 
> IMHO, It would still be somewhat of a hack though.
> 
> Would that approach be considered?

I think it's better than mangling skb->dev
