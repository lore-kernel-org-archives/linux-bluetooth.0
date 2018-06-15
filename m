Return-Path: <andreas@kemnade.info>
Date: Fri, 15 Jun 2018 15:30:12 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH RFC] bluetooth: fix paring problems with 0cf3:0036 and
 certain devices
Message-ID: <20180615153012.39cc0951@kemnade.info>
In-Reply-To: <AF751918-A8E5-4315-AF0C-E6A53A282A07@holtmann.org>
References: <20180614193330.28410-1-andreas@kemnade.info>
	<20180614203500.GA7182@x1c>
	<20180615074526.3982da35@kemnade.info>
	<AF751918-A8E5-4315-AF0C-E6A53A282A07@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, 15 Jun 2018 11:01:26 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
> 
> >>> This is clearly a RFC patch, things should be fixed in a cleaner
> >>> way. With the bluetooth usb adapter 0cf3:0036 (Atheros), there are
> >>> pairing problems in combination with certain remove devices. The
> >>> cause is that smp_resume_cb() gets called after SMP_CMD_IDENT_INFO
> >>> arrives in the end of a SC pairing with numerical comparison. so
> >>> that there are unexpected packet messages in dmesg and although an
> >>> ltk is known, bluetoothd considers the device as unpaired and not
> >>> even the ltk is not stored.
> >>> 
> >>> The patch makes the smp code be more tolerant with the order but
> >>> that does not feel like a safe thing to do.
> >>> Maybe the pairing result should be given back to userspace without
> >>> the irk related stuff.    
> >> 
> >> This sounds like the well known race between ACL data and HCI events
> >> that's inherent with the way the USB HCI transport is designed. So
> >> what's happening is that to the host it looks like some packets were
> >> delivered over an unencrypted connection even though they in reality
> >> came over an encrypted one.   
> > 
> > That matches what I thought. But then the question arises whether this
> > race also can happen the oppositie way, so that the host thinks it gets
> > an encrypted packet but that is really an unencrypted one? Ugly.
> > 
> > But interrupt endpoints are designed for correct timing, so there
> > might be something rotten in the adapter.
> >   
> >> Not enforcing the encrypted connection
> >> requirement is not really a solution since it creates a security
> >> vulnerabilty. The best option (as far as I know) is to consider
> >> switching to some other transport (e.g. H:4 over USB where both ACL
> >> data and HCI events share a single "pipe").
> >>   
> > So can we convince the bluetooth adapter to speak H4? So that we add a
> > quirk to use H4 for certain bluetooth adapters?
> > 
> > A quick grep in the kernel does not show up an easy possibility to do
> > so.
> > 
> > Maybe a fix which would be a bit better would be to not completely
> > ignore SMP_CMD_IDENT_ADDR_INFO (where the kernel has no doubt that it
> > is encrypted) without SMP_CMD_IDENT_INFO, so userspace
> > would not get a pairing timeout but instead a pairing without irk but
> > with ltk?  
> 
> I doubt we can do anything about this. The firmware needs to do this correctly. Can you send a btmon trace when this happens and we can see if this is really the case. If the encryption changed signal comes after the packet, then it is the issue.
> 
Firmware = the non-free ar3k/ramps_something? 
I also checked with wireshark via usbmon. The order stays  the same.
But I am still wondering whether the ltk should be dropped in such cases.
Here is a dump made with hcidump.


< ACL data: handle 32 flags 0x00 dlen 11
    SMP: Pairing Request (0x01)
      capability 0x04 oob 0x00 auth req 0x2d
      max key size 0x10 init key dist 0x0d resp key dist 0x0f
      Capability: KeyboardDisplay (OOB data not present)
      Authentication: Bonding (MITM Protection)
      Initiator Key Distribution:  LTK  CSRK
      Responder Key Distribution:  LTK IRK CSRK
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> ACL data: handle 32 flags 0x02 dlen 11
    SMP: Pairing Response (0x02)
      capability 0x01 oob 0x00 auth req 0x0d
      max key size 0x10 init key dist 0x01 resp key dist 0x03
      Capability: DisplayYesNo (OOB data not present)
      Authentication: Bonding (MITM Protection)
      Initiator Key Distribution:  LTK  
      Responder Key Distribution:  LTK IRK 
< ACL data: handle 32 flags 0x00 dlen 27
< ACL data: handle 32 flags 0x01 dlen 27
< ACL data: handle 32 flags 0x01 dlen 15
    SMP: Unknown (0x0c)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> ACL data: handle 32 flags 0x02 dlen 27
> ACL data: handle 32 flags 0x01 dlen 27
> ACL data: handle 32 flags 0x01 dlen 15
    SMP: Unknown (0x0c)
> ACL data: handle 32 flags 0x02 dlen 21
    SMP: Pairing Confirm (0x03)
      key aaf619a4d97c2a6a21a3e7222ca7a6b0
< ACL data: handle 32 flags 0x00 dlen 21
    SMP: Pairing Random (0x04)
      random 4016a68507abba70795e3ed19457098e
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> ACL data: handle 32 flags 0x02 dlen 21
    SMP: Pairing Random (0x04)
      random 343c0995e5eee8b4818d5037109d9cff
< ACL data: handle 32 flags 0x00 dlen 21
    SMP: Unknown (0x0d)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 32 packets 1
> ACL data: handle 32 flags 0x02 dlen 21
    SMP: Unknown (0x0d)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> ACL data: handle 32 flags 0x02 dlen 21
    SMP: Identity Information (0x08)
      IRK 13860fdc8293df86e7cc9b699632650c
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 32 encrypt 0x01
> ACL data: handle 32 flags 0x02 dlen 12
    SMP: Identity Address Information (0x09)
      bdaddr 56:1D:34:F5:24:2C (Public)

Regards,
Andreas
