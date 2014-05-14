Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 May 2014 23:15:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] input: Fix compilation errors on 32 bit machine
Message-ID: <20140514201511.GA17904@t440s.P-661HNU-F1>
References: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1400096949-18895-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, May 14, 2014, Szymon Janc wrote:
> Fix following with GCC version 4.8.2 (Debian 4.8.2-21):
> 
>   CC       profiles/input/bluetoothd-device.o
> profiles/input/device.c: In function ‘uhid_send_feature_answer’:
> profiles/input/device.c:232:8: error: format ‘%lu’ expects argument
>   of type ‘long unsigned int’, but argument 3 has type ‘unsigned int’
>    [-Werror=format=]
>         len, sizeof(ev));
>         ^
> profiles/input/device.c: In function ‘uhid_send_input_report’:
> profiles/input/device.c:274:8: error: format ‘%lu’ expects argument of
>    type ‘long unsigned int’, but argument 3 has type ‘unsigned int’
>    [-Werror=format=]
>         len, sizeof(ev));
>         ^
> ---
>  profiles/input/device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All three patches have been applied. Thanks.

Johan
