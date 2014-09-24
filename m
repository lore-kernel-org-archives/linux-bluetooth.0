Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix reason code used for rejecting SCO connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411553686-3815-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Sep 2014 14:05:09 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <38625A1E-E16F-4115-A837-FB0658CC712F@holtmann.org>
References: <1411553686-3815-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The core specification defines valid values for the
> HCI_Reject_Synchronous_Connection_Request command to be 0x0D-0x0F. So
> far the code has been using HCI_ERROR_REMOTE_USER_TERM (0x13) which is
> not a valid value and is therefore being rejected by some controllers:
> 
>> HCI Event: Connect Request (0x04) plen 10
> 	bdaddr 40:6F:2A:6A:E5:E0 class 0x000000 type eSCO
> < HCI Command: Reject Synchronous Connection (0x01|0x002a) plen 7
> 	bdaddr 40:6F:2A:6A:E5:E0 reason 0x13
> 	Reason: Remote User Terminated Connection
>> HCI Event: Command Status (0x0f) plen 4
> 	Reject Synchronous Connection (0x01|0x002a) status 0x12 ncmd 1
> 	Error: Invalid HCI Command Parameters
> 
> This patch introduces a new define for a value from the valid range
> (0x0d == Connection Rejected Due To Limited Resources) and uses it
> instead for rejecting incoming connections.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h | 1 +
> net/bluetooth/hci_conn.c    | 2 +-
> 2 files changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

