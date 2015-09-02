Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 2/4] Bluetooth: hci_intel: Add PM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441188254-15507-2-git-send-email-loic.poulain@intel.com>
Date: Wed, 2 Sep 2015 08:29:36 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A0C09397-677C-49EE-ABEB-CC0FB4430206@holtmann.org>
References: <1441188254-15507-1-git-send-email-loic.poulain@intel.com> <1441188254-15507-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add PM suspend/resume callbacks which call lpm_suspend/resume.
> Add LPM ack in threaded IRQ handler to notify the controller that
> resume is complete.
> Protect hci_uart against concurrent removing during suspend/resume.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Rebase on lpm functions reorder.
>     Add idev->hu comment.
> v3: no change
> 
> drivers/bluetooth/hci_intel.c | 53 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 53 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

