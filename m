Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120208153841.GA3181@joana>
References: <1328708855-3010-1-git-send-email-luiz.dentz@gmail.com>
	<CAA37ikZCMxST2rLb3B2NmnC+h+cstPtTWEz3TUsRGgAMOSDRpA@mail.gmail.com>
	<20120208135910.GF5917@aemeltch-MOBL1>
	<20120208153841.GA3181@joana>
Date: Wed, 8 Feb 2012 18:03:17 +0200
Message-ID: <CABBYNZKrNtOyTBok+qcxVGNDo+3GU1qa3=3B+x92mgihgO59zg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix l2cap_tx_window_full
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Ulisses Furquim <ulisses@profusion.mobi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Feb 8, 2012 at 5:38 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
>
> I followed the specification, next_tx_seq minus expecpted_ack_seq is the
> definition of the current size of the tx_window.
>
> Anyway,
>
> Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

I notice it, It was actually possible to fix this by using
__seq_offset but then I notice in Mat's patch he just use
unacked_frames which is way simpler to read/use. Btw, there is still
something else preventing me to use bigger MTU with OBEX, I can use up
to 32k in kvm but only 16k if I boot it directly, at some point it
just stall in the transmitter even though the receiver acks and the
window is not full.

-- 
Luiz Augusto von Dentz
