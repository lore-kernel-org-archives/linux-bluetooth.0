Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTikDd0LzSTTfurzEGLAV8J00nuXtMw@mail.gmail.com>
References: <1308560871-3225-1-git-send-email-sancane@gmail.com>
	<BANLkTikDd0LzSTTfurzEGLAV8J00nuXtMw@mail.gmail.com>
Date: Mon, 20 Jun 2011 13:01:45 +0200
Message-ID: <BANLkTincN82a_ESMaO8YSKFJdT-M-+ANuw@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz

2011/6/20 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi,
>
> On Mon, Jun 20, 2011 at 12:07 PM, Santiago Carot-Nemesio
> <sancane@gmail.com> wrote:
>> ---
>>  doc/thermometer.txt |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 101 insertions(+), 0 deletions(-)
>>  create mode 100644 doc/thermometer.txt
>>
>> diff --git a/doc/thermometer.txt b/doc/thermometer.txt
>> new file mode 100644
>> index 0000000..9d74403
>> --- /dev/null
>> +++ b/doc/thermometer.txt
>> @@ -0,0 +1,101 @@
>> +BlueZ D-Bus Thermomether API description
>> +****************************************
>> +
>> +       Santiago Carot-Nemesio <sancane@gmail.com>
>> +
>> +Health Thermomether Profile hierarchy
>> +=====================================
>> +
>> +Service                org.bluez
>> +Interface      org.bluez.Thermometer
>> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> +
>> +
>> +Methods        void SetProperty(string name, variant value)
>> +
>> +                       Changes the value of the specified property. Only
>> +                       read-write properties can be changed. On success
>> +                       this will emit a PropertyChanged signal.
>> +
>> +               dict GetProperties()
>> +
>> +                       Returns all properties for the interface. See the
>> +                       Properties section for the available properties.
>> +
>> +Signals                PropertyChanged(string name, variant value)
>> +
>> +                       This signal indicates a changed value of the given
>> +                       property.
>> +
>> +               MeasureReceived(dict measure)
>> +
>> +                       This signal is emmited when a measure has been scanned
>> +                       by the thermometer. The Time entry in the dict will be
>> +                       only present if the device supports storing of data.
>> +                       The Type entry is optional and it will be provided if
>> +                       the measure type is non-static. For static measures the
>> +                       property Type will be provided. The Value entry
>> +                       corresponds to IEEE-11073 32-bit FLOAT.
>> +
>> +                       Dict is defined as below:
>> +                       {
>> +                               "Value" : uint32,
>> +                               "Unit" : ("Celsius" or "Fahrenheit")
>> +                               "Time" : {
>> +                                               "Year" : uint16,
>> +                                               "Month" : uint8,
>> +                                               "Day" : uint8,
>> +                                               "Hours" : uint8,
>> +                                               "Minutes" : uint8,
>> +                                               "Seconds" : uint8
>> +                                       }
>
> I would try not got past the Dict, so the Time we could just use a timestamp.

I did it thinking in ISO/IEEE11073-20601 integration. Personal health
devices transcoding whitepaper talk about it. Transcoder components
should get this information when it is present to compose the
appropriate APDUs to use this kind of devices in a 20601 ecosystem. I
though that providing the time fields through a dict makes easy for
both kind of application (20601 compatible applications and non-20601
compatible ones) get the time and make the appropriate internal
representation. I do not oppose your proposal if we can get all these
information from the time stamp too.
so no problem to me.

>
>> +                               "Type" : uint8,
>
> Hmm, what values can Type assume? Also be aware that D-Bus don't have
> enum type so it is a bit inconvenient in some bindings, so perhaps we
> should try to avoid them and always convert to human readable string.

I don't recommend it because type is defined by the upper layer
protocol so I wouldn't do that thinking in the maintainability. The
Type values may change (adding or removing new ones) in the IEEE
specification so we should constantly update this stuff whenever the
upper protocol changes to fullfil with that specification which IMO is
out of Bluetooth scope. I suggest to keep indepence between both
worlds.

>
>> +                               "Measurement" : ("Final", "Intermediate")
>> +                       }
>> +
>> +Properties     boolean Enable [readwrite]
>> +
>> +                       Switch notification of a measure on or off.
>> +
>> +               boolean Intermediate (optional) [readwrite]
>> +
>> +                       Switch notification of intermediates measures on or off.
>> +
>> +               uint16 Interval (optional) [readwrite]
>> +
>> +                       The Measurement Interval defines the time (in seconds)
>> +                       between measurements. This interval is not related to
>> +                       the intermediates measures and must be defined into
>> +                       a valid range. Setting it to zero meaning that no
>> +                       periodic measurements will be taken.
>> +
>> +               dict Range (optional) [readonly]
>> +
>> +                       Defines the valid range for the interval between
>> +                       periodic measurements.
>> +
>> +                       Dict is defined as below:
>> +                       {
>> +                               "Minimum" : uint16,
>> +                               "Maximum" : uint16,
>> +                       }
>
> I guess we can just use them directly as properties.

I considered it too but at the end I choose the dict way thinking that
Range is a property by itself  with minimum and maximum values. But we
can split in two properties if all you think that it fits better in
the API.

>
>> +
>> +               uint8 Type (optional) [readonly]
>> +
>> +                       Describes the type of the temperature measurement in
>> +                       relation to the thermometer location. If this property
>> +                       is present, the measure type won't be provided with the
>> +                       measure received signal. The value corresponds to the
>> +                       descriptions used in ISO/IEEE 11073-10408-2008.
>> +                       Possible values:
>> +                       0 -> Reserved for future use
>> +                       1 -> Armpit
>> +                       2 -> Body (general)
>> +                       3 -> Ear (usually lobe)
>> +                       4 -> Finger
>> +                       5 -> Gastro-intestinal Tract
>> +                       6 -> Mouth
>> +                       7 -> Rectum
>> +                       8 -> Toe
>> +                       9 -> Tympanum (ear drum)
>> +                       10-255 -> Reserved for future use
>
> Not sure why you need MeasureReceived and PropertyChanged here, I
> would use one or another but not both to avoid possible
> inconsistencies.

The idea is that there may be two kinds of thermometers. Static ones
wich are designed for a kind of measurement and non-static ones wich
can be used in different locations. From application side, wherever a
device provides this property is due that it only will provide static
measures so it doesn't need to provide it in all measures scanned (to
keep bandwich), if this property is not present is because of it can
scan for measures in several places and it will provide this
information to you when the measure arrives.

We can remove this roperty from the API if it is confused and always
provide this information in the MeasureReceived signal. It looks fine
to me too.

Thanks for your comments, they are very appreciated.

Let's wait for more suggestions. I'll send other patch including the
changes if nobody says anything about the API in next days.

Regards.
