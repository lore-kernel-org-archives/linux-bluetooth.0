Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] Release of new BlueZ libs and utils
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073212685.25261.138.camel@pegasus>
References: <1071791711.6635.18.camel@pegasus>
	 <1073147533.8729.53.camel@saag>  <1073148476.8729.56.camel@saag>
	 <1073149849.25261.97.camel@pegasus>  <1073154814.8729.66.camel@saag>
	 <1073212685.25261.138.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073388369.8729.164.camel@saag>
Mime-Version: 1.0
Date: Tue, 06 Jan 2004 11:26:09 +0000
List-ID: <bluez-users.lists.sourceforge.net>

On Sun, 2004-01-04 at 10:38, Marcel Holtmann wrote:
> Hi Edd,
> 
> > No, I've not tried BlueZ<->BlueZ, it happened with my SE P800 connecting
> > back to BlueZ.  
> > 
> > Occasionally it gets a bit further, then hangs:
> > 
> > > ACL data: handle 0x002a flags 0x02 dlen 8
> >     L2CAP(d): cid 0x41 len 4 [psm 3]
> >       RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> > < ACL data: handle 0x002a flags 0x02 dlen 8
> >     L2CAP(d): cid 0x169 len 4 [psm 3]
> >       RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
> > > HCI Event: Number of Completed Packets(0x13) plen 5
> > > ACL data: handle 0x002a flags 0x02 dlen 18
> >     L2CAP(d): cid 0x41 len 14 [psm 3]
> >       RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
> >       dlci 2 frame_type 0 credit_flow 15 pri 0 ack_timer 0 frame_size
> > 667 max_retrans 0 credits 3
> > < ACL data: handle 0x002a flags 0x02 dlen 8
> >     L2CAP(d): cid 0x169 len 4 [psm 3]
> >       RFCOMM(s): DM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x73
> 
> how long is the time between these two packets?

no perceptible delay between these two.

>  Is there really a
> listening socket for this channel?

strace shows dund running accept() on the socket, so I guess so.

-- Edd
