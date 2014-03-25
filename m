Return-Path: <cyrus@holtmann.org>
Message-ID: <1395736353.3010.6.camel@joe-AO722>
Subject: Re: [PATCH] drivers:bluetooth:ath3k.c: Fixed sparse warning for
 cast to restricted __le32
From: Joe Perches <joe@perches.com>
To: Surendra Patil <surendra.tux@gmail.com>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 25 Mar 2014 01:32:33 -0700
In-Reply-To: <1395735950-17968-1-git-send-email-surendra.tux@gmail.com>
References: <1395735950-17968-1-git-send-email-surendra.tux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2014-03-25 at 01:25 -0700, Surendra Patil wrote:
> This patch fixes below Sparse warnings -
> drivers/bluetooth/ath3k.c:370:17: warning: cast to restricted __le32
> drivers/bluetooth/ath3k.c:432:17: warning: cast to restricted __le32

You are changing output here.

I suspect rom_version should be marked __le32 instead
of unsigned int in "struct ath3k_version" instead.

> Signed-off-by: Surendra Patil <surendra.tux@gmail.com>
> ---
>  drivers/bluetooth/ath3k.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
> index be571fe..badacbc 100644
> --- a/drivers/bluetooth/ath3k.c
> +++ b/drivers/bluetooth/ath3k.c
> @@ -367,7 +367,7 @@ static int ath3k_load_patch(struct usb_device *udev)
>  	}
>  
>  	snprintf(filename, ATH3K_NAME_LEN, "ar3k/AthrBT_0x%08x.dfu",
> -		le32_to_cpu(fw_version.rom_version));
> +		fw_version.rom_version);
>  
>  	ret = request_firmware(&firmware, filename, &udev->dev);
>  	if (ret < 0) {
> @@ -429,7 +429,7 @@ static int ath3k_load_syscfg(struct usb_device *udev)
>  	}
>  
>  	snprintf(filename, ATH3K_NAME_LEN, "ar3k/ramps_0x%08x_%d%s",
> -		le32_to_cpu(fw_version.rom_version), clk_value, ".dfu");
> +		 fw_version.rom_version, clk_value, ".dfu");
>  
>  	ret = request_firmware(&firmware, filename, &udev->dev);
>  	if (ret < 0) {
