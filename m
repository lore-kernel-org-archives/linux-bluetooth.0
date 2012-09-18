Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347979623-14643-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1347979623-14643-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Tue, 18 Sep 2012 11:59:20 -0400
Message-ID: <CAJdJm_OSzp9i_ox380aFJvrTWwUKUeR2OYeZQDPvoBxSXvYYjw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatttool: Fix Characteristic descriptor discovery
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Sep 18, 2012 at 10:47 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> @@ -298,7 +300,10 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
>
>         att_data_list_free(list);
>
> -       rl_forced_update_display();
> +       if (handle != 0xffff && handle < end) {
> +               gatt_find_info(attrib, handle + 1, end, char_desc_cb, NULL);
> +       } else
> +               rl_forced_update_display();

Just a minor nitpick: no need for curly brackets here.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
