Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: fabien.proriolpatch@kazoe.org, linux-bluetooth@vger.kernel.org
Cc: fabien.proriol@jdsu.com
Subject: Re: [PATCH] Fix obex protocol for powerpc
In-Reply-To: <1469538851-17006-1-git-send-email-fabien.proriolpatch@kazoe.org>
References: <1469538851-17006-1-git-send-email-fabien.proriolpatch@kazoe.org>
Date: Tue, 26 Jul 2016 15:25:27 -0300
Message-ID: <87bn1kcl48.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabien,

fabien.proriolpatch@kazoe.org writes:

> From: Fabien Proriol <fabien.proriol@jdsu.com>
>
> omtu and imtu is define as uint16_t in l2cap_get function (use with va_arg).
>
> Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>
> ---

Nice catch. Looks good.

If you could send a patch fixing 'obexd/client/bluetooth.c' as well, it
would be awesome, seems the same issue also happens there.


Cheers,
--
Vinicius
