Return-Path: <cyrus@holtmann.org>
Subject: Re: duplicate L2CAP connection requests - before and after L2CAP
 information response
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jaikumar Ganesh <jaikumar@google.com>
In-Reply-To: <35c90d960901280116k30f461edod533baa4fb4b5f5@mail.gmail.com>
References: <35c90d960901261529i699411a7jddb81b8d9bef74f8@mail.gmail.com>
	 <B9402F9A-9F2F-4C2B-8F54-24DD213A167A@holtmann.org>
	 <35c90d960901261738t510f7db9v9067c4d70999159f@mail.gmail.com>
	 <AD39F28E-2948-4CD3-9608-4FA48F7F4516@holtmann.org>
	 <35c90d960901262023gebe94c5w9a355d6886b32922@mail.gmail.com>
	 <1233130363.18259.33.camel@violet>
	 <35c90d960901280116k30f461edod533baa4fb4b5f5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 10:20:05 +0100
Message-Id: <1233134405.2139.0.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> > I think your kernel is wrongly patched. Don't cherry-pick patches that
> > you don't know the impact of.
> 
> Thanks for testing,
> 
> I've narrowed it down. The rogue patch is in fact ours:
> 
> @@ -916,8 +916,8 @@ static inline void hci_conn_complete_evt(struct
> hci_dev *hdev, struct sk_buff *s
>                 }
>         }
> 
> +       hci_proto_connect_cfm(conn, ev->status);
>         if (ev->status) {
> -               hci_proto_connect_cfm(conn, ev->status);
>                 hci_conn_del(conn);
>         }
> 
> This patch was motivated by a discussion in an earlier thread - see
> conn->state vs conn->sk->sk_state.
> 
> Sorry for the false alarm, I was not initially suspicious of this
> patch because it was not in l2cap.c.

I commented on that one and gave you a proper patch which is also in
bluetooth-testing.git ;)

Regards

Marcel


