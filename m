Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if
	bemused-bemusedlinuxserver connection is open
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041018221157.GA276622@kosh.hut.fi>
References: <20041017125132.GA274769@kosh.hut.fi>
	 <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi>
	 <1098026676.4911.96.camel@pegasus> <20041017165348.GA292044@kosh.hut.fi>
	 <1098032261.4911.102.camel@pegasus> <20041017184054.GA306443@kosh.hut.fi>
	 <1098042076.21553.0.camel@pegasus> <20041017201517.GA323918@kosh.hut.fi>
	 <1098048662.21553.5.camel@pegasus>  <20041018221157.GA276622@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1098138219.5415.0.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Oct 2004 00:23:39 +0200

Hi Jouni,

> > The dump shows that you have more than one hcid running. This is not a
> > good idea. Check you setup and control with hciconfig if auth and
> > encrypt are really switched off.
> 
> hciconfig did show auth and encrypt were off.
> In the init scripts there is only one place where hcid is started 
> /etc/init.d/bluetooth, it should had been run only once from /etc/rc5.d/ 
> However, I had also some old stuff for RH9 in /etc/hotplug/usb/ to make
> bluetooth autostop/autostart when dongle was removed/added on the fly and
> thats where the extra hcids were started. 
> 
> I tried again with only one hcid running, and auth+encrypt off. The same
> thing happened, the hcid didn't get any data from the HID mouse until
> Bemused connection was closed. After the Bemused connection close it
> then did give the following dump, where is couple of those 
> "ERROR: Unexpected syntax" errors. Is those errors because the old
> version of USB dongle (and firmware)?

you can ignore them, because this is a bug in the SDP parser of hcidump.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
