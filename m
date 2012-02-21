Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Feb 2012 14:21:52 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Don't send New Settings event during setup
 power down
Message-ID: <20120221122152.GB31177@x220>
References: <1329824028-15497-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329824028-15497-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Feb 21, 2012, Marcel Holtmann wrote:
> When the controller gets brought up for initial setup, it will be brought
> back down after a timeout. In that case, don't send a New Settings event.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c |   20 +++++++++++---------
>  1 files changed, 11 insertions(+), 9 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
