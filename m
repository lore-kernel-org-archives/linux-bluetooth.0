Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 09/11] Bluetooth: Use async requests internally in hci_req_sync
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362472150-30965-10-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Mar 2013 09:08:43 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <048A8609-8937-4664-A2A2-01A3F0D1D6A8@holtmann.org>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com> <1362472150-30965-10-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch converts the hci_req_sync() procedure to internaly use the
> asynchronous HCI requests. The consequence is that hci_req_complete()
> becomes private to hci_core.c (the extra reset command handling needs to
> be moved into hci_req_cmd_complete) and the HCI driver init commands are
> run in their own async request prior to the main HCI init request.

since the change is rather large, I would be a bit more verbose with the commit message. Explain the piece in separate paragraphs.

Regards

Marcel

