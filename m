Return-Path: <cyrus@holtmann.org>
Message-ID: <4E9C1E89.5050407@visionsystems.de>
Date: Mon, 17 Oct 2011 14:24:41 +0200
From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>, johan.hedberg@gmail.com
Subject: Re: [PATCH] hciattach: fix serial speed setting for wl1271
References: <4E64D1B4.9020300@visionsystems.de> <20110927092653.GX3952@dell>
In-Reply-To: <20110927092653.GX3952@dell>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Am 27.09.2011 11:26, schrieb Johan Hedberg:
> Hi Yegor,
>
> On Mon, Sep 05, 2011, Yegor Yefremov wrote:
>> override speed setting if firmware script issues serial settings command,
>> otherwise the value given in the firmware script will be overridden.
>>
>> Example:
>>
>> hciattach /dev/ttyO1 texas 115200
>>
>> will fail, because /dev/ttyO1 will be opened with 115200 b/s, then
>> the firmware script will set the buadrate to 3000000 b/s, after UART init
>> hciattach.c will set the baudrate to 115200, so communication is broken.
>>
>> The only correct way is to set both speeds:
>>
>> hciattach -s 115200 /dev/ttyO1 texas 3000000
>>
>> With this patch only initial speed must be specified. The former semantic
>> will be preserved in case the firmware script doesn't provide serial
>> settings action.
>>
>> Tested with wl1271 and firmware TIInit_7.2.31.bts
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>> ---
>>  tools/hciattach.c    |    2 +-
>>  tools/hciattach.h    |    2 +-
>>  tools/hciattach_ti.c |   19 +++++++++++--------
>>  3 files changed, 13 insertions(+), 10 deletions(-)
> Applied after fixing the commit message (we don't use Signed-off-by).
> Thanks.

Thanks for committing. By the way, what is happening with http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=summary? Will it be up in some days?

Best regards,
Yegor
