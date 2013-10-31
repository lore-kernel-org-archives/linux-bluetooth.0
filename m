Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 15:48:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/client: Don't alignt name property while printing
Message-ID: <20131031134852.GD21600@x220.p-661hnu-f1>
References: <1383225721-7579-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383225721-7579-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 31, 2013, Szymon Janc wrote:
> Received name property is guaranteed to be NULL terminated so there is
> no need to use length specifier. This also fix really long space while
> printing due to text alignment to the right.
> ---
>  android/client/if-bt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied (after the obvious typo fix for the subject). Thanks.

Johan
