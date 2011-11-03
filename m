Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Brian Gix <bgix@codeaurora.org>,
	Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Ajay Pillai <Ajay.Pillai@csr.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Date: Thu, 3 Nov 2011 09:37:38 +0100
Subject: RE: Designing a GATT write D-Bus API (was: Re: GATT Dbus API on
 BlueZ - attirbute-api.txt modifications)
Message-ID: <7769C83744F2C34A841232EF77AEA20C01DCC8DB06@dnce01.ent.ti.com>
References: <CAJdJm_NUjsuytSrKzQ=vsSp7oyPdogxSww+r15dX9Mv==TaRNQ@mail.gmail.com>
 <4EB1B1D6.9060806@codeaurora.org>
In-Reply-To: <4EB1B1D6.9060806@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Brian, Anderson, Ajay

> -----Original Message-----
> From: Brian Gix [mailto:bgix@codeaurora.org]
> Sent: Wednesday, November 02, 2011 11:11 PM
> To: Anderson Lizardo
> Cc: Ajay Pillai; Ganir, Chen; Luiz Augusto von Dentz; Mat Martineau;
> Claudio Takahasi; linux-bluetooth@vger.kernel.org; ingas@codeaurora.org
> Subject: Re: Designing a GATT write D-Bus API (was: Re: GATT Dbus API
> on BlueZ - attirbute-api.txt modifications)
> 
> Hi Anderson, Ajay, Chen, Luiz etc etc etc
> 
> On 10/31/2011 7:10 AM, Anderson Lizardo wrote:
> > Hi Ajay,
> >
> > Thanks for bringing these specific items. I took the liberty of
> > changing the subject so it goes in a separate, less generic thread.
> >
> > On Mon, Oct 31, 2011 at 9:35 AM, Ajay Pillai<Ajay.Pillai@csr.com>
> wrote:
> >> Can we detail out the "write" API design once again, please? There
> has been too much discussion and hence I am not sure, which way it is
> going.
> >>
> >> There are two main aspects to write"
> >>
> >> 1) The write mechanism -
> >>         a) Do we do a setproperty() or do we add a new API
> writeValue()?
> >
> > Currently implemented (just verified): SetProperty() on the "Value"
> > property issues a GATT Write Command. Connection establishment is
> > attempted if not up yet, but no completion signal seems to be sent.
> >
> > If we were to have a ReadValue() with specific semantics, we could
> > have WriteValue() with similar semantics (but for writing), at least
> > for consistency.
> 
> I guess I have no *hard* objection to having a caching mechanism for
> Characteristic values, as long as we leave the Apps on the other side
> of
> the D-Bus interface with the capability to specifically send Reads and
> Writes (all methods of both) on LE interfaces.  If those Reads and
> Writes end up refreshing a cache, and result in the generation Property
> Changed signals, that is fine. It is just very important that we do not
> block access to the GATT primitives.
> 
> My understanding is that both Apple and Microsoft appear to be heading
> down the route where their exposed interfaces include some sort of
> direct access to all of these GATT primitives, and while this is not a
> conversation about them, I definitely don't want to be in a position of
> offering less flexibility. That is the main reason I support Chen's
> proposed WriteValue and ReadValue API's.
> 
I agree with this one. Allowing a smaller set of possibilities is bad for us.



