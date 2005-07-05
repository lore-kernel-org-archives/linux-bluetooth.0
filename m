Return-Path: <ville.tervo@nokia.com>
Subject: Re: rfcomm oops
From: Ville Tervo <ville.tervo@nokia.com>
Reply-To: ville.tervo@nokia.com
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1120490944.10273.164.camel@pegasus>
References: <1120490370.30194.50.camel@localhost.localdomain>
	 <1120490944.10273.164.camel@pegasus>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 10:41:17 +0300
Message-Id: <1120549277.30194.55.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, 2005-07-04 at 17:29 +0200, ext Marcel Holtmann wrote:
> Hi Ville,
> 
> > I found reproducible way to make rfcomm layer oops. I attached oops and
> > some notes how they were produced. I used several Nokia phones and IBM
> > T40 laptop in these tests.
> 
> if the attached patch makes it go away, then I know what it is. Actually
> I introduced that problem when I tried to fix another bug with buggy
> phones that can't disconnect their DLCI 0 even if they established it.
> 

Look like this patch helps. I tested with i386 and arm.

-- 
Ville
