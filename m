Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Enable IRQ wake capability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441825455-23767-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 9 Sep 2015 12:08:28 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <13C685FB-703B-4AC8-AA3B-CD46D5B342FD@holtmann.org>
References: <1441825455-23767-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> We need to explicitly enable the IRQ wakeup mode to let the controller
> wake the system from sleep states (like suspend-to-ram).
> PM suspend/resume callbacks now call the generic intel device PM
> functions after enabling/disabling IRQ wake.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: rename generic suspend/resume functions
>     remove useless function name debug
> 
> drivers/bluetooth/hci_intel.c | 30 +++++++++++++++++++++++-------
> 1 file changed, 23 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

