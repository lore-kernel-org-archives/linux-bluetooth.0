Return-Path: <cyrus@holtmann.org>
Subject: Re: Name resolution for mgmt interface
From: Marcel Holtmann <marcel@holtmann.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: Antti Julku <antti.julku@nokia.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 12 Sep 2011 21:07:20 +0200
In-Reply-To: <CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com>
References: <4E6A247C.5040403@nokia.com>
	 <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
	 <1315635815.1937.4.camel@aeonflux>
	 <CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315854441.1937.28.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

> >> > Name resolution of older devices not supporting EIR is still missing from
> >> > the management interface. I discussed with Johan, and he suggested the
> >> > following architecture (if I understood correctly):
> >> >
> >> > New command and event are added to mgmt interface:
> >> >  * Unknown Names Event
> >> >  * Resolve Names Command
> >> >
> >> > When device discovery is completed, kernel sends list of BT addresses of
> >> > devices which names are unknown (no name in EIR data) with Unknown Names
> >> > Event.
> >>
> >> Does it worth to parse the EIR data twice(kernel and userspace)?
> >>
> >> My suggestion is to remove the Unknown Names Event and add the Resolve
> >> Names Command only.
> >>
> >> No matter the decision, we need to evaluate how to map the discovering
> >> session properly, I mean how to sync kernel and userspace events and
> >> signals. One think that it is not clear to me: does name resolution
> >> belongs to discovery procedure? I am not talking about the SPEC, it is
> >> more how we define the concept in BlueZ. Should bluetoothd send
> >> "Discovering=false" after finishing all name resolution or when
> >> inquiry finishes? After clarifying this last question, I think it will
> >> be easier to define which mgmt events will be necessary.
> >>
> >> >
> >> > User space can then request name resolving with Resolve Names Command, which
> >> > takes list of BT addresses as parameter. User space gets a Remote Name Event
> >> > for each device.
> >> >
> >> > Internally kernel would have a list of found devices, to which devices are
> >> > added during discovery. Device in the list is flagged as unknown unless
> >> > there was name for it in EIR data. After discovery is completed, event with
> >> > list of unknown devices is sent, and the found devices list is cleared (it's
> >> > valid only during one discovery session).
> >> >
> >> > Not sure if name resolution should be included in the discovery session done
> >> > via mgmt interface (while Discovering Event indicates discovery is ongoing),
> >> > and how to track discovery state in that case. Maybe another state is needed
> >> > in hdev->flags (e.g. HCI_DISCOVERY) if HCI_INQUIRY is not enough?
> >>
> >> The userspace needs to decide if name resolution is required based on
> >> NameResolving(main.conf) and entries found in the
> >> storage(/var/lib/bluetooth/.../names).
> >>
> >> Another hdev->flags? I am afraid that Marcel will be against it.
> >
> > I remember that I already discussed this Johan a long time ago. So the
> > name resolving is part of the discovery procedure. And luckily it only
> > applies to pre 2.1 devices (or broken devices). The kernel is 100%
> > responsible for handling the name resolving. However it does not track
> > the names actually, it just tracks if the name is already cached or not.
> 
> ok. When I mentioned parse the name in the EIR is actually check if
> complete name type is included in the EIR.

yep, the kernel needs to know if it has to request the name or not.

However it does not mean that the kernel has to parse EIR actually, it
could also ask userspace for names it should request. Something like I
am done with the inquiry, here are the BD_ADDRs without EIR, tell me
which ones I should request.

> > There is no need for the kernel to store the names since it will never
> > ever use them. So either on start of bluetoothd we just load the list of
> > known cached names into the kernel or the kernel has to ask bluetoothd
> > for each address if there is a name cached or not.
> >
> > The reason why name resolving needs to be part of the discovery
> > procedure and in full control by the kernel is that we need to be able
> > to cancel it. A name resolving transaction is a baseband connections and
> > it will conflict with other connection establishment procedures. So the
> > kernel needs to track these and be able to cancel it, before it tries
> > any other connection attempt.
> 
> Based on your comments I am writing below my analysis of your
> suggested approaches.
> 
> 1o. Approach: Load name when bluetoothd starts
> This approach seems to be more easy, since it will require less
> interaction between kernel and userspace. MGMT command complete for
> start discovery will be sent after name resolution finishes. The
> discovery concept will be include name resolution.
> * Pros/Facts:
>   - extend start discovery to enable name resolving or assume that if
> the kernel receives "load names" command it should resolve names
>   - direct mapping of MGMT discovering events to DBUS discovering signals
>   - no extra MGMT command to cancel name resolving, stop discovery
> will automatically cancel name resolution if necessary
> * Cons:
>   - Checking of "complete name" in the EIR in the kernel
> 
> 2o. Ask bluetoothd for each address
> In my opinion this approach will be more difficult to implement. If I
> understood correctly, you are proposing a new command containing a
> list of address to resolve names.
> * Pros/Facts:
>   - new mgmt command to resolve names
>   - no need to check EIR "complete name" type in kernel: it can be
> verified in the kernel, but it will give meaningful benefits.
>   - MGMT discovering false event and MGMT command complete for start
> discovery needs to be sent after inquiry(or LE scan) finishes: it is
> not possible to know if the userspace will request name for at least
> one address.
> * Cons:
>   - two extra MGMT command to start/stop name resolution
>   - MGMT discovering false event can not be directly mapped to DBUS
> Discovering signal

I honestly don't know which one is easier. We also have to keep the
memory constraints in mind. So for how many BD_ADDR does the kernel
needs to store the flag name resolved already yes/no? With system that
are running for years, this can get pretty big.

My current take on this (which is not final) is that after inquiry
complete, the kernel needs to ask userspace to confirm which names to
resolve. It is an action triggered by the kernel and userspace just
responds with the result to. So the kernel has full control here.

Our only limit is the mgmt frame size, but even if we put each confirm
request into a separate event/command sequence, this will be still fast
enough even for 200 devices in range. And of course for LE or 2.1 with
EIR we do not bother.

Question is just left for short names. And we could just be sneaky and
not bother and wait until someone actually selects it for pairing. Once
the ACL link is up, we just update the name anyway.

Or we just quickly parse the EIR and decide inside the kernel if it is
the full name, we don't bother, if it is the short name, we ask
userspace. As I side note here, I have yet to see a device that uses the
shortname feature. They always try to include the fullname.

Regards

Marcel


