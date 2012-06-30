Return-Path: <cyrus@holtmann.org>
Date: Sat, 30 Jun 2012 12:09:05 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix warning: using int as NULL pointer
Message-ID: <20120630150905.GC1920@joana>
References: <1340192412-30161-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340192412-30161-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-06-20 14:40:12 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fix for warnings below:
> 
> ...
> drivers/bluetooth/bt3c_cs.c:667:20: warning: Using plain integer
> 	as NULL pointer
> drivers/bluetooth/btuart_cs.c:596:20: warning: Using plain integer
> 	as NULL pointer
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/bt3c_cs.c   |    2 +-
>  drivers/bluetooth/btuart_cs.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Patch has been applied to bluetooth-next, thanks.

	Gustavo
