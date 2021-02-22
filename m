Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A403C433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E9D64F00
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhBVRrV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBVRrT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 12:47:19 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A47C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 09:46:39 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id b16so12823495otq.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNcGkeUzVjixpuVyco2yj7vpaXgIisaqvdaFOnqvkQM=;
        b=Z10ZoHcPgDR6hzLIQ09EFcC+2Aq5zCdqePMubHAjMKG0lbL7jyVtSzYZz3UZAlaiFX
         5XOE/LNYN7dfAfMJ8J+OxwLsjTdzMrRS2Xf5xbg3JVdZKilsLwvW4lctyL6cCjxQMu5O
         jZrKuJ2LweDA/SbAs7LToHaw6vjMdvYwxCKkAIWhbu8v1q+lnwqgP1xZgl4GkFwLLYgg
         KFnHlNXycGJr9q4Kll7N/A9TJVC91fWrM1gO52AT6m8idDbg/hiCDNVNLbeP+LmTFr8Z
         vsCtvQqoLLQ4LErDu+TCj/f2Ad7OOFeH0fUIBwRI8qY7r4JNQbPRQBTTWtn2VN8smlPi
         F7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNcGkeUzVjixpuVyco2yj7vpaXgIisaqvdaFOnqvkQM=;
        b=I1aAVAXE2jxv5UR9cVZEB7zjePf+DhGcMaGC9zSMFXUe055BUh5uZyC1H7qchInJ2d
         VnvNKd744E7KWmSdfBb5chKbk3x3In5Dc4/sWsy0TbUAF6I0hGXSqtGRrHcy5GRHYU8h
         r4ca4NLZZi9Sr8ThoW5Un9OLDd6BgWi9yy67r4IUr+0vgSnZIRlFpg9rjzIuSfrPJ6XE
         5yS11FdE4goQdK6pR6vuByXLScnkRV4IF8YxAElUYzOCGReZHD3vx2R64yVhN4hncJQp
         L69GbXGZl9sVU6zG9JF3wXMKuJcZjCTNO2PmmJdTc+8Ttmk04tRfbqv/AgbkUHhEFiX0
         MCIw==
X-Gm-Message-State: AOAM5311ec2LkM2a+SyaFHAxzq1I5nUFHYxGcWmUaKb2afDaFy1688iD
        4aF2UgV1ErmfHvVaEL9tRHDIwnFcsIrzckZ+4+Iu/GPtfaE=
X-Google-Smtp-Source: ABdhPJy6mDcmu7m8/ozLfPi4N3lGMkbukfaL9tIYEo0oKz7DUZZJtr7GrvEiDoAyx8UX4N8uYKYvfAhtrQNrmqoEN/4=
X-Received: by 2002:a9d:60c9:: with SMTP id b9mr17859961otk.371.1614015998838;
 Mon, 22 Feb 2021 09:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20210222103021.20923-1-magdalena.kasenberg@codecoup.pl>
In-Reply-To: <20210222103021.20923-1-magdalena.kasenberg@codecoup.pl>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Feb 2021 09:46:28 -0800
Message-ID: <CABBYNZKnDGQM_0GY5OwQg6KD=NigeWf+3pSJU3tDsJpc4cQibw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix for L2CAP/LE/CFC/BV-15-C
To:     Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Magdalena,

On Mon, Feb 22, 2021 at 2:34 AM Magdalena Kasenberg
<magdalena.kasenberg@codecoup.pl> wrote:
>
> This is required for the qualification test L2CAP/LE/CFC/BV-15-C
>
> Implementation does not allow to set different key size for SMP and
> L2CAP, which is needed for a current specification of the test. This fix
> workarounds it with the debugfs variable le_l2cap_min_key_size.
>
> Logs from the test when the IUT uses a min and max l2cap encryption key size 16.
> $ echo 16 > /sys/kernel/debug/bluetooth/hci0/le_l2cap_min_key_size
> The lower tester uses a key size 7.
>
> > ACL Data RX: Handle 99 flags 0x02 dlen 11                #34 [hci0] 25.007392
>       SMP: Pairing Request (0x01) len 6
>         IO capability: DisplayYesNo (0x01)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>         Max encryption key size: 7
>         Initiator key distribution: <none> (0x00)
>         Responder key distribution: <none> (0x00)
> < ACL Data TX: Handle 99 flags 0x00 dlen 11                #35 [hci0] 25.007591
>       SMP: Pairing Response (0x02) len 6
>         IO capability: KeyboardDisplay (0x04)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
>         Max encryption key size: 16
>         Initiator key distribution: <none> (0x00)
>         Responder key distribution: <none> (0x00)
> @ MGMT Event: New Long Term Key (0x000a) plen 37      {0x0001} [hci0] 28.788872
>         Store hint: Yes (0x01)
>         LE Address: C0:DE:C0:FF:FF:01 (OUI C0-DE-C0)
>         Key type: Unauthenticated key from P-256 (0x02)
>         Master: 0x00
>         Encryption size: 7
>         Diversifier: 0000
>         Randomizer: 0000000000000000
>         Key: 529e11e8c7b9f5000000000000000000
>
> <snip>
>
> After pairing with key size 7, L2CAP connection is requested which
> requires key size 16.
>
> > ACL Data RX: Handle 99 flags 0x02 dlen 18                #56 [hci0] 34.998084
>       LE L2CAP: LE Connection Request (0x14) ident 3 len 10
>         PSM: 244 (0x00f4)
>         Source CID: 64
>         MTU: 256
>         MPS: 284
>         Credits: 1
> < ACL Data TX: Handle 99 flags 0x00 dlen 18                #57 [hci0] 34.998325
>       LE L2CAP: LE Connection Response (0x15) ident 3 len 10
>         Destination CID: 0
>         MTU: 0
>         MPS: 0
>         Credits: 0
>         Result: Connection refused - insufficient encryption key size (0x0007)
>
> Signed-off-by: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
> Reviewed-by: Szymon Janc <szymon.janc@codecoup.pl>

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

