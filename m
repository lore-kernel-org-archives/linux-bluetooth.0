Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 16:23:29 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unneeded calculation and magic number
Message-ID: <20120504192329.GA11510@joana>
References: <1336031752-8153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336031752-8153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-03 10:55:52 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Remove magic number unneeded calculation since
> hlen = L2CAP_HDR_SIZE + L2CAP_PSMLEN_SIZE
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch has been applied. Thanks.

	Gustavo
