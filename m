Return-Path: <cyrus@holtmann.org>
Subject: Re: Name resolution for mgmt interface
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Antti Julku <antti.julku@nokia.com>,
	linux-bluetooth@vger.kernel.org
Date: Sat, 10 Sep 2011 08:23:33 +0200
In-Reply-To: <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
References: <4E6A247C.5040403@nokia.com>
	 <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315635815.1937.4.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> > Name resolution of older devices not supporting EIR is still missing from
> > the management interface. I discussed with Johan, and he suggested the
> > following architecture (if I understood correctly):
> >
> > New command and event are added to mgmt interface:
> >  * Unknown Names Event
> >  * Resolve Names Command
> >
> > When device discovery is completed, kernel sends list of BT addresses of
> > devices which names are unknown (no name in EIR data) with Unknown Names
> > Event.
> 
> Does it worth to parse the EIR data twice(kernel and userspace)?
> 
> My suggestion is to remove the Unknown Names Event and add the Resolve
> Names Command only.
> 
> No matter the decision, we need to evaluate how to map the discovering
> session properly, I mean how to sync kernel and userspace events and
> signals. One think that it is not clear to me: does name resolution
> belongs to discovery procedure? I am not talking about the SPEC, it is
> more how we define the concept in BlueZ. Should bluetoothd send
> "Discovering=false" after finishing all name resolution or when
> inquiry finishes? After clarifying this last question, I think it will
> be easier to define which mgmt events will be necessary.
> 
> >
> > User space can then request name resolving with Resolve Names Command, which
> > takes list of BT addresses as parameter. User space gets a Remote Name Event
> > for each device.
> >
> > Internally kernel would have a list of found devices, to which devices are
> > added during discovery. Device in the list is flagged as unknown unless
> > there was name for it in EIR data. After discovery is completed, event with
> > list of unknown devices is sent, and the found devices list is cleared (it's
> > valid only during one discovery session).
> >
> > Not sure if name resolution should be included in the discovery session done
> > via mgmt interface (while Discovering Event indicates discovery is ongoing),
> > and how to track discovery state in that case. Maybe another state is needed
> > in hdev->flags (e.g. HCI_DISCOVERY) if HCI_INQUIRY is not enough?
> 
> The userspace needs to decide if name resolution is required based on
> NameResolving(main.conf) and entries found in the
> storage(/var/lib/bluetooth/.../names).
> 
> Another hdev->flags? I am afraid that Marcel will be against it.

I remember that I already discussed this Johan a long time ago. So the
name resolving is part of the discovery procedure. And luckily it only
applies to pre 2.1 devices (or broken devices). The kernel is 100%
responsible for handling the name resolving. However it does not track
the names actually, it just tracks if the name is already cached or not.

There is no need for the kernel to store the names since it will never
ever use them. So either on start of bluetoothd we just load the list of
known cached names into the kernel or the kernel has to ask bluetoothd
for each address if there is a name cached or not.

The reason why name resolving needs to be part of the discovery
procedure and in full control by the kernel is that we need to be able
to cancel it. A name resolving transaction is a baseband connections and
it will conflict with other connection establishment procedures. So the
kernel needs to track these and be able to cancel it, before it tries
any other connection attempt.

Regards

Marcel


