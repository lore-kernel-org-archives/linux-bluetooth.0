Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Dec 2010 13:57:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Sheldon Demario <sheldon.demario@openbossa.org>
Subject: Re: [PATCH 03/18] Move primary service storage to device.c
Message-ID: <20101222115722.GC27483@jh-x301>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
 <1292966800-6264-4-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292966800-6264-4-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 21, 2010, Vinicius Costa Gomes wrote:
> +void att_primary_free(struct att_primary *prim)
> +{
> +	g_free(prim);
> +}

<snip>

> +	g_slist_foreach(ctxt->primaries, (GFunc) att_primary_free, NULL);

If you're gonna do typecasting to GFunc (something which btw should be
avoided whenever possible) you might as well pass g_free directly and
not create any dedicated function for it.

Johan
