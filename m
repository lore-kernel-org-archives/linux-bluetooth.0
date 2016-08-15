Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 15 Aug 2016 14:11:32 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B074D403-1A2C-46AB-9CB7-C5DE68FF3703@holtmann.org>
References: <1471003888-27124-1-git-send-email-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Commit b5f34f9420b50c9b5876b9a2b68e96be6d629054 attempt to introduce
> proper handling for MSG_TRUNC but recv and variants should still work
> as read if no flag is passed, but because the code may set MSG_TRUNC to
> msg->msg_flags that shall not be used as it may cause it to be behave as
> if MSG_TRUNC is always, so instead of using it this changes the code to
> use the flags parameter which shall contain the original flags.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/af_bluetooth.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

