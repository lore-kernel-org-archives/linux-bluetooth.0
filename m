Return-Path: <cyrus@holtmann.org>
Message-ID: <1358431772.3059.13.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: Add option for SCO socket mode
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Jan 2013 06:09:32 -0800
In-Reply-To: <1358426389-25903-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
	 <1358426389-25903-2-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch extends the current SCO socket option to add a 'mode' field. This
> field is intended to choose data type at runtime. Current modes are CVSD and
> transparent SCO, but adding new modes could allow support for CSA2 and fine
> tuning a sco connection, for example latency, bandwith, voice setting. Incoming
> connections will be setup during defered setup. Outgoing connections have to
> be setup before connect(). The selected type is stored in the sco socket info.
> This patch declares needed members and implements getsockopt().
> ---
>  include/net/bluetooth/sco.h |   20 ++++++++++++++++++++
>  net/bluetooth/sco.c         |    3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index 1e35c43..bc5d3d6 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -41,8 +41,27 @@ struct sockaddr_sco {
>  
>  /* SCO socket options */
>  #define SCO_OPTIONS	0x01
> +
> +#define SCO_MODE_CVSD		0x00
> +#define SCO_MODE_TRANSPARENT	0x01
> +#define SCO_MODE_ENHANCED	0x02
> +

I do not like this enhanced magic. How is this suppose to work? And it
is also not explained in the commit message. Or used in this patch.

Regards

Marcel


