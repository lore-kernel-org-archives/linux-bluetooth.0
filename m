Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349083437-23528-8-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1349083437-23528-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1349083437-23528-8-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Mon, 1 Oct 2012 11:43:42 +0200
Message-ID: <CACLukzL99YF13_+V9wemKgWVQGC8Wcj_v+41A8DWrxnK2=cfoQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] thermometer: Reformat MeasurementReceived description
From: Santiago Carot <sancane@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej

2012/10/1 Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>:
> MeasurementReceived method description is reformatted to be more
> readable and consistent with other API documents.
>
> Special values for Exponent and Mantissa fields specify now only NaN
> value as this is only special value defined by HTS specification for
> measurement.
> ---
>  doc/thermometer-api.txt | 67 +++++++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 30 deletions(-)
>
> diff --git a/doc/thermometer-api.txt b/doc/thermometer-api.txt
> index 1828811..0fb28f5 100644
> --- a/doc/thermometer-api.txt
> +++ b/doc/thermometer-api.txt
> @@ -97,33 +97,40 @@ Service             unique name
>  Interface      org.bluez.ThermometerWatcher
>  Object path    freely definable
>
> -Methods                void MeasurementReceived(dict measure)
> -
> -                       This callback gets called when a measure has been
> -                       scanned in the thermometer. The Time entry in the dict
> -                       will be only present if the device supports storing of
> -                       data. The time value is expressed in seconds since epoch.
> -                       The value represented is (mantissa) x (10**exponent)
> -                       See foot note for special values when treating with
> -                       health devices. The Type entry is only present if the
> -                       measurement type is known. Otherwise, it is undefined.
> -
> -                       Dict is defined as below:
> -                       {
> -                               "Exponent" : int8,
> -                               "Mantissa" : int32,
> -                               "Unit" : ("Celsius" or "Fahrenheit"),
> -                               "Time" : uint64,
> -                               "Type" : ("Armpit", "Body", "Ear", "Finger",
> -                                       "Intestines", "Mouth", "Rectum", "Toe",
> -                                       "Tympanum"),
> -                               "Measurement" : ("Final" or "Intermediate"),
> -                       }
> -
> -                       For special cases, the exponent shall always be zero and
> -                       the mantissa should be one of following values:
> -
> -                       NRes = -(2**23)
> -                       NaN = +(2**23-1)
> -                       INFINITY = (2**23-2)
> -                       -INFINITY = -(2**23-2)
> +Methods                void MeasurementReceived(dict measurement)
> +
> +                       This callback gets called when a measurement has been
> +                       scanned in the thermometer.
> +
> +                       Measurement:
> +
> +                               int16 Exponent:
> +                               int32 Mantissa:
> +
> +                                       Measurement value is calculated as
> +                                       (Mantissa) x (10^Exponent)
> +
> +                                       In case of invalid or missing data,
> +                                       Exponent is set to 0 and Mantissa is
> +                                       set to 2^23-1 (0x7FFFFF hexadecimal).

Mantissa values must not always be 2^23-1 on special cases.
Information provided here is required for upper profiles which are
implementing an 11073-20601 protocol layer because they have to
differentiate among these values. In my opinion, documentation about
passible values for the mantissa should remain as they are.

Regards
