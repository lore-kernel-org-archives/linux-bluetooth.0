Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Feb 2013 16:18:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
Message-ID: <20130228141847.GA24103@x220>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20130220075725.GA14731@x220>
 <512F62E0.1030706@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <512F62E0.1030706@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Feb 28, 2013, Rymarkiewicz Waldemar wrote:
> >>+Methods		RegisterWatcher(object agent)
> >>+
> >>+			Registers a watcher to monitor blood pressure
> >>+			measurements. This agent will be notified about
> >>+			final pressure measurements.
> >>+
> >I'm a bit confused, what's the difference between "watcher" and "agent"?
> >If they're the same thing just pick one term and stick to it.
> 
> Both mean the same, I guess. I've followed the description of
> existing profiles thermometer, cscp, hrp.

You might want to fix those in a separate patch set then. Just because
something is in the source tree doesn't mean that it's worth copying
into new code/documentation.

> Methods		RegisterWatcher(object watcher)
> 
> 			Registers a watcher to monitor blood pressure
> 			measurements. This watcher will be notified about
> 			final pressure measurements.
> 
> Is this ok?

Yes, that looks better.

> >>+Blood Pressure Profile hierarchy
> >>+================================
> >>+
> >>+Service		org.bluez
> >>+Interface	org.bluez.BloodPressure1
> >>+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> >>+
> >>+Properties	boolean Intermediate [readonly]
> >>+
> >>+			True if the device supports intermediate
> >>+			measurement notifications.
> 
> 
> >What's the use of this property (and the interface)? I don't see how it
> >relates to any other APIs in this specification.
> 
> The device may support notifications of intermediate cuff pressure.
> That means during measurement it notifies the Collector what is
> current pressure in cuff (my device sends 5 notifications per sec)
> until it is ready to send final measurements (diastolic, systolic
> and MAP pressure).
> 
> Based on this property an app can decide if it wants to
> EnableIntermediateMeasurement (CCC of right characteristic in
> configured then) or not.

Couldn't you just return a "NotSupported" error to
EnableIntermediateMeasurement?

> Similarly as in thermometer api.

I suspect there are several messed up LE APIs and implementations in the
source tree, so I'd say it's highly advisable to not just blindly copy
from the existing code but also use some common sense and be critical of
what you see.

Johan
