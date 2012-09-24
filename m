Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_N3E+J4rtaT6g=K-Hmd1tXpWwuZP8PxZGy-x=HqtHMHqw@mail.gmail.com>
References: <CAKON4OwW4_4KoseeQqa4_JW5nY0UCLdSAZzU36RrOAtuiA151g@mail.gmail.com>
	<CAJdJm_N3E+J4rtaT6g=K-Hmd1tXpWwuZP8PxZGy-x=HqtHMHqw@mail.gmail.com>
Date: Mon, 24 Sep 2012 12:27:58 -0400
Message-ID: <CAKON4OzNeFMb=8Sm5_Mzb8g8CFT50umTvEc+cRNbJvQzq9UHnQ@mail.gmail.com>
Subject: Re: LE thermometer on Ubuntu 12.10
From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Sep 24, 2012 at 11:11 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Jon,
>
> On Mon, Sep 24, 2012 at 8:55 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>> Ubuntu 12.10 has 4.101 and kernel 3.5. I'm trying to get the sample
>> CC2540 thermometer application from TI working.  The 4.101 package
>> build has --enable-thermometer set.
>
> There is no "--enable-thermometer" since 4.100. Please enable GATT
> with "--enable-gatt". This will enable all supported GATT profiles at
> once.

Ubuntu is building this wrong for the 12.10 release then.  I'm filing
a bug about this, what should the configure option be?

I rebuilt their bluez-4.101 package and it complains about...

configure: WARNING: unrecognized options: --enable-proximity,
--enable-time, --enable-alert, --enable-gatt-example, --enable-tracer,
--enable-thermometer, --enable-capng

configure input from debian/rules...

DEB_CONFIGURE_EXTRA_FLAGS := LDFLAGS=-Wl,--as-needed \
                             --libdir=\$${prefix}/lib/$(DEB_HOST_MULTIARCH) \
                             --enable-static \
                             --disable-hal \
                             --enable-sap \
                             --enable-proximity \
                             --enable-time \
                             --enable-alert \
                             --enable-health \
                             --enable-pnat \
                             --enable-gatt-example \
                             --enable-gstreamer \
                             --enable-alsa \
                             --enable-usb \
                             --enable-tracer \
                             --enable-tools \
                             --enable-bccmd \
                             --enable-pcmcia \
                             --enable-hid2hci \
                             --enable-dfutool \
                             --enable-hidd \
                             --enable-pand \
                             --enable-dund \
                             --enable-cups \
                             --enable-test \
                             --enable-datafiles \
                             --enable-debug \
                             --enable-dbusoob \
                             --enable-wiimote \
                             --enable-thermometer \
                             --enable-capng \
                             --with-systemdunitdir=/lib/systemd/system

>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil



-- 
Jon Smirl
jonsmirl@gmail.com
