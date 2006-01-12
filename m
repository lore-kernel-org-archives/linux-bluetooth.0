Return-Path: <wolfgang.walter@studentenwerk.mhn.de>
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Thu, 12 Jan 2006 12:47:29 +0100
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        maxk@qualcomm.com, Andrew Morton <akpm@osdl.org>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <1137057244.3955.3.camel@localhost.localdomain>
In-Reply-To: <1137057244.3955.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200601121247.30131.wolfgang.walter@studentenwerk.mhn.de>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

Am Donnerstag, 12. Januar 2006 10:14 schrieb Marcel Holtmann:
> Hi Wolfgang,
>
> > A friend and I encountered a problem with sco transfers to a headset
> > using linux (vanilla 2.6.15). While all sco packets sent by the headset
> > were received there was no outgoing traffic.
> >
> > After switching debugging output on we found that actually sco_cnt was
> > always zero in hci_sched_sco.
> >
> > hciconfig hci0 shows sco_mtu to be 64:0. Changing that to 64:8 did not
> > help.
> >
> > This was because in hci_cc_info_param hdev->sco_pkts is set to zero. Wh=
en
> > we changed this line so that hdev->sco_pkts is set to 8 if
> > bs->sco_max_pkt is 0 sco transfer to the headset started to work just
> > fine.
>
> send in the information from "hciconfig -a" for this device, because
> this is a hardware bug and you can't be sure that you can have eight
> outstanding SCO packets.

I'll send you that information that information this evening because  I don=
't=20
have access to the hardware now.

=46or the bluetooth usb-dongle: it is the Belkin F8T013de and it has a broa=
dcom=20
chip. As it is a usb 2.0 device and supports bluetooth 2.0 + edr.

The headset is a Siemens HHB-600.

>
> I personally prefer to implement this as a quirk which can be activated
> by the driver. Once I have seen the device information, I will think
> about how we might deal with it.
>

To be true, I don't know how exactly the driver hci_usb.c sets the maximum=
=20
number of outstanding sco packets.

We only found out using scotest that no packets are sent (tx_sco remains 0 =
and=20
hcidump shows no outgoing sco-traffic) and tried to find out where in the=20
stack they get lost. We found that hci_sched_sco is called but actually nev=
er=20
sent any packets because sco_cnt was always zero.

This is because sco_pkts is set to zero in  hci_cc_info_param (hci_event.c)=
 in=20
case OCF_READ_BUFFER_SIZE bs->sco_max_pkt is always zero.

We found several error reports of the same kind dating from 2005 and 2004 b=
ut=20
we didn't found any answer with a solution. We thought it might be a good=20
idea to send this patch so that others can give it a try and see if there=20
bluetooth-dongles will work at all. And it may helps others with a deeper=20
underst=E4nding of bluetooth to find the real problem of those

It is clear that hardwiring sco_pkts to 8 if (and only if) bs->sco_max_pkt =
is=20
zero is probably not the final solution (we arbitrary chose 8). But zero=20
certainly makes no much sense at all, either. If sco_pkts is zero no sco=20
packets will be sent.

Correct me if I'm wrong:

* sco_pkts says how many packets may be sent to the hardware without=20
completion. At the beginning sco_cnt is set do sco_pkts. For every packet w=
e=20
send it is decremented, for every completion it is incremented (but not=20
beyond sco_pkts).

* when usb device is opened cmd OGF_INFO_PARAM, OCF_READ_BUFFER_SIZE is sen=
t.=20
The device answers with an event OCF_READ_BUFFER_SIZE and then sco_pkts and=
=20
sco_cnt is set.

Therefor in our case sco_mtu is 64:0 unpatched and 64:8 patched.

* hciconfig hci0 scomtu 64:8 wil change sco_pkts to 8 (and it does) in=20
hci_dev_cmd. But sco_cnt remains zero. As long as there is no completion=20
message sco_cnt will remain zero and as there never has been sent any sco=20
packet there will never be a completion message.

By the way: even if sco_pkts was initially > 0: if one increase sco_pkts th=
is=20
will have no effect as sco_cnt will only be increased by completions and=20
therefore only reach the initial value of sco_pkts. Why can it be set at al=
l=20
(it seems one can only decrease it and then never increase it again without=
=20
reinitialisation).

The same holds for acl_pkts.


As far as I can see bs->sco_max_pk =3D=3D 0 only would make sense for=20
OCF_READ_BUFFER_SIZE events which are sent after initialisiation when the=20
device is already sending. I don't know if a device will sent such an event=
=20
unrequested and I don't see the stack sending a OCF_READ_BUFFER_SIZE cmd=20
after initialisation.

=2D-=20
Wolfgang Walter
Studentenwerk M=FCnchen
Anstalt des =F6ffentlichen Rechts
Leiter EDV
Leopoldstra=DFe 15
80802 M=FCnchen
Tel: +49 89 38196 276
=46ax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
