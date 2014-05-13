Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/pts: Add PTS test listing for HDP
Date: Tue, 13 May 2014 12:56:56 +0200
Message-ID: <1642632.UvNO225g6O@uw000953>
In-Reply-To: <1399976751-4206-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399976751-4206-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 13 of May 2014 12:25:49 Sebastian Chlad wrote:
> ---
>  android/Makefile.am |  3 ++-
>  android/pts-hdp.txt | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 android/pts-hdp.txt
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 78015e6..3d1595f 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am

Patches 1 and 2 applied, thanks.

For MPS please enable AVRCP as we discussed offline.

-- 
Best regards, 
Szymon Janc
