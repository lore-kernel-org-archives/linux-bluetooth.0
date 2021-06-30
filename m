Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9DC11F68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 19:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C7961461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jun 2021 19:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhF3T6u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhF3T6t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jun 2021 15:58:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4706C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jun 2021 12:56:19 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p22so6952204yba.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jun 2021 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcWIcPqTc0HFuDTM1dyCVwgLiO+3qNHfRECEP1I29AI=;
        b=M+CbyLmjSijWq3uBd5WJgirHiF1x/qTCZzWnMrS4fK1tAEMp2+v8EWs9EkZCOriYtv
         IdXXpoyqeI/wi7YJwVU4auMJPL72l9PXhuJ5ULf7dip9xud3WEofueu4JbEa7V8kWdi1
         BDFJriXgffMvDWzl9ILeWJMiXn3xC3xiPA4AKtum8bk5fZRaX7y5oMwKZRzg1jRWnhQL
         JPfWFMWtx3iidQ41AAuh//OKB2gCM34r9i+IDG2Y8VWn4AG/deorja3G2nYYZqqmxjKT
         v8A8ANN0WjKkc0iCZVOuZM7/xIy2rG30S08RfYEqfy9WHIMrtx0gUj2XqysR0hRCnpmJ
         d+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcWIcPqTc0HFuDTM1dyCVwgLiO+3qNHfRECEP1I29AI=;
        b=V8O1nP9jQnoTSP8TwH96W+W/ebxaQ6KK2DPVrhUQwdppSmPGd6R6kwYRbvm+jscuRI
         xSZfFAeyyBoW8KIuE/xTHm4fYQse5txp0EZhjKaX6iqjE1EF/il8Ne8tUwOJByNsFP5U
         ykH94jGljcweoufN4qkUa1MgcxC2ipw8wgduVNPi1myY4nCoEFOwxdHfk0nANZiVeF0w
         w6RmlP69oNqf6iGK3KdYSrNl+4tHVsu8n9XiK0wXcsvgPJzovy3of97bI0RMuZaNj2e/
         SyO+VcEIIOqa6MIWa6QcouosgOM8PjCaRb03Oyi3nzjEyoQJxmULrdHoBqWeByzLplJ2
         YvMw==
X-Gm-Message-State: AOAM533sy8QpXEN+Hbe1Ra1iwEE41xwLveZeWFXq5Kyy02G8UAA6R90e
        y+cSxNKWJSPF7v4Zo4glBAUrOn/QZQNTyZUqNx8=
X-Google-Smtp-Source: ABdhPJx9Hn9oJypuyX1JEqaPa0jSxo2pBkly4f3M7UZcSaU7ECLoLMg00LRVWXUyoRV6dIWK7RanHpAU8g4SigjfaaU=
X-Received: by 2002:a05:6902:114c:: with SMTP id p12mr49137181ybu.282.1625082978850;
 Wed, 30 Jun 2021 12:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210630080807.12600-1-kiran.k@intel.com> <20210630080807.12600-10-kiran.k@intel.com>
