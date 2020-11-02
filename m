Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4984C00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F95222BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 23:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJ1dXtra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgKBX2m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgKBX2l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 18:28:41 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8DC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 15:28:41 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 6so7334634oiy.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHEXDpRlVFjUaZbDQWme9DYyv9zS45WrIJ1JZH+WxGQ=;
        b=oJ1dXtrasZi7G/vExbjBbp+Idr/ORhuf3aDwGHjfqK9Q2pgCZ32/VCVkcIAepnJjCq
         gSvS+m6QU0eqL3gIPLiuOkHVwFGovJmB6ClJdJZhSKwiN7ezvR4mjKOwMeY+g0aKza+X
         U78PhncFN8cZdmdbXgGwDpL9iPbQK3ECBxhqb2kG4l3CYc6SWoi2tz/LnIHa//xW5g8z
         swbRk4V9BvXZn9BkUB+5Yb53N952nfWk1jmY8uH4BgKR686EDRfkO3zZTBi2oVRo2MKD
         1ls+TDbMldiVpX89ukYVrv9bx9RS4tFfaBW1x8I6uBIhuPuQdRKwh0+rf7Q8yB9cI2Ep
         Wjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHEXDpRlVFjUaZbDQWme9DYyv9zS45WrIJ1JZH+WxGQ=;
        b=uaMqZcD5ZGUU5EamH9x+AINBW+gT/EC3zs/D9SUmEocoQlWYLbt9J8fldvGBbi0uwO
         UJVxBH3szHKPpyjzvSByrfqZ7g9S4vNgADJs/4xLZLIfabJOy+/14gpBV/TZA9sE1IBu
         R6XxiUgl8lib3ZqBhANZE4gC/ZRCuW5qeFHzcNyZERNz1kxLIOeWNnqLsLT+11+5NNeV
         0Mfl2ewoY9NGrK+cjjajx43PyLcWGd3VGujq6VPz7f5xJqj31BVSZydrJm2r6EFiCshd
         6q6VG7gUyJAVNj/0B5t9d0HYYYAWXE9ICBWVvskwOyZmRZl/RK10CtyiijuF0SlPExk7
         m7Wg==
X-Gm-Message-State: AOAM532Tt+d1nYrmz7SL3TEnFxG7t95vMBANh7MqNAfBEDLpHJ+6Q4Ic
        V2INSRem6sJ01UAA30p1bgEWVnC1Nk0XLg68gzs=
X-Google-Smtp-Source: ABdhPJwEvGMu4nE9a3O46xLP2YqS4JuIA844cg/DLuqESPnmwSXywUauGVi8oTuuIuzBV3ZR96+lIhDm29G6NoIkgK0=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr311391oig.161.1604359721116;
 Mon, 02 Nov 2020 15:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20201102142933.BlueZ.v2.1.I474ca6a46b5ae198462df03d23f46dee652f74bb@changeid>
In-Reply-To: <20201102142933.BlueZ.v2.1.I474ca6a46b5ae198462df03d23f46dee652f74bb@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Nov 2020 15:28:30 -0800
Message-ID: <CABBYNZ+ph_hu7B5_BG5urMvMFiWkj8tt6fzdpf0f7T=1DTcNpw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v2] adapter: Fix a crash caused by lingering
 discovery client pointer
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Mon, Nov 2, 2020 at 2:36 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This cleans up the lingering pointer, adapter->client, during powering
> off the adapter. The crash occurs when a D-Bus client set Powered
> property to false and immediately calls StopDiscovery() when there is
> ongoing discovery. As a part of powering off the adapter,
> adapter->discovery_list gets cleared, and given that adapter->client
> refers to one of the clients in adapter->discovery_list, adapter->client
> should be cleared along with it.
>
> (1) Connect to a BT audio device from BT system tray.
> (2) Once the audio device is connected, power off BT and immediately
> power off the audio device.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> ---
>
> Changes in v2:
> - Move the D-Bus method call clean-up to discovery_free()
>
>  src/adapter.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index c0053000a..f02ab799d 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -1496,6 +1496,7 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
>  static void discovery_free(void *user_data)
>  {
>         struct discovery_client *client = user_data;
> +       struct btd_adapter *adapter = client->adapter;
>
>         DBG("%p", client);
>
> @@ -1507,8 +1508,14 @@ static void discovery_free(void *user_data)
>                 client->discovery_filter = NULL;
>         }
>
> -       if (client->msg)
> +       if (client->msg) {
> +               if (client == adapter->client) {
> +                       g_dbus_send_message(dbus_conn,
> +                                               btd_error_busy(client->msg));
> +                       adapter->client = NULL;
> +               }
>                 dbus_message_unref(client->msg);
> +       }
>
>         g_free(client->owner);
>         g_free(client);
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
