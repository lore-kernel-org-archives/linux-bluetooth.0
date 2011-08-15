Return-Path: <cyrus@holtmann.org>
From: "Ilia, Kolominsky" <iliak@ti.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann
	<marcel@holtmann.org>
CC: "ilia.kolominsky@gmail.com" <ilia.kolominsky@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 15 Aug 2011 17:40:01 +0200
Subject: RE: [PATCH v2 bluetooth-next] Added ioctl flow specification
 command on HCI socket
Message-ID: <AC090B9732AB2B4DB7FF476E907FE6600131D899E4@dnce02.ent.ti.com>
References: <1313325793-27866-1-git-send-email-iliak@ti.com>
	<1313356642.3373.170.camel@aeonflux>
 <CABBYNZKeKQY2QXX2KX6=iyf3o10Wu=iq8PnhiSAJM2E_+RDP2g@mail.gmail.com>
In-Reply-To: <CABBYNZKeKQY2QXX2KX6=iyf3o10Wu=iq8PnhiSAJM2E_+RDP2g@mail.gmail.com>
Content-Type: text/plain; charset="windows-1255"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Monday, August 15, 2011 10:53 AM
> To: Marcel Holtmann
> Cc: ilia.kolominsky@gmail.com; linux-bluetooth@vger.kernel.org; Ilia,
> Kolominsky
> Subject: Re: [PATCH v2 bluetooth-next] Added ioctl flow specification
> command on HCI socket
>=20
> Hi Marcel,
>=20
> On Mon, Aug 15, 2011 at 12:17 AM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > Hi Ilia,
> >
> >> While it is possible to send flow specification HCI command
> >> from the user space directly via the send api of HCI socket,
> >> a more specific approach is preferable over the opaque
> >> HCI command, since it will allow for centralized mangament of
> >> flow specifiaction requests for different l2cap flows over
> >> the same acl link in future. This feature was used successfully
> >> for solving the qos A2DP issue in piconet with concurent file
> >> transfer.
> >>
> >> Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
> >> ---
> >> =A0include/net/bluetooth/hci.h =A0 =A0 =A0| =A0 38 ++++++++++++++++++-=
---
> >> =A0include/net/bluetooth/hci_core.h | =A0 =A03 ++
> >> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 63
> ++++++++++++++++++++++++++++++++++++++
> >> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 37 +++++++++++++++++=
+++++
> >> =A0net/bluetooth/hci_sock.c =A0 =A0 =A0 =A0 | =A0 =A02 +
> >> =A06 files changed, 137 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/net/bluetooth/hci.h
> b/include/net/bluetooth/hci.h
> >> index be30aab..f0f90d5 100644
> >> --- a/include/net/bluetooth/hci.h
> >> +++ b/include/net/bluetooth/hci.h
> >> @@ -109,6 +109,8 @@ enum {
> >> =A0#define HCISETLINKMODE =A0 =A0 =A0 _IOW('H', 226, int)
> >> =A0#define HCISETACLMTU _IOW('H', 227, int)
> >> =A0#define HCISETSCOMTU _IOW('H', 228, int)
> >> +#define HCISETFLOWSPEC _IOW('H', 229, int)
> >> +
> >
> > I am not accepting any new addition of ioctl() at this moment. We are
> > moving towards a proper defined management API. And that is how this
> > should be addressed.

>From what I see in mgmt.h, I cant draw a fine conceptual line between the
qos/tm features and the functionality that is defined there currently -
for instance stuff like MGMT_OP_SET_DISCOVERABLE and MGMT_OP_SET_CONNECTABL=
E.
On the other hand I completely agree that the qos issues should be
managed in a conceptually central component. The bottom line, I am
saying that given the complexity level of the qos management ( that I
describe bellow ) it may be appropriate to introduce separate traffic
management component.

> >
> > And these kind of ictol() that have to execute a HCI command and wait
> > for the result are not a good for being an ioctl() in the first
> place.
> >
> > Regards
> >
> > Marcel
>=20
> I got the impression that the spec indicates this should first be
> negotiated on l2cap level since there is a command with exact same
> parameters, perhaps the way to go would be to have this as a socket
> option and require some capability to be able to set them, after the
> L2CAP QoS negotiation completes the kernel could automatically set the
> HCI QoS based on that.
>=20
> --
> Luiz Augusto von Dentz

I actually tried to keep it simple with this patch despite the fact that
IMHO qos issues that exist in Bluetooth require a more substantial effort.
But since the patch is not accepted and based on Luiz's comments (that
note the complexity of the issue anyway) I take the opportunity to RFC a mo=
re
serious solution for battling the bluetooth qos issues. First of all,
the description of 2 qos problems that we experience (there may exist more
of course):

1. Piconet ACL coexistence:
HeadSet <--- ACL/A2DP/AVRCP ---> Master <---- ACL/OBEX ----> Slave B
In this scenario user audio experience is unacceptable, since transport=20
service does not provide the requested throughput, because the radio is=20
shared with Slave B. This issue was addressed successfully with this patch
and modifications to the user-space which used the ioctl during AVDTP
configuration stage. In short, the master's link manager provided
the required bandwidth for the A2DP stream.

2. L2CAP coexistence:
CarKit <---ACL/2A2DP/AVRCP/BPAP---> Phone
In this scenario user audio experience is also unsatisfying, but not
due to the link manager, but due to the l2cap. Thus, solution
that worked in (1) won`t help here. The need for traffic management
in l2cap is obvious.


So, academically speaking, we have 2 levels of output queues that need to b=
e
managed accordingly to required qos. I propose the following hi-level desig=
n=20
(that draws on network stack scheduler):

l2cap_1------> l2cap_qsched----------> baseband_qsched
l2cap_2-----^        ^                         ^     =20
			   |                         |
		Flow classifications     HCI_FLOW_SPEC commands
			   ^
			   |                         |
			   |                         |
	       BT traffic manager ----------------
                     ^
			   |
			   |
		User space control


l2cap_qsched - manages outgoing queues according to flow classifications db=
.

baseband_qsched - implemented on the controller, controlled with HCI_FLOW_S=
PEC
commands.

Flow classifications - db that contains flow classifications and qos specs.

BT traffic manager - manages the db, sends HCI_FLOW_SPEC commands, ensures
coherency of qos settings on both levels. E.g.: l2cap_1 is A2DP stream,
requests X KB/s throughput, l2cap_2 is AVRCP, requests 100ms delay.
Both are over the same ACL link, thus, the BT traffic manager should
be able to calculate the baseband_qsched requirements for that particular A=
CL
correctly. The manager also needs to "sense" the termination of l2cap flows
in order to update the baseband_qsched settings accordingly.
OPEN ISSUE: How to handle l2cap qos negotiation procedures.

User space control - API for controlling BT traffic management. Probably
commands like "Add/Remove classifications". Probably, extensions to
the current management interface or another form of user-space access.
User space control app may look like this:
"bt_tc add -p A2DP -b 160" - request 160KB/s throughput for A2DP


The main question here - is there a chance that something like this
will be accepted in the stack or this is completely off the target? -
We are in need to provide solution for (1) and (2) to our customers,
obviously we want it to be aligned with bluez architecture.
Regards,


Ilia Kolominsky
iliak@ti.com
Direct:  +972(9)7906231
Mobile: +972(54)909009
