Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Wacom Graphire Bluetooth  problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050926113225.GA19843@polar.elf12.net>
References: <20050924200358.GJ28437@polar.elf12.net>
	 <1127644165.6362.0.camel@localhost.localdomain>
	 <20050925123425.GA8683@polar.elf12.net>
	 <1127661017.6362.9.camel@localhost.localdomain>
	 <20050925165458.GC8683@polar.elf12.net>
	 <1127726670.6163.18.camel@localhost.localdomain>
	 <20050926113225.GA19843@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1127892511.5321.2.camel@localhost.localdomain>
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
Date: Wed, 28 Sep 2005 09:28:31 +0200

Hi Robert,

> Aehm, sorry for being unclear, my question was: Where
> are the huge differences between
> 2.6.12-mh3 and
> 2.6.13-mh1

if you look only to HID then there is no difference.

> A new question: Do I see it right that there are at the moment two HID
> interpreter in a patched kernel: one for USB and one for Bluetooth? Are
> there already differences between them? (Why? Which?)

The Bluetooth HID is derived from the USB HID, but without the hiddev
support and a lot of things stripped out. It is basically a proof of
concept.

> > > Where is the driving force
> > > behind a generic HID driver? Here or more with the USB guys? <-:
> > > I fear that it will take some six month or longer. - I will probably dig
> > > into the HID bluetooth code to get the Wacom working ...
> > > ... and do some adaptions when the generic driver arises.
> > 
> > I think the force for that have to be driven by me. We all agreed on how
> > this should be done, but there are some things pending that I like to
> > see merged first mainline (subclass support and sysfs integration)
> > before I look at it again.
> 
> Hm... Would you approve some HID hacking on your -mh patches for the
> meantime? I'm also interested in a generic HID driver but don't want to
> stand still until it appears. - Later joining wanted.

Send in patches against the latest -mh patch.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
