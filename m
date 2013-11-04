Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Nov 2013 12:15:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix not sending scan mode change notification
Message-ID: <20131104101538.GE2752@x220.p-661hnu-f1>
References: <1383559199-22843-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383559199-22843-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 04, 2013, Szymon Janc wrote:
> Check for current settings instead of changed setting mask when
> sending notification. Otherwise scan mode change would be communicated
> only if power state changed at the same time.
> ---
>  android/adapter.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
