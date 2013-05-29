Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369744633-8980-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Wed, 29 May 2013 03:30:41 -0700
Message-ID: <CABBYNZ+bfZkhD6FOdgw7oyCj6fZiMpJA6VCSuMe1UdJWMe0LqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] obexd: Queue session commands
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, May 28, 2013 at 5:37 AM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> - v2: Split patches, remove void *process_data from pending_request,
>       adapt names as requested
> ---
>
> So far only transfers are queued in OBEX sessions. Commands like setpath
> are not queued and the commands will simply fail when a different
> operation or transfer is ongoing. This patch set removes this limitation and
> queues commands as well.
>
> Currently, the MAP client is directly affected by this limitation.
> An immediate call to SetPath after the MAP connection has been established
> reliably fails, because MNS is being connected in the background in parallel.
>
> Christian Fetzer (9):
>   obexd: Add process callback to session's pending_request
>   obexd: Add session_queue_add
>   obexd: Use process callback to queue transfers
>   obexd: Queue setpath command
>   obexd: Add file_data struct to session
>   obexd: Queue mkdir command
>   obexd: Queue copy command
>   obexd: Queue move command
>   obexd: Queue delete command
>
>  obexd/client/session.c | 296 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 201 insertions(+), 95 deletions(-)
>
> --
> 1.8.2.3

Pushed, note that I did some modifications so that the destroy is the
last parameter of pending_request_new, this is usual practice for
destroy callbacks.

Thanks for your contribution.

--
Luiz Augusto von Dentz
