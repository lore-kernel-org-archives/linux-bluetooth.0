Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] modprobe: FATAL: Error inserting hci_usb
From: David Woodhouse <dwmw2@infradead.org>
To: Pander <pander@users.sourceforge.net>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <416D745B.7020208@users.sourceforge.net>
References: <416D745B.7020208@users.sourceforge.net>
Content-Type: text/plain
Message-Id: <1097866949.13633.512.camel@hades.cambridge.redhat.com>
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
Date: Fri, 15 Oct 2004 20:02:30 +0100

On Wed, 2004-10-13 at 20:30 +0200, Pander wrote:
> I also patched the 2.6.8.1 kernel source with patch-2.6.8-mh2 but that 
> resulted in the same error. dmesg says the same as above. Does anyone 
> know how to fix this?

The unknown symbols are from the core bluetooth.ko module. It looks like
an attempt has been made to insmod the hci_usb.ko module _without_ first
loading the bluetooth.ko modules.

The modules are _also_ loaded correctly though, and then it works.

I don't see this with Fedora on my PowerBook G4. I suspect it's a
userspace problem. Check that the dependencies are correct -- has depmod
been run?

-- 
dwmw2



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
