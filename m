Return-Path: <cyrus@holtmann.org>
Subject: Re: add dbus api to set class of device?
From: Marcel Holtmann <marcel@holtmann.org>
To: Tim Renouf <tpraplix.vger@botech.co.uk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100728165904.GA9840@aplixcorp.com>
References: <20100728153323.GA9410@aplixcorp.com>
	 <1280335558.2621.97.camel@localhost.localdomain>
	 <20100728165904.GA9840@aplixcorp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 10:40:12 -0700
Message-ID: <1280338812.2621.102.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> > I did mention before that JSR82 is the most stupid Bluetooth API that I
> > have seen so far, didn't I? Personally I wouldn't even bother with JSR82
> > and give up right away. It is really a pointless API.
> 
> Unfortunately I have to bother with it as our customers are device
> manufacturers who are willing to pay for MIDP with JSR82 support. :-(
> 
> > In BlueZ the services bits of the class of device settings are modified
> > dynamically based on the registered SDP service records. So you don't
> > have to do anything. Just register the right SDP service record with the
> > proper UUID and it will take care of this automatically.
> 
> Yes, I saw that in update_adapter_svclass_list. I guess the problem is
> that JSR82 lets an app decide to set the "wrong" bit, and the
> conformance tests test that functionality.

fake the conformance test with just adding and removing the right SDP
records ;)

As I said, JSR82 is the most stupid API I have ever seen. It seems these
guys had no clue about Bluetooth when specifying it. And this is besides
that fact that every application has to implement SDP parsing by itself.

> So if I did a patch along the lines I was suggesting, and submitted it
> here, would it be rejected on the grounds that it is not needed for any
> "sensible" functionality ?

I think you just answered this by yourself. I makes no sense to add such
an API since it has the exact problems that you mentioned earlier. Once
you have two applications this gets messy. And it will not work properly
at all. So for us such an extra API will introduce problems instead of
solving anything.

Regards

Marcel


