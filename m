Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: Kyle Rose <krose+bluez@krose.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	 <1097185188.7325.75.camel@pegasus>
	 <khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
Content-Type: text/plain
Message-Id: <1097186322.7325.79.camel@pegasus>
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
Date: Thu, 07 Oct 2004 23:58:42 +0200

Hi Kyle,

> > this looks very weird. Especially the switching to the VT.
> 
> I guess I wasn't very specific here.  I switch to VT because I can't
> get to a terminal without a working mouse. :) It has nothing to do
> with executing hidd --search from a VT vs. a pty.

this are good news, because otherwise the input subsystem may be broken.

> > Is the cradle in HID or in HCI mode?
> 
> Uh... this isn't something I've dealt with before.  When I installed
> bluez on the 32 bit system several months ago, I just turned on HIDP
> support and it simply "worked."  I didn't realize there were different
> modes here.  How do I switch the mode?  Different module?
> 
> FWIW, "hcitool dev" gives "hci0 ...", suggesting it is in hci mode,
> which probably isn't right.

If this is a Debian system then hid2hci will normaly run a boot time and
switch it from HID to HCI mode.

> > Run "hcidump -X" as root whenever possible so we can see if there are
> > wrong things.
> 
> My hcidump doesn't recognize -X.  This is a new option maybe?  I'm
> using the one from the Debian AMD64 alioth repository (1.10).

Then use "-x". I think the "-X" option was introduced with 1.11 or so
and the Debian packages are a little bit behind.

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
