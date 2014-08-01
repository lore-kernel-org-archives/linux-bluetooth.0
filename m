Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+UL_eJFeGT2wZa==fXTRiwrSZ8D1UO+=SzRbPjyEUXvw@mail.gmail.com>
References: <1406805075-16150-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZ+UL_eJFeGT2wZa==fXTRiwrSZ8D1UO+=SzRbPjyEUXvw@mail.gmail.com>
Date: Fri, 1 Aug 2014 10:04:12 +0200
Message-ID: <CAMudyAvk_DptZh5b_yM1OTxrCO5B_5wzu3Ky-_8vT6=V2ZA8eQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] android/gatt: Make usage of kernel auto connect feat.
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 1 August 2014 09:48, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Thu, Jul 31, 2014 at 2:11 PM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> Following patches add support to BfA to use kernel auto connect list
>> when mgmt interface is 1.7 or highier.
>>
>> Tested on PC with latest kernel.
>>
>> Lukasz Rymanowski (6):
>>   android/bluetooth: Add flag for kernel connection control
>>   android/bluetooth: Add API to add device to auto connect list
>>   android/bluetooth: Add API to remove device from auto connect list
>
> Im not quite sure why you introduce as a public API, I mean it does
> not seem like you would control the list externally so perhaps these
> functions should be made static.
>

android/gatt uses it. Patch 5/6

>>   android/gatt: Refactor trigger connection function.
>>   android/gatt: Use kernel auto connect feature if possible
>>   android/bluetooth: Clear auto connect list on startup
>>
>>  android/bluetooth.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  android/bluetooth.h | 10 ++++++
>>  android/gatt.c      | 66 +++++++++++++++++++++++++++++--------
>>  android/main.c      |  4 +++
>>  4 files changed, 160 insertions(+), 14 deletions(-)
>>
>> --
>> 1.8.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz

BR
Lukasz
