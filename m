Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_intel: Replace spinlock with mutex
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441038871-27193-2-git-send-email-loic.poulain@intel.com>
Date: Mon, 31 Aug 2015 09:58:51 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B6C43323-183F-4E6D-BB6A-4E24136B395E@holtmann.org>
References: <1441038871-27193-1-git-send-email-loic.poulain@intel.com> <1441038871-27193-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Replace the device_intel list spinlock with a mutex.
> devm_request_threaded_irq is not atomic and upcomming PM support should
> be simpler.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

