Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] Bluetooth: Check that bind() bdaddr type matches connect()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381774673-14150-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Oct 2013 20:27:47 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <44D17FE9-B4CC-4D4A-966E-EE60ACE2E4B7@holtmann.org>
References: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com> <1381774673-14150-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If a socket was bound to an address type other than BR/EDR (such as LE)
> we should reject trying to connect it to a BR/EDR address. The same
> applies for binding to BR/EDR and trying to connect to non-BR/EDR.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

