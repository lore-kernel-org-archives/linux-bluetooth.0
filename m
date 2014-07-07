Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 1/3] Bluetooth: Fix connecting devices during LE device discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 12:05:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9C296D1E-F48C-4859-A2E4-F492B496A0C9@holtmann.org>
References: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have devices set as to be connected we should connect to them even
> during normal discovery if we get a connectable advertising event. If we
> also have HCI_CONNECTABLE set we should connect ADV_DIRECT_IND events
> even to devices that we don't have in our pend_le_conns list. This patch
> implements such behavior by passing the advertising report type to
> check_pending_le_conn() and calls that function regardless of what type
> of scanning we are doing.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 47 +++++++++++++++++++++++++++++------------------
> 1 file changed, 29 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

