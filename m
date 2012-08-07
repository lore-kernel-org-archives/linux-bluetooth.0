Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120806173021.GA3146@joana>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
	<20120806173021.GA3146@joana>
Date: Tue, 7 Aug 2012 08:55:11 +0530
Message-ID: <CAK9yfHzfxcB2rqGJzMuRL0_bkx+sLKdpzGmcEkqbViN5jtnubQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use devm_kzalloc in bluetooth drivers
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Gustavo Padovan <gustavo@padovan.org>, Sachin Kamat <sachin.kamat@linaro.org>,
	linux-bluetooth@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
	patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Marcel and Gustavo.


On 6 August 2012 23:00, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Sachin,
>
> * Sachin Kamat <sachin.kamat@linaro.org> [2012-07-27 12:38:30 +0530]:
>
>> devm_kzalloc() is a device managed function which eliminates the need
>> to free memory explicitly thereby saving some cleanup code and making
>> the exit code simpler.
>>
>> This series is based on the following tree and is compile tested.
>> git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
>>
>> Sachin Kamat (11):
>>   Bluetooth: Use devm_kzalloc in bcm203x.c file.
>>   Bluetooth: Use devm_kzalloc in bfusb.c file
>>   Bluetooth: Use devm_kzalloc in bluecard_cs.c file
>>   Bluetooth: Use devm_kzalloc in bpa10x.c file
>>   Bluetooth: Use devm_kzalloc in bt3c_cs.c file
>>   Bluetooth: Use devm_kzalloc in btmrvl_sdio.c file
>>   Bluetooth: Use devm_kzalloc in btsdio.c file
>>   Bluetooth: Use devm_kzalloc in btuart_cs.c file
>>   Bluetooth: Use devm_kzalloc in btusb.c file
>>   Bluetooth: Use devm_kzalloc in btwilink.c file
>>   Bluetooth: Use devm_kzalloc in dtl1_cs.c file
>>
>>  drivers/bluetooth/bcm203x.c     |    8 +-------
>>  drivers/bluetooth/bfusb.c       |   12 ++++--------
>>  drivers/bluetooth/bluecard_cs.c |    5 +----
>>  drivers/bluetooth/bpa10x.c      |    8 ++------
>>  drivers/bluetooth/bt3c_cs.c     |    5 +----
>>  drivers/bluetooth/btmrvl_sdio.c |   15 ++++-----------
>>  drivers/bluetooth/btsdio.c      |    8 ++------
>>  drivers/bluetooth/btuart_cs.c   |    5 +----
>>  drivers/bluetooth/btusb.c       |   13 +++----------
>>  drivers/bluetooth/btwilink.c    |    8 ++------
>>  drivers/bluetooth/dtl1_cs.c     |    3 +--
>>  11 files changed, 22 insertions(+), 68 deletions(-)
>
> The whole series have been applied to bluetooth-next. Thanks.
>
>         Gustavo



-- 
With warm regards,
Sachin