> Cc: Szymon Janc <szymon.janc@codecoup.pl>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         |  1 +
>  net/bluetooth/hci_debugfs.c      | 30 ++++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c       | 25 +++++++++++++++++++++++++
>  4 files changed, 57 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index ebdd4afe30d2..0bf0543efec5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -379,6 +379,7 @@ struct hci_dev {
>         __u16           auth_payload_timeout;
>         __u8            min_enc_key_size;
>         __u8            max_enc_key_size;
> +       __u8            le_l2cap_min_key_size;
>         __u8            pairing_opts;
>         __u8            ssp_debug_mode;
>         __u8            hw_error_code;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b0d9c36acc03..9ef4b39b380c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3788,6 +3788,7 @@ struct hci_dev *hci_alloc_dev(void)
>         hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
>         hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
>         hdev->min_enc_key_size = HCI_MIN_ENC_KEY_SIZE;
> +       hdev->le_l2cap_min_key_size = HCI_MIN_ENC_KEY_SIZE;
>
>         /* default 1.28 sec page scan */
>         hdev->def_page_scan_type = PAGE_SCAN_TYPE_STANDARD;
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 1a0ab58bfad0..dec8b96b8427 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -1096,6 +1096,34 @@ static int max_key_size_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(max_key_size_fops, max_key_size_get,
>                           max_key_size_set, "%llu\n");
>
> +static int le_l2cap_min_key_size_set(void *data, u64 val)
> +{
> +       struct hci_dev *hdev = data;
> +
> +       if (val > SMP_MAX_ENC_KEY_SIZE || val < SMP_MIN_ENC_KEY_SIZE)
> +               return -EINVAL;
> +
> +       hci_dev_lock(hdev);
> +       hdev->le_l2cap_min_key_size = val;
> +       hci_dev_unlock(hdev);
> +
> +       return 0;
> +}
> +
> +static int le_l2cap_min_key_size_get(void *data, u64 *val)
> +{
> +       struct hci_dev *hdev = data;
> +
> +       hci_dev_lock(hdev);
> +       *val = hdev->le_l2cap_min_key_size;
> +       hci_dev_unlock(hdev);
> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(le_l2cap_min_key_size_fops, le_l2cap_min_key_size_get,
> +                        le_l2cap_min_key_size_set, "%llu\n");
> +
>  static int auth_payload_timeout_set(void *data, u64 val)
>  {
>         struct hci_dev *hdev = data;
> @@ -1226,6 +1254,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
>                             &min_key_size_fops);
>         debugfs_create_file("max_key_size", 0644, hdev->debugfs, hdev,
>                             &max_key_size_fops);
> +       debugfs_create_file("le_l2cap_min_key_size", 0644, hdev->debugfs, hdev,
> +                           &le_l2cap_min_key_size_fops);
>         debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
>                             &auth_payload_timeout_fops);
>         debugfs_create_file("force_no_mitm", 0644, hdev->debugfs, hdev,
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 72c2f5226d67..d9a3a1c1f366 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5742,6 +5742,20 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>         return err;
>  }
>
> +static bool le_l2cap_key_size_sufficient(struct hci_conn *hcon, u8 sec_level)
> +{
> +       struct smp_ltk *ltk;
> +
> +       if (sec_level == BT_SECURITY_LOW)
> +               return true;
> +
> +       ltk = hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type, hcon->role);
> +       if (ltk && ltk->enc_size >= hcon->hdev->le_l2cap_min_key_size)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int l2cap_le_connect_req(struct l2cap_conn *conn,
>                                 struct l2cap_cmd_hdr *cmd, u16 cmd_len,
>                                 u8 *data)
> @@ -5788,6 +5802,12 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
>                 goto response_unlock;
>         }
>
> +       if (!le_l2cap_key_size_sufficient(conn->hcon, pchan->sec_level)) {
> +               result = L2CAP_CR_LE_BAD_KEY_SIZE;
> +               chan = NULL;
> +               goto response_unlock;
> +       }
> +
>         /* Check for valid dynamic CID range */
>         if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
>                 result = L2CAP_CR_LE_INVALID_SCID;
> @@ -5969,6 +5989,11 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>                 goto unlock;
>         }
>
> +       if (!le_l2cap_key_size_sufficient(conn->hcon, pchan->sec_level)) {
> +               result = L2CAP_CR_LE_BAD_KEY_SIZE;
> +               goto unlock;
> +       }
> +
>         result = L2CAP_CR_LE_SUCCESS;
>         cmd_len -= sizeof(*req);
>         num_scid = cmd_len / sizeof(u16);
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
