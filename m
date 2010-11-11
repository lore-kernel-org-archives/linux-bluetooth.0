Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 11:18:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add a new configuration option to disable Low Energy
 support
Message-ID: <20101111091857.GA2862@jh-x301>
References: <1289426161-10045-1-git-send-email-claudio.takahasi@openbossa.org>
 <1289426161-10045-3-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289426161-10045-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, Nov 10, 2010, Claudio Takahasi wrote:
> @@ -623,6 +624,9 @@ int attrib_server_init(void)
>  
>  	sdp_handle = record->handle;
>  
> +	if (!main_opts.le)
> +		return 0;
> +

If the option is called "le" it shouldn't affect GATT over BR/EDR, so I
think the check in attrib_server_init should only affect the LE socket
(or then rename the option to e.g. main.opts.attrib).

Johan
