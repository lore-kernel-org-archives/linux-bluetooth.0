Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 09:57:25 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
Message-ID: <20130220075725.GA14731@x220>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Tue, Feb 12, 2013, Waldemar Rymarkiewicz wrote:
> Change-Id: I7165ecee0186dfdb51cd01838f28768d94ff12b9
> ---

Please provide a proper commit message.

> +Blood Pressure Manager hierarchy
> +================================
> +
> +Serviceorg.bluez
> +Interface	org.bluez.BloodPressureManager1
> +Object path	[variable prefix]/{hci0,hci1,...}
> +
> +Methods		RegisterWatcher(object agent)
> +
> +			Registers a watcher to monitor blood pressure
> +			measurements. This agent will be notified about
> +			final pressure measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		UnregisterWatcher(object agent)
> +
> +			Unregisters a watcher.
> +
> +		EnableIntermediateMeasurement(object agent)
> +
> +			Enables intermediate measurement notifications
> +			for this agent. Intermediate measurements will
> +			be enabled only for devices which support it.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		DisableIntermediateMeasurement(object agent)
> +
> +			Disables intermediate measurement notifications
> +			for this agent. It will disable notifications in
> +			devices when the last agent removes the
> +			watcher for intermediate measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotFound

I'm a bit confused, what's the difference between "watcher" and "agent"?
If they're the same thing just pick one term and stick to it.

> +Blood Pressure Profile hierarchy
> +================================
> +
> +Service		org.bluez
> +Interface	org.bluez.BloodPressure1
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Properties	boolean Intermediate [readonly]
> +
> +			True if the device supports intermediate
> +			measurement notifications.

What's the use of this property (and the interface)? I don't see how it
relates to any other APIs in this specification.

Johan
