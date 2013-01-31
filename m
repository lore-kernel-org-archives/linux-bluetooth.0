Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Jan 2013 15:39:51 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Bluetooth: Fix hci_conn timeout routine
Message-ID: <20130131173951.GB2556@joana>
References: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-01-30 11:50:55 -0300]:

> If occurs a LE or SCO hci_conn timeout and the connection is already
> established (BT_CONNECTED state), the connection is not terminated as
> expected. This bug can be reproduced using l2test or scotest tool.
> Once the connection is established, kill l2test/scotest and the
> connection won't be terminated.
> 
> This patch fixes hci_conn_disconnect helper so it is able to
> terminate LE and SCO connections, as well as ACL.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

I just pushed this patch to bluetooth.git, this also means I'm not applying
the hci_acl_disconn() rename patch until the next release cycle. A rename
patch is not suitable for 3.8 anymore.  Thanks.

	Gustavo
