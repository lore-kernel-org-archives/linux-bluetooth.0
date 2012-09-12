Return-Path: <cyrus@holtmann.org>
Message-ID: <1347455822.21218.3.camel@obelisk.thedillows.org>
Subject: Re: [PATCH] Add support for Logitech Harmony Adapter for PS3
From: David Dillow <dave@thedillows.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Date: Wed, 12 Sep 2012 09:17:02 -0400
In-Reply-To: <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	 <20120907124559.GA16092@x220>
	 <CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	 <1347284864.3532.1.camel@sirocco.hadess.net>
	 <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	 <CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	 <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	 <1347394656.1606.10.camel@sirocco.hadess.net>
	 <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2012-09-12 at 13:56 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Tue, Sep 11, 2012 at 11:17 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > Certainly, but until somebody writes the code (I already have at least 3
> > drivers to submit to the kernel that I've not had time to handle,
> > include one Bluetooth device), I think it would be nice not to drop
> > support for the existing hardware. The cost of David's patch is close to
> > none.
> 
> Do you have any code already? Anyway it is now removed from upstream,
> I will try to get one of these devices myself and start writing some
> code if you don't have it done already.

I first looked to the kernel for support, but found it in user space and
stopped. I'll take a stab a it, with wiimote as a reference -- it really
shouldn't be too hard.

But it'll take a little time -- the device is in use for MythTV, so I
risk a mutiny if I try to test before bedtime... ;)

