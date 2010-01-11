Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1263225365l.20825l.7l@jars-desktop>
References: <1263225365l.20825l.7l@jars-desktop>
Date: Mon, 11 Jan 2010 14:41:14 -0200
Message-ID: <fbf08281001110841r2a402793oaf321d011ad64a3a@mail.gmail.com>
Subject: Re: l2cap - packet handled event
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: lukasz <ru-dy@o2.pl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jan 11, 2010 at 1:56 PM, lukasz <ru-dy@o2.pl> wrote:
>
> I'm sorry if I write this msg in wrong place or wrong format.
>
> I'm using bluez (l2cap connection) and all my operations are using
> socket API. I have problem with latencies and I would like to know,
> when my packet was sent. Is there any possibility to subscribe with
> function handler or get "packet handled" event from the stack ? In my
> case I don't want to send next packet, if the previous one is not sent
> ( I don't want buffer them, throughput can be limited, I need minimal
> latencies). Is there any possibility to limit socket buffer size (2nd
> write to socket will block, when I will try to write 2nd packet, before
> 1st is not sent) ?

l2cap actually doesn't send the packets, it calls the hci layer to
queue the packets for sending. The hci layer eventually will send the
packet.

You can try to use the L2CAP Enhanced Retransmission Mode with
txWindow = 1. So, you will need to wait the ack from the remote side
to send the next packet.

>
>
> best regards,
> sorry for my English
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
