Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Apr 2012 10:51:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org, hemant.gupta@stericsson.com
Subject: Re: [PATCH] hciops: map KeyboardDisplay IO Capability to DisplayYesNo
Message-ID: <20120419075140.GA20738@x220.ger.corp.intel.com>
References: <1334786461-5643-1-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334786461-5643-1-git-send-email-scott@netsplit.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Wed, Apr 18, 2012, Scott James Remnant wrote:
> Since hciops is not used for LE devices, if an agent announces the
> KeyboardDisplay IO Capability when creating a bonding, map it to
> DisplayYesNo.
> 
> This matches the existing change in hciops_set_io_capability which
> is only used in the RegisterAgent path.
> ---
>  plugins/hciops.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
