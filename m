Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Jul 2010 14:31:06 -0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix signal strength for HFP in maemo6 telephony
Message-ID: <20100712173106.GA18755@jh-x301>
References: <1278954283-3832-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278954283-3832-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Mon, Jul 12, 2010, Dmitriy Paliy wrote:
> Signal strength in terms of bars units is updated by emited
> SignalBarsChanged instead of SignalStrengthChanged from libscnet library.
> It contains required number of bars to display in scale 0..5. Conversion
> from percent or decibel units to bars is not needed and therefore removed.
> 
> Same holds when initializing by request of SignalBars, where bars are in
> 0..5 range. Conversion from percents is removed. Sanity check is done to
> prevent -1 that may be returned when the property is unavailabe (modem
> state off).
> 
> RSSI percents and dBs are neither present among SignalBarsChanged
> properties nor requested during initialization and, therefore, removed.
> ---
>  audio/telephony-maemo6.c |   20 +++++++++-----------
>  1 files changed, 9 insertions(+), 11 deletions(-)

This patch has been pushed upstream. Thanks.

Johan
