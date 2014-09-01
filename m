Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Sep 2014 15:18:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] emulator/btdev: Fix not disabling le advertising on
 connection
Message-ID: <20140901121845.GA16443@t440s>
References: <1408964932-9690-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408964932-9690-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Aug 25, 2014, Jakub Tyszkowski wrote:
> Le Advertising should be disabled after the le connection is
> established (Core Spec. 4.1 - Part E, Sec. 7.8.9). Not doing so
> results in errors while switching advertisement multiple times during
> different connection states.
> ---
>  emulator/btdev.c | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
