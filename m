Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 1 Jun 2011 16:11:37 -0400
Message-ID: <BANLkTimHFKLR2OagEY0CL2_i6=3WcVX3Fw@mail.gmail.com>
Subject: Summary of current and planned implementation of GATT APIs (was: Re:
 [RFC] New API for attribute read/write callback registration)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jaikumar Ganesh <jaikumarg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaikumar,

On Wed, Jun 1, 2011 at 2:11 PM, Jaikumar Ganesh <jaikumarg@gmail.com> wrote:
> Are there any plans to add DBus APIs to allow finer grained read and
> writes of attributes ?
> For example when the application needs more control like reliable
> writes, writes with response,
> writes of long values.

This question is more broad and unrelated to read/write callbacks on
the attribute server (the purpose of this RFC), but I'll try to
explain in summary the current approach (both what is already
implemented and what is planned), regarding D-Bus APIs.

GATT profiles should be implemented as BlueZ plugins (in C), and use
the GATT C API for interacting with the core bluez. This GATT API (see
 attrib/gatt_lib.h) implements all important GATT operations. GATT
operations are implemented on top of ATT protocol (see attrib/att.h
for the various ATT encode/decode functions), which are (ideally) not
meant to be used inside profile implementations. If you look at
existing draft GATT profiles from bluetooth.org, they are always
described in terms of GATT, and not the "low level" ATT protocol. We
follow this same approach on BlueZ code.

Regarding D-Bus, there are two ways to interact with a remote GATT
server: using the (already upstream) "generic" Attribute API (see
doc/attribute-api.txt) and through profile specific APIs. For the
latter, we already have a D-Bus API proposal (and initial code) for
Proximity, which we cannot openly discuss yet because the profile is
not approved by BT-SIG. We can, of course, send the API document on
demand to those interested who have access to the draft specifications
from bluetooth.org (the code makes no sense without access to the
draft specs, anyway).

We could have just the generic API, but given that each GATT profile
has very specific behavior and use cases, and to better align to the
BlueZ architecture of "one-API-per-profile", it is more appropriate to
design APIs for each GATT profile. The generic GATT client D-Bus API
is then restricted to interact with servers which are either not
implemented yet or proprietary, or which are too simple to require a
whole API.

That said, the generic API is already upstream, but it is currently
very simple. Suggestions/code are welcome to help improving it (e.g.
better handling of descriptors, more GATT operations besides
discovery/read/write etc.)

> Also whats the callback mechanism where the write fails because of
> errors like lack of permissions,
> we need to inform the application (using the attribute apis to
> implement a GATT client ) of the actual
> error.

Note that the API discussed on the RFC e-mail is for the server side
(i.e. where attributes are locally stored). For client side everything
is done through D-Bus, using either the generic or per-profile API.

Hope that helps clarifying the current & planned implementation.
Please keep questions/ideas coming! :)

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
