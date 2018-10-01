Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5F0C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213952089D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOlUtUIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213952089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbeJASV5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:21:57 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42334 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbeJASV5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 14:21:57 -0400
Received: by mail-oi1-f182.google.com with SMTP id w81-v6so9173246oiw.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wKpuuGmtBz/8FzFUwYClsbEBEq8e9x0sZrtv7F6rnEE=;
        b=rOlUtUIFnoLbYZhKnVzB+rrbnTcNxdcD4mTLovZbciCIMD9XISMhYOVyo5ocrMCk4W
         b+J+DINbG22wLmK5UBW1EPv7qo8fONfMLrugJnaB2+HdxL4RMUsnM/Q+cy8wA+MkBJBa
         kiu7QXeSQnuiAPtKH9hbdZzgn7coEt1BvtbAlgyR4+yg83Zw9Z2uJm8Taf7hFDdR0P17
         9HUofqDPilVClnV5yxBEs/jDYNntOSbljIUbM+LsRPfZALIUBrZvn6+qyYROKtEBGkCE
         HFDy1Qraf3MuBy7K40FJnFIBCIagIRh/8UjKdDGUCzjZoljO60XVGOyODIuxg4dfXBoT
         /04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wKpuuGmtBz/8FzFUwYClsbEBEq8e9x0sZrtv7F6rnEE=;
        b=cREInmUq6YcK7MeK8hIyX8OKg7CUKe5WZvjM0XxQsZY4EeEFW1/m3vEQ5DdKUKXAR/
         Jwh3l3QDD15K5QGYc1y7x113dJvHRK6gJKyt5Qep46KYtDEAKX7u1LAUWeCJ+tje/tTk
         65t70nBUfxyBAcSDoMScKwYMPQiCC2o22Qw2ktN3ecZNfKj1th7JLCa97zCrcRaiQP9Q
         d23rOmtiCW7tbmN+cDzlaeGKVtZtK6iknQLIRN6tqU6dSpyAgyRMrWiLu8TLRDm8G7XJ
         menFoQn+ptVTXZnfOWzz/CYP8W8/0eiKvk+Puhss6+HHCRngPEqRjLEqi+dvLYYOueuY
         P87A==
X-Gm-Message-State: ABuFfohhcUwW931n6+wNMOS8wvDg3HdB91IS9jN68dSHSomDOZIQRPVj
        m0Ht7Sy/QdnUaWlHIGLJKfv/gvPYekANu9qbXJyztQ==
X-Google-Smtp-Source: ACcGV60wcHtv8ehi8g1qdGodx4kPnj3fd1FgE8Xsv1szOjUNhrpb79c5bzPzrSexD8m1BPSboUUxSAUJA6fX5Gpaczo=
X-Received: by 2002:aca:60c1:: with SMTP id u184-v6mr4461519oib.99.1538394273194;
 Mon, 01 Oct 2018 04:44:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:550:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 04:44:32 -0700 (PDT)
In-Reply-To: <20181001111338.11634-1-luiz.dentz@gmail.com>
References: <20181001111338.11634-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 1 Oct 2018 14:44:32 +0300
Message-ID: <CABBYNZKOij42rhG59VPyLTcdzA9se1BUX_RVhG7n4u6hvNn=HA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Fix not cleaning up device state properly
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Yunhan Wang <yunhanw@google.com>,
        Sukesh Srikakula <sukeshs@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Oct 1, 2018 at 2:13 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the device is removed locally device_free would end up calling
> bt_att_unref which won't trigger any disconnect callback necessary
> to remove device states.
> ---
>  src/device.c        |  3 +++
>  src/gatt-database.c | 24 ++++++++++++++++++++++++
>  src/gatt-database.h |  2 ++
>  3 files changed, 29 insertions(+)
>
> diff --git a/src/device.c b/src/device.c
> index ef5b8f86a..5ddfb9266 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -580,6 +580,9 @@ static void gatt_server_cleanup(struct btd_device *device)
>
>         bt_gatt_server_unref(device->server);
>         device->server = NULL;
> +
> +       btd_gatt_database_att_disconnected(
> +                       btd_adapter_get_database(device->adapter), device->att);
>  }
>
>  static void attio_cleanup(struct btd_device *device)
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index abcf7b759..bdabcb4d6 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -3349,6 +3349,30 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>         state->pending = NULL;
>  }
>
> +void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
> +                                               struct bt_att *att)
> +{
> +       struct device_state *state;
> +       bdaddr_t bdaddr;
> +       uint8_t bdaddr_type;
> +
> +       DBG("");
> +
> +       if (!get_dst_info(att, &bdaddr, &bdaddr_type))
> +               return;
> +
> +       state = find_device_state(database, &bdaddr, bdaddr_type);
> +       if (!state)
> +               return;
> +
> +       if (state->disc_id) {
> +               bt_att_unregister_disconnect(att, state->disc_id);
> +               state->disc_id = 0;
> +       }
> +
> +       att_disconnected(0, state);
> +}
> +
>  static void restore_ccc(struct btd_gatt_database *database,
>                         const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
>  {
> diff --git a/src/gatt-database.h b/src/gatt-database.h
> index a6c3139c4..9e7cda8c2 100644
> --- a/src/gatt-database.h
> +++ b/src/gatt-database.h
> @@ -25,5 +25,7 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
>  struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
>  void btd_gatt_database_att_connected(struct btd_gatt_database *database,
>                                                 struct bt_att *att);
> +void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
> +                                               struct bt_att *att);
>
>  void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
> --
> 2.17.1
>



-- 
Luiz Augusto von Dentz
