Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix line splitting of mgmt_device_found parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395741979-23319-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 10:25:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1C23F3EA-8B49-4F04-8A8A-96017334D47F@holtmann.org>
References: <1395741979-23319-1-git-send-email-johan.hedberg@gmail.com> <1395741979-23319-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The line was incorrectly split between the variable type and its name.
> This patch fixes the issue.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 4 ++--
> net/bluetooth/mgmt.c             | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

