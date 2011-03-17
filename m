Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 14:30:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] Add internal buffer to GAttrib struct
Message-ID: <20110317123031.GA12238@jh-x301>
References: <1300274712-3931-1-git-send-email-bruna.moreira@openbossa.org>
 <1300274712-3931-2-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300274712-3931-2-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Mar 16, 2011, Bruna Moreira wrote:
> +gboolean g_attrib_set_buffer(GAttrib *attrib, int mtu)
> +{
> +	if (mtu < ATT_DEFAULT_LE_MTU)
> +		mtu = ATT_DEFAULT_LE_MTU;
> +
> +	if (mtu > ATT_MAX_MTU)
> +		mtu = ATT_MAX_MTU;
> +
> +	if (!bt_io_set(attrib->io, BT_IO_L2CAP, NULL,
> +			BT_IO_OPT_OMTU, mtu,
> +			BT_IO_OPT_INVALID))
> +		return FALSE;
> +
> +	attrib->buf = g_realloc(attrib->buf, mtu);
> +
> +	attrib->buflen = mtu;
> +
> +	return TRUE;
> +}

Wouldn't g_attrib_set_mtu make more sense for the name of this function?
Since it's named symmetrically to the _get version one would expect it
to take a buffer as an input parameter, but it's not doing that.

Johan
