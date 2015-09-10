Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix warning due to unused pm functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441877027-19794-1-git-send-email-loic.poulain@intel.com>
Date: Thu, 10 Sep 2015 15:24:08 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A2D47579-9D12-4AAC-9F63-25B499AF27D1@holtmann.org>
References: <1441877027-19794-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> intel_suspend/resume depend on CONFIG_PM_SLEEP. They are unused in
> other cases.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 2 ++
> 1 file changed, 2 insertions(+)

I amended your previous patch and push it to bluetooth-next tree.

Regards

Marcel

