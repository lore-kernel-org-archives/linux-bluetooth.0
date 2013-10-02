Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 0/2] Bluetooth: Fix hci_dev_open race condition
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Oct 2013 08:30:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D497B811-786E-4458-B75B-CE95002B6042@holtmann.org>
References: <1380656690-22246-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's an updated set including fixes based on feedback. The patches
> should go to bluetooth.git, but I'm not sure how important it is to try
> to get them to the stable tree since we haven't had this issue reported
> with the Intel setup procedure which (afaik) should be the only one that
> could be affected in older kernels.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (2):
>      Bluetooth: Refactor hci_dev_open to a separate hci_dev_do_open function
>      Bluetooth: Fix workqueue synchronization in hci_dev_open
> 
> net/bluetooth/hci_core.c | 40 ++++++++++++++++++++++++++++++----------
> 1 file changed, 30 insertions(+), 10 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

