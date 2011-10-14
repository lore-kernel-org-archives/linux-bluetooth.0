Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
References: <AcyCnA5DqBiEIGAzQEqnbRbpdBNd8AAAHtNw>
	<F82830D409D80E4881C83250E051B74B4784BE4F@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 14 Oct 2011 09:13:42 -0400
Message-ID: <CAJdJm_O5Bf22=iJZqpJ9SgOCQ-MSxv7WPdwXYXko-mcyiTx=3Q@mail.gmail.com>
Subject: Re: Proposal for GATT Client Dbus API.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vijaykumar Dadmode <Vijaykumar.Dadmode@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vijay,

First of all: can you provide your changes as a diff against the
current doc/attribute-api.txt ? It is not clear you are proposing a
whole new API, or extending the current one in that document.

Note you are also free to change doc/attribute-api.txt, as that API is
not stable yet.

On Tue, Oct 4, 2011 at 9:59 AM, Vijaykumar Dadmode
<Vijaykumar.Dadmode@csr.com> wrote:
> This post contains a proposal for the DBUS GATT API(Gatt CLIENT) that enhances the existing GATT
> functionality provided by DBUS APIs interface. Which include Methods,Signals and Properties.
> Could you please provide your comments and feedback for the same? Or we need more APIs to cover all GATT Client functionality?

You are free to propose a "full" API, but implement it by pieces (as
need arises). These API docs can evolve as long as we keep them
"unstable".

> . RegisterCharacteristicsWatcher can be used to monitor specific Characteristic change.

AFAIK, only the Characteristic Value is allowed to change, and we can
monitor its changes by enabling Notification or Indication. As Claudio
mentioned, we currently have a RegisterCharacteristicsWatcher() method
which is useful for monitoring:

* Characteristic Value changes
* New characteristics (actually not implemented, as we would need
client side support for Service Changed).

All other Characteristic components (properties and descriptors) are
not supposed to change on server side (as far as I know), given they
are part of each profile definition.

> . PropertyChanged Signal for the SetProperty().

If any property is supposed to change, will this PropertyChanged
signal be emitted at all?

> . ServiceChanged and CharacteristicChanged Signal for Service or Characteristic changes on the server.

I think a "ServiceChanged" signal does not make sense under the
characteristic object path. Why not abstract it and instead emit
signals for each characteristic which is mentioned on the "Service
Changed" characteristic of GATT service?

CharacteristicChanged is redundant if you have a
"RegisterCharacteristicsWatcher" which registers a callback when some
characteristic value changes.

> Properties:
>                         uint8 Property [readonly]
>                                     The characteristic property, format defined by GATT spec.

what about "Properties" (plural)?

>
>                         uint16 Configuration [readonly]
>                                     Optional field containing the configuration value on the server.

what about "ClientConfiguration" ? (remember there is Server
Characteristic Configuration as well)

>
>                         uint16 Extended [readonly]
>                                     The characteristic descriptor describing
>                                     the additional Characteristic Properties.

What about "ExtendedProperties"?

One idea (but I want feedback from other BlueZ developers) is to merge
"Properties" and "ExtendedProperties" and instead have an array of
strings representing each bit field, e.g.:

{ "Read", "Write", "Notify", "Reliable Write" }

>
>                         uint16 Aggregate [readonly]
>                                     Optional Characteristic descriptor which defines the
>                                              format of an aggregated Characteristic Value.

Actually the "Aggregate Format" descriptor is a list of handles. But
how can this be useful for a D-Bus client if it does not know about
handles at all?

My suggestion is to modify the current Format property defined in
doc/attribute-api.txt and have it as an array of struct, where each
struct is a Format. If there is no aggregate descriptor and only a
single presentation format descriptor, it will contain only a single
entry (i.e. array with size one). If there is no Presentation format
at all, it will be an empty array.

>
>                         uint16 Custom [readonly]
>                                                Optional Characteristic descriptor which defines profile defined descriptor UUID's.

I see a couple of issues with this property:

* There can be more than one "custom" descriptor.
* The descriptor value can have any size.
* And more important:

"Characteristic descriptor declaration permissions are defined by a higher layer
profile or are implementation specific. A client shall not assume all
characteris-
tic descriptor declarations are readable."

In summary, for custom/unknown descriptors, It makes more sense to
have a Method to read/write to them when needed by the client.

My suggestion is something like:

void           WriteDescriptor(uint16 handle, array{byte} value)
array{byte}  ReadDescriptor(uint16 handle)

And then a property which contains a dict (mapping handle -> uuid) for
*all* descriptors (of course the properties for known descriptors
would still exist, but this generic read/write API would be used for
them as well):

dict Descriptors [readonly]

It should then be noted by the docs that the attribute handle is only
valid during the session, and should not be stored/cached by the
client.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
