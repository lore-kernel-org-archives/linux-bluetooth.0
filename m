Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC] Bluetooth: hci_ll: Convert to use h4_recv_buf helper
Date: Tue, 20 Mar 2018 16:50:37 +0100
References: <20180320083704.11705-1-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>, robh@kernel.org
In-Reply-To: <20180320083704.11705-1-marcel@holtmann.org>
Message-Id: <4DBD77C5-BBFD-4952-A296-30187D85A07F@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> The HCILL or eHCILL protocol from TI is actually an H:4 protocol with a
> few extra events and thus can also use the h4_recv_buf helper. Instead
> of open coding the same funtionality add the extra events to the packet
> description table and use h4_recv_buf.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> drivers/bluetooth/Kconfig  |   1 +
> drivers/bluetooth/hci_ll.c | 214 +++++++++++++++------------------------------
> 2 files changed, 70 insertions(+), 145 deletions(-)

is anybody able to test this change for me and verify that it doesn’t break things.

Regards

Marcel

