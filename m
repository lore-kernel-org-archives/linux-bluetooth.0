Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Sun, 8 Aug 2010 15:24:15 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-bluetooth@vger.kernel.org, linux-omap@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] net: bluetooth: Fix build error from rfcomm/tty.c
Message-ID: <20100808182414.GB9339@vigoh>
References: <1281258478-17335-1-git-send-email-santosh.shilimkar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281258478-17335-1-git-send-email-santosh.shilimkar@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santosh,

* Santosh Shilimkar <santosh.shilimkar@ti.com> [2010-08-08 14:37:58 +0530]:

> The build error is as follows:
> `rfcomm_cleanup_ttys' referenced in section `.init.text' of net/built-in.o:
> defined in discarded section `.exit.text' of net/built-in.o
> make: *** [.tmp_vmlinux1] Error 1
> 
> This patch fixes by removing __exit from fucntion 'rfcomm_cleanup_ttys'
> to avoid section mismatch
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/rfcomm/tty.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

We have fixed that already, thanks anyway. ;)

-- 
Gustavo F. Padovan
http://padovan.org
