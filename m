Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180119133707.18249-1-luiz.dentz@gmail.com>
References: <20180119133707.18249-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 Mar 2018 10:53:48 +0200
Message-ID: <CABBYNZL+SpiTSHHS4R2wkKFc4dhRm89P+hba=9NTRoz1kKizCA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Fix crash when if client invalidate property
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jan 19, 2018 at 3:37 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If a property is invalidated the iter is set to NULL which should be
> checked and properly reset.
> ---
>  src/advertising.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 94a8c4050..f00db86bd 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -203,6 +203,9 @@ static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *client)
>  {
>         const char *msg_type;
>
> +       if (!iter)
> +               return true;
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
>                 return false;
>
> @@ -226,6 +229,11 @@ static bool parse_service_uuids(DBusMessageIter *iter,
>  {
>         DBusMessageIter ariter;
>
> +       if (!iter) {
> +               bt_ad_clear_service_uuid(client->data);
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>                 return false;
>
> @@ -262,6 +270,11 @@ static bool parse_solicit_uuids(DBusMessageIter *iter,
>  {
>         DBusMessageIter ariter;
>
> +       if (!iter) {
> +               bt_ad_clear_solicit_uuid(client->data);
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>                 return false;
>
> @@ -298,6 +311,11 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
>  {
>         DBusMessageIter entries;
>
> +       if (!iter) {
> +               bt_ad_clear_manufacturer_data(client->data);
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>                 return false;
>
> @@ -353,6 +371,11 @@ static bool parse_service_data(DBusMessageIter *iter,
>  {
>         DBusMessageIter entries;
>
> +       if (!iter) {
> +               bt_ad_clear_service_data(client->data);
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>                 return false;
>
> @@ -422,11 +445,19 @@ static bool parse_includes(DBusMessageIter *iter,
>  {
>         DBusMessageIter entries;
>
> +       if (!iter) {
> +               client->flags = 0;
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
>                 return false;
>
>         dbus_message_iter_recurse(iter, &entries);
>
> +       /* Reset flags before parsing */
> +       client->flags = 0;
> +
>         while (dbus_message_iter_get_arg_type(&entries) == DBUS_TYPE_STRING) {
>                 const char *str;
>                 struct adv_include *inc;
> @@ -456,6 +487,12 @@ static bool parse_local_name(DBusMessageIter *iter,
>  {
>         const char *name;
>
> +       if (!iter) {
> +               free(client->name);
> +               client->name = NULL;
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
>                 return false;
>
> @@ -475,6 +512,11 @@ static bool parse_local_name(DBusMessageIter *iter,
>  static bool parse_appearance(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
>  {
> +       if (!iter) {
> +               client->appearance = 0;
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
>                 return false;
>
> @@ -491,6 +533,11 @@ static bool parse_appearance(DBusMessageIter *iter,
>  static bool parse_duration(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
>  {
> +       if (!iter) {
> +               client->duration = 0;
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
>                 return false;
>
> @@ -516,6 +563,13 @@ static gboolean client_timeout(void *user_data)
>  static bool parse_timeout(DBusMessageIter *iter,
>                                         struct btd_adv_client *client)
>  {
> +       if (!iter) {
> +               client->timeout = 0;
> +               g_source_remove(client->to_id);
> +               client->to_id = 0;
> +               return true;
> +       }
> +
>         if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
>                 return false;
>
> --
> 2.14.3

Applied.


-- 
Luiz Augusto von Dentz
