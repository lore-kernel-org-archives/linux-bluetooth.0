Return-Path: <SRS0=I8IU=AS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9807BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE3820708
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jul 2020 02:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfqbSYTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGGCUz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGGCUy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 22:20:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF5C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 19:20:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m26so23855571lfo.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPuUrJIlJbDH1FXvjHv4kD8C1vGWoHt9ZrDqXArb4Cw=;
        b=IfqbSYTGIG9gwzwbE44OSbtKyGpPck0hEAv1buAoqSLx9XuFT6VYMF6URNZgMoBiVs
         fcRP/sxSx5vXVM09EiloMlK5z+ueSdGYmpXoPDBJqUYzjDk6wGadK4UJ5SCMO4LirWFF
         p8Dxrr77Fj/cc19xwYj6AQJ69dNL1vIQ+lPxqWmgol0PQqLzhKMCBYqp1MgscP+Xw0Xi
         wB4S/LkaS2YzXkhSxKlRTLlqjrhBni5Ixuzeyz15TaUni3ZtawbipMA6tyJ3vf5kXhne
         gqC+87CPJ2N2xit79C38qZwEqyg8XuTsuEVCp8QH8LheGvltqqS1edPnkGYEupbIHtd5
         GbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPuUrJIlJbDH1FXvjHv4kD8C1vGWoHt9ZrDqXArb4Cw=;
        b=Ljkk9Pgq/n138BZcK6GDAL2OkZvFd6vGSrTRHIvQilktw4KwDb+OAkZlhgCekaOUDG
         JOVSCaKMvxtZHVfQrfYnokU50VKkkgon0qpmM+Eta7cJ+YFtiBUNu59koeUHpRRqIII6
         apfdHUD5BhSVeQsOU+YbNTZgHBx5DsvYNRmQSJetekavF5paTx6JPPpVGaOH4gvq05Ok
         KS3KKQWH5bzRAxVhY+m0qG2MuN4xr09hDwNTttpb3xP0Zvyvmd8e2w6MI65slv1w8vrH
         LprdQMeoHnjuyGfBb5WHMYePOz/2aaCPlFlZG/s6wF+SaQSKEXjf6hEcgMvsLFeHmxbu
         H5pw==
X-Gm-Message-State: AOAM532vz/qE8YimY+RYjLOKvFu4OcyVMOyPweoTbWuwbc65KzurSrr6
        ItP36QStRtKzfwKnZKBR+KxOwg50opZupKShlYkj5w==
X-Google-Smtp-Source: ABdhPJwzY+VqX5Gt/y/9Auo2JsStC5oI5oUZTHZfESmAgNaW9McxJUfWPEP07zIEGGG4OgRksz6mT/pPgIjCGQJHx/c=
X-Received: by 2002:a19:64c:: with SMTP id 73mr32293247lfg.0.1594088452637;
 Mon, 06 Jul 2020 19:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200706154449.3828193-1-alainm@chromium.org>
In-Reply-To: <20200706154449.3828193-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 6 Jul 2020 22:20:41 -0400
Message-ID: <CALWDO_UXbOn9WNcR6nU-haFd2uKxeJFg0WFezchOxO7GcajCtg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: le_simult_central_peripheral experimental feature
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Here is the userspace change associated with this change:
https://patchwork.kernel.org/project/bluetooth/list/?series=313771

On Mon, Jul 6, 2020 at 11:44 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch adds an le_simult_central_peripheral features which allows a
> clients to determine if the controller is able to support peripheral and
> central connections separately and at the same time.
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> ---
>
> Changes in v3:
>  - Back to the original design of V1 and integrated Marcel's feedback.
>
> Changes in v2:
>  - Slight change of design based on offline feedback
>
>  net/bluetooth/mgmt.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5e9b9728eeac..b34e6f3c07ec 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3753,12 +3753,19 @@ static const u8 debug_uuid[16] = {
>  };
>  #endif
>
> +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> +static const u8 le_simult_central_peripheral[16] = {
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
> @@ -3774,6 +3781,19 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>         }
>  #endif
>
> +       flags = 0;
> +       memcpy(rp->features[idx].uuid, le_simult_central_peripheral,
> +              sizeof(le_simult_central_peripheral));
> +
> +       if (hdev && test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
> +           (hdev->le_states[4] & 0x08) &&      /* Central */
> +           (hdev->le_states[4] & 0x40) &&      /* Peripheral */
> +           (hdev->le_states[3] & 0x10)         /* Simultaneous */)
> +               flags |= BIT(0);
> +
> +       rp->features[idx].flags = cpu_to_le32(flags);
> +       idx++;
> +
>         rp->feature_count = cpu_to_le16(idx);
>
>         /* After reading the experimental features information, enable
> --
> 2.27.0.212.ge8ba1cc988-goog
>
