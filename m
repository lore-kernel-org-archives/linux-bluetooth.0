Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 10:41:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android: Add supported uuids when adapter initialized
Message-ID: <20131031084146.GC1271@x220.p-661hnu-f1>
References: <1383146314-13456-1-git-send-email-marcin.kraglak@tieto.com>
 <1383146314-13456-2-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383146314-13456-2-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Oct 30, 2013, Marcin Kraglak wrote:
> +/*
> + * This is an array of supported uuids and service hints. We add them via mgmt
> + * interface when adapter is initialized. Uuids are in reverse orded.
> + */
> +static const struct mgmt_cp_add_uuid sup_uuids[] = {
> +	/* OBEX */
> +	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
> +	0x10, 0x00, 0x00, 0x05, 0x11, 0x00, 0x00}, 0x10},
> +	/* TELEPHONY */
> +	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
> +	0x10, 0x00, 0x00, 0x1f, 0x11, 0x00, 0x00}, 0x40},
> +	/* CAPTURING */
> +	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
> +	0x10, 0x00, 0x00, 0x0d, 0x11, 0x00, 0x00}, 0x08},
> +	/* NETWORKING */
> +	{{0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80, 0x00,
> +	0x10, 0x00, 0x00, 0x15, 0x11, 0x00, 0x00}, 0x02} };

I think you should at least mention here exactly which UUIDs you're
adding. It looks like it's OPP, HFP AG, Advanced Audio and PANU but it'd
be nicer to be clear about this in the code comment.

The table would also be more readable if you did something like

static const struct mgmt_cp_add_uuid uuids[] = {
	{ .uuid = ...,
	  .svc_hint = ... },
	{ .uuid = ...,
	  .svc_hint = ... },
};

Note that our coding style puts a space after { and before }.

Johan
