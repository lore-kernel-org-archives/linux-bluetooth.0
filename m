Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Charles Bueche <charles@bueche.ch>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Cc: Dave Sailer <dave.sailer@paytec.com>
Subject: Re: [Bluez-users] problem with keyboard/mouse
Message-ID: <20041022152443.251405a6@bluez.bueche.ch>
In-Reply-To: <1098449746.4704.56.camel@pegasus>
References: <1098441508.11708.12.camel@dsailer>
	<1098443444.4704.46.camel@pegasus>
	<1098447645.11708.17.camel@dsailer>
	<1098449746.4704.56.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: Fri, 22 Oct 2004 15:24:43 +0200

Hi,

to add my grain of salt : I run 2.6.9-gentoo with patch-2.6.9-mh1.gz,
and I see no problem at all. I have however no Microsoft hardware, only 
a Logitech MX900 mouse.

Charles

On Fri, 22 Oct 2004 14:55:46 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Dave,
> 
> > The gentoo forums had this advice....
> > 
> > ---------------------------------
> > You'll see an error when applying the patch... Confused : 
> > Quote:
> > 
> > patching file drivers/bluetooth/hci_usb.c 
> > patching file include/net/bluetooth/bluetooth.h 
> > patching file include/net/bluetooth/hci_core.h 
> > patching file include/net/bluetooth/hci.h 
> > patching file Makefile 
> > Hunk #1 FAILED at 1. 
> > 1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej 
> > patching file net/bluetooth/af_bluetooth.c 
> > patching file net/bluetooth/bnep/core.c 
> > patching file net/bluetooth/hci_conn.c 
> > patching file net/bluetooth/hci_core.c 
> > patching file net/bluetooth/hci_event.c 
> > patching file net/bluetooth/hci_sock.c 
> > patching file net/bluetooth/hidp/core.c 
> > patching file net/bluetooth/hidp/hid.c 
> > patching file net/bluetooth/hidp/hid.h 
> > patching file net/bluetooth/hidp/hidp.h 
> > patching file net/bluetooth/hidp/Makefile 
> > patching file net/bluetooth/Kconfig 
> > patching file net/bluetooth/l2cap.c 
> > patching file net/bluetooth/rfcomm/sock.c 
> > That's totaly normal
> > 
> > -----------------------------
> > anyway, do you have any idea what my error might be or is this
> > something I need to go back to the gentoo folks with?
> 
> if you only see a reject for the Makefile then this ok as long as
> Makefile.rej only shows you the hunk for the EXTRAVERSION.
> 
> Maybe you wanna do a "make clean" or "make distclean" first. Or simply
> try a vanilla 2.6.9-mh1.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on
> ITManagersJournal Use IT products in your business? Tell us what you
> think of them. Give us Your Opinions, Get Free ThinkGeek Gift
> Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
