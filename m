Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 18:09:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Force the process of unpair command if
 disconnect failed
Message-ID: <20120927210905.GD15463@joana>
References: <1347989814-4958-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347989814-4958-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

* Jefferson Delfes <jefferson.delfes@openbossa.org> [2012-09-18 13:36:54 -0400]:

> The unpair process tries to disconnect any connection pending with
> remote. If there are some connection in connecting state, disconnect
> command will fail and unpair mgmt command will stay pending.
> 
> That pending mgmt command can cause strange behavior like automatic
> unpair after a lost connection.
> ---
>  net/bluetooth/mgmt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
