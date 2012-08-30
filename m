Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346328542-13203-1-git-send-email-chen.ganir@ti.com>
References: <1346328542-13203-1-git-send-email-chen.ganir@ti.com>
Date: Thu, 30 Aug 2012 15:03:07 +0200
Message-ID: <CAN_we7P2VhJR6XO4bYVZC8oqRiQ=hEFH=tfcTnU-R4YU+7tuTA@mail.gmail.com>
Subject: Re: [PATCH] adapter: add API to find an existing device by D-Bus path
From: Daniele Forsi <dforsi@gmail.com>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2012/8/30  <chen.ganir@ti...>:

> +       for (l = adapter->devices; l != NULL; l = g_slist_next(l))
> +               if (g_strcmp0(device_get_path(l->data), path) == 0)
> +                       break;

what about returning l->data here instead of breaking the loop, so you
don't need the following NULL check?

> +
> +       if (!l)
> +               return NULL;
> +
> +       return l->data;
> +}

-- 
Daniele Forsi
