Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKON4OzNeFMb=8Sm5_Mzb8g8CFT50umTvEc+cRNbJvQzq9UHnQ@mail.gmail.com>
References: <CAKON4OwW4_4KoseeQqa4_JW5nY0UCLdSAZzU36RrOAtuiA151g@mail.gmail.com>
	<CAJdJm_N3E+J4rtaT6g=K-Hmd1tXpWwuZP8PxZGy-x=HqtHMHqw@mail.gmail.com>
	<CAKON4OzNeFMb=8Sm5_Mzb8g8CFT50umTvEc+cRNbJvQzq9UHnQ@mail.gmail.com>
Date: Mon, 24 Sep 2012 12:49:26 -0400
Message-ID: <CAJdJm_PabYdxZcGepX+bo6=LTzdDW_zobVSfmRxQMnfKFB-gGw@mail.gmail.com>
Subject: Re: LE thermometer on Ubuntu 12.10
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

On Mon, Sep 24, 2012 at 12:27 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Mon, Sep 24, 2012 at 11:11 AM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Jon,
>>
>> On Mon, Sep 24, 2012 at 8:55 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> Ubuntu 12.10 has 4.101 and kernel 3.5. I'm trying to get the sample
>>> CC2540 thermometer application from TI working.  The 4.101 package
>>> build has --enable-thermometer set.
>>
>> There is no "--enable-thermometer" since 4.100. Please enable GATT
>> with "--enable-gatt". This will enable all supported GATT profiles at
>> once.
>
> Ubuntu is building this wrong for the 12.10 release then.  I'm filing
> a bug about this, what should the configure option be?
>
> I rebuilt their bluez-4.101 package and it complains about...
>
> configure: WARNING: unrecognized options: --enable-proximity,
> --enable-time, --enable-alert, --enable-gatt-example, --enable-tracer,
> --enable-thermometer, --enable-capng

You should check bootstrap-configure for the available options. For
GATT, you now need only --enable-gatt.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
