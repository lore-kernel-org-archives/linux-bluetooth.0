Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Matthias Thomae <thomae@ei.tum.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F65DB01.9030802@ei.tum.de>
References: <3F65D3E6.60307@ei.tum.de>  <3F65DB01.9030802@ei.tum.de>
Content-Type: text/plain
Message-Id: <1063639940.28891.510.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: bfusb 1.1 firmware loading and rc-scripts
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 15 Sep 2003 17:32:14 +0200

Hallo Matthias,

> since upgrading from bfusb 1.0 to 1.1 I have problems creating bluetooth 
> connections at system start form the rc-scripts on a debian/unstable 
> system, such as PAN or CMTP connections.
> 
> I think this is because the old bfusb version was returning only when 
> the firmware has finished loading into the dongle (which takes a few 
> seconds), whereas the new version returns immediately and loads the 
> firmware in the background. Is this correct? When putting "sleep 10" in 
> one of the rc scripts, it works as before.

the firmware loading routine is the same and blocks until the firmware
is loading. The only difference is where the firmware file comes from.

> Is there a way to detect when the firmware loading is finished, or would 
> you consider to change back to the old behaviour?

The current driver is working fine and the firmware loading is finished,
when the HCI device is created.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
