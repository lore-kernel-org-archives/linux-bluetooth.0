Return-Path: <cyrus@holtmann.org>
Subject: Re: Battery information
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20091106195819.GA15510@jh-x301>
References: <1257533769.23167.194.camel@localhost.localdomain>
	 <20091106195819.GA15510@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 06 Nov 2009 20:15:23 +0000
Message-ID: <1257538523.23167.203.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-11-06 at 21:58 +0200, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Fri, Nov 06, 2009, Bastien Nocera wrote:
> > A colleague has a Samsung WEP470 headset which triggers an error from
> > bluetoothd.
> > 
> > Attached is a minimal patch to avoid the error. Would be nice if we
> > could export that property through bluetoothd.
> 
> I don't really see the point of this patch. What's the benefit of
> returning "OK" instead of "ERROR" in this case, especially since the
> added command handler doesn't do anything? As far as I see returning
> "ERROR" is the right behavior for us when we encounter a command which
> we don't understand (there are also no other side effects on our side
> when we send an error, i.e. the connection is allowed proceed normally).

Nobody likes errors showing up in their /var/log/messages. In any case,
that was a minimal patch to avoid that.

> As far as exporting the battery charge info goes, yes we could consider
> that. However, I'm a bit hesitant about this since AT+CBC isn't part of
> the HFP spec. It is in the 3GPP AT-command spec (TS 07.07), but even
> there it's only specified to be used for querying the ME's (BlueZ in
> this case) battery level. I.e. the way this headset uses it doesn't seem
> to conform to any standard (or at least any that I'm aware of).

I'm pretty sure it's a vendor extension from Samsung. And I guess that
it would actually show the battery information when paired with a
Samsung phone. So it might be something useful to handle in bluetoothd.

