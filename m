Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 16 Nov 2015 15:51:40 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, bharat.panda@samsung.com
Subject: Re: [PATCH] emulator/hciemu: Fix return value
Message-ID: <20151116135140.GA2477@t440s.lan>
References: <1447679560-19712-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1447679560-19712-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Nov 16, 2015, Gowtham Anandha Babu wrote:
> make throws out the following errors.
> 
> emulator/hciemu.c: In function ‘hciemu_get_master_scan_enable’:
> emulator/hciemu.c:433:3: error: return makes integer from pointer without a cast [-Werror]
>    return NULL;
>    ^
> emulator/hciemu.c: In function ‘hciemu_get_master_le_scan_enable’:
> emulator/hciemu.c:441:3: error: return makes integer from pointer without a cast [-Werror]
>    return NULL;
>    ^
> cc1: all warnings being treated as errors
> 
> Fixed by returning zero.
> ---
>  emulator/hciemu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Interestingly these were previously returning 'bool' instead of 'uint8_t'
which apparently didn't cause this kind of warning.

Johan
