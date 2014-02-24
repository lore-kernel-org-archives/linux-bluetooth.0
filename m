Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Enable RPA resolving if mgmt_set_privacy is called
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393233030-5912-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Feb 2014 01:21:01 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <734834E3-40A8-4FCC-A21F-079E0642C2E1@holtmann.org>
References: <1393233030-5912-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> A user space that supports the Set Privacy command is also expected to
> be able to handle New IRK events. Therefore, set the HCI_RPA_RESOLVING
> flag whenever the Set Privacy command is received.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

