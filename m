Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC94610F2568494D8D9291885C48D3103CFE7E@nasanexd01a.na.qualcomm.com>
References: <BANLkTi=T4dqgKW_7WA9BT7EQ9UY4mRZ7JA@mail.gmail.com>
	<EC94610F2568494D8D9291885C48D3103CFE7E@nasanexd01a.na.qualcomm.com>
Date: Wed, 22 Jun 2011 10:23:39 +0300
Message-ID: <BANLkTimQ-KuUwpn_7-97KBM36vb0gf1gOg@mail.gmail.com>
Subject: Re: SRM support in OBEX
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Li, Nami" <nami@qca.qualcomm.com>
Cc: =?ISO-8859-1?Q?Piotr_Zg=F3recki?= <pzgorecki@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

2011/6/22 Li, Nami <nami@qca.qualcomm.com>:
> Hi, Piotr
>  I worked on SRM several weeks ago but finally stopped.
>  It`s easy to set and check SRM header, as well as set the response mode to OBEX_RSP_MODE_SINGLE. And it is already well supported in obex_work function when the response mode is SRM, client and server can continue send data without remote side response or request. The obex_work callback relationship is:
> obex_session_start()
>                                        ...
>                        g_io_add_watch_full(io, G_PRIORITY_DEFAULT,     G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,      obex_handle_input, obex, obex_handle_destroy);
>                                        ...
> obex_handle_input()
>                                        ...
>                        OBEX_HandleInput(obex, 1)
>                                        ...
> OBEX_HandleInput()
>                                        ...
>                        obex_work(self, timeout);
>
> The problem in SRM is:
> If remote side doesn`t send any data to local side, then the G_IO_IN condition couldn`t be set. So how obex_work can be called?
>
> I haven`t found any good solution for this issue. So if you can spend some time on SRM, I`ll be very happy:)

No top posting in this list, please.

So back to the topic, we probably need to add another watch with
G_IO_OUT when using SRM so that it wake ups whenever we can write to
the socket/fd, obviously this should only be active when we are
sending data (GET) and there is no need to call OBEX_HandleInput.


-- 
Luiz Augusto von Dentz
