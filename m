Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
References: <1347353240-1942-1-git-send-email-chen.ganir@ti.com>
Date: Tue, 11 Sep 2012 07:44:06 -0400
Message-ID: <CAJdJm_OZZ+SrYdfbpqy+yFmppx9xAs-YMmDtn3PzQbU1JD_pOA@mail.gmail.com>
Subject: Re: [PATCH v2] gatt: Delay D-Bus reply on char discovery
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: chen.ganir@ti.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Tue, Sep 11, 2012 at 4:47 AM,  <chen.ganir@ti.com> wrote:
> From: Chen Ganir <chen.ganir@ti.com>
>
> Delay sending the D-Bus reply for the discover_characteristics
> command. The D-Bus reply for characteristics is sent before all
> the relevant characteristic information is gathered. This can
> cause problems, when trying to get characteristic information too
> soon. This patch moves the D-Bus reply to the end of the char
> discovery process. Only after all descriptors are discovered and
> read, the D-Bus reply is sent.
> ---

I see you populate chr->descriptors, but I can't find where the list
is actually used. Do you plan to use this information in some other
patch?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
