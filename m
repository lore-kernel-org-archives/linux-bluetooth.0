Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 13:04:34 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Suppress compiler warnings not enabled by
 autotools build
Message-ID: <20131105110434.GA9565@x220.p-661hnu-f1>
References: <1383648613-21352-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383648613-21352-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 05, 2013, Szymon Janc wrote:
> missing-field-initializers warning is not enabled on autotools build.
> Current code rely on implicit fields intializations resulting in flood
> of bogus compiler warnings while building for Android.
> 
> monitor/packet.c:348:2: warning: missing initializer
>     [-Wmissing-field-initializers]
> monitor/packet.c:348:2: warning: (near initialization for
>     'error2str_table[64].error') [-Wmissing-field-initializers]
> monitor/packet.c:542:2: warning: missing initializer
>     [-Wmissing-field-initializers]
> monitor/packet.c:542:2: warning: (near initialization for
>     'svc_class_table[8].bit') [-Wmissing-field-initializers]
> monitor/packet.c:557:2: warning: missing initializer
>     [-Wmissing-field-initializers]
> monitor/packet.c:557:2: warning: (near initialization for
>     'major_class_computer_table[8].val') [-Wmissing-field-initializers]
> ---
>  android/Android.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
