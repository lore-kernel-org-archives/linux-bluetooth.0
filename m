Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20a39652-482a-9fde-6d44-0a8147f156fe@jp.fujitsu.com>
References: <20a39652-482a-9fde-6d44-0a8147f156fe@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Jan 2018 16:16:16 -0200
Message-ID: <CABBYNZ+QaVYh-B08ixqHi=WxZDhj1bshBLgkJOO2NzKEbVuvKA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] obexd: Emit file information for client
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Mon, Jan 15, 2018 at 10:46 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> When running obexctl and then starting to transfer a file, it does not
> retrieve the Size property correctly. Thus it prints out the huge
> remaining time as below:
>
>   [NEW] Transfer /org/bluez/obex/server/session1/transfer0
>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Status: active
>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 32683 (@32KB/s 4286681714:4294967273)
>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 65444 (@32KB/s 428259:59)
>
> And the info command only prints out the Session/Status/Size/Transferred
> properties and does not print out the others as below:
>
>   # info /org/bluez/obex/server/session1/transfer0
>   Transfer /org/bluez/obex/server/session1/transfer0
>           Session: /org/bluez/obex/server/session1
>           Status: active
>           Size: 18446744073709551614
>           Transferred: 262010
>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 294771 (@32KB/s 428259:52)

I think the idea was to omit the Size in case the header has not been
read, or is not available, though perhaps that needs fixing in both
obexd really omit if the size is 0 and perhaps disable progress if the
size is unknown. The documentation already indicates Size is optional
but the implementation does not add a exists callback, but Im not sure
why that would appear as the value above instead of 0.

> This change makes obexd emit the all properties, including the Size
> property, since the first info command may not print out the all
> properties if changing obexctl.
> ---
>  obexd/src/manager.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 78b138c85..6c83479f4 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -533,10 +533,15 @@ void manager_cleanup(void)
>
>  void manager_emit_transfer_started(struct obex_transfer *transfer)
>  {
> +       const GDBusPropertyTable *property;
> +
>         transfer->status = TRANSFER_STATUS_ACTIVE;
>
> -       g_dbus_emit_property_changed(connection, transfer->path,
> -                                       TRANSFER_INTERFACE, "Status");
> +       for (property = transfer_properties;
> +                               property && property->name; property++)
> +               g_dbus_emit_property_changed(connection, transfer->path,
> +                                               TRANSFER_INTERFACE,
> +                                               property->name);
>  }
>
>  static void emit_transfer_completed(struct obex_transfer *transfer,
> --
> 2.14.1
>



-- 
Luiz Augusto von Dentz
