Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 2/8] Bluetooth: Create callbacks for hci device creation and deletion
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1400837248-12179-3-git-send-email-jukka.rissanen@linux.intel.com>
Date: Sat, 24 May 2014 21:36:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2FE3E828-8296-4018-87EF-D0D4BB414F37@holtmann.org>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com> <1400837248-12179-3-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> include/net/bluetooth/hci_core.h | 27 +++++++++++++++++++++++++++
> net/bluetooth/hci_core.c         | 17 +++++++++++++++++
> 2 files changed, 44 insertions(+)

so patches with a no commit body are not acceptable in the Bluetooth subsystem. You need to explain why you are doing this and what it is for. Think of it a bit as story telling so that I can follow it when reviewing the patches.

Regards

Marcel

