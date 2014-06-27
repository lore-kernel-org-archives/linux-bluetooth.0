Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Initial test files for ScPP
Date: Fri, 27 Jun 2014 18:36:34 +0200
Message-ID: <11702433.hDmtY3Zx7U@uw000953>
In-Reply-To: <1403263532-3370-1-git-send-email-sebastian.chlad@tieto.com>
References: <1403263532-3370-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 20 of June 2014 13:25:31 Sebastian Chlad wrote:
> Some PICS for ScPP are optional. These PICS should be filled accordingly by
> developers so it will be clear what is supported and what should be tested.
> 
> As of now most of the tests in pts-scpp.txt are set to INC.
> 
> Sebastian Chlad (1):
>   android/pts: Initial test files for ScPP
> 
>  android/Makefile.am    |   5 +-
>  android/pics-scpp.txt  | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
>  android/pixit-scpp.txt |  24 +++++++++
>  android/pts-scpp.txt   |  25 +++++++++
>  4 files changed, 196 insertions(+), 1 deletion(-)
>  create mode 100644 android/pics-scpp.txt
>  create mode 100644 android/pixit-scpp.txt
>  create mode 100644 android/pts-scpp.txt
> 

I've updated PICS and test results and applied patch. Thanks.

-- 
Best regards, 
Szymon Janc
