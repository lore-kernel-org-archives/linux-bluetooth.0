Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Mar 2013 09:23:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/3] core: Add DisableProfiles entry to main.conf
Message-ID: <20130307072312.GA28996@x220>
References: <1362566668-5098-1-git-send-email-luiz.dentz@gmail.com>
 <1362566668-5098-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362566668-5098-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Mar 06, 2013, Luiz Augusto von Dentz wrote:
>  int btd_profile_register(struct btd_profile *profile)
>  {
> +	int i;
> +
> +	if (blacklist == NULL)
> +		goto done;
> +
> +	for (i = 0; blacklist[i]; i++) {
> +		if (g_pattern_match_simple(blacklist[i], profile->name))
> +			return -EPROTONOSUPPORT;
> +
> +		if (profile->local_uuid != NULL && strcasecmp(blacklist[i],
> +						profile->local_uuid) == 0)
> +			return -EPROTONOSUPPORT;
> +
> +		if (profile->remote_uuids == NULL)
> +			continue;
> +
> +		if (strcasecmp(blacklist[i], profile->remote_uuids[0]) == 0)
> +			return -EPROTONOSUPPORT;
> +	}

Since this is matching both local and remote UUID it seems like it
wouldn't be possible to just disable one role of an asymmetric profile
(like HFP) since no matter which role's UUID you give it'd always match
both roles.

Johan
