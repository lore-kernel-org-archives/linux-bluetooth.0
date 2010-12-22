Return-Path: <cyrus@holtmann.org>
Date: Thu, 23 Dec 2010 00:44:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] sbc: detect when bitpool has changed
Message-ID: <20101222224424.GC10702@jh-x301>
References: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1293010548-25151-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Dec 22, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> A2DP spec allow bitpool changes midstream which is why sbc configuration
> has a range of values for bitpool that the encoder can use and decoder
> must support.
> 
> Bitpool changes do not affect the state of encoder/decoder so they don't
> need to be reinitialize when this happens, so the impact is fairly small,
> what it does change is the frame length so encoders may change the
> bitpool to use the link more efficiently.
> ---
>  sbc/sbc.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)

The patch has been pushed upstream. Thanks. Could you also make sure
that it gets applied to PulseAudio's copy of libsbc?

Johan
