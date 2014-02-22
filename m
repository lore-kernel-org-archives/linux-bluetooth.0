Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 15/15] Bluetooth: Add full support for updating privacy state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-16-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 10:16:20 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <AA86461A-F6BD-4AB9-8B86-AD8B3D84363D@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-16-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several things that need updating in addition to the
> HCI_PRIVACY flag when Set Privacy is called. This includes toggling the
> HCI_RPA_EXPIRED flag, setting the own_address_type variable, as well as
> restarting advertising if necessary.
> 
> This patch adds these missing pieces to the set_privacy function.

none of these should be needed if we use hdev->own_address_type as identity address type. And if we ensure that we update even the static address before each command that needs it.

Regards

Marcel

