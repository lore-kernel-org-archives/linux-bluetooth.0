Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 7/7] Bluetooth: Locking in hci_le_conn_complete_evt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380668636-30654-8-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 2 Oct 2013 07:23:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B5036FD2-37E8-491E-B35E-16F1F2625A3E@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org> <1380668636-30654-8-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch moves hci_dev_lock and hci_dev_unlock calls to where they
> are really required, reducing the critical region in hci_le_conn_
> complete_evt function. hdev->lock is required only in hci_conn_del
> and hci_conn_add call to protect concurrent add and remove operations
> in hci_conn_hash list.

is this statement actually true? Because we have done this for so many HCI event, that I highly doubt that your statement tis correct. And if it is correct, you need to fix all other users first.

Regards

Marcel

