Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: hidp: Initialize list header of hidp sesson user
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150625232756.76568c95@tedd-fedora-vm>
Date: Fri, 26 Jun 2015 09:06:50 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <4AC6BC76-E102-4B03-A42C-07911BBF8B80@holtmann.org>
References: <20150625232756.76568c95@tedd-fedora-vm>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> When new hidp session is created, list header in l2cap_user is
> not initialized and this causes list_empty() to fail in
> l2cap_register_user() even if l2cap_user list is empty.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> net/bluetooth/hidp/core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

