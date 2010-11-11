Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Nov 2010 22:54:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Adding a new option to specify medium security level
 for gatttool
Message-ID: <20101111205448.GA22890@jh-x301>
References: <1289424095-26628-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289424095-26628-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Wed, Nov 10, 2010, Sheldon Demario wrote:
> -- Add command line support to use medium instead of (default) low
> -  security level with gatttool (--sec-level)
> -
> -  Priority: Low
> -  Complexity: C1
> -
<snip>
> +	{ "sec-medium", 's', 0, G_OPTION_ARG_NONE, &opt_medium_sec,
> +		"Use medium instead of default low security level",
> +		NULL},

Maybe the TODO entry should have been more clear, but I'd prefer if the
option would be of the format "--sec-level <level>" where <level> is
"low", "medium" or "high". I'm not completely sure I like --sec-level
either (even though I did write the original TODO entry :) What do you
think about simply "--security <level>"?

Johan
