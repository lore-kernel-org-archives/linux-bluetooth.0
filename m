Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200807311721.34299.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <94E72E02-9C26-4FB4-8E0E-414B08E43F6A@holtmann.org>
	 <200807311721.34299.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 19:42:26 +0200
Message-Id: <1217612547.7819.3.camel@californication>
Mime-Version: 1.0
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > yeah, I was afraid of that switching the alternate settings is not as  
> > easy as the spec. might think. Personally I think it is a broken  
> > specification anyway. So the best assumption is that we have one SCO  
> > connection and that is either 8-bit or 16-bit. So we do the switching  
> > when we get the notify() callback for a changed voice setting.
> 
> That's problematic because in the notify() callback you cannot sleep,
> can you? In addition, a device is legally allowed to take a lot of time
> to switch altsettings.

that was not my point. My point was to switch between first or second
alternate setting when you get the notify() callback for a changed voice
setting. Check with the "hciconfig hci0 voice 0x0040" command.

We have to do it in a work queue and that is fine, but then when we get
a connection add notify(), then we only have to start the SCO URBs. This
leaves the only broken case where we have to switch the alternate
setting, because the second SCO channel got established.

Question is if selecting the 2nd alternate setting and not submitting
the URBs for it is a good idea or if that will still consume bandwidth
and power. And thus it would be better to use the first alternate
setting that is meant for the case with no SCO connections.

Regards

Marcel


