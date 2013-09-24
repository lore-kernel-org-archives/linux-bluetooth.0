Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 6/8] Bluetooth: Use async request for LE enable/disable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-7-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:20:33 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <87B723DB-DFA3-4DF9-AF5F-EBADAC8580FD@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-7-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates the code to use an asynchronous request for handling
> the enabling and disabling of LE support. This refactoring is necessary
> as a preparation for adding advertising support, since when LE is
> disabled we should also disable advertising, and the cleanest way to do
> this is to perform the two respective HCI commands in the same
> asynchronous request.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 -
> net/bluetooth/hci_event.c        | 11 -------
> net/bluetooth/mgmt.c             | 69 +++++++++++++++++-----------------------
> 3 files changed, 29 insertions(+), 52 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

