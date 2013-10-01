Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Refactor hci_dev_open to a separate hci_dev_do_open function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380625828-19538-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 14:56:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2A68E1FB-20F9-4D72-BFBC-3FE63A2311A4@holtmann.org>
References: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com> <1380625828-19538-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The requirements of an external call to hci_dev_open from hci_sock.c are
> different to that from within hci_core.c. In the former case we want to
> flush any pending work in hdev->req_workqueue whereas in the latter we
> don't (since there we are already calling from within the workqueue
> itself). This patch does the necessary refactoring to a separate
> hci_dev_do_open function (analogous to hci_dev_do_close) but does not
> yet introduce the synchronizations relating to the workqueue usage.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 30 ++++++++++++++++++++----------
> 1 file changed, 20 insertions(+), 10 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

