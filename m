Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 10:07:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH 2/2] android: Add set/get for discovery timeout
Message-ID: <20131107080758.GA7493@x220.p-661hnu-f1>
References: <1383750530-18815-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1383750530-18815-2-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383750530-18815-2-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Nov 06, 2013, Lukasz Rymanowski wrote:
>  static bool get_discoverable_timeout(void)
>  {
> -	DBG("Not implemented");
> +	struct hal_ev_adapter_props_changed *ev;
> +	int len;
>  
> -	/* TODO: Add implementation */
> +	len = sizeof(*ev) + sizeof(struct hal_property) + sizeof(uint32_t);
>  

The dynamic memory allocation seems a bit overkill here since the size is
not very big and can be determined even at compile time. I'd consider
doing something like:

	uint8_t buf[sizeof(struct hal_ev_adapter_props_changed) +
			sizeof(struct hal_property) + sizeof(uint32_t)];
	struct hal_ev_adapter_props_changed *ev = (void *) buf;

	...

	ipc_send(..., sizeof(buf), buf, ...);

Johan
