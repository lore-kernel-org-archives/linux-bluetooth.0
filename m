Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1379064212-30056-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1379064212-30056-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
	<1379064212-30056-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 13 Sep 2013 13:11:16 +0300
Message-ID: <CABBYNZKYBd=S0G3Hvno7wQxgtCy5nwnamTD=1sKcVw+kBkAVVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] obexd: Add folder property to map_msg_create
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
> Message interfaces are not necessarily created for the current folder,
> therefore the folder needs to be specified in a parameter.
>
> For example, messages can be created for sub folders when using the folder
> parameter in ListMessages.
> ---
>  obexd/client/map.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index f0dcf72..9a1b140 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -779,7 +779,8 @@ static const GDBusPropertyTable map_msg_properties[] = {
>         { }
>  };
>
> -static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
> +static struct map_msg *map_msg_create(struct map_data *data, const char *handle,
> +                                                       const char *folder)
>  {
>         struct map_msg *msg;
>
> @@ -788,7 +789,7 @@ static struct map_msg *map_msg_create(struct map_data *data, const char *handle)
>         msg->path = g_strdup_printf("%s/message%s",
>                                         obc_session_get_path(data->session),
>                                         handle);
> -       msg->folder = g_strdup(obc_session_get_folder(data->session));
> +       msg->folder = g_strdup(folder);
>
>         if (!g_dbus_register_interface(conn, msg->path, MAP_MSG_INTERFACE,
>                                                 map_msg_methods, NULL,
> @@ -1057,7 +1058,8 @@ static void msg_element(GMarkupParseContext *ctxt, const char *element,
>
>         msg = g_hash_table_lookup(data->messages, values[i]);
>         if (msg == NULL) {
> -               msg = map_msg_create(data, values[i]);
> +               msg = map_msg_create(data, values[i],
> +                                       obc_session_get_folder(data->session));

Is this really fixing anything? Because it seems it is just changing
places where obc_session_get_folder is called when what you should
probably be doing is to store the folder parameter given to
ListMessages. I actually regret to have this parameter as it makes
things a little bit more complicated just to avoid SetFolder.

Probably Session.SetPath would make more sense than having each
profile interface treating it differently but that would require to
break APIs so it is better not to do it right now.



-- 
Luiz Augusto von Dentz
