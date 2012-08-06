Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Aug 2012 14:30:21 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com, patches@linaro.org
Subject: Re: [PATCH 00/11] Use devm_kzalloc in bluetooth drivers
Message-ID: <20120806173021.GA3146@joana>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sachin,

* Sachin Kamat <sachin.kamat@linaro.org> [2012-07-27 12:38:30 +0530]:

> devm_kzalloc() is a device managed function which eliminates the need
> to free memory explicitly thereby saving some cleanup code and making
> the exit code simpler.
> 
> This series is based on the following tree and is compile tested.
> git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
> 
> Sachin Kamat (11):
>   Bluetooth: Use devm_kzalloc in bcm203x.c file.
>   Bluetooth: Use devm_kzalloc in bfusb.c file
>   Bluetooth: Use devm_kzalloc in bluecard_cs.c file
>   Bluetooth: Use devm_kzalloc in bpa10x.c file
>   Bluetooth: Use devm_kzalloc in bt3c_cs.c file
>   Bluetooth: Use devm_kzalloc in btmrvl_sdio.c file
>   Bluetooth: Use devm_kzalloc in btsdio.c file
>   Bluetooth: Use devm_kzalloc in btuart_cs.c file
>   Bluetooth: Use devm_kzalloc in btusb.c file
>   Bluetooth: Use devm_kzalloc in btwilink.c file
>   Bluetooth: Use devm_kzalloc in dtl1_cs.c file
> 
>  drivers/bluetooth/bcm203x.c     |    8 +-------
>  drivers/bluetooth/bfusb.c       |   12 ++++--------
>  drivers/bluetooth/bluecard_cs.c |    5 +----
>  drivers/bluetooth/bpa10x.c      |    8 ++------
>  drivers/bluetooth/bt3c_cs.c     |    5 +----
>  drivers/bluetooth/btmrvl_sdio.c |   15 ++++-----------
>  drivers/bluetooth/btsdio.c      |    8 ++------
>  drivers/bluetooth/btuart_cs.c   |    5 +----
>  drivers/bluetooth/btusb.c       |   13 +++----------
>  drivers/bluetooth/btwilink.c    |    8 ++------
>  drivers/bluetooth/dtl1_cs.c     |    3 +--
>  11 files changed, 22 insertions(+), 68 deletions(-)

The whole series have been applied to bluetooth-next. Thanks.

	Gustavo
