Return-Path: <cyrus@holtmann.org>
Message-ID: <1330634841.3392.107.camel@aeonflux>
Subject: Re: [PATCH 3/5] Bluetooth: mgmt: Move command handlers into a table
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 12:47:21 -0800
In-Reply-To: <1330634012-4502-3-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
	 <1330634012-4502-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> By moving the command handlers into a table (the index being equal to
> the opcode) the lookup is made a bit more efficient. Having a struct to
> describe each handler also paves the way to add more meta-data for each
> handler, e.g. the minimum message size for the command and allow
> handling of common tasks like this in a centralized place.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |  219 ++++++++++++++++++--------------------------------
>  1 files changed, 79 insertions(+), 140 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


