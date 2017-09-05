Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tools/csr_usb: Fix compilation failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170905083534.19184-1-hadess@hadess.net>
Date: Tue, 5 Sep 2017 13:51:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FD40CF28-55D4-4091-BAD7-97168812A6B8@holtmann.org>
References: <20170905083534.19184-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> GCC's "format-nonliteral" security check is enabled as an error in
> recent versions of Fedora. Given the reduced scope of use, mark the
> error as ignorable through pragma.
> 
> tools/csr_usb.c: In function 'read_value':
> tools/csr_usb.c:82:2: error: format not a string literal, argument types not checked [-Werror=format-nonliteral]
>  n = fscanf(file, format, &value);
>  ^
> ---
> tools/csr_usb.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/tools/csr_usb.c b/tools/csr_usb.c
> index a1d7324f7..33e9968a2 100644
> --- a/tools/csr_usb.c
> +++ b/tools/csr_usb.c
> @@ -67,6 +67,8 @@ struct usbfs_bulktransfer {
> #define USBFS_IOCTL_CLAIMINTF	_IOR('U', 15, unsigned int)
> #define USBFS_IOCTL_RELEASEINTF	_IOR('U', 16, unsigned int)
> 
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wformat-nonliteral"
> static int read_value(const char *name, const char *attr, const char *format)
> {
> 	char path[PATH_MAX];
> @@ -88,6 +90,7 @@ static int read_value(const char *name, const char *attr, const char *format)
> 	fclose(file);
> 	return value;
> }
> +#pragma GCC diagnostic pop

can’t we just use __attribute__((format)) somehow to declare this a format specify?

Regards

Marcel

