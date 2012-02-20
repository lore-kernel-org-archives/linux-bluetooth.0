Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Feb 2012 23:12:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set supported settings based on enabled HS
 and/or LE
Message-ID: <20120220211203.GD20660@x220.ger.corp.intel.com>
References: <1329770869-21333-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329770869-21333-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Feb 20, 2012, Marcel Holtmann wrote:
> Since neither High Speed (HS) nor Low Energy (LE) are fully implemented
> yet, only expose them in supported settings when enabled.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/hci_core.c    |    5 -----
>  net/bluetooth/hci_event.c   |    5 -----
>  net/bluetooth/mgmt.c        |   18 ++++++++++++++++--
>  4 files changed, 17 insertions(+), 12 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
