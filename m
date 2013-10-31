Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 15:45:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/daemon: Fix error setting property
Message-ID: <20131031134516.GA21600@x220.p-661hnu-f1>
References: <1383220358-5436-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383220358-5436-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 31, 2013, Andrei Emeltchenko wrote:
> Do not return error setting property which is already set. This fixes
> bug with set_scan_mode which might return HAL_STATUS_DONE.
> ---
>  android/adapter.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
