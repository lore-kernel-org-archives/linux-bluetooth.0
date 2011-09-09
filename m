Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4E6A247C.5040403@nokia.com>
References: <4E6A247C.5040403@nokia.com>
Date: Fri, 9 Sep 2011 19:19:54 -0300
Message-ID: <CAKT1EBdGAyxBh_aeTjPAhOeU2vHSsjbpgi91=vG8HqLv8aV0Yw@mail.gmail.com>
Subject: Re: Name resolution for mgmt interface
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

On Fri, Sep 9, 2011 at 11:36 AM, Antti Julku <antti.julku@nokia.com> wrote:
>
> Hello Bluetooth experts,
>
> Name resolution of older devices not supporting EIR is still missing from
> the management interface. I discussed with Johan, and he suggested the
> following architecture (if I understood correctly):
>
> New command and event are added to mgmt interface:
>  * Unknown Names Event
>  * Resolve Names Command
>
> When device discovery is completed, kernel sends list of BT addresses of
> devices which names are unknown (no name in EIR data) with Unknown Names
> Event.

Does it worth to parse the EIR data twice(kernel and userspace)?

My suggestion is to remove the Unknown Names Event and add the Resolve
Names Command only.

No matter the decision, we need to evaluate how to map the discovering
session properly, I mean how to sync kernel and userspace events and
signals. One think that it is not clear to me: does name resolution
belongs to discovery procedure? I am not talking about the SPEC, it is
more how we define the concept in BlueZ. Should bluetoothd send
"Discovering=false" after finishing all name resolution or when
inquiry finishes? After clarifying this last question, I think it will
be easier to define which mgmt events will be necessary.

>
> User space can then request name resolving with Resolve Names Command, which
> takes list of BT addresses as parameter. User space gets a Remote Name Event
> for each device.
>
> Internally kernel would have a list of found devices, to which devices are
> added during discovery. Device in the list is flagged as unknown unless
> there was name for it in EIR data. After discovery is completed, event with
> list of unknown devices is sent, and the found devices list is cleared (it's
> valid only during one discovery session).
>
> Not sure if name resolution should be included in the discovery session done
> via mgmt interface (while Discovering Event indicates discovery is ongoing),
> and how to track discovery state in that case. Maybe another state is needed
> in hdev->flags (e.g. HCI_DISCOVERY) if HCI_INQUIRY is not enough?

The userspace needs to decide if name resolution is required based on
NameResolving(main.conf) and entries found in the
storage(/var/lib/bluetooth/.../names).

Another hdev->flags? I am afraid that Marcel will be against it.

BR,
Claudio

>
> Any opinions? I think it would be good to have wider discussion before
> making patches.
>
> Br,
> Antti
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
