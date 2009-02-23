Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1235160469.24255.11.camel@californication>
References: <8b5debfa0902200602o58dfe669g2c4ef600460ef480@mail.gmail.com>
	 <1235160469.24255.11.camel@californication>
Date: Mon, 23 Feb 2009 19:10:01 +0530
Message-ID: <8b5debfa0902230540n4573363dtee4f3e9fbca64fe0@mail.gmail.com>
Subject: Re: [PATCH]Generic Netlink Interface
From: alok barsode <alokbarsode@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Feb 21, 2009 at 1:37 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alok,
>
>> As per our last discussion, i am attaching a patch for the generic
>> netlink interface.
>> I am also attaching a test program (can be compiled with -lnl ) to
>> test the interface.
>>
>> I am using "flags" to bring up the device and returning "changed",
>> which indicate the changed bits in the flags.
>> right now the module only supports 'up', 'iscan' and 'pscan'.
>> so i can issue a NEWHOST command with HCI_UP | HCI_PSCAN | HCI_ISCAN.
>> I am not sure if this is the right approach.
>> OR Do you want individual commands for operations ?
>
> the first thing that we have to change the try_lock() change. We can't
> do that. It has way to many implications on the code. So why do you
> really need the try_lock() in this case. And if, then don't change
> current locking code. Just create a new define for the the try_lock()
> case.

I was using try_lock to safeguard the code from being re-entrant.
will create a new define in netlink.c.

>
> I am thinking about not exposing the ->flags directly and just creating
> a new one for the netlink interface. For example for PSCAN and ISCAN I
> like to have clear primitives that say connectable, discoverable etc.
>
> We did a lot of changes in the D-Bus API for 4.x during the last month
> and the best way would be if the netlink API reflects these changes in a
> more closer way. So it might be better to just have primitives that map
> 1:1 the properties powered, connectable, discoverable etc.

sounds good.

>
> We could actually just have PROPERTY primitive and then turn the
> properties into parameters. Netlink should be fine with listing multiple
> parameters in the same message.

PROPERTY can be a nested primitive which holds the parameter <name:
value> pair.
so NEWHOST takes a list of parameter name:value pairs.

did I understand you correctly?

Cheers,
Alok.
