Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
Date: Mon, 16 Apr 2012 08:03:27 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B47E6C9@DNCE05.ent.ti.com>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Anderson Lizardo
> Sent: Thursday, April 12, 2012 4:04 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Anderson Lizardo
> Subject: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
> 
> Hi,
> 
> This patch contains an API proposal for implementing LE
> Broadcaster/Observer
> roles in BlueZ. These roles allow to transfer data unidirectionally
> (from
> Broadcaster to Observer) in a connectionless setup. See Core spec Vol
> 3, Part
> C, section 9.1 for more details.
> 
> The API consists on extending the Adapter API to support
> Observer/Broadcaster
> procedures. These are implemented as methods separate from Discovery,
> given
> that Broadcaster devices are non-connectable and non-discoverable.
> 
> Multiple D-Bus clients can register for Observer mode, as well as for
> Broadcaster. BlueZ is thus responsible for constructing the Adv. Data
> (in
> Broadcaster mode) or routing the broadcast data (in Observer mode) to
> the
> applications.
> 
> On Broadcaster, multiple applications cannot broadcast the same Adv.
> data type.

This looks a bit problematic. What if two applications wish to broadcast services ? Or Service Solicitation ? or Service Data ? This could lead to problems.

In addition, what about TX Power, or Flags - which module is responsible for sending this data ? Will it be public for any application, or will you have some kind of allowed Advertising packets for external application, and some reserved for system ?

Are you planning to support duplicate filtering ?

What are you planning to do if the Advertising data exceeds the MAX ADV Data size ? Will you split the data somehow to multiple advertising packets ? What is the logic behind such a split ?

How will you allow a user to select whether the data is to be sent over Advertising or Scan Response ?

How will you allow a user or system to configure scan parameters for observer or advertising parameters for broadcasters ?

I'm guessing you will need to add more D-BUS Api's, or at least allow setting those parameters in the main.conf file ?

> On Observer, the application(s) register(s) a callback that will be
> called only
> when the specified Adv. types are present on the received advertising
> event.
> 
> We considered using signals for broadcast data, but it turns out it can
> cause
> too much D-Bus traffic given that all registered applications will
> receive the
> signals. The callback approach allows to ignore broadcasts which have
> no
> information relevant to an application.
> 
I agree with that.


> Note that this proposal does not describe the necessary mgmt API
> changes. This
> will come once we agree on the higher level D-Bus API. But it should be
> expected that new commands for enabling/disabling observer/broadcaster
> modes
> and setting adv. data will be necessary, as well as modifying the
> current
> kernel code that ignores non-connectable advertising (which are used by
> Observers).
I also think you need to add PropertyChanged for Broadcasting, since you will need to stop broadcasting when connecting to a device, or when the power is turned off for example. In addition, you will need to figure out a way to synchronize all the GAP LE roles, according to what is allowed or disallowed.

> 
> Comments and suggestions are welcome.
> 
> Anderson Lizardo (1):
>   doc: Document Broadcaster/Observer API
> 
>  doc/adapter-api.txt |   56
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> --
> 1.7.5.4
> 
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



Thanks,
Chen Ganir
