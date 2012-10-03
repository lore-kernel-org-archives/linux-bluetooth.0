Return-Path: <cyrus@holtmann.org>
Date: Wed, 3 Oct 2012 11:21:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 BlueZ 01/27] doc: Introduce Alert API
Message-ID: <20121003082118.GA12607@x220>
References: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
 <1349209490-31830-1-git-send-email-anderson.lizardo@openbossa.org>
 <1349209490-31830-2-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349209490-31830-2-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Oct 02, 2012, Anderson Lizardo wrote:
> +		void SetRinger(string mode)
> +
> +			This method is only called if "ringer" alert category
> +			is specified when registering the agent.
> +
> +			Set ringer to the specified mode. If mode is "enabled",
> +			ringer is set to the default mode, as defined by the
> +			current active profile. If mode is "disabled", ringer
> +			will not activate on incoming calls, until it is set
> +			back to "enabled" mode.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments

Since you've used a string here instead of a boolean is it correct to
assume that you want to maintain the capability of extending the
possible values to more than just "enabled" and "disabled"? Does the
current profile/service specification already proved more possibilities
than these two values?

Johan
