Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Feb 2011 13:14:51 -0800
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 6/7 v2] Introduction of phonebook_pull_read
Message-ID: <20110211211451.GE26894@jh-x301>
References: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
 <1297433139-10923-6-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297433139-10923-6-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Radek,

On Fri, Feb 11, 2011, Radoslaw Jablonski wrote:
> +	ret = phonebook_pull_read(irmc->request);
> +
> +	if (err) {
> +		*err = ret;
> +	}

No empty line before the if-statement and no {} for one-line sections.

> +		ret = phonebook_pull_read(irmc->request);
> +
> +		if (ret < 0) {

No empty line here, like above.

> +	ret = phonebook_pull_read(request);
> +
> +	if (ret < 0)

Same here.

> +		len = string_read(obj->buffer, buf, count);
> +
> +		if (len == 0 && !obj->lastpart) {

And here.

Johan
