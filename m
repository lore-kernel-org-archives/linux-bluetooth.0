Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1410871803-31373-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZLNfm+z_GyPnHvxiUG+pZmpY6QoBrm62LFYENiKx9B=Sg@mail.gmail.com>
In-reply-to: <CABBYNZLNfm+z_GyPnHvxiUG+pZmpY6QoBrm62LFYENiKx9B=Sg@mail.gmail.com>
Subject: RE: [MAP v4] obexd/client : Handle the MAP Event Report 1.1
Date: Wed, 17 Sep 2014 16:12:40 +0530
Message-id: <001101cfd264$1c5a3470$550e9d50$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Wednesday, September 17, 2014 1:58 PM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [MAP v4] obexd/client : Handle the MAP Event Report 1.1
> 
> Hi,
> 
> On Tue, Sep 16, 2014 at 3:50 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Currently blueZ supports MAP Event Report 1.0.
> > Below is the description of MAP Event Report 1.1 and the
> > implementation.
> >
> > The MAP Event report 1.1 has 4 additional attributes than 1.0:
> > subject, datetime, sender_name, priority.
> >
> > MAP Event Report 1.1 supports  new event type READ_STATUS_CHANGED
> to
> > track the message read status.
> >
> > MAP Event report 1.1:
> > 1) Adds below metioned MAP Event report 1.1 attributes:
> >    subject, datetime, sender_name, priority.
> > 2) Adds READ_STATUS_CHANGED event type.
> > 3) Adds the corresponding handlers.
> > ---
> >  lib/sdp.h                |  2 +-
> >  obexd/client/map-event.h |  7 ++++++-
> >  obexd/client/mns.c       | 38
> ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/sdp.h b/lib/sdp.h
> > index cc10e9f..76f61e1 100644
> > --- a/lib/sdp.h
> > +++ b/lib/sdp.h
> > @@ -306,7 +306,7 @@ extern "C" {
> >  #define SDP_ATTR_MAS_INSTANCE_ID               0x0315
> >  #define SDP_ATTR_SUPPORTED_MESSAGE_TYPES       0x0316
> >  #define SDP_ATTR_PBAP_SUPPORTED_FEATURES       0x0317
> > -#define SDP_ATTR_MAP_SUPPORTED_FEATURES                0x0317
> > +#define SDP_ATTR_MAP_SUPPORTED_FEATURES                0x031f
> >
> >  #define SDP_ATTR_SPECIFICATION_ID              0x0200
> >  #define SDP_ATTR_VENDOR_ID                     0x0201
> > diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h index
> > ba5d5d2..99cb0c2 100644
> > --- a/obexd/client/map-event.h
> > +++ b/obexd/client/map-event.h
> > @@ -32,7 +32,8 @@ enum map_event_type {
> >         MAP_ET_MEMORY_FULL,
> >         MAP_ET_MEMORY_AVAILABLE,
> >         MAP_ET_MESSAGE_DELETED,
> > -       MAP_ET_MESSAGE_SHIFT
> > +       MAP_ET_MESSAGE_SHIFT,
> > +       MAP_ET_READ_STATUS_CHANGED
> >  };
> >
> >  struct map_event {
> > @@ -41,6 +42,10 @@ struct map_event {
> >         char *folder;
> >         char *old_folder;
> >         char *msg_type;
> > +       char *datetime;
> > +       char *subject;
> > +       char *sender_name;
> > +       char *priority;
> >  };
> >
> >  /* Handle notification in map client.
> > diff --git a/obexd/client/mns.c b/obexd/client/mns.c index
> > 76b7d1c..dbbc434 100644
> > --- a/obexd/client/mns.c
> > +++ b/obexd/client/mns.c
> > @@ -180,6 +180,8 @@ static void parse_event_report_type(struct
> map_event *event, const char *value)
> >                 event->type = MAP_ET_MESSAGE_DELETED;
> >         else if (!g_ascii_strcasecmp(value, "MessageShift"))
> >                 event->type = MAP_ET_MESSAGE_SHIFT;
> > +       else if (!g_ascii_strcasecmp(value, "ReadStatusChanged"))
> > +               event->type = MAP_ET_READ_STATUS_CHANGED;
> >  }
> >
> >  static void parse_event_report_handle(struct map_event *event, @@
> > -217,6 +219,34 @@ static void parse_event_report_msg_type(struct
> map_event *event,
> >         event->msg_type = g_strdup(value);  }
> >
> > +static void parse_event_report_date_time(struct map_event *event,
> > +                                                       const char
> > +*value) {
> > +       g_free(event->datetime);
> > +       event->datetime = g_strdup(value); }
> > +
> > +static void parse_event_report_subject(struct map_event *event,
> > +                                                       const char
> > +*value) {
> > +       g_free(event->subject);
> > +       event->subject = g_strdup(value); }
> > +
> > +static void parse_event_report_sender_name(struct map_event *event,
> > +                                                       const char
> > +*value) {
> > +       g_free(event->sender_name);
> > +       event->sender_name = g_strdup(value); }
> > +
> > +static void parse_event_report_priority(struct map_event *event,
> > +                                                       const char
> > +*value) {
> > +       g_free(event->priority);
> > +       event->priority = g_strdup(value); }
> > +
> >  static struct map_event_report_parser {
> >         const char *name;
> >         void (*func) (struct map_event *event, const char *value); @@
> > -226,6 +256,10 @@ static struct map_event_report_parser {
> >                 { "folder", parse_event_report_folder },
> >                 { "old_folder", parse_event_report_old_folder },
> >                 { "msg_type", parse_event_report_msg_type },
> > +               { "datetime", parse_event_report_date_time },
> > +               { "subject", parse_event_report_subject },
> > +               { "sender_name", parse_event_report_sender_name },
> > +               { "priority", parse_event_report_priority },
> >                 { }
> >  };
> >
> > @@ -268,6 +302,10 @@ static void map_event_free(struct map_event
> *event)
> >         g_free(event->folder);
> >         g_free(event->old_folder);
> >         g_free(event->msg_type);
> > +       g_free(event->datetime);
> > +       g_free(event->subject);
> > +       g_free(event->sender_name);
> > +       g_free(event->priority);
> >         g_free(event);
> >  }
> >
> > --
> > 1.9.1
> 
> Applied, note that I reworded and remove the changes to SDP there is no
> attribute 0x031f in the assigned numbers. Also I removed read status
> changed since you where not handling it in this patch so please resend it
> once you have the implementation.
> 
> --
> Luiz Augusto von Dentz

Regarding the implementation of the ReadStatusChanged event:

As per the specification: Pg.no : 35 on MAP 1.2 spec
"ReadStatusChanged: indicates that the 'read' status of a message (see 3.1.6) has been changed on the MSE. " 

But the actual Event Report which was provided as test case in PTS tool was:

<MAP-event-report version = "1.1">
<event type = "ReadStatusChanged" handle = "12345678" folder = "TELECOM/MSG/INBOX" msg_type = "SMS_CDMA" subject = "Hello" datetime = "20110221T130510" sender_name = "Jamie" priority = "yes" /> 
</MAP-event-report>

>From the above event report 1.1, we cannot retrieve the read status of a message. But we need update the read status in MCE. 

For SMS,MMS - Only way the read status can change is from unread to read.
For Email - Here the read status can change from read to unread and vice versa.
So, we need to  toggle the read status, whenever we get the ReadstatusChanged event.
Implementation of the ReadStatusChanged event handler in "obexd/client/map" is shown below:

static void map_handle_read_status_changed(struct map_data *map, struct  map_event *event)
 {
	struct map_msg *msg;
	msg = g_hash_table_lookup(map->messages, &event->handle);
	if (msg == NULL)
		return;
	if(msg->flags & MAP_MSG_FLAG_READ)
		parse_read(msg,"no");
	else
		parse_read(msg,"yes");
 }

What is your suggestion?

Regards,
Gowtham Anandha Babu

