Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <718f3799-c500-93b1-7342-848ce39332e2@jp.fujitsu.com>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com> <718f3799-c500-93b1-7342-848ce39332e2@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 24 Sep 2017 20:58:20 +0300
Message-ID: <CABBYNZLYs_CSRLRUg3Ud5YxDysJqaF3HoS9GVxxiq2dEyVp7VA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/6] client: Introduce parse_argument()
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Sep 22, 2017 at 3:20 PM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> ---
>  client/main.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 7b24633..1c34269 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -845,6 +845,44 @@ static gboolean check_default_ctrl(void)
>         return TRUE;
>  }
>
> +static gboolean parse_argument(const char *arg, const char * const *arg_=
table,
> +                                       const char *msg, dbus_bool_t *val=
ue,
> +                                       const char **option)
> +{
> +       const char * const *opt;
> +
> +       if (!arg || !strlen(arg)) {
> +               if (msg)
> +                       rl_printf("Missing on/off/%s argument\n", msg);
> +               else
> +                       rl_printf("Missing on/off argument\n");
> +               return FALSE;
> +       }
> +
> +       if (!strcmp(arg, "on") || !strcmp(arg, "yes")) {
> +               *value =3D TRUE;
> +               if (option)
> +                       *option =3D "";
> +               return TRUE;
> +       }
> +
> +       if (!strcmp(arg, "off") || !strcmp(arg, "no")) {
> +               *value =3D FALSE;
> +               return TRUE;
> +       }
> +
> +       for (opt =3D arg_table; opt && *opt; opt++) {
> +               if (strcmp(arg, *opt) =3D=3D 0) {
> +                       *value =3D TRUE;
> +                       *option =3D *opt;
> +                       return TRUE;
> +               }
> +       }
> +
> +       rl_printf("Invalid argument %s\n", arg);
> +       return FALSE;
> +}
> +
>  static gboolean parse_argument_on_off(const char *arg, dbus_bool_t *valu=
e)
>  {
>         if (!arg || !strlen(arg)) {
> --
> 2.7.4

This one if applied separately would break bisect:

client/main.c:848:17: error: =E2=80=98parse_argument=E2=80=99 defined but n=
ot used
[-Werror=3Dunused-function]
 static gboolean parse_argument(const char *arg, const char * const *arg_ta=
ble,
                 ^~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Lets have it merged with 6/6.


>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
