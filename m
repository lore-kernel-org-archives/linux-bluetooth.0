Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <25fbc871-706b-d435-6c78-120d74ce3505@jp.fujitsu.com>
References: <25fbc871-706b-d435-6c78-120d74ce3505@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 28 Aug 2017 14:27:05 +0300
Message-ID: <CABBYNZKfCgOrX9pxKcg8X6_b98AiipC_6Ri9H9OdhS7kSLg2vQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client: Use the common argument generator
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Aug 25, 2017 at 11:28 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> ---
>  client/main.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/client/main.c b/client/main.c
> index 75696c2..34fcbd7 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -2234,7 +2234,8 @@ static char *attribute_generator(const char *text, int state)
>         return gatt_attribute_generator(text, state);
>  }
>
> -static char *capability_generator(const char *text, int state)
> +static char *argument_generator(const char *text, int state,
> +                                       const char * const *args_list)
>  {
>         static int index, len;
>         const char *arg;
> @@ -2244,7 +2245,7 @@ static char *capability_generator(const char *text, int state)
>                 len = strlen(text);
>         }
>
> -       while ((arg = agent_arguments[index])) {
> +       while ((arg = args_list[index])) {
>                 index++;
>
>                 if (!strncmp(arg, text, len))
> @@ -2254,6 +2255,11 @@ static char *capability_generator(const char *text, int state)
>         return NULL;
>  }
>
> +static char *capability_generator(const char *text, int state)
> +{
> +       return argument_generator(text, state, agent_arguments);
> +}
> +
>  static gboolean parse_argument_advertise(const char *arg, dbus_bool_t *value,
>                                                         const char **type)
>  {
> @@ -2308,22 +2314,7 @@ static void cmd_advertise(const char *arg)
>
>  static char *ad_generator(const char *text, int state)
>  {
> -       static int index, len;
> -       const char *arg;
> -
> -       if (!state) {
> -               index = 0;
> -               len = strlen(text);
> -       }
> -
> -       while ((arg = ad_arguments[index])) {
> -               index++;
> -
> -               if (!strncmp(arg, text, len))
> -                       return strdup(arg);
> -       }
> -
> -       return NULL;
> +       return argument_generator(text, state, ad_arguments);
>  }
>
>  static void cmd_set_advertise_uuids(const char *arg)
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
