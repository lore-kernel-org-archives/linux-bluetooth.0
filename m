Return-Path: <cyrus@holtmann.org>
Subject: Re: add dbus api to set class of device?
From: Marcel Holtmann <marcel@holtmann.org>
To: Tim Renouf <tpraplix.vger@botech.co.uk>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100728153323.GA9410@aplixcorp.com>
References: <20100728153323.GA9410@aplixcorp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Jul 2010 09:45:58 -0700
Message-ID: <1280335558.2621.97.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

> I am putting a JSR82 implementation on an Android device that uses
> BlueZ, accessing BlueZ via the dbus api.
> 
> JSR82 has an API where you can set service class bits for a particular
> service you have registered. So the JSR82 implementation needs to be
> able to set the class of device in some way. I would like to add a dbus
> method to do this, and I'd like to know the opinion of BlueZ developers
> on this:

I did mention before that JSR82 is the most stupid Bluetooth API that I
have seen so far, didn't I? Personally I wouldn't even bother with JSR82
and give up right away. It is really a pointless API.

In BlueZ the services bits of the class of device settings are modified
dynamically based on the registered SDP service records. So you don't
have to do anything. Just register the right SDP service record with the
proper UUID and it will take care of this automatically.

Regards

Marcel


