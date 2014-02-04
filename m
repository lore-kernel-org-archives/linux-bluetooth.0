Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v7 02/11] Bluetooth: Use connection parameters if any
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391446588-18729-2-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 3 Feb 2014 20:02:49 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <1925D759-6AE8-429C-8448-9AB8363BEDEF@holtmann.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org> <1391446588-18729-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch changes hci_connect_le() so it uses the connection
> parameters specified for the certain device. If no parameters
> were configured, we use the default values.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

I know applied the first 2 patches in this series since they were nicely self-contained.

Regards

Marcel

