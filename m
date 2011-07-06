Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jul 2011 19:11:31 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/5] Bluetooth: Remove enable_smp parameter
Message-ID: <20110706221131.GC7786@joana>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
 <1309472456-24674-5-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309472456-24674-5-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-06-30 19:20:56 -0300]:

> The enable_smp parameter is no longer needed. It can be replaced by
> checking lmp_host_le_capable.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_core.c |   15 +--------------
>  net/bluetooth/smp.c      |    9 +++++++++
>  2 files changed, 10 insertions(+), 14 deletions(-)

All five patches applied, thanks.

	Gustavo
