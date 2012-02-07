Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA37ikbn7KUDh0tNR63NY6n4Ah64VLL+x-iq79oZiWGZuDOU+g@mail.gmail.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
	<201202071221.51920.szymon.janc@tieto.com>
	<CAA37ikZSaELhgHmU53jYA==B-11PPiAxVnKxuEjHQMaQiddZCw@mail.gmail.com>
	<201202071302.59506.szymon.janc@tieto.com>
	<CAA37ika1p7nHs97Nu3kmS5ARK7qjGA0RtHSVeq9+FJ8pF745bw@mail.gmail.com>
	<CABBYNZJ8rRS6C_2bsiH9fBRT8-OmLZW5P7MKCSvKp9tC2X2cJw@mail.gmail.com>
	<CAA37ikbn7KUDh0tNR63NY6n4Ah64VLL+x-iq79oZiWGZuDOU+g@mail.gmail.com>
Date: Tue, 7 Feb 2012 15:59:35 +0200
Message-ID: <CABBYNZJaVutBCNGfQXV5n-LNyAdf_u7yRrK9U3DKd3bVEGk8UA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 7, 2012 at 3:45 PM, Ulisses Furquim <ulisses@profusion.mobi> wrote:
>> Btw, here is what Ive been using to test this code:
>>
>>> obexd/tools/test-server -b -c 4097 -p -i 32767 -o 32767
>>
>>> obexd/tools/test-client -b -s <address of source adapter> -d <address of destination adapter> -c 4097 -p -i 32767 -o 32767
>
> Ok. Are you running them on the same machine with 2 dongles?

Yep

>> Im using 32767 as MTU because that is what we use by default in OBEX,
>> but currently it doesn't work due to some bug in ERTM that apparently
>> doesn't handle MTU being bigger than mts * tx_win, so the transfer
>> just stall at some point, using something like 16384 works though.
>
> Does it stall forever? I have no idea what might be this one.

It timeout after 10 seconds than the client disconnects, but I don't
think it would recover even after that since basically each side does
ack with s-frame RR and nothing else happen. I suspect we are going
past what a window could carry (tx_win (63) * mts (300)) because the
MTU is bigger than that the sdu_len can be bigger too, afaik this
would have to be fragmented in different window or perhaps the mts
size should be adjusted too, but lets figure out this in another
thread to avoid too much noise here.

-- 
Luiz Augusto von Dentz
