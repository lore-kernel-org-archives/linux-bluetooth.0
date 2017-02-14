Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170214092750.5528-1-sskcorea@gmail.com>
References: <20170214092750.5528-1-sskcorea@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Feb 2017 20:19:39 +0200
Message-ID: <CABBYNZJLXHn9jXrtuvona1AXZFDG8XYPuVpUty48f5Shj-ukWw@mail.gmail.com>
Subject: Re: [PATCH] client: fix calling ad_unregister
To: Seulki Shin <sskcorea@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Feb 14, 2017 at 11:27 AM, Seulki Shin <sskcorea@gmail.com> wrote:
> From: SeulKi Shin <sskcorea@gmail.com>
>
> ad_register shall only be called in case the advertise command has been
> called so registered flag should be checked before calling
> UnregisterAdvertisement.
>
> Signed-off-by: SeulKi Shin <sskcorea@gmail.com>

We don't use Signed-off-by line in userspace.

> ---
>  client/advertising.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index 62201d5..81fa851 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -317,6 +317,9 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
>         if (!manager)
>                 ad_release(conn);
>
> +       if (!registered)
> +               return;
> +
>         if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
>                                         unregister_setup, unregister_reply,
>                                         conn, NULL) == FALSE) {
> --
> 2.7.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
