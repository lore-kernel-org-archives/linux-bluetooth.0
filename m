Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Sun, 15 Feb 2004 17:43:51 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402140859.36255.jeffs@fairwayacademy.org> <1076770958.14758.5.camel@pegasus>
In-Reply-To: <1076770958.14758.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402151743.51707.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Saturday 14 February 2004 10:02, Marcel Holtmann wrote:
> Hi Jeff,
>
> > > maybe we really have some endian problems here and also in hcitool. The
> > > pkt_type for create_connection is for example uint16 and this explains
> > > why "hcitool info ..." fails. I don't have access to a machine with big
> > > endian, so most of the userspace tools are not fully tested.
> >
> >  I'll have access to this machine for a little while, so if you have
> > something you'd like to try just send patches this way :-)
>
> try this one to solve the problem with "hcitool info ...".

/> hcitool info 00:0A:4F:00:09:5E
Requesting information ...
bcsp_timed_event: Timeout, retransmitting 1 pkts
        BD Address:  00:0A:4F:00:09:5E
        Device Name: BlueZ (0)
        LMP Version: 1.1 (0x1) LMP Subversion: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>
                                                                                
/>

Heh, my hunch was correct for once, looks like it WAS an endian problem :-D

Thanks!
-Jeff

(now to see if I can get a ppp connection going...)
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
