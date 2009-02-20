Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH]Generic Netlink Interface
From: Marcel Holtmann <marcel@holtmann.org>
To: alok barsode <alokbarsode@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <8b5debfa0902200602o58dfe669g2c4ef600460ef480@mail.gmail.com>
References: <8b5debfa0902200602o58dfe669g2c4ef600460ef480@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 20 Feb 2009 21:07:49 +0100
Message-Id: <1235160469.24255.11.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

> As per our last discussion, i am attaching a patch for the generic
> netlink interface.
> I am also attaching a test program (can be compiled with -lnl ) to
> test the interface.
> 
> I am using "flags" to bring up the device and returning "changed",
> which indicate the changed bits in the flags.
> right now the module only supports 'up', 'iscan' and 'pscan'.
> so i can issue a NEWHOST command with HCI_UP | HCI_PSCAN | HCI_ISCAN.
> I am not sure if this is the right approach.
> OR Do you want individual commands for operations ?

the first thing that we have to change the try_lock() change. We can't
do that. It has way to many implications on the code. So why do you
really need the try_lock() in this case. And if, then don't change
current locking code. Just create a new define for the the try_lock()
case.

I am thinking about not exposing the ->flags directly and just creating
a new one for the netlink interface. For example for PSCAN and ISCAN I
like to have clear primitives that say connectable, discoverable etc.

We did a lot of changes in the D-Bus API for 4.x during the last month
and the best way would be if the netlink API reflects these changes in a
more closer way. So it might be better to just have primitives that map
1:1 the properties powered, connectable, discoverable etc.

We could actually just have PROPERTY primitive and then turn the
properties into parameters. Netlink should be fine with listing multiple
parameters in the same message.

What do you think?

Regards

Marcel


