Return-Path: <cyrus@holtmann.org>
Subject: Re: Phonebook functions for BlueZ
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Felix Huber <felix.huber@schyf.de>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100309033841.GA21210@jh-x301>
References: <4B8A3EEA.3030901@schyf.de> <20100301192050.GA25876@jh-x301>
	 <1267982102.7714.87.camel@rb-l1.nos.office>
	 <20100309033841.GA21210@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 21:27:21 -0800
Message-ID: <1268112441.3712.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > > +	if (g_str_equal(property, "direction")) {
> > > > +		dbus_message_iter_get_basic(&sub, &direction);
> > > > +	} else if (g_str_equal(property, "peer")) {
> > > > +		dbus_message_iter_get_basic(&sub, &peer);
> > > > +		vc->number = g_strdup(peer);
> > > > +	} else if (g_str_equal(property, "reason")) {
> > > > +		dbus_message_iter_get_basic(&sub, &reason);
> > > > +	} else if (g_str_equal(property, "auxstatus")) {
> > > > +		dbus_message_iter_get_basic(&sub, &auxstatus);
> > > > +	} else if (g_str_equal(property, "line")) {
> > > > +		dbus_message_iter_get_basic(&sub, &line);
> > > > +	}
> > > 
> > > No braces for one-line scopes.
> > Well, here we have a conflict: The kernel style guide says that if one
> > of the blocks has braces the other one should also have, even if it is a
> > single line.
> 
> Yesh, I noticed the same thing when checking the kernel coding style
> guidelines. Most of BlueZ code is in conflict with the kernel coding
> style in this respect, so I think we'd need some comment from Marcel on
> what exactly he wants the BlueZ style to be (might be that I've already
> discussed this a long time ago with him but I can't remember the outcome
> right now).

there is not real rule here that can be followed and will be true in all
cases. As long as the code is easy to read and understand it is fine. It
goes more like this: If the else statement is by itself then don't
bother with braces around it. Even if the if needs braces. If you have
multiple else if then the braces are actually a good idea. I would
almost go that far for complex ones like the one above using braces
would make it less error prone if you change something later. Even if
the compiler actually does warn you these days.

Use your own personal judgment here. However if the reviewing the code
make my brain hurt, then you did it wrong ;)

Regards

Marcel


