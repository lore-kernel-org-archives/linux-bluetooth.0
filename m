Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1374030918-1730-1-git-send-email-martin.xu@linux.intel.com>
References: <1374030918-1730-1-git-send-email-martin.xu@linux.intel.com>
Date: Wed, 17 Jul 2013 11:17:37 +0300
Message-ID: <CABBYNZ+9z--2pE6=uBBxVC7F4cJ6dx-8MjYHyk_t+Z-cThg2uw@mail.gmail.com>
Subject: Re: [PATCH] obexd/session: Do not check session->driver->uuid in get_target()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: martin.xu@linux.intel.com
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Wed, Jul 17, 2013 at 6:15 AM,  <martin.xu@linux.intel.com> wrote:
> From: Martin Xu <martin.xu@linux.intel.com>
>
> since it already be checked at target_exists(), so if session->driver->uuid
> is NULL get_target() should not be called.
> ---
>  obexd/client/session.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 44e2bf8..361c921 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -680,9 +680,6 @@ static gboolean get_target(const GDBusPropertyTable *property,
>  {
>         struct obc_session *session = data;
>
> -       if (session->driver->uuid == NULL)
> -               return FALSE;
> -
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
>                                                 &session->driver->uuid);
>
> --
> 1.7.10.4

This is used as a safe guard to avoid any chance that NULL is passed
to dbus_message_iter_append_basic in case get_target is called from
another context, it isn't the case here but it is consistent with
other parts of the code.


--
Luiz Augusto von Dentz
