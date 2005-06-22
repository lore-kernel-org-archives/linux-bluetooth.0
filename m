Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <006c01c5772d$595a7020$3202010a@acselection.local>
References: <006c01c5772d$595a7020$3202010a@acselection.local>
Content-Type: text/plain
Message-Id: <1119452070.26772.174.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 22 Jun 2005 16:54:30 +0200

Hi Andy,

> Hotplug has always been installed, the firmware is in /lib/firmware and
> I'm still getting the below error.
> I think it's looking at the wrong directory for the firmware, are there
> any ways to debug what's happening?
> If you have any other suggestions they would be really appreciated.

since Ubuntu is Debian based there should no problem unless they changed
something in the hotplug package. Check if /etc/hotplug/firmware.agent
exists and in what directories it expects the firmware file. Also check
that your firmware file is really present and is not a zero size file.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
