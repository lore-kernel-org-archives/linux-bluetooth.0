Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391772937-12802-2-git-send-email-lukasz.rymanowski@tieto.com>
References: <1391772937-12802-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1391772937-12802-2-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 11 Feb 2014 17:23:48 +0100
Message-ID: <CAMudyAvgG-zjxFS0xjshKOQ7qfkMo=3L4rXnrgOGpqJp_narAQ@mail.gmail.com>
Subject: Re: [RFC 1/2] Add basic API for shared memory driver
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-arm-msm@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On 7 February 2014 12:35, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> This patch adds simple API to shared memory driver based on msm-smd.h
> This is required in order to add support for support Qualcomm BT chips
> via SMD
>
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
>  include/linux/smd.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 include/linux/smd.h
>
> diff --git a/include/linux/smd.h b/include/linux/smd.h
> new file mode 100644
> index 0000000..58de0d4
> --- /dev/null
> +++ b/include/linux/smd.h
> @@ -0,0 +1,69 @@
> +/*
> +* smd.h - API for Shared Memory Driver
> +*
> +* Copyright (c) 2014 Intel Corporation
> +*
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License version 2 as
> +* published by the Free Software Foundation.
> +*/
> +
> +#ifndef _SMD_H_
> +#define _SMD_H_
> +
> +#include <linux/platform_device.h>
> +
> +/**
> +* Events from smd device.
> +*/
> +#define SMD_EVENT_DATA 1
> +#define SMD_EVENT_OPEN 2
> +#define SMD_EVENT_CLOSE 3
> +
> +struct smd_channel;
> +struct smd_notify_data;
> +struct smd_data;
> +
> +/**
> +* struct smd_ops - specific operation for smd channel
> +*
> +* @open:       Open SMD channel. It should return zero once device is opened.
> +*              On open there is need to pass notification cb which is used
> +*              for notifications form SMD device.
> +* @close       Close SMD channel
> +* @write:      Write data to SMD channel. It should return number of written
> +*              bytes or negative value in case of error.
> +* @read:       Read data from SMD channel.It should return number of written
> +*              bytes or negative value in case of error.
> +*@read_avail:  Returns number of bytes ready to be read. This should be called
> +*              before read in order to allocate enought skb
> +*
> +*/
> +struct smd_ops {
> +       int (*open)(struct smd_data *s,
> +               void (*notify)(struct platform_device *pdev,
> +                                                       unsigned int event));
> +       int (*close)(struct smd_data *s);
> +       int (*write)(struct smd_data *s, const void *data, int len);
> +       int (*read)(struct smd_data *s, void *buf, int len);
> +       int (*read_avail)(struct smd_data *s);
> +};
> +/**
> +* struct smd_data - smd device data for shared memory channel
> +*
> +* @pdev:       Platform device for given smd channel.
> +* @ops:                SMD specific operations for this smd channel.
> +* @ch:         SMD channel which is used by SMD device. Should not be
> +*              used by the driver
> +* @notifier:   SMD notifier data. Shall not be used by driver.
> +*
> +* smd_data are initialized by the platform and are available for driver
> +* in platform_data.
> +*/
> +struct smd_data {
> +       struct platform_device *pdev;
> +       struct smd_ops ops;
> +       struct smd_channel *ch;
> +       struct smd_notify_data *notify_data;
> +};
> +#endif
> --

Adding linux-arm-msm group for comments on SMD API

BR
Lukasz
> 1.8.4
>
