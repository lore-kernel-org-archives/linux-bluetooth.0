Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Feb 2011 23:56:53 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add sec-level option to interactive gattool
Message-ID: <20110224025653.GB6189@jh-x301>
References: <1298496610-11705-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298496610-11705-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Feb 23, 2011, Sheldon Demario wrote:
> +	if (conn_state == STATE_CONNECTED) {

I think it'd be cleaner to have:

	if (conn_state != STATE_CONNECTED)
		return;

> +
> +	return;
> +}

Never have empty return statements at the end of void-functions.

Johan
