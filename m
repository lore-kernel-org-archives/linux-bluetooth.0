Return-Path: <cyrus@holtmann.org>
Message-ID: <1350667381.1785.3.camel@aeonflux>
Subject: Re: [PATCH 3/6] Bluetooth: Add initial support for LE-only
 controllers
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Oct 2012 10:23:01 -0700
In-Reply-To: <1350666911-6334-4-git-send-email-johan.hedberg@gmail.com>
References: <1350666911-6334-1-git-send-email-johan.hedberg@gmail.com>
	 <1350666911-6334-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch splits off most the HCI init sequence commands from a fixed
> set into a conditional one that is sent once the HCI_Read_Local_Features
> command completes. This is necessary since many of the current fixed
> commands are not allowed for LE-only controllers.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   35 ---------------------------
>  net/bluetooth/hci_event.c |   58 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 40 deletions(-)

I would merge this one with patch 1/6. Having them split up seems a bit
weird. Especially with 2/6 in between that has nothing to do with it.

Regards

Marcel


