Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Mysterious problem with l2test on Coldfire 5282
Date: Tue, 17 Feb 2004 11:26:46 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402170924.31121.jeffs@fairwayacademy.org> <1077032602.2665.12.camel@pegasus>
In-Reply-To: <1077032602.2665.12.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402171126.46462.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Tuesday 17 February 2004 10:43, Marcel Holtmann wrote:
> Hi Jeff,
>
> > Using the l2test program on Motorola 5282 (uClinux) I have a strange
> > behaviour when using l2test -s from the Moto board.  Using the -d (dump)
> > mode to receive packets from a PC running l2test I see what appears to be
> > the packet sequence number in the first 4 bytes of data (little endian),
> > followed by a 2 byte packet length, then data payload.  When dumping data
> > from the PC the packet sequence number increments by 1 each time, which,
> > I believe, is the expected behaviour.  However, when sending from the
> > Moto board to the PC, the packet sequence number increments by 4 each
> > time. ?????  L2test send looks ok, the sequence number is just seq++; so
> > something must be going on in hcid, right?  Or maybe it's dropping 3 out
> > of 4 send packets for some reason. Maybe something cocked up with the
> > socket ops in l2test?  ?????  Debugging pointers, please...
>
> maybe this code in send_mode() is the problem
>
> 	*(uint32_t *) buf = htobl(seq++);
> 	*(uint16_t *)(buf+4) = htobs(data_size);
>
> Replace it with
>
> 	*(uint32_t *) buf = htobl(seq);
> 	*(uint16_t *)(buf+4) = htobs(data_size);
> 	seq++;
>
> I am not a uClinux or compiler expert, so this is only guess.

Oh, Doh!  I'm sure this is it (haven't tried it yet, though) because of the 
way the byteswap_32() macro expands!  No fair doing increment/decrement ops 
on variables inside macros :-)

-Jeff 
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
