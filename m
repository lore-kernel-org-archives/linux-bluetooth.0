Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 9 Jun 2011 07:00:10 -0400
Message-ID: <BANLkTikwhgD37HzK4v4NRWFUySf8HRoU7w@mail.gmail.com>
Subject: D-Bus GATT API for external/proprietary profiles
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have noticed this topic appearing lately on IRC and the mailing
list, and on private discussions I got with a couple of people.

There seems to have quite some interest in allowing an external
application to talk with BlueZ, and use only its GATT & GAP stack to
talk to the device, implementing all the upper level (profile) logic
on its own. These people are supposing that the "generic" Attribute
API (documented on doc/attribute-api.txt) is intended for that.

I would like to clarify that this has _never_ been the intention of
this API, as far as I remember. It was designed/implemented at a time
when all we knew about LE and GATT was from the Core 4.0 spec drafts
(at least myself didn't closely monitor draft GATT profile draft specs
as I do now). It was meant to be used for simple devices, which may
send information through notifications/indications or have
characteristics whose values are readable/writable (and some standard
descriptors). For these, the Attribute API (along with its Watcher
mechanism) could be used to implement some simple "profile".

To be able to implement a full GATT profile externally (client role),
we would need to expose the full GATT (or even ATT) stack over D-Bus.
For instance, have methods for each GATT operation, and signals for
notifications/indications.

Is that really what we want? If yes, the Attribute API could have to
be severely redesigned. It was not (and currently still not is)
intended for that.

This may bring some issues/questions:

* if an external application issues GATT/ATT operations along with a
BlueZ implemented profile, could it interfere with or corrupt BlueZ
internal state?
* How to implement server roles? It would need a mechanism to register
attributes externally, and handle notifications/indications.

Comments, specially from BlueZ maintainers (Johan, Marcel?) are very welcome.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
