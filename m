Return-Path: <cyrus@holtmann.org>
Message-ID: <1330034307.3392.5.camel@aeonflux>
Subject: Re: [PATCH 1/3] Bluetooth: mgmt: Track pending class changes
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 22:58:27 +0100
In-Reply-To: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
References: <1330032774-16206-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a flag to track pending changes to the class of device.
> This is needed since we cannot cleanly handle multiple simultaneous
> commands and need to return a "busy" error status in the mgmt commands
> that might trigger a class change.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci.h |    1 +
>  net/bluetooth/mgmt.c        |   29 +++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


