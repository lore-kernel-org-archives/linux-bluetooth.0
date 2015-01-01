Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Jan 2015 12:27:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix SMP channel registration for unconfigured
 controllers
Message-ID: <20150101102735.GA21055@t440s.P-661HNU-F1>
References: <1420106716-13323-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420106716-13323-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jan 01, 2015, Marcel Holtmann wrote:
> When the Bluetooth controllers requires an unconfigured state (for
> example when the BD_ADDR is missing), then it is important to try
> to register the SMP channels when the controller transitions to the
> configured state.
> 
> This also fixes an issue with the debugfs entires that are not present
> for controllers that start out as unconfigured.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
