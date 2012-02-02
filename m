Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Feb 2012 11:58:52 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] device: Fix segmentation fault removing devices
Message-ID: <20120202195852.GA30312@x220.amr.corp.intel.com>
References: <1328025545-14320-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328025545-14320-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jan 31, 2012, Santiago Carot-Nemesio wrote:
> There is an unbalanced control regarding to the GATT channel and its
> attachid, we have to to update the attach id value by setting it to
> zero whenever we detach a GATT channel.
> ---
>  src/device.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan
