Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 11/11] Bluetooth: Remove empty HCI event handlers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362472150-30965-12-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Mar 2013 09:10:15 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <247B6A3D-34AD-4B62-851C-12736BCB6F98@holtmann.org>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com> <1362472150-30965-12-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> With the removal of hci_req_complete() several HCI event handles have

nitpick here, it is handlers.

> essentially become empty and can be removed. The only potential benefit
> of these could have been logging, but the hci_event, hci_cmd_complete
> and hci_cmd_status already provide a log for events which they do not
> have an explicit handler for.

Regards

Marcel

