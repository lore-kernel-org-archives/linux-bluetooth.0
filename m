Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 5/6] Bluetooth: Report LE devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 12 Nov 2011 08:14:50 +0900
In-Reply-To: <1321051824-5216-6-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
	 <1321051824-5216-6-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321053293.15441.412.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Devices found during LE scan should be reported to userspace through
> mgmt_device_found events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

However keep in mind that we might have to filter these with the changes
that Johan is doing with triggering scan for random vs public addresses.

Regards

Marcel


