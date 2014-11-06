Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/14] 2nd part of handsfree Android 5.0 adaptation code
Date: Thu, 06 Nov 2014 12:42:47 +0100
Message-ID: <2362169.Zd6WZyUPBF@uw000953>
In-Reply-To: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415262729-12573-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thursday 06 of November 2014 10:31:55 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add support for Android 5.0 interfaces (2nd part of patches) - callbacks.
> 
> Andrei Emeltchenko (14):
>   android/handsfree: Add support for new API for vr_cmd_cb
>   android/handsfree: Add support for new API for handle_answer
>   android/handsfree: Add support for new API for hangup_call_cmd_cb
>   android/handsfree: Add support for new API for volume_cmd_cb
>   android/handsfree: Add support for new API for dial_call_cmd_cb
>   android/handsfree: Add support for new API for handle_dtmf
>   android/handsfree: Add support for new API for nrec_cmd_cb
>   android/handsfree: Add support for new API for chld_cmd_cb
>   android/handsfree: Add support for new API for cnum_cmd_cb
>   android/handsfree: Add support for new API for cind_cmd_cb
>   android/handsfree: Add support for new API for cops_cmd_cb
>   android/handsfree: Add support for new API for clcc_cmd_cb
>   android/handsfree: Add support for new API for unknown_at_cmd_cb
>   android/handsfree: Add support for new API for key_pressed_cmd_cb
> 
>  android/hal-handsfree.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-----
>  android/hal-ipc-api.txt | 25 ++++++++-----
>  android/hal-msg.h       | 28 +++++++++++++++
>  android/handsfree.c     | 48 +++++++++++++++++++++----
>  4 files changed, 172 insertions(+), 24 deletions(-)
 
All patches applied, thanks a lot.

-- 
Best regards, 
Szymon Janc
