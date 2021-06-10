Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA7C47094
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8334F61184
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jun 2021 12:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFJMrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:47:20 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:45371 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFJMrT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jun 2021 08:47:19 -0400
Received: (Authenticated sender: hadess@hadess.net)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0CA9420000B;
        Thu, 10 Jun 2021 12:45:19 +0000 (UTC)
Message-ID: <fe5e3c7519a52aa59e33939c64e9aa4b7c5e30c3.camel@hadess.net>
Subject: Re: [PATCH] rfkill: Fix reading from rfkill socket
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Berg <benjamin@sipsolutions.net>,
        linux-bluetooth@vger.kernel.org
Cc:     Benjamin Berg <bberg@redhat.com>
Date:   Thu, 10 Jun 2021 14:45:19 +0200
In-Reply-To: <20210503131210.90066-1-benjamin@sipsolutions.net>
References: <20210503131210.90066-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2021-05-03 at 15:12 +0200, Benjamin Berg wrote:
> From: Benjamin Berg <bberg@redhat.com>
> 
> The kernel will always send exactly one event, but the size of the
> passed struct will depend on the length of the submitted read() and the
> kernel version. i.e. the interface can be extended and we need to
> expect
> for a read to be longer than expected if we ask for it.
> 
> Fix this by only requesting the needed length and explicitly check the
> length against the V1 version of the structure to make the code a bit
> more future proof in case the internal copy of the struct is updated to
> contain new fields.

This fixes a bug in GNOME where to enable Bluetooth, we removed a soft
rfkill block on the Bluetooth interface.

Without this, the bluetooth rfkill gets unblocked, but bluetoothd
doesn't see it as unblocked so never powers it on, causing the UI to
appear broken, as we expect Bluetooth devices to be either blocked
through rfkill, or powered on.

The equivalent gnome-settings-daemon fix (which deals with rfkill) was
reviewed by Hans de Goede:
https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/merge_requests/234

Benjamin, it might be worth resending this with a better commit message
explaining exactly what it fixes and referencing the gnome-bluetooth
bug:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/38

Cheers

> ---
>  src/rfkill.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/src/rfkill.c b/src/rfkill.c
> index ec9fcdfdd..2099c5ac5 100644
> --- a/src/rfkill.c
> +++ b/src/rfkill.c
> @@ -53,12 +53,12 @@ struct rfkill_event {
>         uint8_t  soft;
>         uint8_t  hard;
>  };
> +#define RFKILL_EVENT_SIZE_V1    8
>  
>  static gboolean rfkill_event(GIOChannel *chan,
>                                 GIOCondition cond, gpointer data)
>  {
> -       unsigned char buf[32];
> -       struct rfkill_event *event = (void *) buf;
> +       struct rfkill_event event = { 0 };
>         struct btd_adapter *adapter;
>         char sysname[PATH_MAX];
>         ssize_t len;
> @@ -69,34 +69,32 @@ static gboolean rfkill_event(GIOChannel *chan,
>  
>         fd = g_io_channel_unix_get_fd(chan);
>  
> -       memset(buf, 0, sizeof(buf));
> -
> -       len = read(fd, buf, sizeof(buf));
> +       len = read(fd, &event, sizeof(event));
>         if (len < 0) {
>                 if (errno == EAGAIN)
>                         return TRUE;
>                 return FALSE;
>         }
>  
> -       if (len != sizeof(struct rfkill_event))
> +       if (len < RFKILL_EVENT_SIZE_V1)
>                 return TRUE;
>  
>         DBG("RFKILL event idx %u type %u op %u soft %u hard %u",
> -                                       event->idx, event->type, event-
> >op,
> -                                               event->soft, event-
> >hard);
> +                                       event.idx, event.type,
> event.op,
> +                                               event.soft,
> event.hard);
>  
> -       if (event->soft || event->hard)
> +       if (event.soft || event.hard)
>                 return TRUE;
>  
> -       if (event->op != RFKILL_OP_CHANGE)
> +       if (event.op != RFKILL_OP_CHANGE)
>                 return TRUE;
>  
> -       if (event->type != RFKILL_TYPE_BLUETOOTH &&
> -                                       event->type != RFKILL_TYPE_ALL)
> +       if (event.type != RFKILL_TYPE_BLUETOOTH &&
> +                                       event.type != RFKILL_TYPE_ALL)
>                 return TRUE;
>  
>         snprintf(sysname, sizeof(sysname) - 1,
> -                       "/sys/class/rfkill/rfkill%u/name", event->idx);
> +                       "/sys/class/rfkill/rfkill%u/name", event.idx);
>  
>         fd = open(sysname, O_RDONLY);
>         if (fd < 0)


