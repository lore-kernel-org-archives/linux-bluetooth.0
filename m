Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 18:14:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH 2/2] Bluetooth: Factor out Create Configuration Response
Message-ID: <20120927211417.GF15463@joana>
References: <1348219805-19406-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1348219805-19406-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348219805-19406-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-09-21 12:30:05 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use function to factor out similar code. For BR/EDR send EFS
> Configuration Response immediately, for HS response will be sent
> after receiving HCI Logical Link Complete event in the following
> patches.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Both patch have been applied to bluetooth-next. Thanks.

	Gustavo
