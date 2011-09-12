Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315635815.1937.4.camel@aeonflux>
References: <4E6A247C.5040403@nokia.com>
	<CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
	<1315635815.1937.4.camel@aeonflux>
Date: Mon, 12 Sep 2011 13:56:06 -0300
Message-ID: <CAKT1EBc4z+rvgqKr1SuE_iYvBMqhLJ=E5AW6k5cq65nqa9EW=A@mail.gmail.com>
Subject: Re: Name resolution for mgmt interface
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Antti Julku <antti.julku@nokia.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Sep 10, 2011 at 3:23 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Claudio,
>
>> > Name resolution of older devices not supporting EIR is still missing f=
rom
>> > the management interface. I discussed with Johan, and he suggested the
>> > following architecture (if I understood correctly):
>> >
>> > New command and event are added to mgmt interface:
>> > =C2=A0* Unknown Names Event
>> > =C2=A0* Resolve Names Command
>> >
>> > When device discovery is completed, kernel sends list of BT addresses =
of
>> > devices which names are unknown (no name in EIR data) with Unknown Nam=
es
>> > Event.
>>
>> Does it worth to parse the EIR data twice(kernel and userspace)?
>>
>> My suggestion is to remove the Unknown Names Event and add the Resolve
>> Names Command only.
>>
>> No matter the decision, we need to evaluate how to map the discovering
>> session properly, I mean how to sync kernel and userspace events and
>> signals. One think that it is not clear to me: does name resolution
>> belongs to discovery procedure? I am not talking about the SPEC, it is
>> more how we define the concept in BlueZ. Should bluetoothd send
>> "Discovering=3Dfalse" after finishing all name resolution or when
>> inquiry finishes? After clarifying this last question, I think it will
>> be easier to define which mgmt events will be necessary.
>>
>> >
>> > User space can then request name resolving with Resolve Names Command,=
 which
>> > takes list of BT addresses as parameter. User space gets a Remote Name=
 Event
>> > for each device.
>> >
>> > Internally kernel would have a list of found devices, to which devices=
 are
>> > added during discovery. Device in the list is flagged as unknown unles=
s
>> > there was name for it in EIR data. After discovery is completed, event=
 with
>> > list of unknown devices is sent, and the found devices list is cleared=
 (it's
>> > valid only during one discovery session).
>> >
>> > Not sure if name resolution should be included in the discovery sessio=
n done
>> > via mgmt interface (while Discovering Event indicates discovery is ong=
oing),
>> > and how to track discovery state in that case. Maybe another state is =
needed
>> > in hdev->flags (e.g. HCI_DISCOVERY) if HCI_INQUIRY is not enough?
>>
>> The userspace needs to decide if name resolution is required based on
>> NameResolving(main.conf) and entries found in the
>> storage(/var/lib/bluetooth/.../names).
>>
>> Another hdev->flags? I am afraid that Marcel will be against it.
>
> I remember that I already discussed this Johan a long time ago. So the
> name resolving is part of the discovery procedure. And luckily it only
> applies to pre 2.1 devices (or broken devices). The kernel is 100%
> responsible for handling the name resolving. However it does not track
> the names actually, it just tracks if the name is already cached or not.

ok. When I mentioned parse the name in the EIR is actually check if
complete name type is included in the EIR.

>
> There is no need for the kernel to store the names since it will never
> ever use them. So either on start of bluetoothd we just load the list of
> known cached names into the kernel or the kernel has to ask bluetoothd
> for each address if there is a name cached or not.
>
> The reason why name resolving needs to be part of the discovery
> procedure and in full control by the kernel is that we need to be able
> to cancel it. A name resolving transaction is a baseband connections and
> it will conflict with other connection establishment procedures. So the
> kernel needs to track these and be able to cancel it, before it tries
> any other connection attempt.

Based on your comments I am writing below my analysis of your
suggested approaches.

1o. Approach: Load name when bluetoothd starts
This approach seems to be more easy, since it will require less
interaction between kernel and userspace. MGMT command complete for
start discovery will be sent after name resolution finishes. The
discovery concept will be include name resolution.
* Pros/Facts:
  - extend start discovery to enable name resolving or assume that if
the kernel receives "load names" command it should resolve names
  - direct mapping of MGMT discovering events to DBUS discovering signals
  - no extra MGMT command to cancel name resolving, stop discovery
will automatically cancel name resolution if necessary
* Cons:
  - Checking of "complete name" in the EIR in the kernel

2o. Ask bluetoothd for each address
In my opinion this approach will be more difficult to implement. If I
understood correctly, you are proposing a new command containing a
list of address to resolve names.
* Pros/Facts:
  - new mgmt command to resolve names
  - no need to check EIR "complete name" type in kernel: it can be
verified in the kernel, but it will give meaningful benefits.
  - MGMT discovering false event and MGMT command complete for start
discovery needs to be sent after inquiry(or LE scan) finishes: it is
not possible to know if the userspace will request name for at least
one address.
* Cons:
  - two extra MGMT command to start/stop name resolution
  - MGMT discovering false event can not be directly mapped to DBUS
Discovering signal

BR,
Claudio

>
> Regards
>
> Marcel
