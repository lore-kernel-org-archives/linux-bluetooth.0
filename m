Return-Path: <cyrus@holtmann.org>
From: Frieder Buerzele <evermind@tuxfamily.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix segfault: If the interface name is NULL the bluetoothd daemon will crash
Date: Thu, 26 Feb 2009 09:46:46 +0100
Message-Id: <1235638007-22946-1-git-send-email-evermind@tuxfamily.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > Hi Frieder,
> >
> > > ---
> > >  gdbus/object.c |   11 ++++++-----
> > >  1 files changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/gdbus/object.c b/gdbus/object.c
> > > index 0786aeb..d920eac 100644
> > > --- a/gdbus/object.c
> > > +++ b/gdbus/object.c
> > > @@ -224,11 +224,12 @@ static struct interface_data
> > > *find_interface(GSList *interfaces,
> > >  {
> > >  	GSList *list;
> > >  
> > > -	for (list = interfaces; list; list = list->next) {
> > > -		struct interface_data *iface = list->data;
> > > -		if (!strcmp(name, iface->name))
> > > -			return iface;
> > > -	}
> > > +	if (name)
> > > +		for (list = interfaces; list; list = list->next) {
> > > +			struct interface_data *iface = list->data;
> > > +			if (!strcmp(name, iface->name))
> > > +				return iface;
> > > +		}
> > >  
> > >  	return NULL;
> > >  }
> > 
> > what about something like this:
> > 
> > 	if (name == NULL)
> > 			return NULL;
> > 
> > 			Regards
> > 
> > 			Marcel
> > 
> 
> k, I'll resend a updated patch
> 
> Greetz Frieder

just forget to test compile the patch, here is the "fixed" fix patch

Greetz Frieder

