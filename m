Return-Path: <cyrus@holtmann.org>
Message-ID: <1330634725.3392.105.camel@aeonflux>
Subject: Re: [PATCH 1/5] Bluetooth: mgmt: Refactor hci_dev lookup for
 commands
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Mar 2012 12:45:25 -0800
In-Reply-To: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
References: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Almost all mgmt commands need to lookup a struct hci_dev based on the
> index received within the mgmt headers. It makese therefore sense to
> look this up in a single place and then just pass the hdev pointer to
> each command handler function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/mgmt.c |  764 ++++++++++++++++++--------------------------------
>  1 files changed, 274 insertions(+), 490 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


