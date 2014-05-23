Return-Path: <cyrus@holtmann.org>
Date: Fri, 23 May 2014 14:40:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 06/11] core: Make connection properties exist only when
 connected
Message-ID: <20140523114007.GA29929@t440s.lan>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1400543083-28811-7-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400543083-28811-7-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, May 20, 2014, Andrzej Kaczmarek wrote:
> +static gboolean dev_property_exists_conn(const GDBusPropertyTable *property,
> +								void *data)
> +{
> +	struct btd_device *device = data;
> +
> +	/* TODO: only exists when monitoring is enabled? */
> +	return btd_device_is_connected(device) ? TRUE : FALSE;

To answer this open, yes, I think the properties should only be
available when there is someone that has requested monitoring of them.
If you didn't fix this later in the set please do it for the first
non-RFC set that you send. I haven't seen anything else too
objectionable in this set.

Johan
