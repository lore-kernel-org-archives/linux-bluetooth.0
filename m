Return-Path: <cyrus@holtmann.org>
Date: Sat, 8 Sep 2012 17:33:16 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/6] Bluetooth: trivial: Make hci_chan_del return void
Message-ID: <20120908203316.GF5788@joana>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933147-11789-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346933147-11789-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-06 15:05:43 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Return code is not needed in hci_chan_del
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next.git. Thanks.

	Gustavo
