Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Jan 2012 12:36:12 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/7] Bluetooth: Report LE devices
Message-ID: <20120116103612.GA20110@x220>
References: <1326230455-9117-1-git-send-email-andre.guedes@openbossa.org>
 <1326230455-9117-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326230455-9117-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Jan 10, 2012, Andre Guedes wrote:
> Devices found during LE scan should be reported to userspace through
> mgmt_device_found events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Patches 1 and 2 have been applied to my bluetooth-next tree (they were
the only ones with Marcels ack and I need those as a base to update the
kernel side to match the latest mgmt-api.txt in user space).

Johan
