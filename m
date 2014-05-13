Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/bluetooth: Make sure proper controller mode is set on start
Date: Tue, 13 May 2014 18:21:15 +0200
Message-ID: <6281335.2xjLc9EaKl@uw000953>
In-Reply-To: <1399540033-26119-1-git-send-email-szymon.janc@tieto.com>
References: <1399540033-26119-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 08 of May 2014 11:07:13 Szymon Janc wrote:
> BR/EDR and LE features can be toggled before daemon is started and
> we should not assume their state.
> ---
>  android/bluetooth.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 2bc79e2..dbd6102 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c

Applied.

-- 
Best regards, 
Szymon Janc
