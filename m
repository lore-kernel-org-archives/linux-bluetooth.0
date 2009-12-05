Return-Path: <cyrus@holtmann.org>
Subject: Re: Wiimote pairing?
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1260021437.3311.1899.camel@localhost.localdomain>
References: <1260021437.3311.1899.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Sat, 05 Dec 2009 15:43:24 +0000
Message-ID: <1260027804.3311.1940.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pascal replied to me off-list and said:
> On Sat, 2009-12-05 at 13:57 +0000, Bastien Nocera wrote:
> > I was under the impression that the Wiimote simply didn't use a PIN
> > code, but it seems there's a way to pair it and associate it with a
> > particular host by doing:
> > http://wiibrew.org/wiki/Wiimote#Sync_Button
> 
> FYI last time I checked, the Wiimote seemed to implement some kind of
> whitelist: even after being successfully paired using that PIN, it
> will not initiate a connection unless the host bluetooth address is
> in a range allocated to Nintendo (not sure about the exact criterion).
> 
> > PS: https://bugzilla.redhat.com/show_bug.cgi?id=544564
> 
> So it is unclear whether the change you are suggesting would help
> this particular user.  You need to be either running Bluez on a Wii,
> or willing to spoof the bd_addr of your bluetooth dongle.
> 
> Pascal

So it looks like it wouldn't help anyway...

