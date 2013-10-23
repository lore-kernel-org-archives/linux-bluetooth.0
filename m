Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 10:51:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix compilation error for Android 4.2.2
Message-ID: <20131023075135.GA4406@x220.p-661hnu-f1>
References: <1382436600-8598-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1382438228-23422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382438228-23422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Oct 22, 2013, Andrei Emeltchenko wrote:
> On our current target the tools cannot be compiled.
> ---
>  android/Android.mk        | 2 ++
>  android/client/if-bt.c    | 6 ++++++
>  android/client/if-main.h  | 3 +++
>  android/client/textconv.c | 2 ++
>  4 files changed, 13 insertions(+)

Applied. Thanks.

Johan
