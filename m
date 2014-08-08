Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix HCI H5 corrupted ack value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407517636-8484-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 8 Aug 2014 10:50:42 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <75871E49-76C5-4CAE-9A21-EB9FAE5FF027@holtmann.org>
References: <1407517636-8484-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> In this expression: seq = (seq - 1) % 8
> seq (u8) is implicitly converted to an int in the arithmetic operation.
> So if seq value is 0, operation is ((0 - 1) % 8) => (-1 % 8) => -1.
> The new seq value is 0xff which is an invalid ACK value, we expect 0x07.
> It leads to frequent dropped ACK and retransmission.
> Fix this by using '&' binary operator instead of '%'.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_h5.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

