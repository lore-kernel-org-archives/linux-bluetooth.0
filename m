Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Mysterious problem with l2test on Coldfire 5282
Date: Tue, 17 Feb 2004 16:47:06 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402170924.31121.jeffs@fairwayacademy.org> <200402171126.46462.jeffs@fairwayacademy.org> <1077042956.2665.85.camel@pegasus>
In-Reply-To: <1077042956.2665.85.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402171647.11969.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Tuesday 17 February 2004 13:35, Marcel Holtmann wrote:
> Hi Jeff,
>
> > > maybe this code in send_mode() is the problem
> > >
> > > 	*(uint32_t *) buf = htobl(seq++);
> > > 	*(uint16_t *)(buf+4) = htobs(data_size);
> > >
> > > Replace it with
> > >
> > > 	*(uint32_t *) buf = htobl(seq);
> > > 	*(uint16_t *)(buf+4) = htobs(data_size);
> > > 	seq++;
> > >
> > > I am not a uClinux or compiler expert, so this is only guess.
> >
> > Oh, Doh!  I'm sure this is it (haven't tried it yet, though) because of
> > the way the byteswap_32() macro expands!  No fair doing
> > increment/decrement ops on variables inside macros :-)
>
> I applied the fix for l2test, rctest and scotest. Should be in CVS now.

I confirmed that this fixed the problem.  I think that this was maybe the last 
of my major issues, thanks for all the help.  rfcomm seems to work, now I 
just need to make use of the connection.  Due to limited resources on my 
Coldfire board I'll probably just use ppp to establish a tcp/ip connection.

Regards,
-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
