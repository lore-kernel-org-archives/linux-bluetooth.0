Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200909290900.51115.sgrubb@redhat.com>
References: <200909251647.15440.sgrubb@redhat.com>
	 <200909281731.00670.sgrubb@redhat.com>
	 <1254181253.2659.27.camel@localhost.localdomain>
	 <200909290900.51115.sgrubb@redhat.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 11:03:46 -0700
Message-Id: <1254247426.2659.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> > Thanks foradding this. Another question that comes to my mind. Where do you
> > have the GIT tree for libcap-ng so we can track the development?
> 
> I've never needed to use git - so no git tree. The project has a home page 
> here:  http://people.redhat.com/sgrubb/libcap-ng/
> and I announce package updates at freshmeat.net. The libcap-ng package is 
> stable and I would not have made a release yesterday if it weren't for needing 
> to a pc file. I don't forsee much development in libcap-ng unless there are 
> updates in the kernel that I need to take into account. IOW, all planned 
> features are complete and I'm not tracking any bugs.

from a security point of it is nice if you have a source code repository
with version tracking. Only thinking about your security team if
something might happen :)
 
> > > > I like to have capability dropping in bluetoothd, but I do wanna do it
> > > > with a proper upstream project.
> > > 
> > > one other thing I thought I would point out. The patch I sent can make it
> > > easy  to run the bluetooth daemon as non-root user. If we switch this
> > > line: 
> > > capng_apply(CAPNG_SELECT_BOTH);
> > > 
> > > to
> > > 
> > > capng_change_id(uid, gid, CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING);
> > > 
> > > then the job is easier. Of course you would likely need to fixup file 
> > > permissions in places, but in theory a non-root bluetooth daemon is
> > > possible  with a 1 line change in the patch. You would probably want to
> > > add error handling and a way to specify the uid/gid, too.
> > 
> > I am not really sold on the non-root daemon idea and there might be
> > hidden problems where this will not work out. However I don't mind
> > trying at some point, but there are other things to sort out first. We
> > should postpone this for the 5.x series.
> 
> Sure, I just wanted to point out that its a 1 line change in code if you ever 
> wanted to do this.
> 
> 
> > Please re-send the original patch using pkg-config so I can go ahead an
> > apply it. Even if Rawhide is not carrying the updated libcap-ng package.
> 
> OK, as soon as I figure out pkg-config. M4 is easier. :)

But the number of people who can read M4 getting less and less. I can
read it, but then nobody else inside the team will have a real clue.
Just send me a patch without the pkg-config magic and I can add that for
you after I applied the patch.

Regards

Marcel


