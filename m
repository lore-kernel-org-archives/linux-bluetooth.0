Return-Path: <cyrus@holtmann.org>
From: Ben YoungTae Kim <ytkim@qca.qualcomm.com>
Subject: Re: Bluetooth: hciuart: Fix to use boolean flag with u32 type
To: Marcel Holtmann <marcel@holtmann.org>, Ben Young Tae Kim
	<ytkim@qca.qualcomm.com>
References: <55CD22F8.3060006@qca.qualcomm.com>
 <8F5EF1AB-8CAF-45B0-85CC-AC3C565728D9@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Message-ID: <55CD771A.4000704@qualcomm.com>
Date: Thu, 13 Aug 2015 22:05:30 -0700
MIME-Version: 1.0
In-Reply-To: <8F5EF1AB-8CAF-45B0-85CC-AC3C565728D9@holtmann.org>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 8/13/15 9:14 PM, Marcel Holtmann wrote:
> Hi Ben,
>
>> debugfs_create_bool is asking to put u32 type pointer instead of bool
>> so that passing bool type with u32* cast will cause memory corruption
>> to read that value since it is handled by 4 bytes instead of 1 byte
>> inside.
>>
>> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
>> ---
>> drivers/bluetooth/hci_qca.c | 8 ++++----
>> 1 file changed, 4 insertions(+), 4 deletions(-)
> this patch does not apply against bluetooth-next tree.

Looks like tabs in patch body was converted with space on email client again since that was sent on new setup(desktop). It was applied properly on my side against bluetooth-next tree. I'll send another one. Sorry for bothering you again.

> Regards
>
> Marcel
>
