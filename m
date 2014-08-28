Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
 <CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
In-reply-to: <CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
Subject: RE: [MAP] obexd/client: Handle MAP event types
Date: Thu, 28 Aug 2014 14:41:05 +0530
Message-id: <000001cfc2a0$0032aa30$0097fe90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
    But in the obexd/client/mns.c 
    Inside parse_event_report_type() function, event types are assigned with the values MAP_ET_MEMORY_FULL and MAP_ET_MEMORY_AVAILABLE.
    It should be handled in the map_handle_notification() inside map.c.

-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Thursday, August 28, 2014 1:27 PM
To: gowtham babu
Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com; Bharat Panda
Subject: Re: [MAP] obexd/client: Handle MAP event types

Hi,

On Thu, Aug 28, 2014 at 8:46 AM, gowtham babu <gowtham.ab@samsung.com> wrote:
> Adds below MCE event types handling in map_handle_notification() 
> MAP_ET_MEMORY_FULL MAP_ET_MEMORY_AVAILABLE
> ---
>  obexd/client/map.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c index 
> 520e492..84feecf 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -1927,6 +1927,12 @@ static void map_handle_notification(struct map_event *event, void *user_data)
>         case MAP_ET_MESSAGE_SHIFT:
>                 map_handle_folder_changed(map, event, event->folder);
>                 break;
> +       case MAP_ET_MEMORY_FULL:
> +               map_handle_status_changed(map, event, "memory-full");
> +               break;
> +       case MAP_ET_MEMORY_AVAILABLE:
> +               map_handle_status_changed(map, event, "memory-available");
> +               break;
>         default:
>                 break;
>         }
> --
> 1.9.1

Those are actually ignored on purpose since there is nothing the applications can do with them, in fact I find it very awkward that it got into MAP spec and in any case this not really work since the handle for those events is not set to a specific message according to the spec page 33:

   '"handle" is not used when the  event "type" is "MemoryFull" or "MemoryAvailable".'

I could be mapped to the session itself but then again how a client is suppose to handle those and is there any server that is sending them.


--
Luiz Augusto von Dentz

