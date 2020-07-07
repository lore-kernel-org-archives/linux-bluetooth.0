Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DBC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B592080D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 15:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie10kp3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgGGPvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGPva (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jul 2020 11:51:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6960BC061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2020 08:51:30 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so24997786lfh.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2020 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjHG2fEc32d5jG/RXXsuugh7BBMStXUSYttEp1ymo5Q=;
        b=ie10kp3godHa5Qm23qDWti0L4tWyZ/zMx7LwRaOf4n3hCjenf5eBVyb10H79rJt0pN
         Wy9g6BKfZ6Bk9XyVby49F0elUzhUuYCHmmJRKFQLm1ApnVVTN4a3QUN/qVbqAnM03WHS
         D9Rk1hloRSv+JJjR/x3NJyKRSvnAJElRWZNyrjPFFRwpzXiQTW0QsKNtB1zi/Bi7iCQb
         u8ojXFlWfW+dpEoGCFEwLKsD0l5ghIGbYOqm2USrYk6aqbHSmFsj2SaYQuuvAO5f0fRl
         7vdrIzbrVlPy6u2sOmaU99Of3SbxUsDA8CGJYA7ibxdYr8Wh+GKEzF6I2RdnwmM7PPwE
         1Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjHG2fEc32d5jG/RXXsuugh7BBMStXUSYttEp1ymo5Q=;
        b=a8ZDqHOmi+/sJKm9qBdikG5Qhdap2NwHIG/kktGkM9yUIdD2kXh51NHJ33Fi0TJnMh
         8Da3qqyZb9cTfbMrBehRBumPvwgWt6NaBdbg7TpszLu7esTc/h6cREqdQPvDSRAvd1Kx
         TCldibieizlesMxTKEOPQv8MIMPKLneVVKVhj4kGLlvPWPZf6B3kFm97w8RfNLI/3sJp
         +ctt/3hMD00/sU7PCQ+eGXT8Yh/DeQcTv8xzzI3pIXkOTdgaGQrM7GH0ZhjLyWc/9/yQ
         t7zcWYOVv3KGQAu1+e8eH9FA03F6NSb004jNT29FHlA3iOyQKHWi0Lvkv5lE1N3J/31o
         iXvA==
X-Gm-Message-State: AOAM533x9demcBcsYIHbPcCU02K5gb2X0PmRYFvcRINnVj27ct/Zg4Xv
        iFLUirZxVQDm5CvlIY5ZnChtboOYOyk46SCpkKQS6XamNwQ=
X-Google-Smtp-Source: ABdhPJwxW0awucU9IURnjrevSmYMDFPmpmkIGSSmEn7KGmWW90q20TW4lt7b8XKx+yVABP550T1J+5737Vrq8umz68Q=
X-Received: by 2002:a19:c78d:: with SMTP id x135mr33396486lff.82.1594137088645;
 Tue, 07 Jul 2020 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200707154606.52947-1-marcel@holtmann.org>
In-Reply-To: <20200707154606.52947-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 7 Jul 2020 11:51:17 -0400
Message-ID: <CALWDO_XrrtVpsB7sahBWUHrJw=eu3B3OuhYO165WwM7MdwpP5g@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: le_simult_central_peripheral experimental feature
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I'm ok with your modifications.

Thanks,
Alain


On Tue, Jul 7, 2020 at 11:46 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> From: Alain Michaud <alainm@chromium.org>
>
> This patch adds an le_simult_central_peripheral features which allows a
> clients to determine if the controller is able to support peripheral and
> central connections separately and at the same time.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5e9b9728eeac..d29da80e38fe 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
>  };
>  #endif
>
> +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> +static const u8 simult_central_periph_uuid[16] = {
> +       0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> +       0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> +};
> +
>  static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                                   void *data, u16 data_len)
>  {
> -       char buf[42];
> +       char buf[44];
>         struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
>         u16 idx = 0;
> +       u32 flags;
>
>         bt_dev_dbg(hdev, "sock %p", sk);
>
> @@ -3766,7 +3773,7 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>
>  #ifdef CONFIG_BT_FEATURE_DEBUG
>         if (!hdev) {
> -               u32 flags = bt_dbg_get() ? BIT(0) : 0;
> +               flags = bt_dbg_get() ? BIT(0) : 0;
>
>                 memcpy(rp->features[idx].uuid, debug_uuid, 16);
>                 rp->features[idx].flags = cpu_to_le32(flags);
> @@ -3774,6 +3781,20 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>         }
>  #endif
>
> +       if (hdev) {
> +               if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
> +                   (hdev->le_states[4] & 0x08) &&      /* Central */
> +                   (hdev->le_states[4] & 0x40) &&      /* Peripheral */
> +                   (hdev->le_states[3] & 0x10))        /* Simultaneous */
> +                       flags = BIT(0);
> +               else
> +                       flags = 0;
> +
> +               memcpy(rp->features[idx].uuid, simult_central_periph_uuid, 16);
> +               rp->features[idx].flags = cpu_to_le32(flags);
> +               idx++;
> +       }
> +
>         rp->feature_count = cpu_to_le16(idx);
>
>         /* After reading the experimental features information, enable
> --
> 2.26.2
>
