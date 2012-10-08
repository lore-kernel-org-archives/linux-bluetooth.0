Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 20:41:50 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix using default Flush Timeout for EFS
Message-ID: <20121008124150.GA14724@joana>
References: <20121007214800.GB13325@joana>
 <1349684082-12928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349684082-12928-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-08 11:14:41 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> There are two Flush Timeouts: one is old Flush Timeot Option
> which is 2 octets and the second is Flush Timeout inside EFS
> which is 4 octets long.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 ++-
>  net/bluetooth/l2cap_core.c    |    6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

	Gustavo
