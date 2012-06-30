Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 12:16:27 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Route traffic only through BR/EDR controller
Message-ID: <20120630151627.GD1920@joana>
References: <1340108482-16071-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340108482-16071-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-19 15:21:21 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> If AMP controller is first in the list then Bluetooth traffic might
> be routed through it (if source is not specified). The patch
> prevents this case and also checks that source is BR/EDR.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
