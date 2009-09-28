Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Drop Posix Capabilities
From: Marcel Holtmann <marcel@holtmann.org>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200909281731.00670.sgrubb@redhat.com>
References: <200909251647.15440.sgrubb@redhat.com>
	 <200909261029.06609.sgrubb@redhat.com>
	 <1254083485.2659.14.camel@localhost.localdomain>
	 <200909281731.00670.sgrubb@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 16:40:53 -0700
Message-Id: <1254181253.2659.27.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

> > > > > +AC_DEFUN([LIBCAP_NG_PATH],
> > > > > +[
> > > > > +     AC_ARG_WITH(libcap-ng,
> > > > > +     [ --with-libcap-ng=[auto/yes/no]  Add Libcap-ng support
> > > > > +             [default=auto]],, with_libcap_ng=auto)
> > > > > +
> > > >
> > > > I mention this to Bastien already. I want pkgconfig support here and
> > > > not some old style aclocal magic.
> > >
> > > libcap-ng itself does not provide any pkgconfig support. I'll check on
> > > this.
> > 
> > According to the bug you guys have open for this, you try to fix this
> > upstream in libcap-ng. So please push a pkgconfig file to libcap-ng and
> > then I am more than happy to accept a patch for this.
> 
> The bug report only said pkg-config support might be nice, but it was not 
> specified as a requirement. Anyways, I made a new release of libcap-ng today 
> with a pkg-config file added. There are no other user of that file, so please let 
> me know if something is wrong with it.
> 
> http://people.redhat.com/sgrubb/libcap-ng/libcap-ng-0.6.2.tar.gz

I might have mentioned it only to Bastien, but for me it is a hard
requirement since fiddling around with m4 files is just stupid and
actually pretty much painful. We are in the 21st century and should do
everything nicely with pkg-config :)

I quickly looked over the pc.in file and it looks good to me. Thanks for
adding this. Another question that comes to my mind. Where do you have
the GIT tree for libcap-ng so we can track the development?

> > I like to have capability dropping in bluetoothd, but I do wanna do it
> > with a proper upstream project.
> 
> one other thing I thought I would point out. The patch I sent can make it easy 
> to run the bluetooth daemon as non-root user. If we switch this line:
> 
> capng_apply(CAPNG_SELECT_BOTH);
> 
> to
> 
> capng_change_id(uid, gid, CAPNG_DROP_SUPP_GRP | CAPNG_CLEAR_BOUNDING);
> 
> then the job is easier. Of course you would likely need to fixup file 
> permissions in places, but in theory a non-root bluetooth daemon is possible 
> with a 1 line change in the patch. You would probably want to add error 
> handling and a way to specify the uid/gid, too.

I am not really sold on the non-root daemon idea and there might be
hidden problems where this will not work out. However I don't mind
trying at some point, but there are other things to sort out first. We
should postpone this for the 5.x series.

Please re-send the original patch using pkg-config so I can go ahead an
apply it. Even if Rawhide is not carrying the updated libcap-ng package.

Regards

Marcel


