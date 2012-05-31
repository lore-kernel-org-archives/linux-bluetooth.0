Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 10:26:06 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org
Subject: Re: [PATCH] Bluetooth: A2MP: Do not reference hci_conn
Message-ID: <20120531132606.GM18069@joana>
References: <1338451297-20109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338451297-20109-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-31 11:01:37 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Make A2MP channel special channel which do not reference hci_conn.
> This prevents from keeping ACL connection open when all L2CAP
> channels got closed.
> 
> hci_conn_hold and hci_conn_put are not reference counts on the
> hci_conn structure in the typical way.  They are reference counts for
> the ACL.  When you do the last hci_conn_put, the ACL is disconnected
> after a timeout.
> 
> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/a2mp.c       |    2 --
>  net/bluetooth/l2cap_core.c |    4 +++-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
