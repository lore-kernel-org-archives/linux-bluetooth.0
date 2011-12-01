Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 21:40:39 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Ignore HCI_Read_Local_Commands failures
Message-ID: <20111201124039.GB2894@joana>
References: <1321898484-17952-1-git-send-email-johan.hedberg@gmail.com>
 <1321898484-17952-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321898484-17952-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-21 20:01:24 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> Some 1.2 controllers will fail the HCI_Read_Local_Commands HCI command
> even though (according to the specification) they should support it.
> Since this HCI command is part of the controller init sequence
> controllers broken in this manner would be unusable. Since not having
> the list of supported commands is not critical for these controllers it
> is better to just ignore failures in this case (additionally, this is
> also how older kernels used to behave).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Both patches have been applied, thanks.

	Gustavo
