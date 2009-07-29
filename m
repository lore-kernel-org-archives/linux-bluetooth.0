Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add rfkill plugin
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1248880408.28327.906.camel@localhost.localdomain>
References: <1248798884.23466.12024.camel@localhost.localdomain>
	 <1248880408.28327.906.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 21:49:27 +0200
Message-Id: <1248896967.28545.236.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> > The plugin allows us to restore the previous power state on
> > adapters when the killswitch on them has been unblocked.
> > 
> > Otherwise we end up with the adapter disabled when coming back from a
> > soft killswitch.
> 
> Just a note that __u32 causes failures with newer GCCs (not sure why),
> using uint32_t instead fixes the problem.
> 
> I'll send another patch when this one gets committed.

I didn't commit this patch, because it should be part of bluetoothd and
not a plugin and as I mentioned before honor the RememberPowered setting
for system where other entities control that.

However I did push a RFKILL skeleton that that all the lifting except
bringing the adapter up. Hijacking the set_powered D-Bus command is the
wrong approach. We need a properly exported adapter_up() function for
this.

Regards

Marcel


