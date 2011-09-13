Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315885582-20027-1-git-send-email-padovan@profusion.mobi>
References: <1315885582-20027-1-git-send-email-padovan@profusion.mobi>
Date: Tue, 13 Sep 2011 10:19:20 +0300
Message-ID: <CABBYNZLBr+Ygaq8wxV+WEmLXKieUAfVmGNm8yEh=HRhyMcNtYw@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: fix DBus message reply
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Sep 13, 2011 at 6:46 AM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
>
> If reply is NULL we have a crash.
> ---
>  serial/port.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/serial/port.c b/serial/port.c
> index d011084..2cdead4 100644
> --- a/serial/port.c
> +++ b/serial/port.c
> @@ -369,7 +369,7 @@ static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
>        GError *gerr = NULL;
>
>        if (!port->listener_id) {
> -               reply = NULL;
> +               reply = btd_error_failed(port->msg, "No listening application");
>                goto failed;
>        }

If we have no listener at this point we should probably not reply
because either the application has called Disconnect or it has exited
the bus, anyway the port->msg need to be unref.

-- 
Luiz Augusto von Dentz
