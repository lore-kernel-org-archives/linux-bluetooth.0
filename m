Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Health Thermometer Profile API
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Elvis Pfutzenreuter <epx@signove.com>
In-Reply-To: <1308560871-3225-1-git-send-email-sancane@gmail.com>
Date: Mon, 20 Jun 2011 08:45:56 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB40D37D-9291-4215-BC31-EE7B1462253B@signove.com>
References: <1308560871-3225-1-git-send-email-sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Jun 20, 2011, at 6:07 AM, Santiago Carot-Nemesio wrote:

> ---
> doc/thermometer.txt |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 101 insertions(+), 0 deletions(-)
> create mode 100644 doc/thermometer.txt
> 
> diff --git a/doc/thermometer.txt b/doc/thermometer.txt
> new file mode 100644
> index 0000000..9d74403
> --- /dev/null
> +++ b/doc/thermometer.txt
> @@ -0,0 +1,101 @@
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
> +Methods 	void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property. Only
> +			read-write properties can be changed. On success
> +			this will emit a PropertyChanged signal.
> +
> +		dict GetProperties()
> +
> +			Returns all properties for the interface. See the
> +			Properties section for the available properties.
> +
> +Signals		PropertyChanged(string name, variant value)
> +
> +			This signal indicates a changed value of the given
> +			property.
> +
> +		MeasureReceived(dict measure)
> +
> +			This signal is emmited when a measure has been scanned
> +			by the thermometer. The Time entry in the dict will be
> +			only present if the device supports storing of data.
> +			The Type entry is optional and it will be provided if
> +			the measure type is non-static. For static measures the
> +			property Type will be provided. The Value entry
> +			corresponds to IEEE-11073 32-bit FLOAT.
> +
> +			Dict is defined as below:
> +			{
> +				"Value" : uint32,
> +				"Unit" : ("Celsius" or "Fahrenheit")
> +				"Time" : {
> +						"Year" : uint16,
> +						"Month" : uint8,
> +						"Day" : uint8,
> +						"Hours" : uint8,
> +						"Minutes" : uint8,
> +						"Seconds" : uint8

We don't really need to mimic the timestamp structure used in spec. We could
go for a simple int with time() format (we should look into other
BlueZ APIs to see which format they use for date or time).

A value for no-timestamp case should be defined, too.

> +					}
> +				"Type" : uint8,
> +				"Measurement" : ("Final", "Intermediate")
> +			}

I would favor an agent for this case instead of signals, because it makes it
implicit whether there is someone interested in getting temperature notifications.
I mean, if some app a) enables notification properties and b) leaves, notification
will keep being done, burning both devices' batteries. That's LE, after all :)

Turning off upon exit is not an option because some other app may be interested,
too. The agent is a natural 'reference counter', too.

Another option would be to create some kind of handle, like HealthApplication,
that allows BlueZ to detect when the client app is gone. That would avoid creating
another agent API and PropertyChanged signal would be emitted when there is at
least one interested party.

> +
> +Properties	boolean Enable [readwrite]
> +
> +			Switch notification of a measure on or off.
> +
> +		boolean Intermediate (optional) [readwrite]
> +
> +			Switch notification of intermediates measures on or off.

Those would go if agent was used.

> +
> +		uint16 Interval (optional) [readwrite]
> +
> +			The Measurement Interval defines the time (in seconds)
> +			between measurements. This interval is not related to
> +			the intermediates measures and must be defined into
> +			a valid range. Setting it to zero meaning that no
> +			periodic measurements will be taken.
> +
> +		dict Range (optional) [readonly]
> +
> +			Defines the valid range for the interval between
> +			periodic measurements.
> +
> +			Dict is defined as below:
> +			{
> +				"Minimum" : uint16,
> +				"Maximum" : uint16,
> +			}

I'd go for two properties: MinimumInterval and MaximumInterval, or some like that.

> +
> +		uint8 Type (optional) [readonly]
> +
> +			Describes the type of the temperature measurement in
> +			relation to the thermometer location. If this property
> +			is present, the measure type won't be provided with the
> +			measure received signal. The value corresponds to the
> +			descriptions used in ISO/IEEE 11073-10408-2008.
> +			Possible values:
> +			0 -> Reserved for future use
> +			1 -> Armpit
> +			2 -> Body (general)
> +			3 -> Ear (usually lobe)
> +			4 -> Finger
> +			5 -> Gastro-intestinal Tract
> +			6 -> Mouth
> +			7 -> Rectum
> +			8 -> Toe
> +			9 -> Tympanum (ear drum)
> +			10-255 -> Reserved for future use

Regardless of signal/agent discussion, there should be Temperature and Intermediate
Temperature properties. If intermediate temp property does not show, this implicitly
means that thermometer does not support it.

All notifiable characteristics of thermometer are also readable; this allows an app
to update its screen and state immediately. (Imagine a thermometer that takes samples
once every 240 seconds.)

> -- 
> 1.7.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

We have the issue of Device Information Servce. In order to be transcodable to IEEE
11073, the API must include Device Information Service data.

We have two options:

a) Adding DIS this very API, making it feature-complete and 1:1 with health
thermometer profile, but that would have to be replicated for every LE health device
API, because every one will have DIS, too.

b) Adding a separate DIS API. This is 'cleaner' and avoids duplication (at
documentation level at least; internally, it could just forward calls to a
single DIS plug-in). But then e.g. the Thermometer API is not 1:1 with profile,
you need that API plus DIS API to cover the whole profile.