Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 01:16:55 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 4/4] Bluetooth: trivial: Use preferred method for NULL
 check
Message-ID: <20120815041655.GD3344@joana>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344351906-27563-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344351906-27563-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-08-07 18:05:06 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use standard bluetooth way to check NULL pointer !var instead of
> var == NULL.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/af_bluetooth.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I applied patches 2, 3 and 4 to bluetooth-next. Patch 1 needs rebase. Thanks.

	Gustavo
