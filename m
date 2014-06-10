Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/3] Bluetooth: Refactor discovery stopping into its own function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402398359-1602-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Jun 2014 13:59:03 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3A86C088-696E-4E28-8674-7948B193CD79@holtmann.org>
References: <1402398359-1602-1-git-send-email-johan.hedberg@gmail.com> <1402398359-1602-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We'll need to reuse the same logic for stopping discovery also when
> cleaning up HCI state when powering off. This patch refactors the code
> out to its own function that can later (in a subsequent patch) be used
> also for the power off case.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 93 +++++++++++++++++++++++++++-------------------------
> 1 file changed, 49 insertions(+), 44 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

