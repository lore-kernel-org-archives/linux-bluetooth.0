Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>,
	'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>,
	'Bharat Panda' <bharat.panda@samsung.com>, cpgs@samsung.com
References: <1410441607-9687-1-git-send-email-gowtham.ab@samsung.com>
 <20140911163752.GA27789@t440s>
 <CABBYNZJJGeaaPU7mgBCBzCVee9qUB6JXiE3m9-O_-+UUsB9CuA@mail.gmail.com>
In-reply-to: <CABBYNZJJGeaaPU7mgBCBzCVee9qUB6JXiE3m9-O_-+UUsB9CuA@mail.gmail.com>
Subject: RE: [PATCH 1/7] obexd/client : Handle the MAP Extended Event Report 1.1
Date: Fri, 12 Sep 2014 19:19:00 +0530
Message-id: <000501cfce90$6a7293a0$3f57bae0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Friday, September 12, 2014 2:16 AM
> To: Gowtham Anandha Babu; linux-bluetooth@vger.kernel.org; Dmitry
> Kasatkin; Bharat Panda; cpgs@samsung.com
> Subject: Re: [PATCH 1/7] obexd/client : Handle the MAP Extended Event
> Report 1.1
> 
> Hi,
> 
> On Thu, Sep 11, 2014 at 7:37 PM, Johan Hedberg
> <johan.hedberg@gmail.com> wrote:
> > Hi,
> >
> > On Thu, Sep 11, 2014, Gowtham Anandha Babu wrote:
> >>  struct map_event {
> >> @@ -41,6 +42,10 @@ struct map_event {
> >>       char *folder;
> >>       char *old_folder;
> >>       char *msg_type;
> >> +     char *datetime;
> >> +     char *subject;
> >> +     char *sender_name;
> >> +     char *priority;
> >>  };
> > <snip>
> >> +static void parse_event_report_date_time(struct map_event *event,
> >> +                                                        const char
> >> +*value) {
> >> +     event->datetime = g_strdup(value); }
> >> +
> >> +static void parse_event_report_subject(struct map_event *event,
> >> +                                                        const char
> >> +*value) {
> >> +     event->subject = g_strdup(value); }
> >> +
> >> +static void parse_event_report_sender_name(struct map_event
> *event,
> >> +                                                        const char
> >> +*value) {
> >> +     event->sender_name = g_strdup(value); }
> >> +
> >> +static void parse_event_report_priority(struct map_event *event,
> >> +                                                        const char
> >> +*value) {
> >> +     event->priority = g_strdup(value); }
> >
> > Where are all these freed? Don't you need to update the
> > map_event_free() function? If you're not yet doing so, please always
> > test your code with "valgrind --leak-check=full".
> 
> And it is mentioned in the HACKING document.
> 
> --
> Luiz Augusto von Dentz

I had sent the updated patch with  freeing all the event attributes and tested with valgrind(No leak). Please have a look at it.

Regards,

Gowtham Anandha Babu




