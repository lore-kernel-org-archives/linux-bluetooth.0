Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 14:28:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org, keybuk@chromium.org,
	marcel@holtmann.org, hadess@hadess.net
Subject: Re: [PATCHv3 2/4v2] bonding: retry if callback returns TRUE
Message-ID: <20120412112837.GB14780@x220.ger.corp.intel.com>
References: <1333665653-30266-1-git-send-email-scott@netsplit.com>
 <1333665653-30266-3-git-send-email-scott@netsplit.com>
 <20120405225446.GA19517@samus>
 <1333741029-3249-1-git-send-email-scott@netsplit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333741029-3249-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

On Fri, Apr 06, 2012, Scott James Remnant wrote:
> When a bonding completes, pass the status to any plugin bonding
> callbacks; if any return TRUE than set a timer to retry the bonding
> after an appropriate backoff period.
> ---
>  src/device.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 46 insertions(+), 0 deletions(-)

I think you messed up something here. This is not v2 of patch 2/4 but
seems to be a resend of patch 3/4.

Johan
