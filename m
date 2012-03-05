Return-Path: <cyrus@holtmann.org>
Message-ID: <1330923469.3392.154.camel@aeonflux>
Subject: Re: [PATCH] Heart Rate Profile API
From: Marcel Holtmann <marcel@holtmann.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 04 Mar 2012 20:57:49 -0800
In-Reply-To: <1330770910-7992-1-git-send-email-sancane@gmail.com>
References: <1330770910-7992-1-git-send-email-sancane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

>  doc/heartrate-api.txt |   72 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 doc/heartrate-api.txt
> 
> diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
> new file mode 100644
> index 0000000..5dcaa52
> --- /dev/null
> +++ b/doc/heartrate-api.txt
> @@ -0,0 +1,72 @@
> +BlueZ D-Bus Heart Rate API description
> +****************************************
> +
> +	Santiago Carot-Nemesio <sancane@gmail.com>
> +
> +Heart Rate Profile hierarchy
> +============================
> +
> +Service		org.bluez
> +Interface	org.bluez.HeartRate
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Methods		dict GetProperties()
> +
> +			Returns all properties for the interface. See the
> +			Properties section for the available properties.
> +
> +		RegisterWatcher(object agent)
> +
> +			Registers a watcher to monitor heart rate measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		UnregisterWatcher(object agent)
> +
> +			Unregisters a watcher.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotFound
> +
> +		Reset()
> +
> +			Restart the accumulation of energy expended from zero.
> +
> +			Possible Errors: org.bluez.Error.NotSupported
> +
> +Properties	boolean ResetSupported [readonly]
> +
> +			True if energy expended is supported.
> +
> +Heart Rate Watcher hierarchy
> +============================
> +Service		unique name
> +Interface	org.bluez.HeartRateWatcher
> +Object path	freely definable
> +
> +Methods		void MeasurementReceived(dict measure)
> +
> +			This callback is called whenever a heart rate measurement
> +			is received from the heart rate device. The unit for the
> +			Value is expressed in beats per minute (bpm). The energy
> +			field is optional and represents the accumulated energy
> +			expended in kilo Joules since last time it was reset.
> +			Furthermore, the device will be automatically reset when
> +			it is needed.
> +			The Contact field, if present, indicates that the device
> +			supports contact sensor, besides it will be true if skin
> +			contact is detected. The optional interval field is an
> +			array containing RR-Interval values which represent the
> +			time between two R-Wave detections, where the RR-Interval
> +			Value 0 is older than the Value 1 and so on.
> +
> +			Dict is defined as below:
> +			{
> +				"Value" : uint16,
> +				"Energy" : uint16,
> +				"Contact" : boolean,
> +				"Location" : ("Other", "Chest", "Wrist","Finger",
> +					"Hand", "Ear Lobe", "Foot"),

values are lower-case and either one word or connected via -. Also I
think it is earlobe and not ear lobe. Oxford dictionary please ;)

Regards

Marcel


