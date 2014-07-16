Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/8] haltest support for Audio SCO HAL testing
Date: Wed, 16 Jul 2014 12:06:03 +0200
Message-ID: <2531197.yT6D9yrepN@uw000953>
In-Reply-To: <1405411167-15638-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405411167-15638-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 15 of July 2014 10:59:19 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Helps to test Audio SCO HAL
> 
> Andrei Emeltchenko (8):
>   android/haltest: Add open/close input stream commands
>   android/haltest: Add read command.
>   android/haltest: Add loop command
>   android/haltest: Implement read to file
>   android/haltest: Add sample rate parameter when opening audio streams
>   android/haltest: Correct check for similar buffer size
>   android/haltest: Add mono to stereo conversion for loopback
>   android/haltest: Refactor stop and closing streams
> 
>  android/Android.mk      |   3 +
>  android/client/if-sco.c | 291 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 283 insertions(+), 11 deletions(-)
> 

All patches applied. Thanks.

(I've changed android/haltest to android/client in commits messages)

-- 
Best regards, 
Szymon Janc
