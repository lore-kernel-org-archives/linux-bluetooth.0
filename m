Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Oct 2012 09:50:58 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 6/6] Bluetooth: Zero bredr pointer when chan is deleted
Message-ID: <20121015125058.GB6498@joana>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1350291524-13258-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350291524-13258-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-15 11:58:44 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> If BREDR L2CAP chan is deleted and this chan is the channel through
> which High Speed traffic is routed to AMP then zero pointer to
> the chan in amp_mgr to prevent accessing it.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++++
>  1 file changed, 4 insertions(+)

All patches but patch 5 were applied to bluetooth-next. Thanks.

	Gustavo
