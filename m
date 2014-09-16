Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1410851152-15572-1-git-send-email-gowtham.ab@samsung.com>
References: <1410851152-15572-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 16 Sep 2014 10:36:27 +0300
Message-ID: <CABBYNZKLETy7MxCyLs=HkWBDPw5KVamL14cya8kGz2L0tXMPwQ@mail.gmail.com>
Subject: Re: [MAP v3] obexd/client : Handle the MAP Event Report 1.1
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 16, 2014 at 10:05 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Currently blueZ supports MAP Event Report 1.0.
> Below is the description of MAP Event Report 1.1 and the implementation.
>
> MAP Event Reprot 1.0 has only few attributes listed below:
> type, handle, folder, old_folder, msg_type.
>
> But the MAP Event report 1.1 has some extra attributes listed below:
> type, handle, folder, old_folder, msg_type, subject, datetime, sender_name, priority.
>
> Event Report 1.1 will give more useful information to MCE about a message than Event Report 1.0.
> In addition to that a new event type READ_STATUS_CHANGED is introduced in 1.1, which will help MCE to keep track of message read status.

Commit message should follow 50/72 format, please fix the line above.

> 1) In SDP_ATTR_MAP_SUPPORTED_FEATURES, the 'Extended Event Reports 1.1' bit is set.
> 2) The additional attributes in 1.1 (subject, datetime, sender_name, priority) are defined in the map_event.
> 3) New event type MAP_ET_READ_STATUS_CHANGED is also added in map_event.
> 4) The corresponding handlers for (subject, datetime, sender_name, priority) are added in mns

We can figure from the code what you are doing so you can omit this
information, if there is anything not very clear in the code you
should add comment in the code itself.

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
> index 76b7d1c..24392c6 100644
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
> +                                                        const char *value)
> +{
> +       g_free(event->datetime);
> +       event->datetime = g_strdup(value);
> +}
> +
> +static void parse_event_report_subject(struct map_event *event,
> +                                                        const char *value)
> +{
> +       g_free(event->subject);
> +       event->subject = g_strdup(value);
> +}
> +
> +static void parse_event_report_sender_name(struct map_event *event,
> +                                                        const char *value)
> +{
> +       g_free(event->sender_name);
> +       event->sender_name = g_strdup(value);
> +}
> +
> +static void parse_event_report_priority(struct map_event *event,
> +                                                        const char *value)
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

Applying: obexd/client : Handle the MAP Event Report 1.1
ERROR:CODE_INDENT: code indent should use tabs where possible
#57: FILE: obexd/client/mns.c:223:
+                                                        const char *value)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#57: FILE: obexd/client/mns.c:223:
+                                                        const char *value)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#64: FILE: obexd/client/mns.c:230:
+                                                        const char *value)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#64: FILE: obexd/client/mns.c:230:
+                                                        const char *value)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#71: FILE: obexd/client/mns.c:237:
+                                                        const char *value)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#71: FILE: obexd/client/mns.c:237:
+                                                        const char *value)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#78: FILE: obexd/client/mns.c:244:
+                                                        const char *value)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#78: FILE: obexd/client/mns.c:244:
+                                                        const char *value)$

total: 4 errors, 4 warnings, 89 lines checked


-- 
Luiz Augusto von Dentz
