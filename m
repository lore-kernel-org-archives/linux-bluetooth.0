Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Dec 2012 23:38:36 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 5/5] Bluetooth: AMP: Use set_bit / test_bit for amp_mgr
 state
Message-ID: <20121221013836.GC5485@joana>
References: <1354885148-4677-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1354885148-4677-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354885148-4677-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-12-07 14:59:08 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Using bit operations solves problems with multiple requests
> and clearing state.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/a2mp.h |    2 +-
>  net/bluetooth/a2mp.c         |    6 +++---
>  net/bluetooth/amp.c          |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Patch 2 to 5 have been applied to bluetooth-next. Thanks.

	Gustavo
