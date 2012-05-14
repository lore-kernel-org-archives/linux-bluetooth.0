Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 14 May 2012 20:00:43 +0300
Message-ID: <CABBYNZKyPPb=Ov+6p6-9PUY6nrBTD1M_Ew9YeF_cxt8OQ5x85Q@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 0/5] ACL disconnect reason
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, May 14, 2012 at 6:32 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Some use-cases require distinguishing the reason behind an ACL disconnection. Particularly, IVI use-cases regarding HFP and A2DP need to know if a disconnection was due to a timeout, in order to know which should be the reconnection strategy.

Afaik there is only one use case which is link loss aka out of range,
because of that carkit/headset policy is normally clean disconnect do
not reconnect, non-clean disconnect do reconnect.

>
> This information needs to be exposed to some component implementing the specific policy of each application. Typically neither BlueZ or oFono (in case of HFP) would be the case. This means the disconnect reason needs to be exposed in D-Bus.
>
> In this patch series the proposed approach is to add a signal in the device API, given that we already have some low-level disconnection-related API there. Another approach would be to support it in the specific HFP and A2DP interfaces.

The disconnect reason might no be necessary, have you thought about
implementing the reconnection logic directly in bluetoothd? This way
we can test this without the UI, and we know when for example A2DP has
disconnect without CLOSE command or things like that and afaik we can
query the error from the socket.

Btw, none of this is useful without tuning the link supervision
timeout because the current one used by BlueZ iirc is 20 seconds, far
too big for being able to recover the audio.

-- 
Luiz Augusto von Dentz
