Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362180153-11133-5-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
	<1362180153-11133-5-git-send-email-vinicius.gomes@openbossa.org>
Date: Fri, 1 Mar 2013 21:50:19 -0400
Message-ID: <CAJdJm_NkO+96ptksOGnK8jO5qE8J-MgChW7cq+6cZPEeEZ-zBw@mail.gmail.com>
Subject: Re: [RFC BlueZ v0 04/10] device: Remove misleading function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Fri, Mar 1, 2013 at 7:22 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> @@ -3049,7 +3044,9 @@ static void register_all_services(struct btd_device *device, GSList *services)
>         g_slist_free_full(device->primaries, g_free);
>         device->primaries = NULL;

I think you can remove the NULL assignment above, as device->primaries
is updated just below.

>
> -       device_register_primaries(device, g_slist_copy(services), -1);
> +       /* And keep the new one */
> +       device->primaries = g_slist_copy(services);
> +
>         if (removed)
>                 device_remove_profiles(device, removed);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
