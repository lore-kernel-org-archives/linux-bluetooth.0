Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 2/8] Bluetooth: Remove unused mask parameter in sco_conn_defer_accept
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 9 Jul 2013 00:37:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0466A225-14C6-4D36-B1B0-F875C59D5611@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-3-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Bluetooth specification states that when accepting a bluetooth synchronous
> connection request, the role parameter is unused and will be ignored by the
> controller. Moreover, the function is called only once with a fixed value.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |   10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)

I am fine with this patch, but please quote the spec section in the commit message when you send the update patch series.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

