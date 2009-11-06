Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Nov 2009 21:58:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Battery information
Message-ID: <20091106195819.GA15510@jh-x301>
References: <1257533769.23167.194.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257533769.23167.194.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Fri, Nov 06, 2009, Bastien Nocera wrote:
> A colleague has a Samsung WEP470 headset which triggers an error from
> bluetoothd.
> 
> Attached is a minimal patch to avoid the error. Would be nice if we
> could export that property through bluetoothd.

I don't really see the point of this patch. What's the benefit of
returning "OK" instead of "ERROR" in this case, especially since the
added command handler doesn't do anything? As far as I see returning
"ERROR" is the right behavior for us when we encounter a command which
we don't understand (there are also no other side effects on our side
when we send an error, i.e. the connection is allowed proceed normally).

As far as exporting the battery charge info goes, yes we could consider
that. However, I'm a bit hesitant about this since AT+CBC isn't part of
the HFP spec. It is in the 3GPP AT-command spec (TS 07.07), but even
there it's only specified to be used for querying the ME's (BlueZ in
this case) battery level. I.e. the way this headset uses it doesn't seem
to conform to any standard (or at least any that I'm aware of).

Johan
