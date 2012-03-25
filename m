Return-Path: <cyrus@holtmann.org>
Date: Sun, 25 Mar 2012 13:15:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] Bluetooth: Fix memory leaks due to chan refcnt
Message-ID: <20120325161503.GB3106@joana>
References: <1332488535-10605-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332488535-10605-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-23 09:42:15 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When we queue delayed work we hold(chan) and delayed work
> shall put(chan) after execution.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 

Applied, thanks.

	Gustavo
