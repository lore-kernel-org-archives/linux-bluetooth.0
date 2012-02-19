Return-Path: <cyrus@holtmann.org>
Message-ID: <1329652672.2246.1.camel@aeonflux>
Subject: Re: [PATCH 2/6] Bluetooth: mgmt: Move status parameters into the
 cmd_complete header
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 19 Feb 2012 12:57:52 +0100
In-Reply-To: <1329652469-28973-2-git-send-email-johan.hedberg@gmail.com>
References: <1329652469-28973-1-git-send-email-johan.hedberg@gmail.com>
	 <1329652469-28973-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Instead of having status paramters part of each individual command
> response it's simpler to just have the status as part of the command
> complete header. This patch updates the code to follow this convention
> and thereby also ensures compliance with the latest mgmt API
> specification.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    8 +---
>  net/bluetooth/mgmt.c         |  107 +++++++++++++++++++++--------------------
>  2 files changed, 56 insertions(+), 59 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


