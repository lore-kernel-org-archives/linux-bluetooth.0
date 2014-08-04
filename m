Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Aug 2014 09:24:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v3 1/6] android/bluetooth: Add flag for kernel connection
 control
Message-ID: <20140804062446.GB9924@t440s.P-661HNU-F1>
References: <1406899885-5338-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1406899885-5338-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406899885-5338-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Fri, Aug 01, 2014, Lukasz Rymanowski wrote:
> +struct main_opts {
> +	bool kernel_conn_control;
> +};
> +
> +extern struct main_opts main_opts;

I'd prefer if we could avoid this hcid-era (i.e. BlueZ 3.x) style
construct. Perhaps a simple static bool kernel_conn_control in
bluetooth.c and then a getter function for modules like gatt.c to get
the value, e.g. bool bt_kernel_conn_control(void);

Johan
