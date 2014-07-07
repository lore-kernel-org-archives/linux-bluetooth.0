Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 2/3] Bluetooth: Remove redundant IRK lookup in mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404726355-7037-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 12:06:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E8F107EF-238B-4A15-83FB-DF1E468022E9@holtmann.org>
References: <1404726355-7037-1-git-send-email-johan.hedberg@gmail.com> <1404726355-7037-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that we have the process_adv_report() function doing the IRK lookup
> and updating the bdaddr we don't need to do this anymore in mgmt.c in
> the mgmt_device_found() function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

