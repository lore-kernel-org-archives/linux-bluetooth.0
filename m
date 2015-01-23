Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/2] Bluetooth: Check for valid bdaddr in add_remote_oob_data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 23 Jan 2015 10:07:13 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E235616A-A4BB-4820-9E8B-77652F94221C@holtmann.org>
References: <1422000639-4918-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Before doing any other verifications, the add_remote_oob_data function
> should first check that the given address is valid. This patch adds such
> a missing check to the beginning of the function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

