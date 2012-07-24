Return-Path: <cyrus@holtmann.org>
Date: Tue, 24 Jul 2012 11:49:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] attio: Rename att_cleanup to attio_cleanup
Message-ID: <20120724094910.GA9576@x220.ice.intel.com>
References: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343054163-19119-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Mon, Jul 23, 2012, Claudio Takahasi wrote:
> Cosmetic change renaming attio cleanup function. attio prefix is more
> suitable since attio implements GIOChannel abstraction in the top of
> the GAttrib.
> ---
>  src/device.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
