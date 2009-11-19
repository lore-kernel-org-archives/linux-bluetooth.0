Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1258635027.2150.9168.camel@localhost.localdomain>
References: <5eee8c670911190321gd44f7f4x522dc8af67e19c2f@mail.gmail.com>
	<20091119123535.GA4305@jh-x301> <1258635027.2150.9168.camel@localhost.localdomain>
From: Alexander H Deriziotis <deriziotis@gmail.com>
Date: Thu, 19 Nov 2009 14:13:20 +0000
Message-ID: <5eee8c670911190613q774ff195me5728f3f3dc6061e@mail.gmail.com>
Subject: Re: Connecting to Bluetooth Speakers via command line
To: Bastien Nocera <hadess@hadess.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/11/19 Bastien Nocera <hadess@hadess.net>:
> On Thu, 2009-11-19 at 14:35 +0200, Johan Hedberg wrote:
>
> How about trying to connect to the last used audio device? That would
> probably solve most use cases, and avoid surprises.
>
> Do you want to file a bug against gnome-bluetooth to ask for that? I'll
> try to implement it then.
>
> Cheers
>

Hi Bastien,

This would fit my needs perfectly. If I want to stop using the
bluetooth speakers, I'll just Disconnect them through the applet.
Sounds pretty intuitive.

Hopefully I've filed the bug in the correct place:

https://bugzilla.gnome.org/show_bug.cgi?id=602409

I take it if anyone disagrees with this behaviour, then they'll raise
it here, or on the bugreport.

Thanks,
Alex

p.s. Thanks Johan for the script, I'll test it when I get home tonight :)
