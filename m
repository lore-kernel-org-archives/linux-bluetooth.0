Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
 <1410441607-9687-2-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZKURNPgJ+MYv+yFrtYTo7b+OFejWY2LqgsT9zgEk5a3zw@mail.gmail.com>
In-reply-to: <CABBYNZKURNPgJ+MYv+yFrtYTo7b+OFejWY2LqgsT9zgEk5a3zw@mail.gmail.com>
Subject: RE: [PATCH 2/7] obexd/client/map : Handle MAP ReadStatusChanged event
 type
Date: Fri, 12 Sep 2014 19:13:37 +0530
Message-id: <000401cfce8f$a3392470$e9ab6d50$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, September 12, 2014 2:30 AM
> To: Gowtham Anandha Babu
> Cc: linux-bluetooth@vger.kernel.org; Dmitry Kasatkin; Bharat Panda;
> cpgs@samsung.com
> Subject: Re: [PATCH 2/7] obexd/client/map : Handle MAP
> ReadStatusChanged event type
> 
> Hi,
> 
> On Thu, Sep 11, 2014 at 4:20 PM, Gowtham Anandha Babu
> <gowtham.ab@samsung.com> wrote:
> > Adds ReadStatusChanged MCE event type handling in
> > map_handle_notification()
> > ---
> >  obexd/client/map.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/obexd/client/map.c b/obexd/client/map.c index
> > 520e492..a505707 100644
> > --- a/obexd/client/map.c
> > +++ b/obexd/client/map.c
> > @@ -1872,6 +1872,25 @@ static void map_handle_status_changed(struct
> map_data *map,
> >
> > "Status");  }
> >
> > +static void map_handle_read_status_changed(struct map_data *map,
> > +                                                        struct
> > +map_event *event) {
> > +       struct map_msg *msg;
> > +
> > +       msg = g_hash_table_lookup(map->messages, &event->handle);
> > +       if (msg == NULL)
> > +               return;
> > +
> > +       /* In MAP V 1.2 specification : ReadStatusChanged event didn't have
> clear explaination.
> > +       So as of now it will set the message read status as "yes" if it was "no"
> already
> > +       and the other way round. This implementation may change once
> > + we get 'read' attribute in the event report. */
> 
> The coding style for multi-line comment is wrong, please check our coding
> style there is a specific chapter for it, and to be honest I did not get it why we
> are toggling the value if it is not clearly explained, btw there is a typo there,
> perhaps you should check against the test specification if there is any test
> regarding that or any errata documenting the behavior.
> 
> > +       if(msg->flags & MAP_MSG_FLAG_READ)
> > +               parse_read(msg,"no");
> > +       else
> > +               parse_read(msg,"yes"); }
> > +
> >  static void map_handle_folder_changed(struct map_data *map,
> >                                                         struct map_event *event,
> >                                                         const char
> > *folder) @@ -1927,6 +1946,9 @@ static void
> map_handle_notification(struct map_event *event, void *user_data)
> >         case MAP_ET_MESSAGE_SHIFT:
> >                 map_handle_folder_changed(map, event, event->folder);
> >                 break;
> > +       case MAP_ET_READ_STATUS_CHANGED:
> > +               map_handle_read_status_changed(map, event);
> > +               break;
> >         default:
> >                 break;
> >         }
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-bluetooth" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Luiz Augusto von Dentz

I will send the updated patch with proper multi-line comment following the coding style and with modification(if any).

Btw,
As per the specification: Pg.no : 35 on MAP 1.2 spec
"ReadStatusChanged: indicates that the 'read' status of a message (see 3.1.6) has
been changed on the MSE. " 

But the actual Event Report which was provided as test case in PTS tool was:

<MAP-event-report version = "1.1">
<event type = "ReadStatusChanged" handle = "12345678" folder =
"TELECOM/MSG/INBOX" msg_type = "SMS_CDMA" subject = "Hello" datetime =
"20110221T130510" sender_name = "Jamie" priority = "yes" />
</MAP-event-report>

>From the above event report 1.1, we cannot retrieve the read status of a message. 

ReadStatusChanged event is received by the MCE only if the previous read status has been changed in the MSE device. 

There are two approaches we may follow:

1) We have to toggle the read status whenever we get the ReadstatusChanged event.
2) Or simply we can call parse_read() function without toggling as show below, because the only way read status can change is from unread to read. 

Instead of if else , we can have a single line implementation : 

parse_read(msg,"yes");

What do you think?

Regards,
Gowtham Anandha Babu



