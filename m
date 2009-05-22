Return-Path: <cyrus@holtmann.org>
From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Rafael Seste <rseste@gmail.com>
Subject: Re: bluez 4.x, SCO socket - connection reset by peer
Date: Fri, 22 May 2009 19:14:47 +0200
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
References: <5d223510905201349w416f50cal520dde1281f90bc7@mail.gmail.com> <1242853150.3147.32.camel@localhost.localdomain> <5d223510905210710s21f5a433r50ae5ca610ccff4@mail.gmail.com>
In-Reply-To: <5d223510905210710s21f5a433r50ae5ca610ccff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200905221914.48170.Hugo.Mildenberger@namir.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Donnerstag, 21. Mai 2009 schrieb Rafael Seste:
> Marcel
> 
> On Wed, May 20, 2009 at 5:59 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Rafael,
> >
> >> I trying to use asterisk (with chan_mobile) to connect with my mobile phone.
> >> When there is a incoming/outgoing call, this module creates a
> >> sco_socket to send/receive audio packets.
> >>
> >> socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)
> >>
> >> when this socket is ready...it can write data once, after that when it
> >> tries to read an error is returned:
> >>
> >> sco_read() error 104
> >>
> >> 104 means - connection reset by peer
> >>
> >> after this i got error 107 - not connect.
> >>
> >> Some one knows why is the reason of this error 104???
> >>
> >> kernel 2.6.22.18
> >> bluez 4.32
> >
> > I don't know, but your kernel is ancient. Please re-test with 2.6.30-rc6
> > and bluez-4.40 to see if this error still persists.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> 
> I have a setup:
> kernel 2.6.9-78.ELsmp #1 SMP Fri Jul 25 00:04:28 EDT 2008 i686 i686
> i386 GNU/Linux
> and bluez 2.10-3
> 
> and it works fine.
> 
> The difference is the arch that now I changed to an ARM and i can't
> install this old kernel.
> 

I can confirm this behaviour on x86 with a CSR Adapter (0a12:0001), 
a Nokia 6280 V6.43, linux-2.6.30-rc6-00159-ga15ae93 and bluez-4.40. 

Until today, I thought it might be related to the interaction between 
the Nokia firmware and Asterisk, but if Rafael says 2.6.9-78/bluez-2.10.3 
would be working?

https://issues.asterisk.org/view.php?id=15075 now has a patch which at 
least cures the symptoms.
  
I do also see some kernel errors via dmesg:

btusb_isoc_complete: hci0 corrupted SCO packet
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
btusb_isoc_complete: hci0 corrupted SCO packet
hci_scodata_packet: hci0 SCO packet for unknown connection handle 46
hci_scodata_packet: hci0 SCO packet for unknown connection handle 0
[...]
