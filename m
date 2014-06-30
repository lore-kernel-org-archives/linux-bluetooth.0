Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 1/1] Bluetooth: constify seq_operations
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404149183-7059-1-git-send-email-fabf@skynet.be>
Date: Mon, 30 Jun 2014 19:45:11 +0200
Cc: linux-kernel@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <AD5E0363-1B57-42E9-B82A-F50B765FCC26@holtmann.org>
References: <1404149183-7059-1-git-send-email-fabf@skynet.be>
To: Fabian Frederick <fabf@skynet.be>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabian,

> bt_seq_ops is only used with __seq_open_private as
> const struct seq_operations *
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: linux-bluetooth@vger.kernel.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> net/bluetooth/af_bluetooth.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

