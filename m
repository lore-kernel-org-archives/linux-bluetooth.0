Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Nov 2012 01:22:51 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Use proper invalid value for tx_power
Message-ID: <20121108002251.GA19170@x220.colubris.lan>
References: <1352333942-18964-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352333942-18964-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Nov 08, 2012, Johan Hedberg wrote:
> The core specification defines 127 as the "not available" value (well,
> "reserved" for BR/EDR and "not available" for LE - but essentially the
> same). Therefore, instead of testing for 0 (which is in fact a valid
> value) we should be using this invalid value to test if the tx_power is
> available.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |    3 +++
>  net/bluetooth/hci_core.c    |    2 ++
>  net/bluetooth/hci_event.c   |    2 ++
>  net/bluetooth/mgmt.c        |    2 +-
>  4 files changed, 8 insertions(+), 1 deletion(-)

Please ignore these two patches. They slipped off before I had the
chance to slap the v2 label on them. Proper set coming in a minute.

Johan
