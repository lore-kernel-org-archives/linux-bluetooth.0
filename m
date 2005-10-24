Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [D-BUS PATCH] Authentication
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
References: <e1effdeb0510201045w5ebf17afh87897564184ce9f9@mail.gmail.com>
	 <1129986496.11428.36.camel@blade>
	 <e1effdeb0510240606l1998f61dhc2fe813c48b1e6db@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130159970.19317.28.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 24 Oct 2005 15:19:30 +0200

Hi Claudio,

> I will send a cleanup patch before send the authentication
> improvements patch.
> Regarding the variable name, It should be better change to "dd"
> instead of 
> sock or sk. If you see the hcitool code standard you will notice
> that. 

I am fine with dd. My point was to be consistent.

> I noticed that there is a HCI raw socket created in the main.c file
> that belongs to hcid structure.
> Can I use it in the functions handle_display_conn_req and
> handle_get_devices_req instead of create 
> a new one?

Open a new one, because the HCI filter is per descriptor and you don't
wanna mess with the filter of the HCI socket in main.c.

> I will try apply you other suggestions.

Cool.

> Another point is the reply method for authentication. We need discuss
> how we should design it.
> I am not a hcid expert therefore I would like ask you how we should
> implement the authentication stuff.
> 
> Currently, the METHOD REPLY of the authentication doesn't consider the
> authentication complete event.
> In order to check it and reply after the authentication finishes it is
> required store some D-Bus message
> attributes(sender, serial, destination, ...). Another approach is send
> a SIGNAL. Which approach do you prefer
> send send a peer message(method reply) or a signal?

In generell everything authentication or encryption related should be
done inside the kernel. However the infrastructure is not there yet and
so keep it as simple as possible.

> Regarding the pin helper. Are you planning support the "normal" helper
> and the dbus helper? I am asking 
> this because the call_pin_helper function is blocking. If you are
> planning support both, we have to try add
> the pin helper file descriptor inside the hcid main loop.

My plan is to require D-Bus for bluez-utils, but so far I haven't
received any comments on it. The main problem is that the distributions
must move to a decent version of D-Bus and Debian unstable is still on
D-Bus 0.23. Actually any D-Bus 0.3x will not work very good and so we
might need to support the "normal" PIN helper for some time. I am open
for changes, because the PIN helper code in generell is not that good.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
