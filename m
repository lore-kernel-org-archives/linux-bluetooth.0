Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Sep 2012 10:47:09 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Santiago Carot-Nemesio <sancane@gmail.com>
Subject: Re: [PATCH v2 01/17] Heart Rate Profile API
Message-ID: <20120905134708.GA11695@samus>
References: <1346850348-21176-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1346850348-21176-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346850348-21176-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 15:05 Wed 05 Sep, Andrzej Kaczmarek wrote:
> From: Santiago Carot-Nemesio <sancane@gmail.com>
> 
> ---
>  doc/heartrate-api.txt | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 doc/heartrate-api.txt
> 
> diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
> new file mode 100644
> index 0000000..3afea78
> --- /dev/null
> +++ b/doc/heartrate-api.txt
> @@ -0,0 +1,83 @@
> +			 Heart Rate API description
> +****************************************
> +
> +Copyright (C) 2012	Santiago Carot-Nemesio <sancane@gmail.com>
> +Copyright (C) 2012	Tieto Poland
> +
> +Heart Rate Manager hierarchy
> +============================
> +
> +Service		org.bluez
> +Interface	org.bluez.HeartRateManager
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods		RegisterWatcher(object agent)
> +
> +			Registers a watcher to monitor heart rate measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		UnregisterWatcher(object agent)
> +
> +			Unregisters a watcher.
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
> +		Reset()
> +
> +			Restart the accumulation of energy expended from zero.
> +
> +			Possible Errors: org.bluez.Error.NotSupported
> +
> +Properties	String Location (optional) [readonly]
> +
> +			Possible values: "Other", "Chest", "Wrist","Finger",
> +					"Hand", "Earlobe", "Foot"
> +
> +		boolean ResetSupported [readonly]
> +
> +			True if energy expended is supported.
> +
> +Heart Rate Watcher hierarchy
> +
> +============================
> +Service		unique name
> +Interface	org.bluez.HeartRateWatcher
> +Object path	freely definable
> +
> +Methods		void MeasurementReceived(object device, dict measure)
> +
> +			This callback is called whenever a heart rate
> +			measurement is received from the heart rate device.
> +			The unit for the Value is expressed in beats per
> +			minute (bpm). The energy field is optional and
> +			represents the accumulated energy expended in
> +			kilo Joules since last time it was reset. Furthermore,
> +			the device will be automatically reset when it
> +			is needed.
> +			The Contact field, if present, indicates
> +			that the device supports contact sensor, besides it
> +			will be true if skin contact is detected. The optional
> +			interval field is an array containing RR-Interval
> +			values which represent the time between two R-Wave
> +			detections, where the RR-Interval value 0 is older
> +			than the value 1 and so on.

The description of the possible fields could be similar to what's done
above and what media-api.txt is doing.

> +
> +			Dict is defined as below:
> +			{
> +				"Value" : uint16,
> +				"Energy" : uint16,
> +				"Contact" : boolean,
> +				"Interval" : array{uint16}
> +			}
> +
> -- 
> 1.7.11.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
