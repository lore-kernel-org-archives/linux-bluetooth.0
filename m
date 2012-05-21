Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 May 2012 13:54:33 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Silent sparse warnings
Message-ID: <20120521165433.GF16942@joana>
References: <1337604466-3860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337604466-3860-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-05-21 15:47:46 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Silence warnings below:
> 
> net/bluetooth/l2cap_core.c:1662:24: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:1662:27: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:1683:24: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:1683:27: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:2260:46: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:2574:33: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:2581:33: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:4556:24: warning: Using plain integer
> as NULL pointer
> net/bluetooth/l2cap_core.c:4556:27: warning: Using plain integer
> as NULL pointer
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
