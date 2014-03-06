Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1394029952-3319-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Thu, 6 Mar 2014 17:45:26 +0200
Message-ID: <CABBYNZLNL3dJqFBj1AVJLx9AysnwyWjtpUpRG+hJDVrhX2wYBQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] unit/avrcp: Refactor check attributes code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Mar 5, 2014 at 4:32 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Make check_attributes() function which would handle attributes check.
> ---
>  unit/test-avrcp.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index 803dd6b..7ce2801 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -288,6 +288,20 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
>                 { },
>  };
>
> +static bool check_attributes(const uint8_t *params)
> +{
> +       int i;
> +
> +       for (i = 1; i <= params[0]; i++) {
> +               DBG("params[%d] = 0x%02x", i, params[i]);
> +               if (params[i] > AVRCP_ATTRIBUTE_LAST ||
> +                   params[i] == AVRCP_ATTRIBUTE_ILEGAL)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static ssize_t avrcp_handle_get_capabilities(struct avrcp *session,
>                                                 uint8_t transaction,
>                                                 uint16_t params_len,
> @@ -326,16 +340,10 @@ static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
>                                                 uint8_t *params,
>                                                 void *user_data)
>  {
> -       int i;
> -
>         DBG("params[0] %d params_len %d", params[0], params_len);
>
> -       for (i = 1; i <= params[0]; i++) {
> -               DBG("params[%d] = 0x%02x", i, params[i]);
> -               if (params[i] > AVRCP_ATTRIBUTE_LAST ||
> -                       params[i] == AVRCP_ATTRIBUTE_ILEGAL)
> -                       return -EINVAL;
> -       }
> +       if (!check_attributes(params))
> +               return -EINVAL;
>
>         params[0] = 0;
>
> --
> 1.8.3.2

Pushed after some code style fixes, please do not mix spaces and tabs.
Also the tests are starting to get logic outside of just testing the
handler but the actual PDU handling so perhaps we need to think if the
API of avrcp-lib.h is really a proper one or we should do create a
different one as it is done for passthrough where the callback are not
actually pure PDU handlers.


-- 
Luiz Augusto von Dentz
