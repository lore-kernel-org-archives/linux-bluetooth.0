Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Allow change security level on ATT_CID in slave role
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402661302-26674-1-git-send-email-marcin.kraglak@tieto.com>
Date: Fri, 13 Jun 2014 14:58:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <9F285574-AE23-4F81-94BD-7E62DC60D9AE@holtmann.org>
References: <1402661302-26674-1-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> Kernel supports SMP Security Request so don't block increasing security
> when we are slave.
> 
> Signed-off-by: Marcin Kraglak <marcin.kraglak@tieto.com>
> ---
> net/bluetooth/l2cap_sock.c | 5 -----
> 1 file changed, 5 deletions(-)

patch has been applied to bluetooth tree.

Regards

Marcel

