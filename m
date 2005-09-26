Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Wacom Graphire Bluetooth  problems
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050925165458.GC8683@polar.elf12.net>
References: <20050924200358.GJ28437@polar.elf12.net>
	 <1127644165.6362.0.camel@localhost.localdomain>
	 <20050925123425.GA8683@polar.elf12.net>
	 <1127661017.6362.9.camel@localhost.localdomain>
	 <20050925165458.GC8683@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1127726670.6163.18.camel@localhost.localdomain>
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
Date: Mon, 26 Sep 2005 11:24:29 +0200

Hi Robert,

> > > I'm using debian and it's kernel-making tool but the latest prepared
> > > kernel was 2.6.12.  I patched it with 2.6.12-mh3. There does not seem
> > > to be much Bluetooth/HID related changes between it and 2.6.13 with
> > > patch. - Am I wrong?
> > 
> > yes, you are.
> 
> Hey, that answer was to short... (-:  I found no changelog for the 2.6
> kernel series patches and I compared the patch 2.6.12-mh3 with the
> 2.6.13 one (with my two human eyes). - What changed so dramatically?

the -mh patches contain a specific version for the hidp driver with
report protocol support that is not mainline. It will also never get
into mainline, because the solution is the generic HID driver.

> > > Other question: does BlueZ support HID get/set report feature?? How to
> > > interface it?
> > 
> > Not really at the moment. They will come with generic HID driver sometime
> > in the future.
> 
> The Wacom Graphire Bluetooth needs it...  Where is the driving force
> behind a generic HID driver? Here or more with the USB guys? <-:
> I fear that it will take some six month or longer. - I will probably dig
> into the HID bluetooth code to get the Wacom working ...
> ... and do some adaptions when the generic driver arises.

I think the force for that have to be driven by me. We all agreed on how
this should be done, but there are some things pending that I like to
see merged first mainline (subclass support and sysfs integration)
before I look at it again. Check the mailing list archive for comments
about that.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
