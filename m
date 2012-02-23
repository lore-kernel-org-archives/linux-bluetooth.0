Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329731673-5878-2-git-send-email-sancane@gmail.com>
References: <1329731673-5878-1-git-send-email-sancane@gmail.com>
	<1329731673-5878-2-git-send-email-sancane@gmail.com>
Date: Thu, 23 Feb 2012 12:06:36 -0400
Message-ID: <CAJdJm_MYTdfXhnkbM8-53U0Ge6vn3DDGJcJYWUTvo+ZrVSJhkw@mail.gmail.com>
Subject: Re: [PATCH] Heart Rate Profile API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

Just minor typos below. After they are fixed, I think it is okay to go upstream.

On Mon, Feb 20, 2012 at 5:54 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +Methods                void MeasurementReceived(dict measure)
> +
> +                       This callback is called whenever a heart rate measurement
> +                       is received from the heart rate device. The unit for the
> +                       Value is expressed in beats per minute (bpm). The energy
> +                       field is optional and represents the accumulated energy
> +                       expended in kilo Joules since last time it was resetted.
> +                       Furthermore, the device will be automatically resetted

resetted -> reset (two occurrences)

> +                       when it is needed.
> +                       The Contact field, if present, indicates that the device
> +                       supports contact sensor, besides it will be true if skin
> +                       contact is detected. The optional interval field is an
> +                       array containing RR-Interval values which represent the
> +                       time between two R-Wave detections, where the RR-Interval
> +                       Value 0 is older than the Value 1 and so on.
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

Remember to add the missing newline on the last line of the file (Vim
adds this automatically, so it avoids "collateral" changes if we
simple add the newline at the end of text files).


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
