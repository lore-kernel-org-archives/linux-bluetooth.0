Return-Path: <SRS0+60c553d8115f4e85c6cb+262+infradead.org+dwmw2@pentafluge-151807.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084368229.25099.26.camel@pegasus>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084371486.4426.156.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 12 May 2004 15:18:07 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

On Wed, 2004-05-12 at 15:23 +0200, Marcel Holtmann wrote:
> Hi Nicholas,
> 
> > i don't get the point why there is a difference in the configuration
> > file in /etc/default/bluetooth and the init script. Or the other way
> > around: why is hidd and hid2hci activated by default?
> > I don't see any sense in this.
> 
> the bluez-utils-2.7 now contains sdpd, pand, dund and hidd. So there was
> a need for a new init script that is able to start each of these daemons
> on bootup. I enabled hidd by default, because it didn't harm if it is
> started and hid2hci makes also sense. Why should it not be started?

For the Fedora package I've put pand, dund and hidd in separate init
scripts. It's expected that individual services can be enabled or
disabled with chkconfig or system-config-services, rather than by
manually editing a separate config file. 

Also, I've often been glad of being able to restart pand _separately_
from hcid and sdpd. Doesn't sdpd forget _everything_ that's registered
when you restart it?

But hid2hci does make sense, assuming of course that you're not relying
on a Bluetooth HID device without having the Linux BT-HID support
working yet.

-- 
dwmw2
