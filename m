Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Mar 2012 10:49:40 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Subject: Re: [PATCH 4/4] Bluetooth: Ignore inquiry results from periodic
 inquiry
Message-ID: <20120322134939.GE6260@joana>
References: <1332299018-15933-1-git-send-email-aguedespe@gmail.com>
 <1332299018-15933-5-git-send-email-aguedespe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332299018-15933-5-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <aguedespe@gmail.com> [2012-03-21 00:03:38 -0300]:

> This patch changes inquiry result function handlers so they ignore
> inquiry result events if periodic inquiry is enabled.
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

All four patches applied. Thanks.

	Gustavo
