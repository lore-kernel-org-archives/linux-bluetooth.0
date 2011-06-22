Return-Path: <cyrus@holtmann.org>
Message-ID: <20110622131818.15044knmo3u145ts@mail.hendrik-sattler.de>
Date: Wed, 22 Jun 2011 13:18:18 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Li, Nami" <nami@qca.qualcomm.com>,
	Piotr =?iso-8859-1?b?WmfzcmVja2k=?= <pzgorecki@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Liu, Haijun" <haijun@qca.qualcomm.com>,
	"Fan, Hong" <hongfan@qca.qualcomm.com>
Subject: Re: SRM support in OBEX
References: <BANLkTi=T4dqgKW_7WA9BT7EQ9UY4mRZ7JA@mail.gmail.com>
 <EC94610F2568494D8D9291885C48D3103CFE7E@nasanexd01a.na.qualcomm.com>
 <BANLkTimQ-KuUwpn_7-97KBM36vb0gf1gOg@mail.gmail.com>
In-Reply-To: <BANLkTimQ-KuUwpn_7-97KBM36vb0gf1gOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:

> Hi Nami,
>
> 2011/6/22 Li, Nami <nami@qca.qualcomm.com>:
>> Hi, Piotr
>>  I worked on SRM several weeks ago but finally stopped.
>>  It`s easy to set and check SRM header, as well as set the response  
>> mode to OBEX_RSP_MODE_SINGLE. And it is already well supported in  
>> obex_work function when the response mode is SRM, client and server  
>> can continue send data without remote side response or request. The  
>> obex_work callback relationship is:
>> obex_session_start()
>>                                        ...
>>                        g_io_add_watch_full(io, G_PRIORITY_DEFAULT,  
>>     G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,      
>>  obex_handle_input, obex, obex_handle_destroy);
>>                                        ...
>> obex_handle_input()
>>                                        ...
>>                        OBEX_HandleInput(obex, 1)
>>                                        ...
>> OBEX_HandleInput()
>>                                        ...
>>                        obex_work(self, timeout);
>>
>> The problem in SRM is:
>> If remote side doesn`t send any data to local side, then the  
>> G_IO_IN condition couldn`t be set. So how obex_work can be called?
>>
>> I haven`t found any good solution for this issue. So if you can  
>> spend some time on SRM, I`ll be very happy:)
>
> No top posting in this list, please.
>
> So back to the topic, we probably need to add another watch with
> G_IO_OUT when using SRM so that it wake ups whenever we can write to
> the socket/fd, obviously this should only be active when we are
> sending data (GET) and there is no need to call OBEX_HandleInput.

You have to call OBEX_HandleInput() for sure. It does the work also  
for the SRM case. I am also redesigning the state machine in OpenOBEX  
so that incomplete writes on non-blocking sockets are possible. This  
feature will be protected by a flag because it creates a small problem  
like for SRM.
If you need a function in OpenOBEX that tells you if input-independent  
writes are needed, just tell me or create one :-)

HS

