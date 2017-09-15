Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALvjcs9HB7E2=Rmm7LxPHwzEFbF4az+G2=T=XzgnH4JZ6fSN_Q@mail.gmail.com>
References: <20170914234748.79584-1-yunhanw@google.com> <20170914234748.79584-3-yunhanw@google.com>
 <CALvjcs-K1m30XA8+dmg0-ncRjvLJZk-jSpp7P8mFc_WbrWNrqw@mail.gmail.com>
 <CABBYNZLmJcgnzJqUKaZq5Lf=Ccb_ArwjK22dG4L9Lq7DT_Kt=A@mail.gmail.com> <CALvjcs9HB7E2=Rmm7LxPHwzEFbF4az+G2=T=XzgnH4JZ6fSN_Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Sep 2017 10:36:19 +0300
Message-ID: <CABBYNZLCj3m8iXHF_cc5Gu5_nA2hkb_wHLyDUcjDT+S8Q-ptDA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] doc/gatt-api: Add UpdateMTU and MTU
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,


On Fri, Sep 15, 2017 at 10:18 AM, Yunhan Wang <yunhanw@google.com> wrote:
> Hi Luiz
>
> Sounds great! Could you describe a little bit more about the idea that use
> AcquireWrite and AcquireNotify and get MTU in GATT service side?

No top-posting in the list, please reply inline.

It is pretty similar to Acquire* for clients but adding a few options
to the server like MTU and Device, the key difference is that the app
can provide any type of fd instead of pipe for each device that has
requested it.

> Thank you.
>
> Best wishes
> Yunhan
>
> On Thu, Sep 14, 2017 at 23:21 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> wrote:
>>
>> Hi Yunhan,
>>
>> On Fri, Sep 15, 2017 at 2:52 AM, Yunhan Wang <yunhanw@google.com> wrote:
>> > Hi, Luiz
>> >
>> > In order to implement packet fragmentation/assembly in upper layer
>> > application, may we get ATT MTU extraction API in peripheral/server
>> > side? Basic idea is to get ATT mtu after MTU exchange complete and
>> > write comes in. This patch is the draft implementation.
>>
>> Im implementing AcquireWrite and AcquireNotify for server as well,
>> that should address GATT services that want to emulate serial port or
>> other protocol on top of it, like mesh
>> > Thanks
>> > Best wishes
>> > Yunhan
>> >
>> > On Thu, Sep 14, 2017 at 4:47 PM, Yunhan Wang <yunhanw@google.com> wrote:
>> >> Add updateMTU in gatt method to get att mtu value in server side.
>> >> Add MTU property in gatt property.
>> >> ---
>> >>  doc/gatt-api.txt | 11 +++++++++++
>> >>  1 file changed, 11 insertions(+)
>> >>
>> >> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
>> >> index cdd15f301..419308a7e 100644
>> >> --- a/doc/gatt-api.txt
>> >> +++ b/doc/gatt-api.txt
>> >> @@ -169,6 +169,13 @@ Methods            array{byte} ReadValue(dict
>> >> options)
>> >>
>> >>                         Possible Errors: org.bluez.Error.Failed
>> >>
>> >> +               void UpdateMTU() [optional] (Server only)
>> >> +
>> >> +                       This method doesn't expect a reply so it is
>> >> just
>> >> +                       MTU value update in user space at server side.
>> >> +
>> >> +                       Possible Errors: org.bluez.Error.Failed
>> >> +
>> >>  Properties     string UUID [read-only]
>> >>
>> >>                         128-bit characteristic UUID.
>> >> @@ -225,6 +232,10 @@ Properties string UUID [read-only]
>> >>                                 "secure-read" (Server only)
>> >>                                 "secure-write" (Server only)
>> >>
>> >> +               uint16_t MTU [read-only, optional]
>> >> +
>> >> +                       ATT MTU value
>> >> +
>> >>  Characteristic Descriptors hierarchy
>> >>  ====================================
>> >>
>> >> --
>> >> 2.14.1.690.gbb1197296e-goog
>> >>
>>
>>
>>
>> --
>> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
