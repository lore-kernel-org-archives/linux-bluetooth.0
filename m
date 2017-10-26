Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1508848208.28409.22.camel@hadess.net>
References: <20171020230304.21173-1-hadess@hadess.net> <20171020230304.21173-2-hadess@hadess.net>
 <CABBYNZLRHvKuLqL5T8yY7CCUq5-gzc-Y3LzKr6XQWbbvJT1Gdg@mail.gmail.com> <1508848208.28409.22.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Oct 2017 16:19:55 +0300
Message-ID: <CABBYNZJw_TTOgBJsB-q8T=BVx6L=VbpOp9Fp8zTXdeEseA2zdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] profiles/battery: Add Bluetooth LE Battery service
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Tue, Oct 24, 2017 at 3:30 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2017-10-24 at 14:58 +0300, Luiz Augusto von Dentz wrote:
>> Hi Bastien,
>>
>> On Sat, Oct 21, 2017 at 2:03 AM, Bastien Nocera <hadess@hadess.net>
>> wrote:
>> > Only the Battery Level characteristic was tested with a
>> > Microsoft Arc Touch Mouse SE.
>> >
>> > This patch however hopes to support both the Battery Level and
>> > the Battery Power State characteristics.
>> > ---
>> >  Makefile.plugins           |   3 +
>> >  doc/battery-api.txt        |  36 +++
>> >  profiles/battery/battery.c | 568
>> > +++++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 607 insertions(+)
>> >  create mode 100644 doc/battery-api.txt
>> >  create mode 100644 profiles/battery/battery.c
>> >
>> > diff --git a/Makefile.plugins b/Makefile.plugins
>> > index 73377e532..1f3b5b552 100644
>> > --- a/Makefile.plugins
>> > +++ b/Makefile.plugins
>> > @@ -100,6 +100,9 @@ builtin_sources += profiles/midi/midi.c \
>> >  builtin_ldadd += @ALSA_LIBS@
>> >  endif
>> >
>> > +builtin_modules += battery
>> > +builtin_sources += profiles/battery/battery.c
>> > +
>> >  if SIXAXIS
>> >  plugin_LTLIBRARIES += plugins/sixaxis.la
>> >  plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
>> > diff --git a/doc/battery-api.txt b/doc/battery-api.txt
>> > new file mode 100644
>> > index 000000000..6d28f7b17
>> > --- /dev/null
>> > +++ b/doc/battery-api.txt
>> > @@ -0,0 +1,36 @@
>> > +BlueZ D-Bus Battery API description
>> > +***********************************
>> > +
>> > +
>> > +Battery hierarchy
>> > +=================
>> > +
>> > +Service                org.bluez
>> > +Interface      org.bluez.Battery1
>> > +Object path    [variable
>> > prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> > +
>> > +Properties     boolean Present [readonly]
>> > +
>> > +                       Whether the device has a battery present.
>>
>> Not sure why would we have this as a property, if the battery is not
>> present then we should not even publish the interface.
>
> UPower has a "present" property as well, so this matches both the
> service and the UPower properties. It avoids logic bugs where the
> battery presence changes but we'd forget to export/unexport the
> interface (or races). Finally, it's useful information for devices
> which have another means of power (I can imagine some devices having
> batteries, but also working wired, with a removable battery).

Not sure what another power source has to do with it? Power and
battery are 2 different things. About race conditions, if you do have
the interface it means it is battery powered if we do set its presence
to false all other properties should be invalidated as well and the
same should go when battery is plugged again all properties have to be
fetched once again, so imo it easier to add and remove the entire
interface to avoid having properties in inconsistent state. Btw,
forgetting to export/unexport may happen either way if the device
decides to remove the entire service that is what should happen, in
fact is what I would do if implementing the service so there is no
chance the remote side would maintain a subscription for something
that is not actually present anymore.

>> > +               boolean Rechargeable [readonly]
>> > +
>> > +                       Whether the battery built into the device
>> > is rechargeable
>> > +                       or not.
>
> We wouldn't be able to export this property either if the battery
> wasn't present above, and we did hide the interface.
> <snip>
>> > +       /* Values explained at:
>> > +        * https://www.bluetooth.com/specifications/gatt/viewer?att
>> > ributeXmlFile=org.bluetooth.characteristic.battery_power_state.xml
>> > */
>>
>> I guess it is better to quote the actual text instead of the link
>> here.
>
> Sure. I'll send an updated patch with that.
>
> <snip>
>> > --
>> > 2.14.2
>>
>> Otherwise looks good.
>
> Great!



-- 
Luiz Augusto von Dentz
