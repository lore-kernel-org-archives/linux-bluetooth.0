Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Apr 2012 13:15:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] DeviceInfo: Fix compilation with old glib
Message-ID: <20120405101555.GA32212@x220>
References: <1333551502-28159-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1333551502-28159-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Apr 04, 2012, Szymon Janc wrote:
> Add missing include glib-compat.h to deviceinfo.c. deviceinfo_free
> is using g_slist_free_full() which is not available in old glib
> resulting in compilation error.
> 
> deviceinfo/deviceinfo.c: In function ‘deviceinfo_free’:
> deviceinfo/deviceinfo.c:66: error: implicit declaration of function ‘g_slist_free_full’
> ---
>  deviceinfo/deviceinfo.c |    1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

Johan
