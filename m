Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Fri, 13 Feb 2004 23:10:53 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402131858.51524.jeffs@fairwayacademy.org> <1076717197.18588.109.camel@pegasus>
In-Reply-To: <1076717197.18588.109.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402132310.53881.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Friday 13 February 2004 19:06, Marcel Holtmann wrote:
> Hi Jeff,
>
> > I've tried the l2test -s from Coldfire several times, doing 'hciconfig
> > hci0 reset' in between for good measure, always get the same results on
> > the pc end.  This looks suspiciously like an endian problem somewhere,
> > but why would receive work ok?
>
> the endian stuff looks fine in the l2test.c source. What endian do the
> Coldfire processor use?

Big Endian.

Regards,
-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
