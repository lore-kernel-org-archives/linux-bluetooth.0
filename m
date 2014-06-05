Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jun 2014 20:38:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix compile error
Message-ID: <20140605173818.GA8098@t440s.P-661HNU-F1>
References: <1401720579-18551-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401720579-18551-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Mon, Jun 02, 2014, Andre Guedes wrote:
> During configure, if SBC is not installed in the system, we may use
> SBC_CFLAGS and SBC_LIBS variables to indicate where SBC headers and
> binaries can be found.
> 
> However, SBC_CFLAGS variable is not used in android/Makefile.am,
> causing the following compile error:
> 
> $ ./bootstrap-configure SBC_CFLAGS=-I../sbc SBC_LIBS=-L../sbc/src/
> $ make
> 
> (...)
> 
> android/hal-audio-sbc.c:22:21: fatal error: sbc/sbc.h: No such file or directory
>  #include <sbc/sbc.h>
> ^
> compilation terminated.
> make[1]: *** [android/android_audio_a2dp_default_la-hal-audio-sbc.lo] Error 1
> 
> This patch fixes this error by appending SBC_CFLAGS to android_audio_
> a2dp_default_la_CFLAGS.
> ---
>  android/Makefile.am | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
