Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
Date: Thu, 20 Sep 2012 06:56:58 -0400
Message-ID: <CAJdJm_MhZwRyD8JVsmm6QTWqhWh1x2FXkopTQqdmNy=td0aj8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Implement Generic battery and LE Battery client
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Sep 20, 2012 at 4:27 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> This patch set replaces previous patch sets which implemented the LE battery
> GATT Client. This patch set implements a generic device battery D-Bus interface
> that can be used to get remote device battery status using D-Bus. In addition,
> This patch set also implements the GATT Battery client, which uses the generic
> device battery to expose LE device battery status.
>
> see doc/battery-api.txt and doc/device-api.txt for more information.
>
> This is version 2 of the patch set, including multiple style and other comments
> reported on the ML. This version is rebased on the latest code.

Besides some minor style comments (found on this last round of
review), patch set looks good to me.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
