Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E28C18E01
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 08:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E6A2145D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 08:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZljsVCBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E6A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKTTSh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:18:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37694 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeKTTSc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 14:18:32 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so985834oth.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8ZIFDHr7ZftwhrBHcMZ1HNvBlaRD4+FZney/mWN3Hg=;
        b=ZljsVCBb6jGZFfSkuD3Z8omycrNkZjn5zTPu3fEVVOnWaC6v2I1U7u9IthgCXy+hPB
         nFrDuA5QYyemMXn+qtMFDRq1Oyb8ZbjedBFBuU7Nwd5xfKESJeKNQPXk9rfxTPrsVBQ2
         8U2R6ODYMVv0c3on3mFVQGANq53PeUhb6F/+rAPBTSlw5Kfrx9FLZtyRO/0cbbtpobXu
         6j4pfR5LQnlnrxuiajDUTL5GKVzO1/5to7gOWAlaF7xky3ihhhObGTwyFUfIMCQDsXHY
         XSnbYEzbCMCHdIr39SWWOQlgPVVTGE5VjkjPpyr1A/IMPsa5/dkY6j09NgAYnP/gBE/Y
         PpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8ZIFDHr7ZftwhrBHcMZ1HNvBlaRD4+FZney/mWN3Hg=;
        b=U4N5viOugLtnPikIwQwdXYtbYglV98FsqeCsbJWJMflnFYFzYrtbyu3ghmPeNfT/n8
         MKBSncsp6N292/K3ZNN1KejbU7tg/gbKxtXs6nlXRCeBxGLvlpT0jc7dsZ1vNbtdAvgC
         kn/YuncodW8sNBDjGZjhXkEqqrtf/RAe3J2J2/5pv0V/NsWVIOR/uTAab1w52HAe5KGO
         CaoVyOU6Vco8wLVjPQJGFnpHjjW1tDivqxb4TFv0mnD7w1z1uzyd9eR8szg4ZDGNGIYA
         39QFTK3tg/xjxtRsCKjeXTLot2+gW0jlT2OQrtrym3g/8gm9Ayu9i0q9tMv6M9t0ZMBJ
         2VrA==
X-Gm-Message-State: AA+aEWao3rCa3kr0O9ni5yi5bXLb9xMp9fKmK14+NLjLOI8RdbjNiUhr
        R99zks8PghnbTWZ3axgd/Mqi9gZFI6MjKSWWyvg8KQ==
X-Google-Smtp-Source: AFSGD/XsaBTWov1reY4LhDnsiAJ8iWuiZsWq4h7rAtCzE3f+q47hXCcQ4zuHoDNsF4RPiKk/qwiG0YYc1bkHVV08/ec=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr571541otp.254.1542703832200;
 Tue, 20 Nov 2018 00:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20181119154311.27826-1-luiz.dentz@gmail.com>
In-Reply-To: <20181119154311.27826-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 20 Nov 2018 10:50:20 +0200
Message-ID: <CABBYNZK90H=0e4GKo1g96jYkg3EM+5C2DhbCvi-Cgtd8W+E3YA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] gatt: Fix invalid read when disconnecting
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     gbenhaim@augury.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Nov 19, 2018 at 5:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> In case there is a client of AcquireNotify and a disconnect happens the
> code not only have to free the client object but also destroy the io
> associated with it, for this reason the client object cannot be freed
> until the io is destroyed otherwise it may lead to the following error:
>
> Invalid read of size 4
>    at 0x63920: notify_io_destroy (gatt-client.c:1461)
>    by 0x63EDB: pipe_io_destroy (gatt-client.c:1082)
>    by 0x6405B: characteristic_free (gatt-client.c:1663)
>    by 0x81F33: remove_interface (object.c:667)
>    by 0x826CB: g_dbus_unregister_interface (object.c:1391)
>    by 0x85D2B: queue_remove_all (queue.c:354)
>    by 0x635F7: unregister_service (gatt-client.c:1893)
>    by 0x85CF7: queue_remove_all (queue.c:339)
>    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
>    by 0x695CB: gatt_service_removed (device.c:3747)
>    by 0x85B17: queue_foreach (queue.c:220)
>    by 0x91283: notify_service_changed (gatt-db.c:280)
>    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
>  Address 0x515ed48 is 0 bytes inside a block of size 20 free'd
>    at 0x483EAD0: free (vg_replace_malloc.c:530)
>    by 0x85D2B: queue_remove_all (queue.c:354)
>    by 0x636D3: unregister_characteristic (gatt-client.c:1741)
>    by 0x85D2B: queue_remove_all (queue.c:354)
>    by 0x635F7: unregister_service (gatt-client.c:1893)
>    by 0x85CF7: queue_remove_all (queue.c:339)
>    by 0x661DF: btd_gatt_client_service_removed (gatt-client.c:2199)
>    by 0x695CB: gatt_service_removed (device.c:3747)
>    by 0x85B17: queue_foreach (queue.c:220)
>    by 0x91283: notify_service_changed (gatt-db.c:280)
>    by 0x91283: gatt_db_service_destroy (gatt-db.c:291)
>    by 0x85D2B: queue_remove_all (queue.c:354)
>    by 0x91387: gatt_db_clear_range (gatt-db.c:475)
> ---
>  src/gatt-client.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 234f46ed7..55aa5e423 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -1645,13 +1645,22 @@ static const GDBusMethodTable characteristic_methods[] = {
>         { }
>  };
>
> +static void remove_client(void *data)
> +{
> +       struct notify_client *ntfy_client = data;
> +       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> +
> +       queue_remove(client->all_notify_clients, ntfy_client);
> +
> +       notify_client_unref(ntfy_client);
> +}
> +
>  static void characteristic_free(void *data)
>  {
>         struct characteristic *chrc = data;
>
>         /* List should be empty here */
>         queue_destroy(chrc->descs, NULL);
> -       queue_destroy(chrc->notify_clients, NULL);
>
>         if (chrc->write_io) {
>                 queue_remove(chrc->service->client->ios, chrc->write_io->io);
> @@ -1663,6 +1672,8 @@ static void characteristic_free(void *data)
>                 pipe_io_destroy(chrc->notify_io);
>         }
>
> +       queue_destroy(chrc->notify_clients, remove_client);
> +
>         g_free(chrc->path);
>         free(chrc);
>  }
> @@ -1715,16 +1726,6 @@ static struct characteristic *characteristic_create(
>         return chrc;
>  }
>
> -static void remove_client(void *data)
> -{
> -       struct notify_client *ntfy_client = data;
> -       struct btd_gatt_client *client = ntfy_client->chrc->service->client;
> -
> -       queue_remove(client->all_notify_clients, ntfy_client);
> -
> -       notify_client_unref(ntfy_client);
> -}
> -
>  static void unregister_characteristic(void *data)
>  {
>         struct characteristic *chrc = data;
> @@ -1738,7 +1739,6 @@ static void unregister_characteristic(void *data)
>         if (chrc->write_op)
>                 bt_gatt_client_cancel(gatt, chrc->write_op->id);
>
> -       queue_remove_all(chrc->notify_clients, NULL, NULL, remove_client);
>         queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
>
>         g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
> --
> 2.17.2

Can you try with this set to see it does work properly.

--
Luiz Augusto von Dentz
