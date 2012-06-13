Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Jun 2012 23:24:41 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix flags of mgmt_device_found event
Message-ID: <20120613022441.GA3016@joana>
References: <1338577525-9182-1-git-send-email-jefferson.delfes@openbossa.org>
 <1339420731-27485-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339420731-27485-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

* Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-06-11 09:18:51 -0400]:

> Change flags field to matches userspace structure.
> This field needs to be converted to little endian before forward it.
> 
> Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
> ---
>  include/net/bluetooth/mgmt.h |    2 +-
>  net/bluetooth/mgmt.c         |    5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth-next.git. Thanks

	Gustavo
