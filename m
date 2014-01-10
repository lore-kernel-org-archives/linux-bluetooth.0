Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] android/tester: Multi property check for test case
Date: Fri, 10 Jan 2014 16:24:27 +0100
Message-ID: <1389370457.yrK6roSgYp@uw000953>
In-Reply-To: <1389363698-30492-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389363698-30492-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 10 of January 2014 15:21:38 Grzegorz Kolodziejczyk wrote:
> This patch allows to check multiple properties for test case. Properties
> can be prioritized to allow check if they'll come in right order. Now
> properties aren't treated as a "single" callback. In future in one
> callback multiple properties can come.
> ---
>  android/android-tester.c | 536 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 392 insertions(+), 144 deletions(-)

Applied, thanks.

-- 
Best regards, 
Szymon Janc
