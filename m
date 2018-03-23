Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180322200755.21972-1-szymon.janc@codecoup.pl>
References: <20180322200755.21972-1-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 23 Mar 2018 13:34:19 +0200
Message-ID: <CABBYNZ+8RPhGisthAZrepxSES4aa2xG0NmeuT5UAyz24C40=yw@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fail to register service with invalid Includes property
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 22, 2018 at 10:07 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> This is optional property but if it is present it must be of
> proper type.
> ---
>  src/gatt-database.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index a22fc3b85..19f03c544 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -1676,6 +1676,7 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
>         DBusMessageIter array;
>         char *obj;
>
> +       /* Includes property is optional */
>         if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
>                 return true;
>
> @@ -2682,8 +2683,10 @@ static bool database_add_service(struct external_service *service)
>                 return false;
>         }
>
> -       if (!parse_includes(service->proxy, service))
> +       if (!parse_includes(service->proxy, service)) {
>                 error("Failed to read \"Includes\" property of service");
> +               return false;
> +       }
>
>         service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
>                                                 primary, service->attr_cnt);
> --
> 2.14.3

Applied, thanks.

-- 
Luiz Augusto von Dentz
