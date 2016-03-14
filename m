Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL-bw24z_RNAskRTpfzRjcuOjO2a8Pxccmj1qt2ner1Ng@mail.gmail.com>
References: <1457706745-14511-1-git-send-email-luiz.dentz@gmail.com> <CABBYNZL-bw24z_RNAskRTpfzRjcuOjO2a8Pxccmj1qt2ner1Ng@mail.gmail.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Mon, 14 Mar 2016 19:17:34 +0100
Message-ID: <CADAkoF799PaJwxDfgpH+d02xvofZGDLFGq_X=drdb2sEHremvQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/device-api: Replace GattServices with
 ServicesDiscovered property
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 14, 2016 at 3:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Fri, Mar 11, 2016 at 4:32 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> GattServices is not really doing was it was meant to do which was to
>> track progress of service discovery since it only worked for the very
>> first time a device is connected but since we no longer remove the
>> attributes an application would have the false impression the service are
>> all resolved by the time it reconnects when in fact the service may have
>> changed.
>>
>> Furthermore object tracking like it is doing has been obsolete by
>> ObjectManager so this propose to replace the service discovery tracking
>> with a boolean property which works both with SDP as well as GATT
>> discovery.

I'm just curious - do you also plan to remove
org.bluez.GattService1.Characteristics and
org.bluez.GattCharacteristic1.Descriptors?

BR,
Andrzej
