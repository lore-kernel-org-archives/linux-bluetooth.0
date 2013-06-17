Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 Jun 2013 13:51:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] emulator: Fix Remote Name Request Cancel command
 complete
Message-ID: <20130617105142.GB22357@x220.ger.corp.intel.com>
References: <1370466293-14471-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370466293-14471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Jun 05, 2013, Anderson Lizardo wrote:
> The Command Complete event for this HCI command contains two parameters,
> status and bd_addr.
> ---
>  emulator/btdev.c |    6 ++++--
>  monitor/bt.h     |    4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
