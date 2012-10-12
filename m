Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 14:16:28 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 1/8] Bluetooth: Fix L2CAP coding style
Message-ID: <20121012111626.GC28051@aemeltch-MOBL1>
References: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349938311-25101-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 11, 2012 at 02:51:44PM +0800, Gustavo Padovan wrote:
> -static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen, unsigned long *val)
> +static inline int l2cap_get_conf_opt(void **ptr, int *type, int *olen,
> +				     unsigned long *val)

For those functions you could also remove inline

Best regards 
Andrei Emeltchenko 


