Return-Path: <cyrus@holtmann.org>
Date: Tue, 12 Aug 2014 10:57:56 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 10/10] obexd: Fix possible NULL dereference
Message-ID: <20140812075754.GD10034@aemeltch-MOBL1>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1407743445-1329-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20140811133720.GB28382@t440s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140811133720.GB28382@t440s>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Aug 11, 2014 at 04:37:20PM +0300, Johan Hedberg wrote:
> Hi Andrei,
> 
> On Mon, Aug 11, 2014, Andrei Emeltchenko wrote:
> > In a case snprintf fails we have NULL dereference. Fixes clang warnings
> > below:
> > ...
> > obexd/client/map.c:471:9: warning: Access to field 'message' results in
> > a dereference of a null pointer (loaded from variable 'err')
> >                                                            err->message);
> >                                                            ^~~~~~~~~~~~
> > obexd/client/map.c:772:9: warning: Access to field 'message' results in
> > a dereference of a null pointer (loaded from variable 'err')
> >                                                            err->message);
> >                                                            ^~~~~~~~~~~~
> > ...
> > ---
> >  obexd/client/map.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I've applied patches 3-9 (1 & 2 already had feedback). This one needs a
> bit more consideration too:
> 
> > diff --git a/obexd/client/map.c b/obexd/client/map.c
> > index 47afc31..ed535e2 100644
> > --- a/obexd/client/map.c
> > +++ b/obexd/client/map.c
> > @@ -468,7 +468,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
> >  
> >  fail:
> >  	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
> > -								err->message);
> > +						err ? err->message : "");
> >  	g_error_free(err);
> >  	return reply;
> >  }
> > @@ -769,7 +769,7 @@ static void set_status(const GDBusPropertyTable *property,
> >  
> >  fail:
> >  	g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed", "%s",
> > -								err->message);
> > +						err ? err->message : "");
> >  	g_error_free(err);
> >  }
> 
> It seems to me that the only code path that can lead to err being still
> NULL is this one:
> 
>         if (snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle) < 0)
>                 goto fail;
> 
> All others should have err != NULL. I don't really see how snprintf
> could ever fail in this case, so probably the simplest solution would be
> to just remove the error check there?

OK, I will remove check.

Best regards 
Andrei Emeltchenko 

