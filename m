Return-Path: <cyrus@holtmann.org>
Date: Sat, 13 Oct 2012 19:49:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] heartrate: Fix registration of notification handler
Message-ID: <20121013164914.GA9534@x220.P-661HNU-F1>
References: <1350141502-4385-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350141502-4385-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Sat, Oct 13, 2012, Andrzej Kaczmarek wrote:
> Notification handler is registered only when CCC is written during
> descriptors discovery, i.e. at least one watcher is registered before
> device is connected. This means there will be no handler registered in
> case watcher is registered after device already connected.
> This is side-effect of 74a9fc7.
> 
> This patch registers handler immediately when measurement characteristic
> is discovered so it does not matter when watcher is registered.
> 
> ccc_write_cb() is reduntant in this case so it's removed.
> ---
>  profiles/heartrate/heartrate.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Both patches have been applied. Thanks.

Johan
