Return-Path: <cyrus@holtmann.org>
Date: Tue, 6 Apr 2010 20:57:30 +0100 (BST)
To: Garry Paxinos <paxinos@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: upper limit of bonded devices?
In-Reply-To: <x2xf3ae2ce11004061132gd546fb7emd890e6c096c72bd3@mail.gmail.com>
References: <r2if3ae2ce11004061001mc539e7eaq206d43ffb12fb2d2@mail.gmail.com>  <j2tf3ae2ce11004061008x26da852el996b017a5115d595@mail.gmail.com>  <1270577971.764253.580.nullmailer@galant.ukfsn.org>
 <x2xf3ae2ce11004061132gd546fb7emd890e6c096c72bd3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1270583850.437918.726.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 6 Apr 2010, Garry Paxinos wrote:

> Thanks for the quick reply!    We actually have an application that
> could conceivable pair with over 1M devices if the project is
> successful.
>
> There are really two other issues to resolve in this scenario -
>
> 1. Is it possible to have the computer initiate the connection to a
> bonded device without previously knowing what devices are currently in
> the vicinity?  Especially when our bonded DB is excessively large.

Sure, but consider that the page timeout (time to failure of a connection
attempt) is usually around 20 seconds.. and most Bluetooth controllers
(that I have tried) can only page a single device at a time.. So, if you
don't know which devices are in range, you might be waiting a *long* time
before you connect to anything..

I have not read the 3.0 spec though, and using another transport (wifi)
might make some things faster and make what you want possible.

> 2. Is there a way (even if we need to do device driver work) to gain
> access to signal strength before bonding to  a device?  And before
> connecting to a device?  We really need to limit ourselves to bonding
> and connecting with devices that are located in a very close
> proximity.

Hrm, you can do inquiry-with-rssi which will tell you the signal strength.
But, that requires the remote device to be discoverable. And, it takes
more time (most Bluetooth controllers are not able to make connections at
the same time as discovering nearby devices). And, I read of experiments
trying to correlate signal strength with distance which were not that
successful anyway.

You don't say too much about the role and ownership of different devices
in your application network, and if you really need the generic
interoperability of Bluetooth. By this, I mean for instance if you need to
be able to contact standard devices (eg phones owned by third-parties,
possibly running your app amongst other things) or if the devices will be
custom built for your application (in which case, you can control
everything about how the device behaves)

There is unused capability in the "class of device" identifier which is
provided in inquiry results and can be used to filter inquiry results
before trying connections. But, in a 'standard' device you might have
trouble using it for your own purposes..

regards,
iain


