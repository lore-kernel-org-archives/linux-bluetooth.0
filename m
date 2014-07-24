Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
	<D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
	<3D02B219753AD44CBDDDE484323B1774112D143D@SHSMSX104.ccr.corp.intel.com>
	<CABBYNZJb_UyNTkrO1qFTk2Uevv9UKnVWrU5rGy_-DPcKUWJY4w@mail.gmail.com>
Date: Thu, 24 Jul 2014 11:01:32 +0300
Message-ID: <CABBYNZ+6v_kaCu51PkJVpMCHQLY6nkRtYxh+ab12GJ97GxGsLg@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 24, 2014 at 10:58 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
>
> On Thu, Jul 24, 2014 at 7:11 AM, Gu, Chao Jie <chao.jie.gu@intel.com> wrote:
>>
>> Hi Arman,
>>
>> > Explain to me how, using only the InterfacesAdded signal, an
>> > application can know that all characteristic objects under a service
>> > hierarchy have been added? The only way is if the external application
>> > already knows about service it's interacting with, which is not the
>> > case if you're building a generic application API on top of
>> > bluetoothd. Without what I'm proposing, you can't build a generic GATT
>> > application API without requiring cumbersome event handling for each
>> > service, characteristic, and descriptor object as they get added and
>> > have only partial access to these objects in the handlers as the
>> > objects are getting processed. This might be fine for low-level
>> > applications that interact with D-Bus directly, but for higher level
>> > app developers this is a real issue that we want to handle properly
>> > and make their lives easier.
>
>
> Im just wondering why we did not use variant type instead of array of bytes
> for value, imo it seems a better fit since it can be extended with different
> types in host byte order.
>
>>
>> You are right, we work on Tizen Bluetooth-frwk which is low-level
>> service/application in system . Bluetooth-frwk can take a role to handle
>> D-Bus informaiton and give defined API to application such as characteristic
>> discovery method, so we refer to different level application indeed.
>> From your aspect, I understood that you consider that high level app
>> developer how to get characteristic array directly from bluetoothd. .
>>
>>
>
> Tizen has to follow BlueZ design, you can offer a C binding for it exposing
> the exact same (or a subset) of the D-Bus API, anything other than that will
> cause a maintenance burden in your end.

Resending since vger rejected my last email claiming it contained HTML subparts.


-- 
Luiz Augusto von Dentz
