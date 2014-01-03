Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jan 2014 13:55:20 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: bill dr <bilel.dr@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: BLE for Android
Message-ID: <20140103115518.GC9809@aemeltch-MOBL1>
References: <CAHTi60GvSMT54WbHC_aw=qja8ApFKZ4ouUYMDVi7RPuFZf-Urw@mail.gmail.com>
 <CABBYNZ+qQp3+n7BL_E7CQO-agz48aCdbsyKRYcEmMZ16P=hU7A@mail.gmail.com>
 <20140103110209.GB9809@aemeltch-MOBL1>
 <CAHTi60E1Qo1XNM+hyaMo9zWbVpNoKYqD8L4MtdbqPEZ43yJWuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHTi60E1Qo1XNM+hyaMo9zWbVpNoKYqD8L4MtdbqPEZ43yJWuA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bilel,

On Fri, Jan 03, 2014 at 12:39:04PM +0100, bill dr wrote:
> Hi all,
> Thank you Luiz and Andrei for your responses.
> 
> @Andrei : I am aware that the latest android version supports "as best
> as it can" BLE. But I have a constaint to use 4.1 Android only.
> 
> 
> That lead us to my second question : what should I do to add such support ?
> 
> If I have understood correctly the HAL Bluetooth (in Bluez package) is
> different from Android HAL.

There is no Bluetooth HAL in Android 4.1, HAL appeared when Android moved
to Bluedroid stack in version 4.2.

> so to have BLE support in Android 4.1 I have to:
> 
> 1- Adding the last Bluez package and compile it.
> 2- make changes to Android Bluetooth HAL or just add a JNI interface
> wrapping the Bluetooth HAL one ?
> 3- make changes to system service to support BLE.
> 4- make changes to Android SDK to export these changes to developpers.

Looks too much work for nothing.

> Is it correct ? is there more straightforward way ?
> especially about the second point and the confusion between Bluetooth
> HAL and Android HAL.

Forget about HAL, hack JNI ....

Best regards 
Andrei Emeltchenko 

