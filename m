Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] HID mouse doesnt reconnect after sleep if
	bemused-bemusedlinuxserver connection is open
From: Marcel Holtmann <marcel@holtmann.org>
To: Jouni.Lohikoski@iki.fi
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041017133034.GC274769@kosh.hut.fi>
References: <20041017125132.GA274769@kosh.hut.fi>
	 <1098018136.4911.87.camel@pegasus>  <20041017133034.GC274769@kosh.hut.fi>
Content-Type: text/plain
Message-Id: <1098026676.4911.96.camel@pegasus>
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
Date: Sun, 17 Oct 2004 17:24:37 +0200

Hi Jouni,

> > > hcid is in security mode 3, auth+encryption turned on.
> > 
> > as I always said, do this only if you know what you are doing ;)
> 
> I have a hint of what I am doing? :-)
> If I take the authentication off, with current bemused implementation
> anyone could download ogg and mp3-files from my computer. I could not
> claim I did not know this was possible or I didn't know that would be
> illegal :P

fine for me as long as you are aware of the side effects of using
security mode 3.

> > What does "hciconfig -a" and "hcitool info <phone>" say?
> 
> Now, in this moment when I have both HID-mouse and Bemused working, it
> looks like this:

Check with "hciconfig hci0 revision" (as root) your firmware version of
your dongle, but it is not a HCI 16.x one and so it does not support any
kind of scatternet stuff and this is maybe the reason why it fails. Use
"hcidump -x" to check for the real HCI error codes and look them up in
the Bluetooth specification.

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