In-Reply-To: <20210630080807.12600-10-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Jun 2021 12:56:08 -0700
Message-ID: <CABBYNZK-bE6vxikRHhxBM_7ucyZqMjxUBY6VEyw_e8C_xxAigA@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Wed, Jun 30, 2021 at 1:08 AM Kiran K <kiran.k@intel.com> wrote:
>
> Allow user level process to enable / disable codec offload
> feature through mgmt interface. By default offload codec feature
> is disabled.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v10:
>   - new patch added to place offload codec feature under experimental flag
>
>  include/net/bluetooth/hci.h |   4 ++
>  net/bluetooth/mgmt.c        | 106 +++++++++++++++++++++++++++++++++++-
>  net/bluetooth/sco.c         |  10 ++++
>  3 files changed, 119 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e20318854900..5ca98d9f64dd 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -331,6 +331,10 @@ enum {
>         HCI_CMD_PENDING,
>         HCI_FORCE_NO_MITM,
>
> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> +       HCI_OFFLOAD_CODECS_ENABLED,
> +#endif

That is probably a bad idea as it could lead the enum to assume
different values based on what is enabled, besides we don't gain
anything by not having the symbol defined all the time.

> +
>         __HCI_NUM_FLAGS,
>  };
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3663f880df11..d7be85eb52e7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3791,6 +3791,14 @@ static const u8 debug_uuid[16] = {
>  };
>  #endif
>
> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> +/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
> +static const u8 offload_codecs_uuid[16] = {
> +       0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
> +       0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
> +};
> +#endif
> +
>  /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
>  static const u8 simult_central_periph_uuid[16] = {
>         0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> @@ -3806,7 +3814,7 @@ static const u8 rpa_resolution_uuid[16] = {
>  static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                                   void *data, u16 data_len)
>  {
> -       char buf[62];   /* Enough space for 3 features */
> +       char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
>         struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
>         u16 idx = 0;
>         u32 flags;
> @@ -3850,6 +3858,28 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                 idx++;
>         }
>
> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> +       if (hdev) {

If we have HCI_OFFLOAD_CODECS_ENABLED defined you can just use
IS_ENABLED within the if statement below.

> +               if (hdev->get_data_path_id) {
> +                       /* BIT(0): indicating if offload codecs are
> +                        * supported by controller.
> +                        */
> +                       flags = BIT(0);
> +
> +                       /* BIT(1): indicating if codec offload feature
> +                        * is enabled.
> +                        */
> +                       if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
> +                               flags |= BIT(1);
> +               } else {
> +                       flags = 0;
> +               }
> +               memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
> +               rp->features[idx].flags = cpu_to_le32(flags);
> +               idx++;
> +       }
> +#endif
> +
>         rp->feature_count = cpu_to_le16(idx);
>
>         /* After reading the experimental features information, enable
> @@ -3892,6 +3922,23 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
>  }
>  #endif
>
> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)
> +static int exp_offload_codec_feature_changed(bool enabled, struct sock *skip)
> +{
> +       struct mgmt_ev_exp_feature_changed ev;
> +
> +       BT_INFO("enabled %d", enabled);
> +
> +       memset(&ev, 0, sizeof(ev));
> +       memcpy(ev.uuid, offload_codecs_uuid, 16);
> +       ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
> +
> +       return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
> +                                 &ev, sizeof(ev),
> +                                 HCI_MGMT_EXP_FEATURE_EVENTS, skip);
> +}
> +#endif
> +
>  static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
>                            void *data, u16 data_len)
>  {
> @@ -4038,6 +4085,63 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
>                 return err;
>         }
>
> +#if IS_ENABLED(CONFIG_BT_OFFLOAD_CODECS)

Ditto.

> +       if (!memcmp(cp->uuid, offload_codecs_uuid, 16)) {
> +               bool val, changed;
> +               int err;
> +
> +               /* Command requires to use a valid controller index */
> +               if (!hdev)
> +                       return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_INVALID_INDEX);
> +
> +               /* Parameters are limited to a single octet */
> +               if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
> +                       return mgmt_cmd_status(sk, hdev->id,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_INVALID_PARAMS);
> +
> +               /* Only boolean on/off is supported */
> +               if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
> +                       return mgmt_cmd_status(sk, hdev->id,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_INVALID_PARAMS);
> +
> +               val = !!cp->param[0];
> +               changed = (val != hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED));
> +
> +               if (!hdev->get_data_path_id) {
> +                       bt_dev_info(hdev, "offload codecs not supported");
> +                       return mgmt_cmd_status(sk, hdev->id,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_NOT_SUPPORTED);
> +               }
> +
> +               if (changed) {
> +                       if (val)
> +                               hci_dev_set_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
> +                       else
> +                               hci_dev_clear_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
> +               }
> +
> +               bt_dev_info(hdev, "offload codecs enable %d changed %d",
> +                           val, changed);
> +
> +               memcpy(rp.uuid, offload_codecs_uuid, 16);
> +               rp.flags = cpu_to_le32(val ? BIT(0) : 0);
> +               hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +               err = mgmt_cmd_complete(sk, hdev->id,
> +                                       MGMT_OP_SET_EXP_FEATURE, 0,
> +                                       &rp, sizeof(rp));
> +
> +               if (changed)
> +                       exp_offload_codec_feature_changed(val, sk);
> +
> +               return err;
> +       }
> +#endif
> +
>         return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
>                                MGMT_OP_SET_EXP_FEATURE,
>                                MGMT_STATUS_NOT_SUPPORTED);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index b44d56eb936a..bc033464af43 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -964,6 +964,11 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>                         break;
>                 }
>
> +               if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
> +                       err = -EOPNOTSUPP;
> +                       break;
> +               }
> +
>                 if (!hdev->get_codec_config_data) {
>                         err = -EOPNOTSUPP;
>                         break;
> @@ -1163,6 +1168,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>                         break;
>                 }
>
> +               if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
> +                       err = -EOPNOTSUPP;
> +                       break;
> +               }
> +
>                 if (!hdev->get_data_path_id) {
>                         err = -EOPNOTSUPP;
>                         break;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
