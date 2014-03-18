Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
References: <1395061683-17206-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 18 Mar 2014 10:57:25 +0200
Message-ID: <CABBYNZ+8++LzydXpVOUUFYfWC9AhWGoPeNnjSpn2=C1YJd6mFQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/17] unit/test-avrcp: Use avrcp_register_player
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 17, 2014 at 3:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This replaces the use of avrcp_set_control_handlers which is now
> deprecated in favor of avrcp_register_player.
> ---
>  unit/test-avrcp.c | 264 ++++++++++++------------------------------------------
>  1 file changed, 56 insertions(+), 208 deletions(-)
>
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index b86d572..9fdbe6d 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -297,243 +297,106 @@ static const struct avrcp_passthrough_handler passthrough_handlers[] = {
>                 { },
>  };
>
> -static bool check_attributes(const uint8_t *params)
> -{
> -       int i;
> -
> -       for (i = 1; i <= params[0]; i++) {
> -               DBG("params[%d] = 0x%02x", i, params[i]);
> -               if (params[i] > AVRCP_ATTRIBUTE_LAST ||
> -                                       params[i] == AVRCP_ATTRIBUTE_ILEGAL)
> -                       return false;
> -       }
> -
> -       return true;
> -}
> -
> -static ssize_t avrcp_handle_get_capabilities(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_capabilities(struct avrcp *session, uint8_t transaction,
> +                                                       void *user_data)
>  {
> -       if (params_len != 1)
> -               return -EINVAL;
> -
> -       switch (params[0]) {
> -       case CAP_COMPANY_ID:
> -               params[1] = 1;
> -               hton24(&params[2], IEEEID_BTSIG);
> -               return 5;
> -       }
> -
>         return -EINVAL;
>  }
>
> -static ssize_t avrcp_handle_list_attributes(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int list_attributes(struct avrcp *session, uint8_t transaction,
> +                                                       void *user_data)
>  {
>         DBG("");
>
> -       params[0] = 0;
> -
>         return 1;
>  }
>
> -static ssize_t avrcp_handle_get_player_attr_text(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_attribute_text(struct avrcp *session, uint8_t transaction,
> +                                       uint8_t number, uint8_t *attrs,
> +                                       void *user_data)
>  {
> -       DBG("params[0] %d params_len %d", params[0], params_len);
> -
> -       if (!check_attributes(params))
> -               return -EINVAL;
> -
> -       params[0] = 0;
> +       DBG("");
>
>         return 1;
>  }
>
> -static ssize_t avrcp_handle_list_player_values(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int list_values(struct avrcp *session, uint8_t transaction,
> +                                               uint8_t attr, void *user_data)
>  {
> -       DBG("params[0] 0x%02x params_len %d", params[0], params_len);
> -
> -       if (params_len != 1)
> -               return -EINVAL;
> -
> -       if (params[0] > AVRCP_ATTRIBUTE_LAST ||
> -                                       params[0] == AVRCP_ATTRIBUTE_ILEGAL)
> -               return -EINVAL;
> -
> -       params[0] = 0;
> +       DBG("");
>
>         return 1;
>  }
>
> -static ssize_t avrcp_handle_get_player_value_text(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_value_text(struct avrcp *session, uint8_t transaction,
> +                               uint8_t attr, uint8_t number, uint8_t *values,
> +                               void *user_data)
>  {
> -       int i;
> -
> -       DBG("attr_id %d num_vals %d len %d", params[0], params[1], params_len);
> -
> -       if (params_len != 2 + params[1])
> -               return -EINVAL;
> -
> -       if (params[0] > AVRCP_ATTRIBUTE_LAST ||
> -                                       params[0] == AVRCP_ATTRIBUTE_ILEGAL)
> -               return -EINVAL;
> -
> -       for (i = 2; i < 2 + params[1]; i++) {
> -               DBG("Value 0x%02x", params[i]);
> -
> -               /* Check for invalid value */
> -               switch (params[0]) {
> -               case AVRCP_ATTRIBUTE_EQUALIZER:
> -                       if (params[i] < 0x01 || params[i] > 0x02)
> -                               return -EINVAL;
> -               }
> -       }
> -
> -       params[0] = 0;
> +       DBG("");
>
>         return 1;
>  }
>
> -static ssize_t avrcp_handle_get_current_player_value(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_value(struct avrcp *session, uint8_t transaction,
> +                       uint8_t number, uint8_t *attrs, void *user_data)
>  {
>         uint8_t *attributes;
>         int i;
>
> -       DBG("params[0] %d params_len %d", params[0], params_len);
> -
> -       if (!check_attributes(params))
> -               return -EINVAL;
> +       DBG("");
>
> -       attributes = g_memdup(&params[1], params[0]);
> +       attributes = g_memdup(attrs, number);
>
> -       for (i = 0; i < params[0]; i++) {
> -               params[i * 2 + 1] = attributes[i];
> -               params[i * 2 + 2] = 0; /* value */
> +       for (i = 0; i < number; i++) {
> +               attrs[i * 2 + 1] = attributes[i];
> +               attrs[i * 2 + 2] = 0; /* value */
>         }
>
>         g_free(attributes);
>
> -       params[0] = i;
> -
> -       return params[0] * 2 + 1;
> -}
> -
> -static ssize_t avrcp_handle_set_player_value(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> -{
> -       int i;
> -
> -       DBG("params[0] %d params_len %d", params[0], params_len);
> -
> -       if (params_len != params[0] * 2 + 1)
> -               return -EINVAL;
> -
> -       for (i = 0; i < params[0]; i++) {
> -               uint8_t attr = params[i * 2 + 1];
> -               uint8_t val = params[i * 2 + 2];
> -
> -               DBG("attr 0x%02x val 0x%02x", attr, val);
> -               switch (attr) {
> -               case AVRCP_ATTRIBUTE_REPEAT_MODE:
> -                       if (val < 0x01 || val > 0x05)
> -                               return -EINVAL;
> -               }
> -       }
> -
> -       return 1;
> +       return number * 2 + 1;
>  }
>
> -static ssize_t avrcp_handle_set_addr_player(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int set_value(struct avrcp *session, uint8_t transaction,
> +                       uint8_t number, uint8_t *attrs, void *user_data)
>  {
>         DBG("");
>
> -       params[0] = 0;
> -
> -       return 1;
> +       return 0;
>  }
>
> -static ssize_t avrcp_handle_get_play_status(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_play_status(struct avrcp *session, uint8_t transaction,
> +                                                       void *user_data)
>  {
>         DBG("");
>
> -       if (params_len)
> -               return -EINVAL;
> -
>         avrcp_get_play_status_rsp(session, transaction, 0xaaaaaaaa, 0xbbbbbbbb,
>                                                                         0x00);
>
>         return -EAGAIN;
>  }
>
> -static ssize_t avrcp_handle_get_element_attrs(struct avrcp *session,
> -                                               uint8_t transaction,
> -                                               uint16_t params_len,
> -                                               uint8_t *params,
> -                                               void *user_data)
> +static int get_element_attributes(struct avrcp *session, uint8_t transaction,
> +                                       uint64_t uid, uint8_t number,
> +                                       uint32_t *attrs, void *user_data)
>  {
> -       DBG("params_len %d params[8] %d", params_len, params[8]);
> -
> -       if (params_len < 9)
> -               return -EINVAL;
> -
> -       if (params_len != 9 + params[8] * 4)
> -               return -EINVAL;
> +       DBG("");
>
>         avrcp_get_element_attrs_rsp(session, transaction, NULL, 0);
>
>         return -EAGAIN;
>  }
>
> -static ssize_t avrcp_handle_register_notification(struct avrcp *session,
> -                                                       uint8_t transaction,
> -                                                       uint16_t params_len,
> -                                                       uint8_t *params,
> -                                                       void *user_data)
> +static int register_notification(struct avrcp *session, uint8_t transaction,
> +                                       uint8_t event, uint32_t interval,
> +                                       void *user_data)
>  {
>         struct context *context = user_data;
> -       uint8_t event;
>         uint8_t pdu[9];
>         size_t pdu_len;
>
>         DBG("");
>
> -       if (params_len != AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH)
> -               return -EINVAL;
> -
> -       event = params[0];
>         pdu[0] = event;
>         pdu_len = 1;
>
> @@ -567,41 +430,26 @@ static ssize_t avrcp_handle_register_notification(struct avrcp *session,
>         return -EAGAIN;
>  }
>
> -static const struct avrcp_control_handler control_handlers[] = {
> -               { AVRCP_GET_CAPABILITIES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_capabilities },
> -               { AVRCP_LIST_PLAYER_ATTRIBUTES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_list_attributes },
> -               { AVRCP_GET_PLAYER_ATTRIBUTE_TEXT,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_player_attr_text },
> -               { AVRCP_LIST_PLAYER_VALUES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_list_player_values },
> -               { AVRCP_GET_PLAYER_VALUE_TEXT,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_player_value_text },
> -               { AVRCP_GET_CURRENT_PLAYER_VALUE,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_current_player_value },
> -               { AVRCP_SET_PLAYER_VALUE,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_set_player_value },
> -               { AVRCP_GET_PLAY_STATUS,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_play_status },
> -               { AVRCP_GET_ELEMENT_ATTRIBUTES,
> -                                       AVC_CTYPE_STATUS, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_get_element_attrs },
> -               { AVRCP_REGISTER_NOTIFICATION,
> -                                       AVC_CTYPE_NOTIFY, AVC_CTYPE_INTERIM,
> -                                       avrcp_handle_register_notification },
> -               { AVRCP_SET_ADDRESSED_PLAYER,
> -                                       AVC_CTYPE_CONTROL, AVC_CTYPE_STABLE,
> -                                       avrcp_handle_set_addr_player },
> -               { },
> +static int set_addressed(struct avrcp *session, uint8_t transaction,
> +                                               uint16_t id, void *user_data)
> +{
> +       DBG("");
> +
> +       return 1;
> +}
> +
> +static const struct avrcp_control_ind control_ind = {
> +       .get_capabilities = get_capabilities,
> +       .list_attributes = list_attributes,
> +       .get_attribute_text = get_attribute_text,
> +       .list_values = list_values,
> +       .get_value_text = get_value_text,
> +       .get_value = get_value,
> +       .set_value = set_value,
> +       .get_play_status = get_play_status,
> +       .get_element_attributes = get_element_attributes,
> +       .register_notification = register_notification,
> +       .set_addressed = set_addressed,
>  };
>
>  static void test_server(gconstpointer data)
> @@ -610,7 +458,7 @@ static void test_server(gconstpointer data)
>
>         avrcp_set_passthrough_handlers(context->session, passthrough_handlers,
>                                                                 context);
> -       avrcp_set_control_handlers(context->session, control_handlers, context);
> +       avrcp_register_player(context->session, &control_ind, NULL, context);
>
>         g_idle_add(send_pdu, context);
>
> --
> 1.8.5.3

Pushed.


-- 
Luiz Augusto von Dentz
