Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Jul 2012 13:21:17 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 8/8] Bluetooth: Fix processing A2MP chan in security_cfm
Message-ID: <20120719162117.GF5141@joana>
References: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342706627-19129-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1342706627-19129-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-07-19 17:03:47 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Do not process A2MP channel in l2cap_security_cfm
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    5 +++++
>  1 file changed, 5 insertions(+)

All patches have been applied to bluetooth-next.git, but patch 4 that went to
bluetooth.git, thanks.

	Gustavo
