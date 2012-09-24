Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKON4OwW4_4KoseeQqa4_JW5nY0UCLdSAZzU36RrOAtuiA151g@mail.gmail.com>
References: <CAKON4OwW4_4KoseeQqa4_JW5nY0UCLdSAZzU36RrOAtuiA151g@mail.gmail.com>
Date: Mon, 24 Sep 2012 11:11:20 -0400
Message-ID: <CAJdJm_N3E+J4rtaT6g=K-Hmd1tXpWwuZP8PxZGy-x=HqtHMHqw@mail.gmail.com>
Subject: Re: LE thermometer on Ubuntu 12.10
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

On Mon, Sep 24, 2012 at 8:55 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> Ubuntu 12.10 has 4.101 and kernel 3.5. I'm trying to get the sample
> CC2540 thermometer application from TI working.  The 4.101 package
> build has --enable-thermometer set.

There is no "--enable-thermometer" since 4.100. Please enable GATT
with "--enable-gatt". This will enable all supported GATT profiles at
once.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
