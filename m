Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1511534342.16445.52.camel@ewol.com>
References: <1511534342.16445.52.camel@ewol.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Nov 2017 17:10:23 +0200
Message-ID: <CABBYNZKLGjucdGxWJ-771MPc6xZnE9GWnaPUpdqbUX=vCaz1aA@mail.gmail.com>
Subject: Re: [RFC]Mesh: meshctl configuration output fails in gatt.c:pipe_write
To: Steve Brown <sbrown@cortland.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Fri, Nov 24, 2017 at 4:39 PM, Steve Brown <sbrown@cortland.com> wrote:
> If the first command output in a new connection exceeds 20 bytes,
> mesh_gatt_write sets the SAR to FIRST as the write_mtu is initially 0
> and the default is GATT_MTU-3 (20).
>
> When pipe_write gets called, a new larger write_mtu has been set, but
> the SAR is still set to FIRST. It's assumed that data->gatt_len >
> max_len. However, it's not which causes lots of bogus output.
>
> I've added code to reset the SAR and length in acquire_write_reply in
> case write_mtu might have changed.
>
> This seems to work, but I'm sure there is a better way.
>
> Steve
>
> ---
>
> [config: Target = 0100]# get-ttl
> mesh_gatt_write: max_len:20 len:21 sar:0 write_mtu:0 write_io:(nil)
> Characteristic property changed /org/bluez/hci0/dev_C9_63_A3_A6_CD_DA/service000a/char000b
> AcquireWrite success: fd 8 MTU 69
> pipe_write: len:21 max_len:65
> GATT-TX:         40 f4 a8 fa b2 33 ac 51 80 ff 16 2e 74 b4 a0 bb
> GATT-TX:         2f 2f 54 e2 96
> GATT-TX: iov[0]:         40
> GATT-TX: iov[1]:         f4 a8 fa b2 33 ac 51 80 ff 16 2e 74 b4 a0 bb 2f
> GATT-TX: iov[1]:         2f 54 e2
> GATT-TX: iov[0]:         80
> GATT-TX: iov[1]:         00 00 fe ff ff ff fe ff ff ff fe ff ff ff fe ff
> GATT-TX: iov[1]:         ff ff fe ff ff ff fe ff ff ff fe ff ff ff fe ff
> GATT-TX: iov[1]:         ff ff 14 00 00 00 fe ff ff ff 01 00 00 00 70 15
> GATT-TX: iov[1]:         d6 01 36 00 00 00 3e 00 00 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00
> GATT-TX: iov[0]:         80
> GATT-TX: iov[1]:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00 00 00 00 00 00 00 00 00 51 00 00 00 06 00 00
> GATT-TX: iov[1]:         00 0c 98 d7 76 00 00 00 00 00 00 00 00 04 00 97
> GATT-TX: iov[1]:         d7
> GATT-TX: iov[0]:         80
> GATT-TX: iov[1]:         76 c4 97 d7 00 00 00 00 30 00 00 00 b0 4d d4 01
> GATT-TX: iov[1]:         e0 b6 dc 76 20 b6 dc 76 21 00 00 00 dc 97 d7 76
> GATT-TX: iov[1]:         dc 97 d7 76 28 4e d4 01 20 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00 00 00 00 50 00 00 00 29 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00
> GATT-TX: iov[0]:         c0
> GATT-TX: iov[1]:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> GATT-TX: iov[1]:         00
>
> diff --git a/mesh/gatt.c b/mesh/gatt.c
> index 001eb17a8..3f59268f2 100644
> --- a/mesh/gatt.c
> +++ b/mesh/gatt.c
> @@ -358,6 +362,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>         struct write_data *data = user_data;
>         DBusError error;
>         int fd;
> +       uint8_t max_len;
>
>         dbus_error_init(&error);
>
> @@ -383,6 +388,18 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
>
>         write_io = pipe_io_new(fd);
>
> +       /* Reset type and length as write_mtu may have changed */
> +       max_len = write_mtu ? write_mtu - 3 : GATT_MTU - 3;
> +       data->gatt_data[0] &= GATT_TYPE_MASK;

Ive never really liked the idea of putting the SAR byte into data but
it was required due to use of WriteValue, now perhaps we can even
remove that since AcquireWrite is stable the sar byte can be set in an
independent variable in pipe_write so we can move this logic there.

> +       if (max_len < data->gatt_len) {
> +               data->iov.iov_len = max_len;
> +               data->gatt_data[0] |= GATT_SAR_FIRST;
> +       }
> +
> +       else
> +               data->iov.iov_len = data->gatt_len;
> +
>         pipe_write(write_io, data);
>  }
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
