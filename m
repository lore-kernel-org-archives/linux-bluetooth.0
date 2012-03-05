Return-Path: <cyrus@holtmann.org>
Date: Sun, 4 Mar 2012 17:51:18 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Heart Rate Profile API
Message-ID: <20120305015118.GA26388@x220>
References: <1330770910-7992-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330770910-7992-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

A couple of issues still:

On Sat, Mar 03, 2012, Santiago Carot-Nemesio wrote:
> @@ -0,0 +1,72 @@
> +BlueZ D-Bus Heart Rate API description
> +****************************************
> +
> +	Santiago Carot-Nemesio <sancane@gmail.com>

Is the above supposed to be a copyright statement? If so, fix it. (the
documentation files need that anyway).

> +Heart Rate Watcher hierarchy
> +============================
> +Service		unique name

Add an empty line after the header.

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
> +				"Interval" : array{uint16}
> +			}

Please reformat the above to be less than 80 characters wide. Right now
some lines are either 80 or 81.

Johan
