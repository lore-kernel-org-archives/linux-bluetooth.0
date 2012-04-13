Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 18:36:44 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 01/26] Bluetooth: btmrvl_sdio: remove pointless
 conditional before release_firmware()
Message-ID: <20120413213628.GA1680@joana>
References: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
 <alpine.LNX.2.00.1204092158070.13925@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1204092158070.13925@swampdragon.chaosbits.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesper,

* Jesper Juhl <jj@chaosbits.net> [2012-04-09 22:49:49 +0200]:

> release_firmware() deals gracefullt with NULL pointers so there's no
> reason to test for one prior to calling the function.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Patch has been applied, thanks.

	Gustavo
