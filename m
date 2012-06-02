Return-Path: <cyrus@holtmann.org>
Date: Sat, 2 Jun 2012 09:12:24 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] core: Fix repeated connection attempt
Message-ID: <20120602011224.GB22641@x220.docomointertouch.net>
References: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Jun 01, 2012, Claudio Takahasi wrote:
> This patch fixes possible repeated connections attempt to the same
> remote device when there is an attempt pending, since device drivers
> can request independently ATT connections.
> ---
>  src/device.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

All three patches have been applied. Thanks.

Johan
