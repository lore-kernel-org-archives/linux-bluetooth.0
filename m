Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE6520706
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbhgY+X1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgFRRhf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgFRRhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 13:37:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B19C0613EE
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 10:37:32 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so5187716otd.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 10:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCBfNmZg/9Xb+bCpZGi47AZAQwI7RzmkzN4hrII2gQI=;
        b=jbhgY+X1kxfwun4widosJ6H0UXwhG2T/OHil3rUF/Jdp0+MKeovqx7m0GXv7svqpZW
         WZVsyxP7hydRKO6gNi3Gbz8BbkHKu8X9eB9DhB/aWNZuqy7YY8AYzouWiQrnqm5mCPsw
         W88Ge4zpZrarqZB92GlDqNNNNQjpMOcEw38IeoRjMhiUCpsKaxurFxXhRPN3FAA+rv0t
         7nr9Dzas539jaoLu+GpDLv2B5llNsXbVnYb9HaxfDRoUPGyFPcpQ/q9dNJCKKvRAAdqK
         pFqurFvYo83DrdfLUi3nMybH9tUQpF8cLU8OqdiiNnJj1iHf7CjSC8rUuHOLANpap2BO
         x5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCBfNmZg/9Xb+bCpZGi47AZAQwI7RzmkzN4hrII2gQI=;
        b=rYVJvGcKxu+GurA2xeaHyB+wsatwaBGGgzSda9m7FK1DxTyTfKv6Ow23+omY+aJvLn
         +TRZ4nInhQPUdxaYNaQt4qtNvqCWEuCiLBviT0Vfl0IoGMsgzM/MoR9GnvdTILfu6er3
         Q73Q7ifWXi9lwgdaiVeRdBEPVs9RkO3OyhPA+3p7NwFmiLS9kc/mKmRRlNMtIcNdwZD/
         9sz4jR3h3N7sYz1g/KVdBmOkNorZGg2G1IM3hs3cBg6DE6nlCXV/GJvj8JvnD0tfVZGS
         Ac+9JUIHU9ULk1TPE8masCpD4m1x26xg5XzvKblfDuQMQn2gS4qseks89tRJeOnG8Yf4
         hGiw==
X-Gm-Message-State: AOAM533uX8OnNDylT3HzY8J35vzUwDA48PDLcw+57OkKSLA1aZ3esXcM
        mZcp7wZxyUtrl2+T6sS41e/iTlFAJIzHD/hw8ArCUA==
X-Google-Smtp-Source: ABdhPJwnewXl3+kMrUvDPbIAIL/C6FzSTJTs5kb7n5NwNdypDp8yx73OpVCK1GBZxRMYEd5sVddndsigGF6S3jY6fK4=
X-Received: by 2002:a9d:4691:: with SMTP id z17mr4437509ote.88.1592501851401;
 Thu, 18 Jun 2020 10:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200520212015.626026-1-luiz.dentz@gmail.com>
In-Reply-To: <20200520212015.626026-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 Jun 2020 10:37:20 -0700
Message-ID: <CABBYNZKBcpV4CNhLKkzApnEq0FWX+wbY7o4P-6sWr85j9qWhMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: Disconnect if E0 is used for Level 4
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, May 20, 2020 at 2:20 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> E0 is not allowed with Level 4:
>
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:
>
>   '128-bit equivalent strength for link and encryption keys
>    required using FIPS approved algorithms (E0 not allowed,
>    SAFER+ not allowed, and P-192 not allowed; encryption key
>    not shortened'
>
> SC enabled:
>
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>         Status: Success (0x00)
>         Handle: 256
>         Page: 1/2
>         Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           Secure Simple Pairing (Host Support)
>           LE Supported (Host)
>           Secure Connections (Host Support)
> > HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 256
>         Encryption: Enabled with AES-CCM (0x02)
>
> SC disabled:
>
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>         Status: Success (0x00)
>         Handle: 256
>         Page: 1/2
>         Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           Secure Simple Pairing (Host Support)
>           LE Supported (Host)
> > HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 256
>         Encryption: Enabled with E0 (0x01)
> [May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>         Handle: 256
>         Reason: Authentication Failure (0x05)
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/hci_core.h | 10 ++++++----
>  net/bluetooth/hci_conn.c         | 17 +++++++++++++++++
>  net/bluetooth/hci_event.c        | 20 ++++++++------------
>  3 files changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cdd4f1db8670..c69309ffd40a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1402,11 +1402,13 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>         else
>                 encrypt = 0x01;
>
> -       if (conn->sec_level == BT_SECURITY_SDP)
> -               conn->sec_level = BT_SECURITY_LOW;
> +       if (!status) {
> +               if (conn->sec_level == BT_SECURITY_SDP)
> +                       conn->sec_level = BT_SECURITY_LOW;
>
> -       if (conn->pending_sec_level > conn->sec_level)
> -               conn->sec_level = conn->pending_sec_level;
> +               if (conn->pending_sec_level > conn->sec_level)
> +                       conn->sec_level = conn->pending_sec_level;
> +       }
>
>         mutex_lock(&hci_cb_list_lock);
>         list_for_each_entry(cb, &hci_cb_list, list) {
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 307800fd18e6..b99b5c6de55a 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1323,6 +1323,23 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
>                         return 0;
>         }
>
> +        /* AES encryption is required for Level 4:
> +         *
> +         * BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C
> +         * page 1319:
> +         *
> +         * 128-bit equivalent strength for link and encryption keys
> +         * required using FIPS approved algorithms (E0 not allowed,
> +         * SAFER+ not allowed, and P-192 not allowed; encryption key
> +         * not shortened)
> +         */
> +       if (conn->sec_level == BT_SECURITY_FIPS &&
> +           !test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
> +               bt_dev_err(conn->hdev,
> +                          "Invalid security: Missing AES-CCM usage");
> +               return 0;
> +       }
> +
>         if (hci_conn_ssp_enabled(conn) &&
>             !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
>                 return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index cfeaee347db3..d6a1e2450696 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3065,27 +3065,23 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
>
>         clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
>
> +       /* Check link security requirements are met */
> +       if (!hci_conn_check_link_mode(conn))
> +               ev->status = HCI_ERROR_AUTH_FAILURE;
> +
>         if (ev->status && conn->state == BT_CONNECTED) {
>                 if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
>                         set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
>
> +               /* Notify upper layers so they can cleanup before
> +                * disconnecting.
> +                */
> +               hci_encrypt_cfm(conn, ev->status);
>                 hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
>                 hci_conn_drop(conn);
>                 goto unlock;
>         }
>
> -       /* In Secure Connections Only mode, do not allow any connections
> -        * that are not encrypted with AES-CCM using a P-256 authenticated
> -        * combination key.
> -        */
> -       if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
> -           (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
> -            conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
> -               hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
> -               hci_conn_drop(conn);
> -               goto unlock;
> -       }
> -
>         /* Try reading the encryption key size for encrypted ACL links */
>         if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
>                 struct hci_cp_read_enc_key_size cp;
> --
> 2.25.3

Looks like we had left this behind.

-- 
Luiz Augusto von Dentz