> As an aside, I have broached the subject of value caching in general
> with Brian Redding, who is our BT Sig Core representative. I have
> suggested adding a bit or two to the Extended Properties mask, to
> specificly allow a server to indicate whether a particular
> characteristic should ever be cached, and perhaps whether it could be
> considered so persistent as to never change without a Service Change
> Notification. As with most features like this, it would have to wait
> for
> a Core Spec revision, with a 9 month or longer lead time.
> 
> >
> >>         b) Is the method blocking or non-blocking?
> >
> > SetProperty() is non-blocking, and I think it is not appropriate to
> > block it (for compatibility with applications which use
> > SetProperty()).
> >
> > Even for a WriteValue(), I strongly suggest going with a non-blocking
> > implementation, maybe with some completion signal or callback.
> >
> >>         c) If non-blocking,what is the mechanism like?
> >> My understanding - if the write is called while the connection is
> not active, then the value is going to be buffered in BlueZ while BlueZ
> tries to get the connection up. When the connection comes up, after the
> write operation is complete, BlueZ will emit a signal indicating that
> it is written.
> >
> > This is how the current non-bloncking SetProperty() method works
> > (aside from the missing completion signal).
> >
> > For a WriteValue(), a similar approach could be taken.
> >
> >> 2) The choice of write operation - Does it lie within BlueZ or is it
> given to DBUS Apps. I guess Anderson is okay with giving some control
> to the DBUS App.
> >
> > Then you mean Chen, as I'm with the "no full control to applications
> > by default" idea :)
> >
Since ReadValue and WriteValue should be non-blocking, as far as I understand from what has been discussed so far. This means that we need to notify the D-BUS clients of write or read results.
One option is to use D-BUS events, but I would rather not use those, since it is broadcasted on the bus for everyone, and we already have registered watchers for this purpose.
The other option is to use the currently registered watchers, and use the ValueChanged message, which contains the path and value, both for read (if the read value is different from the cached one) and for write command (always sent after the write command) and write request (called only when the write response is received, with status success). However, I do see some problems with this convention :
1. If read returns with the same value, and the watcher is not called, the D-BUS client has no idea whether the value was read or not. 
2. On write command, we have no idea if the server has updated the value or not. We can not call the ValueChanged in this case for sure. 
3. Current implementation sends the property changed event on "Connected" from the device, once the ACL is up and running. However, this may not indicate that the connection is ready for data, as we have SMP in progress. We need to find a better way to let the user know that the connection is really up, or fix the SMP issue and queue up requests when SMP is in progress.

I would suggest the following for solving this :
1. The user MUST register a watcher for the service, if he wants to be notified of read/write results.
2. Add ValueWritten and ValueRead messages to the watcher interface, to allow better reporting of read/write procedures.
3. Read and Write commends sent to an offline client should not result in automatic reconnection procedure. A client must implement timeouts to figure out if a server will be available for write/read commands or not, and manage it's states accordingly. Something needs to be changed here somehow - I'm not so comfortable with the existing implementation.In addition, we got for the buffering/caching of the written value in bluez, while the connection is offline. What happens if a client writes a new value to the offline server? This will trigger a connection procedure, which may take anywhere from 1 second to infinity. What happens if in this gap, the d-bus client requests the properties? What should the value be ? The old one or the new one?

What do you guys think ?


> >>         a) write without response, write with response, signed write
> without response -
> >> I believe the DBUS App must be allowed to indicate its preference
> among these to BlueZ. BlueZ must be able to meet this preference in
> most of the cases, but in cases where it cannot, BlueZ must throw an
> error. It would in most cases be a wrong request from App (using signed
> write on a long characteristic, for instance)
> >
> > In this case, you are basically suggesting delegating characteristic
> > property and security level checks to each application and a more
> > extensive D-Bus API (like Chen's proposal). My only concern on this
> is
> > the "complex API by default" policy, instead of extending as
> > necessary. But I have no strong opinions on this (and it for sure
> does
> > not affect cross-application operation).
> >
> >>         b) Write long characteristics value
> >> This, I believe, is a value add to Apps, if done autonomously within
> BlueZ.
> >
> > I agree. And would be consistent with the (already implemented) Read
> > Long Characteristic Value.
> >
> >>         c) reliable write of one characteristic
> >> Not covered in this discussion so far. But worth having a separate
> API like writeReliable(offset, value, {"prepare","execute"})?
> >>         d) reliable write used for atomic write of multiple
> characteristics
> >> Not covered in this discussion so far. Same API as above. But an
> "execute" operation on any char object will do complete the reliable
> write operation.
> >
> > I still have not suggestion regarding the Reliable Write API. I would
> > be happy to discuss on some API proposal specific to it.
> >
> >> Regarding reliable writes, we will need to figure out a state
> machine within BlueZ that blocks out other operations on a remote
> server during a prepare-execute cycle and also an exit criteria from
> that "block-other-operations" state to cater to Aps that disappear
> after doing a "prepare".
> >
> > Yes, and that requires more D-Bus API design experience than what I
> > currently have :). If anyone wants to try this, this API can be sent
> > later as extension.
> >
> > Regards,
> 
> 
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

Regards,
Chen Ganir
