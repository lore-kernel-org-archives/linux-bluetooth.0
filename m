Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040511192919.GB28581@gmx.net>
References: <20040511192919.GB28581@gmx.net>
Content-Type: text/plain
Message-Id: <1084368229.25099.26.camel@pegasus>
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
Date: Wed, 12 May 2004 15:23:49 +0200

Hi Nicholas,

> i don't get the point why there is a difference in the configuration
> file in /etc/default/bluetooth and the init script. Or the other way
> around: why is hidd and hid2hci activated by default?
> I don't see any sense in this.

the bluez-utils-2.7 now contains sdpd, pand, dund and hidd. So there was
a need for a new init script that is able to start each of these daemons
on bootup. I enabled hidd by default, because it didn't harm if it is
started and hid2hci makes also sense. Why should it not be started?

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
