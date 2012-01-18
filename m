Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 14:17:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] Add Proximity Reporter API
Message-ID: <20120118121731.GC6655@x220>
References: <1326143081-30005-2-git-send-email-claudio.takahasi@openbossa.org>
 <1326485995-707-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326485995-707-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Jan 13, 2012, Claudio Takahasi wrote:
> +Proximity Reporter hierarchy
> +===========================
> +
> +Service used by Proximity Path Loss and Find Me. Allows per device
> +alert level handling.
> +
> +Service		org.bluez
> +Interface	org.bluez.ProximityReporter
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods
> +
> +
> +Signals		ImmediateAlertLevelChanged(object device, string value)
> +
> +			This signal indicates that Immediate Alert Level
> +			characteristic was changed by the remote device.
> +			Values: "none", "mild", "high".
> +
> +Properties

Shouldn't ImmediateAlertLevel and LinkLossAlertLevel be defined as
properties and then you'd have PropertyChanged instead of these custom
signals?

Johan
