Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
Date: Mon, 6 Aug 2012 21:38:15 +0530
Message-ID: <CAK9yfHynuNNqYccAp4BC9zAtWE_Ni27tEK-Pq2Ngt6N2PZukRw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use devm_kzalloc in bluetooth drivers
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	sachin.kamat@linaro.org, patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Any comments regarding this patch set?

On 27 July 2012 12:38, Sachin Kamat <sachin.kamat@linaro.org> wrote:
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
>
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
