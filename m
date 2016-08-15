Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix hci_sock_recvmsg when MSG_TRUNC is not set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471266140-6901-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 15 Aug 2016 16:36:34 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F53CF1C6-2F77-4F66-AAD3-225B99D485ED@holtmann.org>
References: <1471266140-6901-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Similar to bt_sock_recvmsg MSG_TRUNC shall be checked using the original
> flags not msg_flags.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

