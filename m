Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 16:28:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Didier <didier@archos.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix leftovers handling
Message-ID: <20100825132837.GA26560@jh-x301>
References: <20100825084932.GA27072@cybione.org>
 <20100825112636.GA23943@jh-x301>
 <20100825130607.GA7199@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100825130607.GA7199@cybione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Wed, Aug 25, 2010, Colin Didier wrote:
> If for some reason there is not enough data provided to the function
> bluetooth_a2dp_write() and there are leftovers to handle, the ALSA
> module will segfault.
> ---
>  audio/pcm_bluetooth.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Thanks. This patch is now upstream.

Johan
