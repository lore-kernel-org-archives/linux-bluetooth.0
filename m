Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v3 1/4] Bluetooth: hci_intel: Implement LPM suspend/resume
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
Date: Wed, 2 Sep 2015 08:29:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <312EC1B1-5894-4C65-85F1-CF015F4D7497@holtmann.org>
References: <1441188254-15507-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add LPM PM suspend/resume/host_wake LPM functions.
> A LPM transaction is composed with a LPM request and ack/response.
> Host can send a LPM suspend/resume request to the controller which
> should respond with a LPM ack.
> If resume is requested by the controller (irq), host has to send a LPM
> ack once resumed.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: Bracket coding style fixes.
>     Reorder lpm functions to avoid forward declaration.
> v3: Add comment about lpm_transaction failure ignoring
> 
> drivers/bluetooth/hci_intel.c | 158 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 158 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

