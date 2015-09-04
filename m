Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Fix warnings due to unused lpm functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441381165-13510-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 4 Sep 2015 08:57:14 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98111A63-C92D-4861-9FEF-27EF957C9FEF@holtmann.org>
References: <1441381165-13510-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> intel_lpm_suspend/resume are only used in case of CONFIG_PM.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

