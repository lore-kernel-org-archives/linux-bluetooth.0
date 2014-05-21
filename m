Return-Path: <cyrus@holtmann.org>
Date: Wed, 21 May 2014 14:05:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/tester: Add support for debug logs for tester
Message-ID: <20140521110540.GA22193@t440s.lan>
References: <1399473907-9698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399473907-9698-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, May 07, 2014, Grzegorz Kolodziejczyk wrote:
> +void tester_debug(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	if (!tester_use_debug())
> +		return;
> +
> +	printf("   tester-dbg: %s", COLOR_WHITE);

I think it'd be good to make the prefix consistent with the other
logging functions here. Do we really need to know that a line is a debug
print? Isn't it simply enough that the line is printed when debugging is
enabled? I don't see any special identifiers for the other types of logs
either. So unless there's a good reason to have it I'd just keep this
consistent with the other logs.

Johan
