Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2013 15:27:10 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Refactor mgmt_pending_foreach
Message-ID: <20130201172710.GB4733@joana>
References: <1359728490-26097-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359728490-26097-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-02-01 11:21:30 -0300]:

> This patch does a trivial refactor in mgmt_pending_foreach function.
> It replaces list_for_each_safe by list_for_each_entry_safe, simplifying
> the function.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
