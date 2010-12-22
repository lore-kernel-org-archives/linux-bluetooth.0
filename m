Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5] Bluetooth: Fix __hci_request synchronization for
 hci_open_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292965287-29849-1-git-send-email-johan.hedberg@gmail.com>
References: <1292965287-29849-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Dec 2010 13:31:31 -0800
Message-ID: <1293053496.9439.0.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The initialization function used by hci_open_dev (hci_init_req) sends
> many different HCI commands. The __hci_request function should only
> return when all of these commands have completed (or a timeout occurs).
> Several of these commands cause hci_req_complete to be called which
> causes __hci_request to return prematurely.
> 
> This patch fixes the issue by adding a new hdev->req_last_cmd variable
> which is set during the initialization procedure. The hci_req_complete
> function will no longer mark the request as complete until the command
> matching hdev->req_last_cmd completes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
> v5: comment added for req_last_cmd check as well as empty line added to
> hci_init_req as requested

looks all good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org.

Regards

Marcel


