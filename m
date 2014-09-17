Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410871803-31373-1-git-send-email-gowtham.ab@samsung.com>
References: <1410871803-31373-1-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 17 Sep 2014 11:27:56 +0300
Message-ID: <CABBYNZLNfm+z_GyPnHvxiUG+pZmpY6QoBrm62LFYENiKx9B=Sg@mail.gmail.com>
Subject: Re: [MAP v4] obexd/client : Handle the MAP Event Report 1.1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 16, 2014 at 3:50 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Currently blueZ supports MAP Event Report 1.0.
> Below is the description of MAP Event Report 1.1
> and the implementation.
>
> The MAP Event report 1.1 has 4 additional attributes than 1.0:
> subject, datetime, sender_name, priority.
>
> MAP Event Report 1.1 supports  new event type
> READ_STATUS_CHANGED to track the message read status.
>
> MAP Event report 1.1:
> 1) Adds below metioned MAP Event report 1.1 attributes:
>    subject, datetime, sender_name, priority.
> 2) Adds READ_STATUS_CHANGED event type.
> 3) Adds the corresponding handlers.
> ---
>  lib/sdp.h                |  2 +-
>  obexd/client/map-event.h |  7 ++++++-
>  obexd/client/mns.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/lib/sdp.h b/lib/sdp.h
> index cc10e9f..76f61e1 100644
> --- a/lib/sdp.h
> +++ b/lib/sdp.h
> @@ -306,7 +306,7 @@ extern "C" {
>  #define SDP_ATTR_MAS_INSTANCE_ID               0x0315
>  #define SDP_ATTR_SUPPORTED_MESSAGE_TYPES       0x0316
>  #define SDP_ATTR_PBAP_SUPPORTED_FEATURES       0x0317
> -#define SDP_ATTR_MAP_SUPPORTED_FEATURES                0x0317
> +#define SDP_ATTR_MAP_SUPPORTED_FEATURES                0x031f
>
>  #define SDP_ATTR_SPECIFICATION_ID              0x0200
>  #define SDP_ATTR_VENDOR_ID                     0x0201
> diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
> index ba5d5d2..99cb0c2 100644
> --- a/obexd/client/map-event.h
> +++ b/obexd/client/map-event.h
> @@ -32,7 +32,8 @@ enum map_event_type {
>         MAP_ET_MEMORY_FULL,
>         MAP_ET_MEMORY_AVAILABLE,
>         MAP_ET_MESSAGE_DELETED,
> -       MAP_ET_MESSAGE_SHIFT
> +       MAP_ET_MESSAGE_SHIFT,
> +       MAP_ET_READ_STATUS_CHANGED
>  };
>
>  struct map_event {
> @@ -41,6 +42,10 @@ struct map_event {
>         char *folder;
>         char *old_folder;
>         char *msg_type;
> +       char *datetime;
> +       char *subject;
> +       char *sender_name;
> +       char *priority;
>  };
>
>  /* Handle notification in map client.
> diff --git a/obexd/client/mns.c b/obexd/client/mns.c
> index 76b7d1c..dbbc434 100644
> --- a/obexd/client/mns.c
> +++ b/obexd/client/mns.c
> @@ -180,6 +180,8 @@ static void parse_event_report_type(struct map_event *event, const char *value)
>                 event->type = MAP_ET_MESSAGE_DELETED;
>         else if (!g_ascii_strcasecmp(value, "MessageShift"))
>                 event->type = MAP_ET_MESSAGE_SHIFT;
> +       else if (!g_ascii_strcasecmp(value, "ReadStatusChanged"))
> +               event->type = MAP_ET_READ_STATUS_CHANGED;
>  }
>
>  static void parse_event_report_handle(struct map_event *event,
> @@ -217,6 +219,34 @@ static void parse_event_report_msg_type(struct map_event *event,
>         event->msg_type = g_strdup(value);
>  }
>
> +static void parse_event_report_date_time(struct map_event *event,
> +                                                       const char *value)
> +{
> +       g_free(event->datetime);
> +       event->datetime = g_strdup(value);
> +}
> +
> +static void parse_event_report_subject(struct map_event *event,
> +                                                       const char *value)
> +{
> +       g_free(event->subject);
> +       event->subject = g_strdup(value);
> +}
> +
> +static void parse_event_report_sender_name(struct map_event *event,
> +                                                       const char *value)
> +{
> +       g_free(event->sender_name);
> +       event->sender_name = g_strdup(value);
> +}
> +
> +static void parse_event_report_priority(struct map_event *event,
> +                                                       const char *value)
> +{
> +       g_free(event->priority);
> +       event->priority = g_strdup(value);
> +}
> +
>  static struct map_event_report_parser {
>         const char *name;
>         void (*func) (struct map_event *event, const char *value);
> @@ -226,6 +256,10 @@ static struct map_event_report_parser {
>                 { "folder", parse_event_report_folder },
>                 { "old_folder", parse_event_report_old_folder },
>                 { "msg_type", parse_event_report_msg_type },
> +               { "datetime", parse_event_report_date_time },
> +               { "subject", parse_event_report_subject },
> +               { "sender_name", parse_event_report_sender_name },
> +               { "priority", parse_event_report_priority },
>                 { }
>  };
>
> @@ -268,6 +302,10 @@ static void map_event_free(struct map_event *event)
>         g_free(event->folder);
>         g_free(event->old_folder);
>         g_free(event->msg_type);
> +       g_free(event->datetime);
> +       g_free(event->subject);
> +       g_free(event->sender_name);
> +       g_free(event->priority);
>         g_free(event);
>  }
>
> --
> 1.9.1

Applied, note that I reworded and remove the changes to SDP there is
no attribute 0x031f in the assigned numbers. Also I removed read
status changed since you where not handling it in this patch so please
resend it once you have the implementation.

-- 
Luiz Augusto von Dentz
