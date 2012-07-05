Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340878959-1343-6-git-send-email-michal.labedzki@tieto.com>
References: <1340878959-1343-1-git-send-email-michal.labedzki@tieto.com>
	<1340878959-1343-6-git-send-email-michal.labedzki@tieto.com>
Date: Thu, 5 Jul 2012 11:13:20 +0300
Message-ID: <CABBYNZ+69jpZA2+YjLsDYAzd7Hdd137NuwD+BdiLSB15jMGVJA@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] AVRCP: Keep AVRCP version of connected device in session
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, lucas.demarchi@profusion.mobi,
	johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Thu, Jun 28, 2012 at 1:22 PM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:

> +               rec_tg = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
> +               rec_ct = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
> +
> +               if (rec_tg && sdp_get_profile_descs(rec_tg, &list) >= 0) {
> +                       desc = list->data;
> +                       if (desc)
> +                               server->session.version_tg = desc->version;
> +                       else
> +                               server->session.version_tg = VERSION_UNKNOWN;
> +                       sdp_list_free(list, free);
> +               }
>
> -               if (sdp_get_profile_descs(rec, &list) < 0)
> -                       return;
> +               if (rec_ct && sdp_get_profile_descs(rec_ct, &list) >= 0) {
> +                       desc = list->data;
> +                       if (desc)
> +                               server->session.version_ct = desc->version;
> +                       else
> +                               server->session.version_ct = VERSION_UNKNOWN;
> +                       sdp_list_free(list, free);
> +               }

Maybe we should create a helper function to get the version e.g int
sdp_get_profile_version(rec, uuid, &version)

> @@ -1335,6 +1354,9 @@ int avrcp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
>
>         bacpy(&server->src, src);
>
> +       server->session.version_tg = VERSION_UNKNOWN;
> +       server->session.version_ct = VERSION_UNKNOWN;
> +

I guess we can start with 1.0, so if we are unable to read the version
(which probably indicates a malformed record) we should use 1.0 by
default.

-- 
Luiz Augusto von Dentz
