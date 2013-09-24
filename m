Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 3/8] Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL in mgmt_valid_hdev()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 24 Sep 2013 20:19:03 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DFCF34C2-5AA9-4644-BB4B-3D6073DA9D42@holtmann.org>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com> <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If either one of the HCI_SETUP or HCI_USER_CHANNEL flags is set the
> device is not considered valid for mgmt. By having these checks inside
> the mgmt_valid_hdev function the a couple of places using it can be
> simplified.

I looked at doing this and decided not to. Reason was that the device gets removed from mgmt anyway.

So I need a bit more detail why we better do it this way.

Regards

Marcel

