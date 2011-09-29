Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Sep 2011 15:27:03 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_le_adv_report_evt code refactoring
Message-ID: <20110929182703.GA2605@joana>
References: <1317080915-3901-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317080915-3901-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-09-26 20:48:35 -0300]:

> There is no reason to treat the first advertising entry differently
> from the potential other ones. Besides, the current implementation
> can easily leads to typos.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.

	Gustavo
