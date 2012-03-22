Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Mar 2012 10:36:45 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded timer clear
Message-ID: <20120322133645.GC6260@joana>
References: <1332318872-15225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332318872-15225-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-21 10:34:32 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> set_chan_timer clears timer itself
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)

Applied to bluetooth-next, thanks

	Gustavo
