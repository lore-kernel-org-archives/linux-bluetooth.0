Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if
	bemused-bemusedlinuxserver connection is open
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041017201517.GA323918@kosh.hut.fi>
References: <20041017125132.GA274769@kosh.hut.fi>
	 <1098018136.4911.87.camel@pegasus> <20041017133034.GC274769@kosh.hut.fi>
	 <1098026676.4911.96.camel@pegasus> <20041017165348.GA292044@kosh.hut.fi>
	 <1098032261.4911.102.camel@pegasus> <20041017184054.GA306443@kosh.hut.fi>
	 <1098042076.21553.0.camel@pegasus>  <20041017201517.GA323918@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1098048662.21553.5.camel@pegasus>
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
Date: Sun, 17 Oct 2004 23:31:02 +0200

Hi Jouni,

> > it is enough to do "hciconfig hci0 noauth noencrypt" for testing this,
> > but if this not helps then you should buy yourself a Bluetooth dongle
> > with at least HCI 16.4 firmware on it.
> 
> Ok. It is not huge problem, as I can always disconnect the bemused
> connection for a moment to reconnect the HID mouse.
> 
> But still I don't quite understand why it works otherway around,
> so if HID mouse connection is open and working, I can connect with
> Bemused client to bemusedlinuxserver whether hcid was in security mode 3
> or not, and both works until HID mouse is idle long enough to go in the
> sleep mode.

it looks like a scatternet problem.

> One thing I didn't try. Although HID mouse now made a connection without
> authentication and encryption, maybe it remembered it has to
> authenticate and tried it just like before when hcid was in security
> mode 3. The following hcidump may tell if this was the case for someone
> who is used to read those dumps?

The dump shows that you have more than one hcid running. This is not a
good idea. Check you setup and control with hciconfig if auth and
encrypt are really switched off.

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
