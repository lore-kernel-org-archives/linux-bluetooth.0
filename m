Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Nicholas A. Preyss" <nalp@gmx.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1084371486.4426.156.camel@hades.cambridge.redhat.com>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1084382445.25099.77.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 19:20:45 +0200

Hi David,

> > the bluez-utils-2.7 now contains sdpd, pand, dund and hidd. So there was
> > a need for a new init script that is able to start each of these daemons
> > on bootup. I enabled hidd by default, because it didn't harm if it is
> > started and hid2hci makes also sense. Why should it not be started?
> 
> For the Fedora package I've put pand, dund and hidd in separate init
> scripts. It's expected that individual services can be enabled or
> disabled with chkconfig or system-config-services, rather than by
> manually editing a separate config file. 
> 
> Also, I've often been glad of being able to restart pand _separately_
> from hcid and sdpd. Doesn't sdpd forget _everything_ that's registered
> when you restart it?
> 
> But hid2hci does make sense, assuming of course that you're not relying
> on a Bluetooth HID device without having the Linux BT-HID support
> working yet.

I have no problem with that, but for the upstream package I am going to
keep it this way. If you aren't a developer then you start the daemons
at boot and kill them at shutdown. That's all.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
