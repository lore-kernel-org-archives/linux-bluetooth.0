Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
References: <1409204803-3705-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 28 Aug 2014 10:57:14 +0300
Message-ID: <CABBYNZJaruAHM3sAg6msQyvgGj=_+CehXmEmGzOt4gjE_b+10w@mail.gmail.com>
Subject: Re: [MAP] obexd/client: Handle MAP event types
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: gowtham babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 28, 2014 at 8:46 AM, gowtham babu <gowtham.ab@samsung.com> wrote:
> Adds below MCE event types handling in map_handle_notification()
> MAP_ET_MEMORY_FULL
> MAP_ET_MEMORY_AVAILABLE
> ---
>  obexd/client/map.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 520e492..84feecf 100644
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

Those are actually ignored on purpose since there is nothing the
applications can do with them, in fact I find it very awkward that it
got into MAP spec and in any case this not really work since the
handle for those events is not set to a specific message according to
the spec page 33:

   '"handle" is not used when the  event "type" is "MemoryFull" or
"MemoryAvailable".'

I could be mapped to the session itself but then again how a client is
suppose to handle those and is there any server that is sending them.


-- 
Luiz Augusto von Dentz
