Return-Path: <cyrus@holtmann.org>
Message-ID: <1329938761.2049.42.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Allow local name changes while
 powered off
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Feb 2012 20:26:01 +0100
In-Reply-To: <1329937615-29893-3-git-send-email-johan.hedberg@gmail.com>
References: <1329937615-29893-1-git-send-email-johan.hedberg@gmail.com>
	 <1329937615-29893-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch makes it possible to set the local name before powering on
> the device. The name will be applied using the hci_write_local_name
> command once the device gets powered on.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |   13 ++++++++++---
>  net/bluetooth/mgmt.c      |   38 ++++++++++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 15 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


