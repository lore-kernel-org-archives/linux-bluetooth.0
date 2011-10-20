Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319104011-27747-2-git-send-email-sancane@gmail.com>
References: <1319104011-27747-1-git-send-email-sancane@gmail.com>
	<1319104011-27747-2-git-send-email-sancane@gmail.com>
Date: Thu, 20 Oct 2011 08:11:18 -0300
Message-ID: <CAJdJm_Oi7WeZmFW3A2pHiRuKnQFJxh8cHPLwZ2gpQuzO8OVX=w@mail.gmail.com>
Subject: Re: [PATCH 1/8] Process characteristic descriptors in thermometer service.
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Thu, Oct 20, 2011 at 6:46 AM, Santiago Carot-Nemesio
<sancane@gmail.com> wrote:
> +               } else
> +                       goto end;

We usually call this label "done".

> +
> +               return;
> +       }
> +
> +       bt_uuid16_create(&btuuid, GATT_CHARAC_VALID_RANGE_UUID);
> +
> +       if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0)
> +               if (g_strcmp0(desc->ch->attr.uuid,
> +                                       MEASUREMENT_INTERVAL_UUID) == 0) {

You can join these nested if()'s in a single one and use &&.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
