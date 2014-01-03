Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140103110209.GB9809@aemeltch-MOBL1>
References: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
	<CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
	<20140103110209.GB9809@aemeltch-MOBL1>
Date: Fri, 3 Jan 2014 12:39:04 +0100
Message-ID: <CAHTi60E1Qo1XNM+hyaMo9zWbVpNoKYqD8L4MtdbqPEZ43yJWuA@mail.gmail.com>
Subject: Re: BLE for Android
From: bill dr <bilel.dr@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	bill dr <bilel.dr@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
Thank you Luiz and Andrei for your responses.

@Andrei : I am aware that the latest android version supports "as best
as it can" BLE. But I have a constaint to use 4.1 Android only.


That lead us to my second question : what should I do to add such support ?

If I have understood correctly the HAL Bluetooth (in Bluez package) is
different from Android HAL.
so to have BLE support in Android 4.1 I have to:

1- Adding the last Bluez package and compile it.
2- make changes to Android Bluetooth HAL or just add a JNI interface
wrapping the Bluetooth HAL one ?
3- make changes to system service to support BLE.
4- make changes to Android SDK to export these changes to developpers.

Is it correct ? is there more straightforward way ?
especially about the second point and the confusion between Bluetooth
HAL and Android HAL.
Thank you for your help.

Regards,
Bilel

2014/1/3 Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>:
> Hi all,
>
> On Tue, Dec 31, 2013 at 02:02:59PM +0200, Luiz Augusto von Dentz wrote:
>> Hi,
>>
>> On Tue, Dec 31, 2013 at 1:47 PM, bill dr <bilel.dr@gmail.com> wrote:
>> > Hi,
>> >
>> > I am trying to port BLE into a 4.1.1 android device.
>
> There is no sense to make this work, use the latest Android instead, many
> things should be already working ...
>
> Best regards
> Andrei Emeltchenko
>
>> > I found that bluez git repository contains an android directory.
>> > Could you explain me or point me to any link or document that explain
>> > how to use this directory. Is there any HAL implementation already
>> > done. Or this directory contains only "bluedroid" code ?
>> >
>> > Thank you !
>>
>> Checkout the README:
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/android/README
>>
>> It is a clean implementation of bluetooth HAL, so no bluedroid code
>> bellow the HAL interface, above HAL is considered Android itself even
>> though it may actually contain bluetooth specific bits here and there.
>> Btw, we are almost ready to start looking at the BLE HAL.
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
