Return-Path: <Andreas.Gaufer@blue-cell-networks.com>
Date: Tue, 29 Jun 2004 10:41:40 +0200
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: andreas.gaufer@blue-cell-networks.com, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Link interrupted/destroyed by CC on other hci device
Message-Id: <20040629104140.04f9c2c8.Andreas.Gaufer@blue-cell-networks.com>
In-Reply-To: <1088453745.6030.89.camel@pegasus>
References: <20040628215642.516c0ff6.Andreas.Gaufer@blue-cell-networks.com>
	<1088453745.6030.89.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

im afraid i dont actauly see the event in hcidump. I guess this is
something that goes wrong on the remote side.

------------ snipp --------------
1088497489.410713 < ACL data: handle 0x002a flags 0x02 dlen 192
1088497489.410725 < ACL data: handle 0x002a flags 0x01 dlen 63
    L2CAP(d): cid 0x85 len 251 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 246 fcs 0x31 
      6C 61 67 00 00 00 00 01 00 00 38 42 49 4D 27 10 14 4A 61 70 
      61 6E 65 73 65 20 50 72 69 6E 74 20 46 6C 61 67 73 00 00 00 
      00 0A 00 01 00 00 00 00 00 00 00 02 38 42 49 4D 03 F5 17 43 
      6F 6C 6F 72 20 48 61 6C 66 74 6F 6E 65 20 53 65 74 74 69 6E 
      67 73 00 00 00 48 00 2F 66 66 00 01 00 6C 66 66 00 06 00 00 
      00 00 00 01 00 2F 66 66 00 01 00 A1 99 9A 00 06 00 00 00 00 
      00 01 00 32 00 00 00 01 00 5A 00 00 00 06 00 00 00 00 00 01 
      00 35 00 00 00 01 00 2D 00 00 00 06 00 00 00 00 00 01 38 42 
      49 4D 03 F8 17 43 6F 6C 6F 72 20 54 72 61 6E 73 66 65 72 20 
      53 65 74 74 69 6E 67 73 00 00 00 70 00 00 FF FF FF FF FF FF 
      FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 03 E8 00 00 
      00 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
      FF FF FF FF 03 E8 
1088497489.410753 < ACL data: handle 0x002a flags 0x02 dlen 28
    L2CAP(d): cid 0x85 len 24 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 20 pf 0 ilen 20 fcs 0x31 
      00 00 00 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 
1088497489.425622 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00 
1088497489.427617 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00 
1088497489.437616 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00 
1088497489.440617 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00 
1088497489.442615 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 2A 00 01 00 

Here the phone says "Link interupted" and the Transfer is stalled on
host side. 

After 10s of inactivity during the transfer I kill the obex process so
the link gets closed.

1088497499.412666 < ACL data: handle 0x002a flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0083 scid 0x0040

Do you see anything strange here? I guess i need a PA to debug this. 
Since this happens on SE Phones only i'll try to get somone to talk to
there. 

As i sayd it heappens not always but verry often in the moment when
another chip is paging. Maby this makes the phones stack crazy when they
jump on the same freq?

Anyways i guess this is not a bluez issue so thanks for the help so far.

Greetings

Andy



On Mon, 28 Jun 2004 22:15:45 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Andreas,
> 
> > I noticed that running OBEX Transfers on one hci device are
> > interrupted(L2CAP link is destroyed) by a CC that is issued on a
> > different hci dev.
> > 
> > 
> > As far as i can see it only happens on T6xx Phones from SE but this
> > is not for sure now. Im will start digging on this phenomina now. 
> > 
> > I would greatly appreciate hints or thoughts why this could happen. 
> 
> I don't think that this can happen, but who knows for sure. Make
> binary dump files and compare the timestamps of the two HCI devices.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
