Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 20:33:28 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded parameter from L2CAP ATT
 channel handling
Message-ID: <20130423233328.GD1697@joana>
References: <1366703940-27816-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366703940-27816-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-04-23 00:59:00 -0700]:

> The CID is fixed to L2CAP ATT channel and so there is no need to hand it
> down to the handling function. Just use a constant instead.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
