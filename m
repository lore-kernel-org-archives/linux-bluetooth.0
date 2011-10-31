Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 31 Oct 2011 10:10:26 -0400
Message-ID: <CAJdJm_NUjsuytSrKzQ=vsSp7oyPdogxSww+r15dX9Mv==TaRNQ@mail.gmail.com>
Subject: Designing a GATT write D-Bus API (was: Re: GATT Dbus API on BlueZ -
 attirbute-api.txt modifications)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: "Ganir, Chen" <chen.ganir@ti.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

Thanks for bringing these specific items. I took the liberty of
changing the subject so it goes in a separate, less generic thread.

On Mon, Oct 31, 2011 at 9:35 AM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
> Can we detail out the "write" API design once again, please? There has been too much discussion and hence I am not sure, which way it is going.
>
> There are two main aspects to write"
>
> 1) The write mechanism -
>        a) Do we do a setproperty() or do we add a new API writeValue()?

Currently implemented (just verified): SetProperty() on the "Value"
property issues a GATT Write Command. Connection establishment is
attempted if not up yet, but no completion signal seems to be sent.

If we were to have a ReadValue() with specific semantics, we could
have WriteValue() with similar semantics (but for writing), at least
for consistency.

>        b) Is the method blocking or non-blocking?

SetProperty() is non-blocking, and I think it is not appropriate to
block it (for compatibility with applications which use
SetProperty()).

Even for a WriteValue(), I strongly suggest going with a non-blocking
implementation, maybe with some completion signal or callback.

>        c) If non-blocking,what is the mechanism like?
> My understanding - if the write is called while the connection is not active, then the value is going to be buffered in BlueZ while BlueZ tries to get the connection up. When the connection comes up, after the write operation is complete, BlueZ will emit a signal indicating that it is written.

This is how the current non-bloncking SetProperty() method works
(aside from the missing completion signal).

For a WriteValue(), a similar approach could be taken.

> 2) The choice of write operation - Does it lie within BlueZ or is it given to DBUS Apps. I guess Anderson is okay with giving some control to the DBUS App.

Then you mean Chen, as I'm with the "no full control to applications
by default" idea :)

>        a) write without response, write with response, signed write without response -
> I believe the DBUS App must be allowed to indicate its preference among these to BlueZ. BlueZ must be able to meet this preference in most of the cases, but in cases where it cannot, BlueZ must throw an error. It would in most cases be a wrong request from App (using signed write on a long characteristic, for instance)

In this case, you are basically suggesting delegating characteristic
property and security level checks to each application and a more
extensive D-Bus API (like Chen's proposal). My only concern on this is
the "complex API by default" policy, instead of extending as
necessary. But I have no strong opinions on this (and it for sure does
not affect cross-application operation).

>        b) Write long characteristics value
> This, I believe, is a value add to Apps, if done autonomously within BlueZ.

I agree. And would be consistent with the (already implemented) Read
Long Characteristic Value.

>        c) reliable write of one characteristic
> Not covered in this discussion so far. But worth having a separate API like writeReliable(offset, value, {"prepare","execute"})?
>        d) reliable write used for atomic write of multiple characteristics
> Not covered in this discussion so far. Same API as above. But an "execute" operation on any char object will do complete the reliable write operation.

I still have not suggestion regarding the Reliable Write API. I would
be happy to discuss on some API proposal specific to it.

> Regarding reliable writes, we will need to figure out a state machine within BlueZ that blocks out other operations on a remote server during a prepare-execute cycle and also an exit criteria from that "block-other-operations" state to cater to Aps that disappear after doing a "prepare".

Yes, and that requires more D-Bus API design experience than what I
currently have :). If anyone wants to try this, this API can be sent
later as extension.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
