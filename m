Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Oct 2015 17:20:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel: Add support for enabling tracing
 functionality
Message-ID: <20151009142008.GA26499@t440s.P-661HNU-F1>
References: <1444394528-17016-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444394528-17016-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Oct 09, 2015, Marcel Holtmann wrote:
> For Intel controllers with firmware that allows tracing of baseband
> functionality this allows enabling it via set_diag driver callback.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btintel.c   | 32 ++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h   |  6 ++++++
>  drivers/bluetooth/btusb.c     |  1 +
>  drivers/bluetooth/hci_intel.c |  1 +
>  4 files changed, 40 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
