Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "vinicius.gomes@openbossa.org" <vinicius.gomes@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 29 Apr 2011 18:05:53 +0800
Subject: FW: [PATCH] Check session->msg at sync_getphonebook_callback() in
 file client/sync.c
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47358E27C1B@shsmsx501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:

I will modify the code style and thank you.

> -----Original Message-----
> From: Vinicius Costa Gomes [mailto:vinicius.gomes@openbossa.org]
> Sent: Wednesday, April 27, 2011 2:42 AM
> To: Zheng, Wu
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Check session->msg at sync_getphonebook_callback()
> in file client/sync.c
> 
> Hi,
> 
> On 11:03 Tue 26 Apr, Zheng, Wu wrote:
> > Otherwise,session->msg will be NULL and cause segmentation fault
> error.The reason is that the condition of transfer->fd>0 && session-
> >msg is ok and session->msg will be set to NULL in the func of
> session_notify_progress when sync profile is used.
> 
> Please try to keep your commit title to less than 72 characters (if
> possible
> less than 50) and the commit message to less than 72 characters.
> 
> >
> > ---
> >  client/sync.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/client/sync.c b/client/sync.c
> > index 3622a3d..28ace61 100644
> > --- a/client/sync.c
> > +++ b/client/sync.c
> > @@ -78,6 +78,9 @@ static void sync_getphonebook_callback(struct
> session_data *session,
> >  	DBusMessage *reply;
> >  	char *buf = NULL;
> >
> > +	if (session->msg == NULL)
> > +		goto done;
> > +
> >  	reply = dbus_message_new_method_return(session->msg);
> >
> >  	if (transfer->filled > 0)
> > @@ -91,6 +94,8 @@ static void sync_getphonebook_callback(struct
> session_data *session,
> >  	g_dbus_send_message(session->conn, reply);
> >  	dbus_message_unref(session->msg);
> >  	session->msg = NULL;
> 
> Add an empty line here.
> 
> > +done:
> > +	transfer_unregister(transfer);
> 
> There's a trailing space here.
> 
> Also, taking a look at the code, if the reply is big enough (is it
> possible?),
> the callback could be called more than one time for one transfer, right?
> Seems
> it would cause some unexpected problems.
> 

The callback will only be invoked once when one transfer of sync is completed.

The reason of checking session->msg = NULL is that the func of session_notify_progress will set session->msg = NULL in the process of transferring.

> >  }
> >
> >  static DBusMessage *sync_getphonebook(DBusConnection *connection,
> > --
> > 1.7.3.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> Cheers,
> --
> Vinicius
