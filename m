Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346928807-17149-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346928807-17149-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 6 Sep 2012 10:56:25 -0300
Message-ID: <CAKT1EBdHL8q-sm=ibqZFoTFYtzeNTVHjB2wvoFBS=zHrb7xyxQ@mail.gmail.com>
Subject: Re: [PATCH] gatt: Remove reading Service Changed characteristic after connected
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej:

On Thu, Sep 6, 2012 at 7:53 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Service Changed characteristic is a control-point attribute thus it cannot be
> read and attempting to do so will fail. Instead, server shall send indication
> once enabled in CCC.
> ---
>  profiles/gatt/gas.c | 37 -------------------------------------
>  1 file changed, 37 deletions(-)
>
> diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
> index 28d7fbf..d189221 100644
> --- a/profiles/gatt/gas.c
> +++ b/profiles/gatt/gas.c
> @@ -161,37 +161,6 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
>         btd_device_gatt_set_service_changed(gas->device, start, end);
>  }
>
> -static void gatt_service_changed_cb(guint8 status, const guint8 *pdu,
> -                                       guint16 plen, gpointer user_data)
> -{
> -       struct gas *gas = user_data;
> -       uint16_t start, end;
> -
> -       if (status) {
> -               error("Read GATT Service Changed failed: %s",
> -                                               att_ecode2str(status));
> -               return;
> -       }
> -
> -       if (plen != 5) {
> -               error("Service Changed: PDU length mismatch");
> -               return;
> -       }
> -
> -       start = att_get_u16(&pdu[1]);
> -       end = att_get_u16(&pdu[3]);
> -
> -       if (gas->changed.start == start && gas->changed.end == end)
> -               return;
> -
> -       gas->changed.start = start;
> -       gas->changed.end = end;
> -
> -       DBG("GATT Service Changed start: 0x%04X end: 0x%04X", start, end);
> -
> -       btd_device_gatt_set_service_changed(gas->device, start, end);
> -}
> -
>  static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
>                                                         gpointer user_data)
>  {
> @@ -311,8 +280,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>         /* TODO: Read other GAP characteristics - See Core spec page 1739 */
>
>         /*
> -        * Always read the characteristic value in the first connection
> -        * since attribute handles caching is not supported at the moment.
>          * When re-connecting <<Service Changed>> handle and characteristic
>          * value doesn't need to read again: known information from the
>          * previous interaction.
> @@ -322,10 +289,6 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>
>                 bt_uuid16_create(&uuid, GATT_CHARAC_SERVICE_CHANGED);
>
> -               gatt_read_char_by_uuid(gas->attrib, gas->gatt.start,
> -                                               gas->gatt.end, &uuid,
> -                                               gatt_service_changed_cb, gas);
> -
>                 gatt_discover_char(gas->attrib, gas->gatt.start, gas->gatt.end,
>                                         &uuid, gatt_characteristic_cb, gas);
>         }
> --
> 1.7.11.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

As discussed in the IRC, please add in the commit message the BT SPEC
errata information/section.

Since we can't read the characteristic value, it will be necessary to
store the handle, otherwise BlueZ will loose the Service Changed
Indication when re-connecting.

Regards,
Claudio
