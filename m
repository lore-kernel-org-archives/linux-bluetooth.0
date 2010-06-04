Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jun 2010 14:34:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Fix regression with debug via SIGUSR2
Message-ID: <20100604113422.GA6118@jh-x301>
References: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275646613-32639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Jun 04, 2010, Gustavo F. Padovan wrote:
> +static void turn_debug_on(const char *debug)

Please call this simply debug_on()

> +static void turn_debug_off()

same here (debug_off)

> +void __btd_toogle_debug()

It's called toggle and not toogle :)

> +	if (enabled == NULL)
> +		turn_debug_on("*");

I suppose this should restore the previous value and not hard-code "*"?

Johan
