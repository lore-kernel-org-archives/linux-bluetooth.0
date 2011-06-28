Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309263917-14931-1-git-send-email-sancane@gmail.com>
References: <1309263917-14931-1-git-send-email-sancane@gmail.com>
Date: Tue, 28 Jun 2011 09:48:00 -0400
Message-ID: <BANLkTi=VFT++3BN9KumrXczvCmzuaJTb9w@mail.gmail.com>
Subject: Re: [RFC] Health Thermometer Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Tue, Jun 28, 2011 at 8:25 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> ---
>  doc/thermometer.txt |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 125 insertions(+), 0 deletions(-)
>  create mode 100644 doc/thermometer.txt
>
> diff --git a/doc/thermometer.txt b/doc/thermometer.txt
> new file mode 100644
> index 0000000..9afd2b2
> --- /dev/null
> +++ b/doc/thermometer.txt
> @@ -0,0 +1,125 @@
> +BlueZ D-Bus Thermomether API description

Typo: Thermomether -> Thermometer

> +****************************************
> +
> +       Santiago Carot-Nemesio <sancane@gmail.com>
> +
> +Health Thermomether Profile hierarchy
> +=====================================

Typo: Thermomether -> Thermometer

> +
> +Service                org.bluez
> +Interface      org.bluez.Thermometer
> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +
> +Methods                void SetProperty(string name, variant value)
> +
> +                       Changes the value of the specified property. Only
> +                       read-write properties can be changed. On success
> +                       this will emit a PropertyChanged signal.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +
> +               dict GetProperties()
> +
> +                       Returns all properties for the interface. See the
> +                       Properties section for the available properties.
> +
> +               RegisterThermometerWatcher(object agent)
> +
> +                       Registers a watcher to monitor scanned measures.The agent

Typo: measures -> measurements

> +                       will be notified about final.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +
> +               UnregisterThermometerWatcher(object agent)
> +
> +                       Unregisters a watcher.
> +
> +                       Final and intermediate temperatures won't be notified to
> +                       this agent any more.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                       org.bluez.Error.NotFound
> +
> +               EnableIntermediateMeasures(object agent)
> +
> +                       Enables intermediate measure notifications for this agent

Typo: measure -> measurement

> +                       if the thermometer supports it.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                       org.bluez.Error.NotSupported
> +
> +               DisableIntermediateMeasures(object agent)

What about a second argument to RegisterThermometerWatcher() that
enables/disables intermediate measurements ?

> +
> +                       Disables intermediate measure notifications for this

Typo: measure -> measurement

> +                       agent. It will disable notifications in the thermometer
> +                       when the last agent removes the watcher for intermediate
> +                       measures.

Typo: measures -> measurements

> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                       org.bluez.Error.NotFound
> +
> +Signals                PropertyChanged(string name, variant value)
> +
> +                       This signal indicates a changed value of the given
> +                       property.
> +
> +Properties     boolean Intermediate [readonly]
> +
> +                       True if the thermometer supports intermediate measure

Typo: measure -> measurement

> +                       notifications.
> +
> +               uint16 Interval (optional) [readwrite]
> +
> +                       The Measurement Interval defines the time (in seconds)
> +                       between measurements. This interval is not related to
> +                       the intermediates measures and must be defined into

Typo: intermediates -> intermediate
Typo: measures -> measurements

> +                       a valid range. Setting it to zero meaning that no

Typo: meaning -> means

> +                       periodic measurements will be taken.
> +
> +               uint16 Minimum (optional) [readonly]

This is inverted with Maximum.

> +
> +                       Defines the maximum value allowed for the interval
> +                       between periodic measurements.
> +
> +               uint16 Maximum (optional) [readonly]
> +
> +                       Defines the minimuum value allowed for the interval

Typo: minimuum -> minimum

> +                       between periodic measurements.
> +
> +
> +Health Thermometer Watcher hierarchy
> +====================================
> +Service                unique name
> +Interface      org.bluez.ThermometerWatcher
> +Object path    freely definable
> +
> +Methods                void MeasureReceived(dict measure)

typo (measure vs. measurement)

> +
> +                       This callback gets called when a measure has been
> +                       scanned in the thermometer. The Time entry in the dict
> +                       will be only present if the device supports storing of
> +                       data. The time value is expressed in seconds since epoch.
> +                       The value represented is (mantissa) x (10**exponent)
> +                       See foot note for special values when treating with
> +                       health devices.

IIRC, the "Type" value is also optional.

> +
> +                       Dict is defined as below:
> +                       {
> +                               "Exponent" : int8,
> +                               "Mantissa" : int32,
> +                               "Unit" : ("Celsius" or "Fahrenheit"),
> +                               "Time" : uint64,
> +                               "Type" : ("Armpit", "Body", "Ear", "Finger",
> +                                       "Intestines", "Mouth", "Rectum", "Toe",
> +                                       "Tympanum"),
> +                               "Measurement" : ("Final" or "Intermediate"),
> +                       }
> +
> +                       For special cases, the exponent shall always be zero and
> +                       the mantissa should be one of following values:
> +
> +                       NRes = -(2**23)
> +                       NaN = +(2**23-1)
> +                       INFINITY = (2**23-2)
> +                       -INFINITY = -(2**23-2)
> --
> 1.7.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
