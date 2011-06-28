Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309210781-2674-6-git-send-email-dmitriy.paliy@nokia.com>
References: <1309210781-2674-1-git-send-email-dmitriy.paliy@nokia.com>
	<1309210781-2674-6-git-send-email-dmitriy.paliy@nokia.com>
Date: Tue, 28 Jun 2011 10:48:11 +0300
Message-ID: <BANLkTi=pJhVwZaKszrPGSg4aQezd77d+xQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] Add FindAdapter method call to obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Dmitriy Paliy <dmitriy.paliy@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Tue, Jun 28, 2011 at 12:39 AM, Dmitriy Paliy <dmitriy.paliy@gmail.com> wrote:
> ---
>  client/session.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 423eb8c..d8e3bf2 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -848,11 +848,21 @@ proceed:
>        callback->func = function;
>        callback->data = user_data;
>
> -       req = send_method_call(session->conn_system,
> +       if (source) {
> +               req = send_method_call(session->conn_system,
> +                               BT_BUS_NAME, BT_PATH,
> +                               BT_MANAGER_IFACE, "FindAdapter",
> +                               manager_reply, callback,
> +                               DBUS_TYPE_STRING, &source,
> +                               DBUS_TYPE_INVALID);
> +       } else {
> +               req = send_method_call(session->conn_system,
>                                BT_BUS_NAME, BT_PATH,
>                                BT_MANAGER_IFACE, "DefaultAdapter",
>                                manager_reply, callback,
>                                DBUS_TYPE_INVALID);
> +       }
> +
>        if (!req) {
>                session_unref(session);
>                g_free(callback);
> --
> 1.7.4.1

I guess this one belong to the same patch where DefaultAdapter call
was introduced since it actually fix requesting the session to the
wrong adapter in case it the address is not from the default.


-- 
Luiz Augusto von Dentz
