Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Alignment issue
From: Marcel Holtmann <marcel@holtmann.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092384465.4186.37.camel@imladris.demon.co.uk>
References: <001201c47fc2$7093e4a0$1301010a@baked>
	 <1092252699.4564.238.camel@pegasus>
	 <1092299689.4622.8.camel@imladris.demon.co.uk>
	 <1092302834.28711.72.camel@pegasus>
	 <1092304890.15466.44.camel@hades.cambridge.redhat.com>
	 <1092306154.28711.85.camel@pegasus>
	 <1092306935.15466.74.camel@hades.cambridge.redhat.com>
	 <1092308407.28711.99.camel@pegasus>
	 <1092310391.15466.178.camel@hades.cambridge.redhat.com>
	 <1092311388.28711.117.camel@pegasus>
	 <1092312127.15466.211.camel@hades.cambridge.redhat.com>
	 <1092317787.28711.150.camel@pegasus>
	 <1092384465.4186.37.camel@imladris.demon.co.uk>
Content-Type: text/plain
Message-Id: <1092387952.28711.217.camel@pegasus>
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
Date: Fri, 13 Aug 2004 11:05:52 +0200

Hi David,

> > I looked at the patches from the bluez-utils source RPM and actually I
> > can include optional PIE support for you. A simple patch for that is
> > easy and actually I already did that. From what I saw, this is a GCC 3.4
> > only feature and you give -pie at linking time and not at compile time
> > of the sources itself. Is this correct? 
> 
> You also need -fpic in CFLAGS, I believe.

if this is true, then this makes your patch useless. However after doing
some research in this area it seems that I must use -fPIE and then link
with -pie. This actually only works for programs, because libtool don't
uses these extra flags.

Check out the CVS. The patch for that is already included.

> > What is the best way to detect PIE support in the compiler?
> 
> I hate myself for saying it, but possibly just test whether you can
> actually build an executable that way?

I did it this way, but there were reports of Sparc platforms where the
resulting binary should be run-tested.

> > And please don't do this
> > 
> >         # Authentication and Encryption
> > -       #auth enable;
> > -       #encrypt enable;
> > +       auth enable;
> > +       encrypt enable;
> > 
> > in the bluez-utils-2.3-conf.patch. If you do that then you are going to
> > set your local device in security mode 3 and this is not what you want.
> 
> Hmmm, OK.... /me refers to Google and then
> http://www.niksula.cs.hut.fi/~jiitv/bluesec.html

This is a nice page, I know, but it is too theoretical ;)

> Don't I want that? If I were to leave it out, would that leave it in
> mode 1, and mean I wouldn't be required to exchange a PIN with _every_
> device before I can communicate with it at all?

The point here is that setting "auth enable" sets the device into
security mode 3. It is the same with "hciconfig hci0 auth". And you
can't have encryption without authentication and so leave this both
disabled.

Even if the Bluetooth specification talks about three security modes, we
can only differ between mode 3 and mode 1/2 on the device level. This
means that we are in security mode 1 or in mode 2 if you don't set this
options.

The difference between mode 1 and 2 are that in security mode 1 or
device will never initiate the security mechanism, but it will respond
to it if the other device asks. For example a mobile phone.

In security mode 2 the mechanism will be triggerd before the service is
usable. In general these are done by the daemons that implement the
profile. Look at pand and dund for example. This is why it is called
service level security.

The reason behind security mode 1/2 and mode 3 are that in mode 1 and 2
you can request SDP information without authentication, but in security
mode 3 the authentication is enforced right after the link creation on
the HCI level and you must even authenticate for SDP information.

And some device don't really like connections from hosts with security
mode 3. It will work in some way, but it causes more troubles than it is
good for.

> The gnome-bluetooth program has been known to register its OBEX file
> receive service and then just dump stuff into the user's home directory
> -- even files with names like .rhosts :) If I make the requested change,
> would that mean that _anyone_ can exploit this, rather than only devices
> with which we're already paired?

If this is possible, then this is a misdesign in the program. You can't
rely on the Bluetooth security mechanism for everything. Look at the
reports about hacking into a mobile phone. I wrote one of that papers ;)

> Or am I getting confused? Can we do security mode 2?

You can enforce authentication with the correct option to dund and pand
for example. Otherwise we go with security mode 1, but this does not
mean that we never have to authenticate.

> I have a _vague_ recollection that there were devices I couldn't
> communicate with unless I enabled those -- but it was a long time ago
> and perhaps it was just that I thought authentication and encryption
> sounded like good things so I should probably enable them :)

You will be always able to communicate to all devices if you are in
security mode 1/2, but there are some that expect something and you
don't get any feedback. The best example is the Apple keyboard. If
connect to it the first time it expects that you input a PIN on the
numeric keys. If you don't do this in time the connectio is terminated
and you don't see why. Even hcidump don't gives you any clues. You must
know how these devices work. The stupid thing behind this is that Apple
uses security mode 3 for the mouse and the keyboard. And how would you
input a PIN with a mouse. The only other security mode 3 device is the
old Nokia 6210 and that is it. Every other device I have seen so far is
using service based security.

And I never checked this, but I think the CSR based mice don't have a
default PIN or something like that and so you won't be able to connect
these devices (every mice except the Apple one) to a host in security
mode 3. Investigate this before your think about enabling this again.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
