Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Mar 2013 15:37:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
Message-ID: <20130301133733.GA28091@x220.P-661HNU-F1>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <20130220075725.GA14731@x220>
 <512F62E0.1030706@tieto.com>
 <20130228141847.GA24103@x220>
 <51309AE3.7070909@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51309AE3.7070909@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Fri, Mar 01, 2013, Rymarkiewicz Waldemar wrote:
> >>>>+Blood Pressure Profile hierarchy
> >>>>+================================
> >>>>+
> >>>>+Service		org.bluez
> >>>>+Interface	org.bluez.BloodPressure1
> >>>>+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> >>>>+
> >>>>+Properties	boolean Intermediate [readonly]
> >>>>+
> >>>>+			True if the device supports intermediate
> >>>>+			measurement notifications.
> >>
> >Couldn't you just return a "NotSupported" error to
> >EnableIntermediateMeasurement?
> 
> 
> I've just confronted this with the code and this make no sens
> because the watcher passed to EnableIntermediateMeasurement is
> registered on the adapter not for a device. So, it's not possible to
> check if the device supports this feature.
> 
> Thus, I will keep Intermediate property for that reason.

Now it makes even less sense. If the EnableIntermediateMeasurement is
per adapter then what use is it to know about whether individual devices
support it or not? The method call will always succeed and the UI will
anyway need to be able to receive intermediate measurements from
arbitrary devices if it has called this method.

So what I'm lacking is a proper explanation of how a UI is supposed to
use this API (in a way that's actually meaningful) as well as why there
is this adapter/device split to begin with (i.e. why the registration
isn't per device or even bluetoothd global).

Johan
