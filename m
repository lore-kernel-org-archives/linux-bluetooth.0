Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 Oct 2015 10:37:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2] core/device: Fix build on some platforms
Message-ID: <20151023073710.GA18697@t440s.lan>
References: <1445579543-5054-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445579543-5054-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Oct 22, 2015, Jakub Pawlowski wrote:
> due to type promotions in C this code was failing on some platforms.
> 
> src/device.c:2016:8: error: format specifies type 'unsigned short' but the
>       argument has type 'uint8_t' (aka 'unsigned char') [-Werror,-Wformat]
>   properties, uuid_str);
>   ^~~~~~~~~~
> /build/falco/usr/include/bits/stdio2.h:39:7: note: expanded from macro 'sprintf'
>                            __VA_ARGS__)
>                            ^
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
