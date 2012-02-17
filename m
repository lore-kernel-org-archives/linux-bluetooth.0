Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329475050-2710-2-git-send-email-sancane@gmail.com>
References: <1329475050-2710-1-git-send-email-sancane@gmail.com>
	<1329475050-2710-2-git-send-email-sancane@gmail.com>
Date: Fri, 17 Feb 2012 08:00:05 -0400
Message-ID: <CAJdJm_N6gd6A5_4-y-P39-6-feY9aOcrRQR7aQ0EhRo0ScyaAw@mail.gmail.com>
Subject: Re: [PATCH] Heart Rate Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

I think this API covers the HR spec well enough. There is the "Reset
Energy Expended" operation which is not being exposed here (I suppose
it could be a method).

A few textual comments below.

On Fri, Feb 17, 2012 at 6:37 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +Heart Rate Profile hierarchy
> +============================
> +
> +Service                org.bluez
> +Interface      org.bluez.HeartRate
> +Object path    [variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Methods                RegisterWatcher(object agent)
> +
> +                       Registers a heart reat watcher to monitor scanned
> +                       measurements.

typo: reat -> rate

I would rather not use "scanned" word here as it is not used on the
spec. What about:

"Registers a watcher to monitor heart rate measurements."

> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +
> +               UnregisterWatcher(object agent)
> +
> +                       Unregisters a watcher.
> +
> +                       Possible Errors: org.bluez.Error.InvalidArguments
> +                                       org.bluez.Error.NotFound
> +
> +Heart Rate Watcher hierarchy
> +============================
> +Service                unique name
> +Interface      org.bluez.HeartRateWatcher
> +Object path    freely definable
> +
> +Methods                void MeasurementReceived(dict measure)
> +
> +                       This callback gets called whenever a measure is scanned
> +                       from the heart rate device. The units for the Value is

Suggestion: "This callback is called whenever a heart rate measurement
is received"

typo: units -> unit

> +                       expressed in beats per minute (bpm). The energy field is
> +                       optional and it represents the accumulated energy
> +                       expended in kilo Joules since last time it was reset.
> +                       Furthermore, the device will be automatically reset when
> +                       it is needed.

>From the spec I see this "automatic reset" could happen if this value
becomes 0xFFFF. But the user may want to reset this manually using a
UI button (e.g. when switching exercises).

> +                       The Contact field, when it's present, indicates that the

suggestion: "when it's present"  -> "if present"

> +                       device support contact sensor, besides it will be true

typo: support -> supports

> +                       if skin contact is detected. The interval field is also
> +                       optional, it's an array containing RR-Interval values
> +                       wich represents the time between two R-Wave detections,
> +                       where the RR-Interval Value 0 is older than the Value 1
> +                       and so on.

typo: wich -> which

Suggestion for the beginning of this sentence: "The interval field,
which is also optional, is an array containing RR-Interval values..."

> +
> +                       Dict is defined as below:
> +                       {
> +                               "Value" : uint16,
> +                               "Energy" : uint16,
> +                               "Contact" : boolean,
> +                               "Location" : ("Other", "Chest", "Wrist","Finger",
> +                                       "Hand", "Ear Lobe", "Foot"),
> +                               "Interval" : array{uint16}
> +                       }
> \ No newline at end of file

Be sure to add a new line here, so it does not generate unnecessary
diff when someone edits this file later.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
