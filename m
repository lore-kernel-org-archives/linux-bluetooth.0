Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jul 2011 20:18:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Fix possible invalid read/free on manager.c
Message-ID: <20110714171811.GA32109@dell.ger.corp.intel.com>
References: <1310624928-17720-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310624928-17720-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 14, 2011, Luiz Augusto von Dentz wrote:
> +static void remove_adapter(void *data)
> +{
> +	struct btd_adapter *adapter = data;
> +
> +	adapter_remove(adapter);
> +	btd_adapter_unref(adapter);
> +}

The only places that call this function don't anymore use generic
pointers so it can actually have struct btd_adapter instead of void.
However, since this function is getting so simple I think it'd be more
transparent if you just did these calls in the two places where it's
necessary and don't have this extra helper function at all.

Johan
