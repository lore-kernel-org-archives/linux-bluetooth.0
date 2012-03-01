Return-Path: <cyrus@holtmann.org>
Message-ID: <1330634786.3392.106.camel@aeonflux>
Subject: Re: [PATCH 2/5] Bluetooth: mgmt: Initialize HCI_MGMT flag for any
 command
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 12:46:26 -0800
In-Reply-To: <1330634012-4502-2-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
	 <1330634012-4502-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The read_controller_info is typically the first command that user space
> sends when taking a controller into use. This is also the reason why
> this command has been used as the trigger to set the HCI_MGMT flag.
> However, when not running the user-space daemon and using command line
> tools it is possible that read_controller_info is not the first
> controller specific command. This patch moves the HCI_MGMT
> initialization to a generic place where it will be set for whatever
> happens to be the first mgmt command targetting a specific controller.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


