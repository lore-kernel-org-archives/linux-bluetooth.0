Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4134B9.5010307@Atheros.com>
Date: Sat, 17 Jul 2010 10:12:33 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: "Gustavo F. Padovan" <gustavo@padovan.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH] Bluetooth: Support for Atheros AR300x serial Bluetooth
 Chip
References: <1279191250-5923-1-git-send-email-suraj@atheros.com> <20100715195214.GA5734@vigoh>
In-Reply-To: <20100715195214.GA5734@vigoh>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

*poke*

On 7/16/2010 1:22 AM, Gustavo F. Padovan wrote:
> Hi Suraj,
>
> * Suraj Sumangala<suraj@atheros.com>  [2010-07-15 16:24:10 +0530]:
>
>> Implements Atheros AR300x Serial HCI protocol.
>> This protocol extends H4 serial protocol to implement enhanced power management
>> features supported by Atheros AR300x serial Bluetooth chipsets.
>>
>> Signed-off-by: Suraj Sumangala<suraj@atheros.com>
>> ---
>>   drivers/bluetooth/Kconfig     |   12 ++
>>   drivers/bluetooth/Makefile    |    1 +
>>   drivers/bluetooth/hci_ath.c   |  241 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/bluetooth/hci_ldisc.c |    6 +
>>   drivers/bluetooth/hci_uart.h  |    8 ++-
>>   5 files changed, 267 insertions(+), 1 deletions(-)
>>   create mode 100755 drivers/bluetooth/hci_ath.c
>>
> Patch looks fine, nevertheless I'm unable to test it since I don't have
> such hardware.
>

Can this patch be pushed upstream?

Regards
Suraj

