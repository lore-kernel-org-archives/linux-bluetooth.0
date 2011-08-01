Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Aug 2011 14:57:41 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 7/7] Bluetooth: cmtp: Fix lost wakeup of session thread
Message-ID: <20110801175740.GA4430@joana>
References: <1311480670.4106.32.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311480670.4106.32.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

* Peter Hurley <peter@hurleysoftware.com> [2011-07-24 00:11:10 -0400]:

> Fix race condition which can result in missing the wakeup intended
> to stop the session thread.
> 
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  net/bluetooth/cmtp/core.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

All patches applied (including the other one about l2cap). Thanks.

	Gustavo
