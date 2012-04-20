Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334786904-26282-5-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
	<1334786904-26282-5-git-send-email-jprvita@openbossa.org>
Date: Fri, 20 Apr 2012 14:06:42 -0400
Message-ID: <CAJdJm_NkNC2ohPnobJPwR6GvmRg6Zb6hnMBeqQnb0wz8bZ4ahg@mail.gmail.com>
Subject: Re: [RFC v2 04/16] HoG: discover all characteristics declaration
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org, claudio.takahasi@openbossa.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

2012/4/18 João Paulo Rechi Vita <jprvita@openbossa.org>:
> +static void report_free(struct report *report)
> +{
> +       g_free(report->decl);
> +       g_free(report);
> +}

We usually avoid casts (like you do later on the g_slist_free_full()
call), by having:

static void report_free(void *data)
{
        struct report *report = data;
...
}

> @@ -153,6 +203,7 @@ int hog_device_register(struct btd_device *device, const char *path)
>  static void hog_device_free(struct hog_device *hogdev)
>  {
>        btd_device_unref(hogdev->device);
> +       g_slist_free_full(hogdev->reports, (GDestroyNotify) report_free);

You can then drop the cast above.

>        g_free(hogdev->path);
>        g_free(hogdev->hog_primary);
>        g_free(hogdev);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
