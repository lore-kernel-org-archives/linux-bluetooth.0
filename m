Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1379064212-30056-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1379064212-30056-3-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 13 Sep 2013 13:47:41 +0300
Message-ID: <CABBYNZL+d8CpQNJ2z750s30naUoY-049XpCs3gOtGMsG1hCJVw@mail.gmail.com>
Subject: Re: [PATCH 2/4] obexd: Fix setting message folder for relative folder
 in ListMessages
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Fri, Sep 13, 2013 at 12:23 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> The method ListMessages allows to specify a relative subfolder.
> This subfolder needs to be added to the current path when registering
> a new message interface.
> ---
>  obexd/client/map.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 9a1b140..54011d8 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -96,6 +96,7 @@ static const char * const filter_list[] = {
>  struct map_data {
>         struct obc_session *session;
>         DBusMessage *msg;
> +       char *folder;
>         GHashTable *messages;
>         int16_t mas_instance_id;
>         uint8_t supported_message_types;
> @@ -1058,8 +1059,7 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
>
>         msg = g_hash_table_lookup(data->messages, values[i]);
>         if (msg == NULL) {
> -               msg = map_msg_create(data, values[i],
> -                                       obc_session_get_folder(data->session));
> +               msg = map_msg_create(data, values[i], data->folder);
>                 if (msg == NULL)
>                         return;
>         }
> @@ -1153,6 +1153,19 @@ static void message_listing_cb(struct obc_session *session,
>  done:
>         g_dbus_send_message(conn, reply);
>         dbus_message_unref(map->msg);
> +       g_free(map->folder);
> +       map->folder = NULL;
> +}
> +
> +static char *get_absolute_folder(const char *root, const char *subfolder)
> +{
> +       if (!subfolder || strlen(subfolder) == 0)
> +               return g_strdup(root);
> +       else
> +               if (g_str_has_suffix(root, "/"))
> +                       return g_strconcat(root, subfolder, NULL);
> +               else
> +                       return g_strconcat(root, "/", subfolder, NULL);
>  }
>
>  static DBusMessage *get_message_listing(struct map_data *map,
> @@ -1175,6 +1188,8 @@ static DBusMessage *get_message_listing(struct map_data *map,
>         if (obc_session_queue(map->session, transfer, message_listing_cb, map,
>                                                                 &err)) {
>                 map->msg = dbus_message_ref(message);
> +               map->folder = get_absolute_folder(obc_session_get_folder(
> +                                                       map->session), folder);
>                 return NULL;
>         }
>
> --
> 1.8.3.4

This will probably not work in case of multiple outstanding requests
the last will always overwrite the folder, which btw will leak, so
probably we need a per request data.


-- 
Luiz Augusto von Dentz
