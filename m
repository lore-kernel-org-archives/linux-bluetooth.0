Return-Path: <cyrus@holtmann.org>
Message-ID: <1358757002.7854.27.camel@pflykt-mobl1>
Subject: Object manager properties on Network1 Connect method call reply
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 21 Jan 2013 10:30:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


	Hi,

While implementing ConnMan Bluez 5 plugin using GDBusProxy from ./gdbus
I noticed the following things.

On org.bluez.Network1.Connect method call return the object properties
'Connected', 'Interface' and 'UUID' have not yet been updated. It is of
course obvious that if no error occurs, the network is connected. And
the interface is provided as an argument to the method call return
function so that's fine as well.

If the method call signals an error, then the network is of course not
connected. Except if the error is 'AlreadyConnected', which means it is.
Since it is not possible to send arguments in an error reply, the only
way to figure out the interface is via the 'Interface' GDBusProxy
property. 'Connected' and 'UUID' properties are also set properly in
this case.

>From the above it would be more consistent if the properties were
already set to their intended values when the Connect method call
returns independent of success or failure. Thus one set of logic would
suffice on ConnMan side to handle both cases.

Maybe the org.bluez.Network1 object properties could be updated only for
the Network1 object in question before sending the method call return?
Of course the devil may be in the details of the Bluez 5 API why the
object property update should not or can not be done this way.

Just my €0.02 on this.

Cheers,

	Patrik


