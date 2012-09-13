Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347541403-11780-10-git-send-email-chen.ganir@ti.com>
References: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
	<1347541403-11780-10-git-send-email-chen.ganir@ti.com>
Date: Thu, 13 Sep 2012 10:50:58 -0400
Message-ID: <CAJdJm_MUHMc1-td02fwWLZihCnXBQNHJT5_te1KjhaG-k3v=vg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] battery: Add support for notifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Sep 13, 2012 at 9:03 AM,  <chen.ganir@ti.com> wrote:
>  static void battery_free(gpointer user_data)
>  {
>         struct battery *batt = user_data;
> @@ -99,6 +109,14 @@ static void battery_free(gpointer user_data)
>         if (batt->attrib != NULL)
>                 g_attrib_unref(batt->attrib);
>
> +       if (batt->attrib != NULL) {

You are still repeating the if (batt->attrib != NULL) check here like
Joao mentioned (see above). Instead, you should merge the "if
(batt->attnotid)" block into the existing "if (batt->attrib != NULL)"
block.

> +               if (batt->attnotid) {
> +                       g_attrib_unregister(batt->attrib, batt->attnotid);
> +                       batt->attnotid = 0;
> +               }
> +
> +               g_attrib_unref(batt->attrib);
> +       }
>         btd_device_unref(batt->dev);
>         g_free(batt->svc_range);
>         g_free(batt);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
