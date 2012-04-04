Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Apr 2012 13:01:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] gdbus: Use destroy callback for service watch
Message-ID: <20120404100117.GB11856@x220>
References: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Apr 03, 2012, Anderson Lizardo wrote:
> Even though service watches accepted a "destroy" callback, they were
> being ignored. This fix properly pass them along so they are called when
> the watch is removed.
> ---
>  gdbus/watch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

All three patches have been applied. I also applied this gdbus one to
the obexd tree. Thanks.

Johan
