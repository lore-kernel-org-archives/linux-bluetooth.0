Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE66C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41C620663
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHJE/ZuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGOPkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOPkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 11:40:20 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7F8C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 08:40:19 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id c4so547390oou.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5n8TYGp5vc2hXKBCFOAMT1bwN0hqgSluIwICLUpdYjU=;
        b=kHJE/ZuLR/YtlhVnRHj7qPqtjnNImMXGbqPJhuhzQD05rklspcMm5S8+CXCYfspkAb
         PWUFaVXP5iUff9elBfB0kuJsl2Y305jpguuJXQST7RvJiwqV0/E/j/3Gps6d39jad9bQ
         cPqAPLhIQ+GI1GUhdduSB9A1lgC0MjtOHutnQFsQQjjbxbQ496Kq+4QzwGZ1VPN2FSRE
         sItYRYK52kWHv8gknNgy/S/dR4XQSeH95bH6KGzRNmqIc1Otj6hmgrlal8v3tey8ONjw
         eW1pQ0lqLZfUslUICKbWqMD8y4n0Z0twAhPlc5KgB9kNRjUfeQf5BeUCBflXXOCFIwlp
         NzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5n8TYGp5vc2hXKBCFOAMT1bwN0hqgSluIwICLUpdYjU=;
        b=jvgM9se5fnFGxO74Y1zrsx2DhGY90kcE+y8ImD0amxSCKE1HbyLAZlGEvAKzFyZ+3j
         IGjtAINYC2v59ZaxGER2qDkKhq2z+QtqM82Ouqko+TT55eUX3sQyGFMpi0HLhCSJcxHN
         t6MzUWSaM5UMmw68BBmDBYja3jCPnmrYERl4IaZZQO7YgqpvwKwYZOyCuftXB2MSqj3J
         48hnTpsPBZ1Xtu0C+47phS6fhhPXYio0d9NrZ8DM5CHA32wy2LdPQFzJ7g3BOXgFczjH
         h3zFYDCMWu2S2oxl8BtMZX6G+8s0Dl5isKpiMGYRkuNCmIIRtzgzwyhWU0i6D5WXz3Sh
         0fkg==
X-Gm-Message-State: AOAM531lRIfNVt54TcVJhDVBnN0QWixZmpMWWRtVWHpHOljLloSkTJ7U
        4OXf1RhhbFYxEadVCQ5yCKo6hLgk6D5f97d/f7g=
X-Google-Smtp-Source: ABdhPJyKTSURCK/qkwjxm9Qv8gCGrqcVOxIOdOjya4ldV5COZBVp7TYLNj3dqNtFltv3gaGeHvsYvcjFDXO9HncpIHY=
X-Received: by 2002:a4a:3405:: with SMTP id b5mr10065284ooa.9.1594827619020;
 Wed, 15 Jul 2020 08:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
In-Reply-To: <0df5bf3eac160de28b9493a8959510980a8a8e8b.1594803508.git.ps@pks.im>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Jul 2020 08:40:05 -0700
Message-ID: <CABBYNZKixtkC30bwQG-Zx5E0i1+mTRhd+8c-ns5jGBh2yiszeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix updating connecton state in `hci_encrypt_cfm`
To:     Patrick Steinhardt <ps@pks.im>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Patrick,

On Wed, Jul 15, 2020 at 7:50 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> Starting with the upgrade to v5.8-rc3, I've noticed I wasn't able to
> connect to my Bluetooth headset properly anymore. While connecting to
> the device would eventually succeed, bluetoothd seemed to be confused
> about the current connection state where the state was flapping hence
> and forth. Bisecting this issue led to commit 3ca44c16b0dc ("Bluetooth:
> Consolidate encryption handling in hci_encrypt_cfm"), which refactored
> `hci_encrypt_cfm` to also handle updating the connection state.
>
> The commit in question changed the code to call `hci_connect_cfm` inside
> `hci_encrypt_cfm` and updating the connection state. But the conversion
> didn't keep old behaviour of when the connection state is updated, which
> now causes us to not properly update it anymore.
>
> Fix the issue by adding another parameter to the function that allows
> callers to specify whether the connection state should be updated, which
> allows us to restore previous behaviour.
>
> Fixes: 3ca44c16b0dc ("Bluetooth: Consolidate encryption handling in hci_encrypt_cfm")
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  include/net/bluetooth/hci_core.h | 4 ++--
>  net/bluetooth/hci_event.c        | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cdd4f1db8670..9abcc4a89abc 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1381,13 +1381,13 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
>                 conn->security_cfm_cb(conn, status);
>  }
>
> -static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
> +static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status, __u8 update_state)
>  {
>         struct hci_cb *cb;
>         __u8 encrypt;
>
>         if (conn->state == BT_CONFIG) {
> -               if (status)
> +               if (update_state)

The intent was actually to have if (!status) as it means the
encryption has succeeded the state can be considered connected, so I
wonder if we really need to introduce another parameter. Anyway as it
is broken we need to come up with a fix rather quickly.

>                         conn->state = BT_CONNECTED;
>
>                 hci_connect_cfm(conn, status);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index cfeaee347db3..483d35eda2f1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2931,7 +2931,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
>                                      &cp);
>                 } else {
>                         clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
> -                       hci_encrypt_cfm(conn, ev->status);
> +                       hci_encrypt_cfm(conn, ev->status, 0);
>                 }
>         }
>
> @@ -3016,7 +3016,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
>                 conn->enc_key_size = rp->key_size;
>         }
>
> -       hci_encrypt_cfm(conn, 0);
> +       hci_encrypt_cfm(conn, 0, 1);
>
>  unlock:
>         hci_dev_unlock(hdev);
> @@ -3134,7 +3134,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
>         }
>
>  notify:
> -       hci_encrypt_cfm(conn, ev->status);
> +       hci_encrypt_cfm(conn, ev->status, !ev->status);
>
>  unlock:
>         hci_dev_unlock(hdev);
> --
> 2.27.0
>


-- 
Luiz Augusto von Dentz
