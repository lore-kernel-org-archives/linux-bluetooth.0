Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Apr 2013 10:35:34 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix HCI command send functions to use const
 specifier
Message-ID: <20130419133534.GA2194@joana>
References: <1366355691-3173-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366355691-3173-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2013-04-19 10:14:51 +0300]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> All HCI command send functions that take a pointer to the command
> parameters do not need to modify the content in any way (they merely
> copy the data to an skb). Therefore, the parameter type should be
> declared const. This also allows passing already const parameters to
> these APIs which previously would have generated a compiler warning.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   14 ++++++++------
>  net/bluetooth/hci_core.c         |   16 +++++++++-------
>  2 files changed, 17 insertions(+), 13 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
