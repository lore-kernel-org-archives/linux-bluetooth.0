Return-Path: <cyrus@holtmann.org>
Message-ID: <1349103234.23068.6.camel@aeonflux>
Subject: Re: [PATCH BlueZ] build: Fix out-of-tree builds
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 01 Oct 2012 16:53:54 +0200
In-Reply-To: <CAJdJm_PpVLw6vC4Bf9gkjtpv9Fsx48-QFBoDAtWiBK9j47qE+w@mail.gmail.com>
References: <1348861411-31555-1-git-send-email-anderson.lizardo@openbossa.org>
	 <1349073517.13371.43.camel@aeonflux>
	 <CAJdJm_PpVLw6vC4Bf9gkjtpv9Fsx48-QFBoDAtWiBK9j47qE+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> >>  profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
> >> -     $(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
> >> +     $(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
> >>
> >>  profiles/input/suspend.c: profiles/input/@HOG_SUSPEND_DRIVER@
> >>       $(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
> >
> > personally I am no longer a big fan of these selection of a specific
> > driver. We should be able to build all of them and make the selection at
> > runtime. So there is more work needed here.
> 
> I agree, this could also help on testing as well (actually, all
> drivers are built, regardless of which one was selected by configure,
> but only the selected object is linked).
> 
> What do you propose? a config file option, e.g. "sap_driver=u8500" ,
> "hog_suspend_driver=dummy" , etc (this could fit of the INI config
> format proposal).

something like that. I have no clear idea. So just go ahead and propose
a patch set for it. We then can review it.

Regards

Marcel


