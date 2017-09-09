Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170908221934.11910-1-inga.stotland@intel.com>
References: <20170908221934.11910-1-inga.stotland@intel.com>
From: Laczen JMS <laczenjms@gmail.com>
Date: Sat, 9 Sep 2017 11:07:08 +0200
Message-ID: <CAFxSrVu-vApomoiJzr1CL-_qgdMUcmKWbx1-QdupMY2-ACE4xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Add characteristic property name check
To: Inga Stotland <inga.stotland@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

This solves the issue.

Kind regards,

Jehudi

2017-09-09 0:19 GMT+02:00 Inga Stotland <inga.stotland@intel.com>:
> If PropertyChanged signal is not emitted due to a change in
> characteristic's "Value" property, the characteristic does
> not need to be processed.
> ---
>  mesh/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mesh/main.c b/mesh/main.c
> index 42506a6..3a39d8f 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -1295,8 +1295,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
>                 rl_printf("Characteristic property changed %s\n",
>                                                 g_dbus_proxy_get_path(proxy));
>
> -               if ((connection.type == CONN_TYPE_PROVISION) ||
> -                                                       connection.session_open)
> +               if ((strcmp(name, "Value") == 0) &&
> +                               ((connection.type == CONN_TYPE_PROVISION) ||
> +                                               connection.session_open))
>                         process_mesh_characteristic(proxy);
>         }
>  }
> --
> 2.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
