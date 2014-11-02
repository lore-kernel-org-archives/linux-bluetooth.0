Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <00a501cff515$0d93ebb0$28bbc310$@samsung.com>
References: <1414764241-2459-1-git-send-email-gowtham.ab@samsung.com>
	<00a501cff515$0d93ebb0$28bbc310$@samsung.com>
Date: Sun, 2 Nov 2014 20:58:03 +0200
Message-ID: <CABBYNZKZ1XuRWz6shfXRf4mEmeXJZT7-ubZ0rcUGdBy7=RbM5A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add support for RFCOMM in btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: Gowtham Anandha Babu <gowtham.ab@samsung.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 31, 2014 at 4:14 PM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Friday, October 31, 2014 7:34 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
>> cpgs@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH 0/6] Add support for RFCOMM in btmon
>>
>> Adds an initial implementation for RFCOMM in Bluetooth monitor.
>>
>> Implementation for Decoding MSC, RPN, RLS, PN, NSC frames will  be covered
>> in the next patch-set.
>>
>> Bharat Panda (2):
>>   monitor/rfcomm: Add handlers for mcc frame type
>>   monitor/rfcomm: Add mcc type handlers code
>>
>> Gowtham Anandha Babu (4):
>>   monitor/rfcomm: Add RFCOMM support to btmon
>>   monitor/rfcomm: Add support for RFCOMM commands
>>   monitor/rfcomm: Add support for UIH frame decoding
>>   monitor/rfcomm: Add support for mcc frame decoding
>>
>>  Makefile.tools   |   1 +
>>  monitor/l2cap.c  |   4 +
>>  monitor/l2cap.h  |   1 +
>>  monitor/rfcomm.c | 333
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 339 insertions(+)
>>  create mode 100644 monitor/rfcomm.c
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> Please note that android/Android.mk needs to be updated if we change
> anything on the build of btmon.

Yes, and apparently Android.mk has not been updated so we need this
fixing before we can apply.
