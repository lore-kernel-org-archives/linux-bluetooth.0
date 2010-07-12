Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jul 2010 14:36:44 -0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Code consitency for signal strength in HFP maemo6
Message-ID: <20100712173644.GB18755@jh-x301>
References: <1278954361-3876-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278954361-3876-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jul 12, 2010, Dmitriy Paliy wrote:
> This patch simplifies and makes maemo6 telephony driver code consistent
> with libscnet API regarding SignalBarsChanged. RSSI percents and RSSI
> dBs are not among the parameters when SignalBarsChanged emited.
> Therefore, these parameters are removed. Names are changed to reflect
> libscnet d-bus interface notations. Comments and debug information are
> updated in places where units or operations are unclear.
> ---
>  audio/telephony-maemo6.c |   46 +++++++++++++++++++++++-----------------------
>  1 files changed, 23 insertions(+), 23 deletions(-)

This patch has also been pushed upstream, but I had to make the
following manual fixes before that:

> +	 /* Init as 0 meaning inactive mode. In modem power off state */
> +	 /* can be be -1, but we treat all values as 0s regardless */ 
> +	 /* inactive or power off. */

All three lines have tabs and spaces for intentation (one tab + one
space) and the second line has an extra space at the end before the
newline character.

> +static void update_signal_strength(int32_t signal_strength_bars)

The variable name is unnecessarlily long. Simply signal_bars is better
imho.

> +	if (signal_strength_bars < 0) {
> +		DBG("signal strength smaller than expected: %d<0", signal_strength_bars);
> +		signal_strength_bars = 0;
> +	} else if (signal_strength_bars > 5) {
> +		DBG("signal strength greater than expected: %d>5", signal_strength_bars);
> +		signal_strength_bars = 5;

You're going beyond the 80 character limit here and the extra long
variable name isn't really helping out with that.

> +	telephony_update_indicator(maemo_indicators, "signal", signal_strength_bars);

Same here.

Normally I'd have asked you to fix these things, but since we're trying
to get a new release out I went ahead and did it myself. So in the
future please pay attention to this kind of issues :)

Johan
