Return-Path: <cyrus@holtmann.org>
Message-ID: <1330034382.3392.7.camel@aeonflux>
Subject: Re: [PATCH 3/3] Bluetooth: mgmt: Fix clear_uuids response
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 22:59:42 +0100
In-Reply-To: <1330032774-16206-3-git-send-email-johan.hedberg@gmail.com>
References: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
	 <1330032774-16206-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since the clear_uuids operation doesn't send an immediate HCI command
> but just sets off a timer to wait for subsequent add_uuid calls it
> doesn't make sense to wait until the timer fires off to send the
> response. Instead send the response immediately.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


