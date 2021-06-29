Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2217AC11F67
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 20:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA2961DA6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jun 2021 20:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhF2U36 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jun 2021 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhF2U36 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jun 2021 16:29:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24DC061760
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 13:27:29 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s129so1041338ybf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jun 2021 13:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JBDOYDSTMn/hemKL1+ENVnqoTyDrtHFK7f5j/2eT9s=;
        b=SOaLOcLo8VMc9Geo/wcjM0MkSAJRW97hhetXaeUR74jMc2+hvXc6DqsVeENvjr0u6N
         5JE7DFQfpL1rbqST+Q3yQpMcSKDD+Cmh0asD+u5rLdBVvyEziN2fS1neBSAIvjoAzrn8
         5MtU5ZxKr8wJjT4sauxAK/dPz1lWR3nHyWMp5DfC2L0fiXzMhdvHyqNVcjQaEvcRhX/y
         XTMIWiETiKJRyj2VpQOoEGiuPoFdklG2BAArVXNiHfu3w/J/rXacFzBJCMfeMw+S4x0d
         IX2BBwyFhv/RdichTnmYGWBkJlQsHiXh3YbMbofHzbHRXzcONchA4Gal0YQ+H3fbc6au
         xdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JBDOYDSTMn/hemKL1+ENVnqoTyDrtHFK7f5j/2eT9s=;
        b=uaX3qpTVD1Vpcq1pokaW1RXr6/FDA9VWfqYcdHTENeGz4IXutfMkEYC0felOJEjRSm
         1PAYQdpgHPgJyZlf9t5VkDv3vSt2/wwjBsiuJt7aadj/XX/RpyKerj2M0jrbw7nqpYYm
         4HeT296OjPGionQkuC3R51PdhUQi4mAI3RJhJwu0MDuihmWZfPI242eSJe+NbewwMfiS
         IvQ/+//Dxeenqc9kNsayov7O0ekyqcBDuOJHRv9KyChE1QuXE9kbQze40lrWOYTPv12z
         JId4nC70ELvbc98iKrGuIukgJn+43Iu1pQq3WmNlmcaGP7ehmgLE2cP497LTJgxVx0K3
         ChkA==
X-Gm-Message-State: AOAM532exy7rNaycaR0u9hvzm2ZsKHLF73hI5RaYpwkBsesExOOu3bvH
        WzXrVvUzVbBBFahKlXuhD9b3jS8Xt3kUlc7ahSE=
X-Google-Smtp-Source: ABdhPJwvLnLpUc51KhSaDXwNdXdYWscxh5eDlwbk+P5B91toLwiggM5OzatRMA4FX7P6+8EWciSOyhVhqKrz+T1SBtk=
X-Received: by 2002:a5b:b44:: with SMTP id b4mr40490066ybr.440.1624998449130;
 Tue, 29 Jun 2021 13:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210629154652.BlueZ.v5.1.I832f2d744fe2cff0d9749e24c9ec27071fa0b4ed@changeid>
 <20210629154652.BlueZ.v5.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
In-Reply-To: <20210629154652.BlueZ.v5.2.I7d16f055bc51ac86915c114c671743f49a1fc226@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Jun 2021 13:27:18 -0700
Message-ID: <CABBYNZJsH_2HJXOMj7gbsKDuXwMnx+WOR7i8MiL3a_NtDu5WLA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 2/3] adapter: read quality report feature
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Joseph,

On Tue, Jun 29, 2021 at 12:47 AM Joseph Hwang <josephsih@chromium.org> wrote:
>
> This patch adds a new UUID for the quality report experimental
> feature. When reading the experimental features, it checks if
> the new feature is supported by the controller and stores the
> value in the quality_report_supported flag of the adapter.
>
> The quality_report_supported flag could be used by the bluetoothd
> to determine if the quality report feature can be enabled.
>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
>
> (no changes since v1)
>
>  src/adapter.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 98fc78f1e..e2873de46 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -284,6 +284,7 @@ struct btd_adapter {
>         bool is_default;                /* true if adapter is default one */
>
>         bool le_simult_roles_supported;
> +       bool quality_report_supported;
>  };
>
>  typedef enum {
> @@ -9234,6 +9235,12 @@ static const uint8_t le_simult_central_peripheral_uuid[16] = {
>         0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
>  };
>
> +/* 330859bc-7506-492d-9370-9a6f0614037f */
> +static const uint8_t quality_report_uuid[16] = {
> +       0x7f, 0x03, 0x14, 0x06, 0x6f, 0x9a, 0x70, 0x93,
> +       0x2d, 0x49, 0x06, 0x75, 0xbc, 0x59, 0x08, 0x33,
> +};
> +

Please add support for decoding the new UUID on src/shared/util.c
first so the likes of btmon/bluetoothctl can properly print it.

>  /* 15c0a148-c273-11ea-b3de-0242ac130004 */
>  static const uint8_t rpa_resolution_uuid[16] = {
>         0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> @@ -9276,6 +9283,14 @@ static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
>         adapter->le_simult_roles_supported = flags & 0x01;
>  }
>
> +static void quality_report_func(struct btd_adapter *adapter, uint32_t flags)
> +{
> +       adapter->quality_report_supported = le32_to_cpu(flags) & 0x01;
> +
> +       btd_info(adapter->dev_id, "quality_report_supported %d",
> +                       adapter->quality_report_supported);
> +}
> +
>  static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
>                                         const void *param, void *user_data)
>  {
> @@ -9313,6 +9328,7 @@ static const struct exp_feat {
>         EXP_FEAT(debug_uuid, exp_debug_func),
>         EXP_FEAT(le_simult_central_peripheral_uuid,
>                  le_simult_central_peripheral_func),
> +       EXP_FEAT(quality_report_uuid, quality_report_func),
>         EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
>  };
>
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
