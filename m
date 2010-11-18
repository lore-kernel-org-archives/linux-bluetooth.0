Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Nov 2010 14:43:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Extract service UUIDs from advertising data
Message-ID: <20101118124320.GA4918@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
 <1290009593-13658-2-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290009593-13658-2-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bruna,

On Wed, Nov 17, 2010, Bruna Moreira wrote:
> +	/* Extract UUIDs from extended inquiry response if any */
> +	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
> +	uuid_count = g_slist_length(dev->services);
> +
> +	if (dev->services) {
> +		uuids = strlist2array(dev->services);
> +		g_slist_foreach(dev->services, (GFunc) g_free, NULL);
> +		g_slist_free(dev->services);
> +		dev->services = NULL;
> +	}

What's the reason that the get_eir_uuids API is designed so that it can
handle a list which already contains elements before calling the
function? Since you free the list right after creating the uuids array
it seems like this shouldn't happen. Or am I missing something?

Btw, is there something that could be optimized here since it seems like
you're regenerating the uuids array before every signal even though the
set of service might not have changed since the previous one. Maybe you
should track this and only regenerate the array if there has been a
changed from the previous signal. What do you think?

Johan
