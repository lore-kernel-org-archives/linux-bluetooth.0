Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Apr 2014 13:12:35 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hciattach: Fix missing includes
Message-ID: <20140415201235.GA3645@t440s.meeting.verilan.com>
References: <1397561453-23047-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397561453-23047-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Apr 15, 2014, Szymon Janc wrote:
> According to writev manual one should include <sys/uio.h> to use it.
> 
> This fix following warnings with bionic:
> external/bluetooth/bluez/tools/hciattach_tialt.c: In function
>     'texas_load_firmware':
> external/bluetooth/bluez/tools/hciattach_tialt.c:142:4: warning:
>     implicit declaration of function 'writev'
>     [-Wimplicit-function-declaration]
> target thumb C: hciattach <= external/bluetooth/bluez/tools/
>     hciattach_ath3k.c
> target thumb C: hciattach <= external/bluetooth/bluez/tools/
>     hciattach_qualcomm.c
> external/bluetooth/bluez/tools/hciattach_qualcomm.c: In function
>     'qualcomm_load_firmware':
> external/bluetooth/bluez/tools/hciattach_qualcomm.c:147:4: warning:
>     implicit declaration of function 'writev'
>     [-Wimplicit-function-declaration]
> ---
>  tools/hciattach_qualcomm.c | 1 +
>  tools/hciattach_tialt.c    | 1 +
>  2 files changed, 2 insertions(+)

Applied. Thanks.

Johan
