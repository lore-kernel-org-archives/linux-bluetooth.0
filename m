Return-Path: <cyrus@holtmann.org>
Message-ID: <1326913510.6454.400.camel@aeonflux>
Subject: Re: [PATCH 04/15] Bluetooth: Rename eir_has_complete_name to
 eir_has_data_type
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:05:10 +0100
In-Reply-To: <1326912717-6347-5-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-5-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This allows for other uses such as checking for an embedded class of
> device value in order to decide whether to append the class or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


