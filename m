Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 18:05:25 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix: increment MDL and MCL reference counter in IO
 watchers.
Message-ID: <20101122170525.GA13003@jh-x301>
References: <AANLkTinQAeN8jyBmmPnw0tMWDfvOVamOU5+gBXLF-hTT@mail.gmail.com>
 <1290437712-28991-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290437712-28991-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Mon, Nov 22, 2010, Jose Antonio Santos Cadenas wrote:
> When a io_watcher is added to an MDL or an MCL channel, its reference
> should be incremented because the watcher should keep its own
> reference the the structure.
> 
> Also  a destroy function is added in order to decrement the reference
> once the watcher is removed.
> ---
>  health/mcap.c |   28 +++++++++++++++++++---------
>  1 files changed, 19 insertions(+), 9 deletions(-)

Thanks. Pushed upstream, but I still had to tweak the summary line a
little bit (take a look at the upstream tree if you're interested).

Johan
