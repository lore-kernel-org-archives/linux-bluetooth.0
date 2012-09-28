Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 13:43:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 07/14] thermometer: Reformat MeasurementReceived
 description
Message-ID: <20120928104318.GC25415@x220>
References: <1348584763-22824-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348584763-22824-8-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348584763-22824-8-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Sep 25, 2012, Andrzej Kaczmarek wrote:
> +			Measurement:
> +
> +				int16 Exponent:
> +				int32 Mantissa:
> +
> +					Measurement value is calculated as
> +					(Mantissa) x (10^Exponent)
> +
> +					In case of invalid or missing data,
> +					Exponent is set to 0 and Mantissa is
> +					set to 2^23-1 (0x7FFFFF hexadecimal).

Why aren't we using the D-Bus DOUBLE type for this? For invalid/missing
data just leave out these values from the dict. No need to try to
brute-force a 1:1 mapping from the protocol to D-Bus.

> +
> +				string Unit:
> +
> +					Possible values: "Celsius" or "Fahrenheit"

String properties should be lower-case. Please fix (both doc and
implementation).

> +				string Type (optional):
> +
> +					Only present if measurement type is known.
> +
> +					Possible values: "Armpit", "Body", "Ear",
> +						"Finger", "Intestines", "Mouth",
> +						"Rectum", "Toe", "Tympanum"

Same here.

> +				string Measurement:
> +
> +					Possible values: "Final" or "Intermediate"

And here.

Johan
