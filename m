Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
Date: Tue, 29 Sep 2009 09:00:50 -0400
Cc: linux-bluetooth@vger.kernel.org
References: <200909251647.15440.sgrubb@redhat.com> <200909281731.00670.sgrubb@redhat.com> <1254181253.2659.27.camel@localhost.localdomain>
In-Reply-To: <1254181253.2659.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200909290900.51115.sgrubb@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 September 2009 07:40:53 pm Marcel Holtmann wrote:
> I quickly looked over the pc.in file and it looks good to me.

Thanks.

> Thanks foradding this. Another question that comes to my mind. Where do you
> have the GIT tree for libcap-ng so we can track the development?

I've never needed to use git - so no git tree. The project has a home page 
here:  http://people.redhat.com/sgrubb/libcap-ng/
and I announce package updates at freshmeat.net. The libcap-ng package is 
stable and I would not have made a release yesterday if it weren't for needing 
to a pc file. I don't forsee much development in libcap-ng unless there are 
updates in the kernel that I need to take into account. IOW, all planned 
features are complete and I'm not tracking any bugs.

 
> > > I like to have capability dropping in bluetoothd, but I do wanna do it
> > > with a proper upstream project.
> > 
> > one other thing I thought I would point out. The patch I sent can make it
> > easy  to run the bluetooth daemon as non-root user. If we switch this
> > line: 
> > capng_apply(CAPNG_SELECT_BOTH);
> > 
> > to
> > 
> > capng_change_id(uid, gid, CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING);
> > 
> > then the job is easier. Of course you would likely need to fixup file 
> > permissions in places, but in theory a non-root bluetooth daemon is
> > possible  with a 1 line change in the patch. You would probably want to
> > add error handling and a way to specify the uid/gid, too.
> 
> I am not really sold on the non-root daemon idea and there might be
> hidden problems where this will not work out. However I don't mind
> trying at some point, but there are other things to sort out first. We
> should postpone this for the 5.x series.

Sure, I just wanted to point out that its a 1 line change in code if you ever 
wanted to do this.


> Please re-send the original patch using pkg-config so I can go ahead an
> apply it. Even if Rawhide is not carrying the updated libcap-ng package.

OK, as soon as I figure out pkg-config. M4 is easier. :)

-Steve
