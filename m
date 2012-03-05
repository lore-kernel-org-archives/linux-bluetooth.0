Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Mar 2012 11:36:04 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] mgmtops: When settings discoverable also set
 connectable if not set yet
Message-ID: <20120305193604.GB16481@x220.ice.intel.com>
References: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330974325-4071-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Mar 05, 2012, Szymon Janc wrote:
> Otherwise command would be rejected e.g. when setting discoverable at
> bluetoothd startup.
> ---
>  plugins/mgmtops.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

All three patches have been applied. Thanks.

Johan
