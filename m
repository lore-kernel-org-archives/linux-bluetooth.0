Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Fri, 13 Feb 2004 18:58:51 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402131819.10939.jeffs@fairwayacademy.org> <1076715629.18588.103.camel@pegasus>
In-Reply-To: <1076715629.18588.103.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402131858.51524.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Friday 13 February 2004 18:40, Marcel Holtmann wrote:
> Hi Jeff,

<snip>

> Both look fine, but you should enable role switch support in hcid.conf
> or set it by hand with hciconfig.
>
> > Other than that sequence problem it looks like the link mostly works,
> > still issues with most of the commands of hcitool though, on Coldfire.
>
> Keep trying and look with hcidump at it, but we can also have a bug in
> our tools if they are used on a ColdFire processor.

I've tried the l2test -s from Coldfire several times, doing 'hciconfig hci0 
reset' in between for good measure, always get the same results on the pc 
end.  This looks suspiciously like an endian problem somewhere, but why would 
receive work ok?

2test[30524]: Receiving ...
l2test[30524]: 672 bytes in 0.06 sec, 11.49 kB/s
l2test[30524]: seq missmatch: 1 -> 4
l2test[30524]: 672 bytes in 0.09 sec, 7.57 kB/s
l2test[30524]: seq missmatch: 5 -> 8

Thanks for all your help on this.  I was really hoping once I got the buggered 
mcfserial.c driver working that I would be done...

-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
