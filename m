Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Aug 2014 09:48:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH ] GATT: Fixed PTS issues for multiple write request
Message-ID: <20140818064848.GA7214@t440s.P-661HNU-F1>
References: <1408342269-25170-1-git-send-email-bharat.panda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408342269-25170-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Mon, Aug 18, 2014, Bharat Panda wrote:
> Updates gatt attribute db using offset value. This fixes below
> PTS TCs.
> 
> TP/GAW/SR/BV-06-C
> TP/GAW/SR/BV-10-C
> TP/GAW/SR/BI-14-C
> TP/GAW/SR/BI-15-C
> TP/GAW/SR/BV-05-C
> TP/GAW/SR/BI-07-C
> TP/GAW/SR/BI-08-C
> TP/GAW/SR/BI-34-C
> TP/GAW/SR/BI-25-C
> TP/GAW/SR/BI-26-C
> ---
>  plugins/gatt-example.c        |  2 +-
>  profiles/alert/server.c       | 16 ++++++-------
>  profiles/proximity/linkloss.c |  2 +-
>  profiles/time/server.c        |  6 ++---
>  src/attrib-server.c           | 53 +++++++++++++++++++++++++++++++++++--------
>  src/attrib-server.h           |  2 +-
>  6 files changed, 57 insertions(+), 24 deletions(-)

Your commit message should have a bit more content, i.e. give some more
background to the issue and justify & explain the way that you're
solving it. Also, the subject seems misleading to me as this is related
to long writes and not "multiple write".

> -	case ATT_OP_READ_MULTI_REQ:
>  	case ATT_OP_PREP_WRITE_REQ:
> +		length = dec_prep_write_req(ipdu, len, &start, &offset, value, &vlen);
> +		if (length == 0) {
> +			status = ATT_ECODE_INVALID_PDU;
> +			goto done;
> +		}
> +
> +		length = write_value(channel, start, value, vlen, opdu,
> +									channel->mtu, offset);
> +		break;
> +
>  	case ATT_OP_EXEC_WRITE_REQ:
> +		break;
> +	case ATT_OP_READ_MULTI_REQ:
>  	default:
>  		DBG("Unsupported request 0x%02x", ipdu[0]);
>  		status = ATT_ECODE_REQ_NOT_SUPP;

This doesn't look right. The changes should not be taking effect until
execute write has been issued. Here it seems the write_value() makes an
irreversible change to the database.

> -	a->data = g_try_realloc(a->data, len);
> +	if (offset) {
> +		uint8_t *temp;
> +		temp = malloc(sizeof(uint8_t) * a->len);
> +		if (temp == NULL) {
> +			DBG("Unable to allocate memory");
> +			return -ENOMEM;
> +		}
> +		memcpy(temp, a->data, a->len);
> +		a->data = g_try_realloc(a->data, (a->len + (a->len - offset) + len));

This calculation doesn't look right. Shouldn't the new size be simply
offset + len? Or if offset + len is less than the original length and
the specification requires to preserve the data after it (which I'm not
sure it does) then you'd need some extra condition here. You'd also not
need realloc in this case since the buffer wouldn't grow.

> +		memcpy(a->data, temp, a->len);

First of all the "try" versions of GLib allocation functions may return
NULL so you can't just copy to a->data without checking first. However,
most of this code is completely unnecessary: realloc maintains the the
contents of the memory so there's no need of a temporary buffer here.

> +		free(temp);
> +	}
> +	else {
> +		a->data = g_try_realloc(a->data, len);
> +	}

The coding style is:

	if (...) {
		...
		...
	} else {
		...
		...
	}

> +	if (offset) {
> +		a->len = a->len + (a->len - offset) + len;

Shouldn't this be a->len = offset + len?

> +		memcpy((a->data + offset), value, len);
> +	}
> +	else {
> +		a->len = len;
> +		memcpy(a->data, value, len);
> +	}

Same thing as earlier with the if-else coding style.

Johan
