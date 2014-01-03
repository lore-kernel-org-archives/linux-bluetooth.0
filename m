Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140103115518.GC9809@aemeltch-MOBL1>
References: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
	<CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
	<20140103110209.GB9809@aemeltch-MOBL1>
	<CAHTi60E1Qo1XNM+hyaMo9zWbVpNoKYqD8L4MtdbqPEZ43yJWuA@mail.gmail.com>
	<20140103115518.GC9809@aemeltch-MOBL1>
Date: Fri, 3 Jan 2014 13:02:38 +0100
Message-ID: <CAHTi60Eo3tS0NWhep1tDxhV=wE+7HBR9gn2vEq1Pnu4oo0pY_g@mail.gmail.com>
Subject: Re: BLE for Android
From: bill dr <bilel.dr@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	bill dr <bilel.dr@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2014/1/3 Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>:
> Hi Bilel,
>
> On Fri, Jan 03, 2014 at 12:39:04PM +0100, bill dr wrote:
>> Hi all,
>> Thank you Luiz and Andrei for your responses.
>>
>> @Andrei : I am aware that the latest android version supports "as best
>> as it can" BLE. But I have a constaint to use 4.1 Android only.
>>
>>
>> That lead us to my second question : what should I do to add such support ?
>>
>> If I have understood correctly the HAL Bluetooth (in Bluez package) is
>> different from Android HAL.
>
> There is no Bluetooth HAL in Android 4.1, HAL appeared when Android moved
> to Bluedroid stack in version 4.2.
>

OK I got it. Indeed, my confusion comes from bluedroid

>> so to have BLE support in Android 4.1 I have to:
>>
>> 1- Adding the last Bluez package and compile it.
>> 2- make changes to Android Bluetooth HAL or just add a JNI interface
>> wrapping the Bluetooth HAL one ?
>> 3- make changes to system service to support BLE.
>> 4- make changes to Android SDK to export these changes to developpers.
>
> Looks too much work for nothing.

isn't it required to have a proper support ?
indeed it is too munch work. is there any alternative ?

>
>> Is it correct ? is there more straightforward way ?
>> especially about the second point and the confusion between Bluetooth
>> HAL and Android HAL.
>
> Forget about HAL, hack JNI ....

OK.

>
> Best regards
> Andrei Emeltchenko
>

Thank you.
