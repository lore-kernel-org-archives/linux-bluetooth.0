Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <1308661408-8364-1-git-send-email-sancane@gmail.com>
Date: Tue, 21 Jun 2011 10:54:02 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C521DA9B-E3C6-46F2-834E-6E33C12B18C7@signove.com>
References: <1308661408-8364-1-git-send-email-sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Jun 21, 2011, at 10:03 AM, Santiago Carot-Nemesio wrote:

> ---
> doc/thermometer.txt |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 111 insertions(+), 0 deletions(-)
> create mode 100644 doc/thermometer.txt
> 
> diff --git a/doc/thermometer.txt b/doc/thermometer.txt
> new file mode 100644
> index 0000000..4635fdf
> --- /dev/null
> +++ b/doc/thermometer.txt
> @@ -0,0 +1,111 @@
> +BlueZ D-Bus Thermomether API description
> +****************************************
> +
> +	Santiago Carot-Nemesio <sancane@gmail.com>
> +
> +Health Thermomether Profile hierarchy
> +=====================================
> +
> +Service		org.bluez
> +Interface	org.bluez.Thermometer
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +
> +Methods		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			read-write properties can be changed. On success
> +			this will emit a PropertyChanged signal.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		dict GetProperties()
> +
> +			Returns all properties for the interface. See the
> +			Properties section for the available properties.
> +
> +		RegisterThermometerWatcher(object agent)
> +
> +			Register a watcher to monitor scanned measures.
> +
> +			The agent registered for the health thermometer
> +			service will be notified about measures scanned.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		UnregisterThermometerWatcher(object agent)
> +
> +			Unregister a watcher.
> +
> +			Final and intermediate temperatures won't be notified to
> +			the agent any more.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotFound
> +
> +		EnableIntermediateMeasures(object agent)
> +
> +			Enable notifications about intermediate measures. Agent
> +			should have registered a watcher for health thermometer
> +			service before to enable this feature.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotAllowed
> +
> +		DisableIntermediateMeasures(object agent)
> +
> +			Disable intermediate temperatures. It will disable
> +			intermediate measure notifications in the device when
> +			the last agent disables this feature.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotFound

Not sure whether there is a need to have these. Out of simplicity we could just
accept that intermediate temperatures will be notified, if the thermometer
provides this feature.

In the other hand, a good reason to keep this would be saving energy when
intermediate measures are not needed. LE profiles to into great lengths to
save a couple bytes of traffic (literally).

> +
> +Signals		PropertyChanged(string name, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +Properties	uint16 Interval (optional) [readwrite]
> +
> +			The Measurement Interval defines the time (in seconds)
> +			between measurements. This interval is not related to
> +			the intermediates measures and must be defined into
> +			a valid range. Setting it to zero meaning that no
> +			periodic measurements will be taken.
> +
> +		uint16 Minimum (optional) [readonly]
> +
> +			Defines the maximum value allowed for the interval
> +			between periodic measurements.
> +
> +		uint16 Maximum (optional) [readonly]
> +
> +			Defines the minimuum value allowed for the interval
> +			between periodic measurements.

I would still like to have temperature (final and intermediate) among properties
so an app could read them out without having to register an agent, either to
take a single measurement or to update display upon loading. (That's why
the respective GATT characteristics support read along with notification.)
Reading the property provokes actual characteristic reading.

Disvantage: generating PropertyChanged signals along with agent calls, which
puts the usefulness of the agent into question.

Another option would be to guarantee that MeasureReceived() is called
right after agent registering, in order to give the client an
initial value to show (having in mind that notification interval might
be very long).

> +
> +
> +Health Thermometer Watcher hierarchy
> +====================================
> +Service		unique name
> +Interface	org.bluez.ThermometerWatcher
> +Object path	freely definable
> +
> +Methods		void MeasureReceived(dict measure)
> +
> +			This callback gets called when a measure has been
> +			scanned	in the thermometer. The Value entry corresponds
> +			to IEEE-11073 32-bit FLOAT.The Time entry in the dict
> +			will be only present if the device supports storing of
> +			data. The time value is expressed in seconds since epoch.

Using such a special type (FLOAT) looks funny. Not sure whether it is the best option
for this API.

At the very least, a description of FLOAT type should be added to the API, since
IEEE 11073 specs are not public/free, and API users would have to resort to unofficial
source to learn it.

I understand why you used this type (keeps the thermometer transcodable through this
API and there are the special values), so BTW the lack of device information service
access through this API should at least be mentioned, so we ammend that later (either
here or adding another API).

> +
> +			Dict is defined as below:
> +			{
> +				"Value" : uint32,
> +				"Unit" : ("Celsius" or "Fahrenheit"),
> +				"Time" : uint64,
> +				"Type" : ("Armpit", "Body", "Ear", "Finger",
> +					"Intestines", "Mouth", "Rectum", "Toe",
> +					"Tympanum"),
> +				"Measurement" : ("Final" or "Intermediate"),
> +			}
> -- 
> 1.7.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

