Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix build with ./configure-bootstrap
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090707233939.5969cf7e@stoetzler>
References: <20090707091325.38dec13a@stoetzler>
	 <1246987312.3384.4.camel@localhost.localdomain>
	 <20090707233939.5969cf7e@stoetzler>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Jul 2009 15:54:08 -0700
Message-Id: <1247007248.3384.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> > > hciops.c: In function ‘hciops_exit’:
> > > hciops.c:728: error: call to function ‘btd_adapter_cleanup_ops’
> > >               without a real prototype
> > > ---
> > >  plugins/hciops.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/plugins/hciops.c b/plugins/hciops.c
> > > index 659f754..6baed76 100644
> > > --- a/plugins/hciops.c
> > > +++ b/plugins/hciops.c
> > > @@ -725,7 +725,7 @@ static int hciops_init(void)
> > >  }
> > >  static void hciops_exit(void)
> > >  {
> > > -	btd_adapter_cleanup_ops(&hci_ops);
> > > +	btd_adapter_cleanup_ops();
> > >  }
> > >  
> > >  BLUETOOTH_PLUGIN_DEFINE(hciops, VERSION,
> > 
> > the subject is not matching the patch and I have no idea what is going
> > on here. I leave this to Johan or Alok to look at.
> 
> The build fails, because of this warning:
> 
> make[3]: Entering directory `/local/seife/src/git-repos/bluez-git/plugins'
>   CC     libbuiltin_la-service.lo
>   CC     libbuiltin_la-hciops.lo
> cc1: warnings being treated as errors
> hciops.c: In function ‘hciops_exit’:
> hciops.c:728: error: call to function ‘btd_adapter_cleanup_ops’ without a real prototype
> ../src/adapter.h:174: note: ‘btd_adapter_cleanup_ops’ was declared here
> 
> The hci_ops are not used by btd_adapter_cleanup_ops (it takes no
> parameter), so I guessed that the above would be a valid fix.
> 
> It is certainly a good idea to have this reviewed by someone who
> actually knows the code (I don't ;)

we fixed it now with bluez-4.45 release, but your patch was actually
wrong. The problems with the prototype with no argument list. Bad C
programming and bad that it slipped through our review.

Regards

Marcel


