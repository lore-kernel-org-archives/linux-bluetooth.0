Return-Path: <SRS0=Hv/D=BG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94888C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 11:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684C620714
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jul 2020 11:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXFEeaXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0Lqi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgG0Lqh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jul 2020 07:46:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD7C061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 04:46:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w12so2975089iom.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2020 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QSdUN1soPfoKeCyvOxy1GyQLEauSujDq0FyNrkcHWA=;
        b=bXFEeaXt2ImEDBc4MBatUQhKoruNN4D4UjrdIhrwkWvLTAxubjHi6ufBPkbL0rZUQ4
         2D8wmvP1zK4fIu/33pP2iYiq0sGxNB+EQDRzmztNd7ZRNnFrScIFE7mCJZbr6mEAE36K
         bNznDH4BRhqWYF+go6zxX4J2+7BPgt5xQHhb+2s9KxozQrOoxlabBqSiiP8razNngwUH
         oaJcqgaHm8OmcC2dWe3IuHo+5jQYISxy/DFqu+TWUFq4beVNUeZ0PkHSZXbzJBQTDCr2
         6Z7dI3iovUe+fkQy1vP8D5go8I6h1g80PQZCPx9bVPa5NygeHHwQx3y54WceDjT/juQo
         YYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QSdUN1soPfoKeCyvOxy1GyQLEauSujDq0FyNrkcHWA=;
        b=BghW9U2x+Pez+kON5ArGQ+1Ij+YrODbh3OT4LVJVMA0LprsDE/ZuQYr1GXB7PaLZK5
         yv72xxHRaaBFYsesHw0egHx+ued7j/SHS4TwssePmaaesjvqXSeJJAhRSENMzSYEfJzE
         6yLA2fdOfGu8/zqHAORiq9hjkeaBgeQ83BqLkVa4u5otbIhJRXe8iTpNLFFYDTezAPEt
         aH/2MPYbg93y+W/0QT3FqMVcekcTHvJx0m6kGfGKQOz8ZHnatmr1nM8bTXRQ7ieW53UB
         aN47wOnkrgRXSYivTVO8PISRAa8LIwEtkAlwvrIMmcNjLg2uyZhQ0wgBrS+DbACxKkJ9
         fnvw==
X-Gm-Message-State: AOAM532ocqvGYLBMMfHUIr2ijF97qb3+N7clL2jgLY0eOJl+ovBDXDDB
        4veGwgmNCY2S/F1trybtrbbzYI0i9CUvXH7IkLCYc0Ye
X-Google-Smtp-Source: ABdhPJy8Dio1s81m6+q53V/OlPgKtsqthJhrC2hV7/hCx7pa7FjgiSung7+dkExaG42/MFFsfq2rOMySmgBLI7h15LE=
X-Received: by 2002:a05:6602:220f:: with SMTP id n15mr23649656ion.103.1595850396605;
 Mon, 27 Jul 2020 04:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200723123903.29337-1-sathish.narasimman@intel.com> <20200723123903.29337-8-sathish.narasimman@intel.com>
In-Reply-To: <20200723123903.29337-8-sathish.narasimman@intel.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Mon, 27 Jul 2020 17:16:25 +0530
Message-ID: <CAOVXEJ+=Y+e4bSmysA-_j6j4GsVseazOzpNxnGRKGDL25+86jw@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] Bluetooth: Enable controller RPA resolution using
 Experimental feature
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

gentle reminder

On Thu, Jul 23, 2020 at 6:05 PM Sathish Narasimman <nsathish41@gmail.com> wrote:
>
> This patch adds support to enable the use of RPA Address resolution
> using expermental feature mgmt command.
>
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  include/net/bluetooth/hci.h |   1 +
>  net/bluetooth/hci_event.c   |   1 +
>  net/bluetooth/hci_request.c |   7 ++-
>  net/bluetooth/mgmt.c        | 112 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 120 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4ff2fc4498f3..55205d805c22 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -307,6 +307,7 @@ enum {
>         HCI_FORCE_BREDR_SMP,
>         HCI_FORCE_STATIC_ADDR,
>         HCI_LL_RPA_RESOLUTION,
> +       HCI_ENABLE_LL_PRIVACY,
>         HCI_CMD_PENDING,
>         HCI_FORCE_NO_MITM,
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 628831b15c0a..33d8458fdd4a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5230,6 +5230,7 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
>                              le16_to_cpu(ev->supervision_timeout));
>
>         if (use_ll_privacy(hdev) &&
> +           hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>             hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
>                 hci_req_disable_address_resolution(hdev);
>  }
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 70e077cc7dfa..435400a43a78 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -678,8 +678,10 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
>
>         /* Disable address resolution */
>         if (use_ll_privacy(hdev) &&
> +           hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
>             hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
>                 __u8 enable = 0x00;
> +
>                 hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
>         }
>  }
> @@ -870,8 +872,11 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
>                 return;
>         }
>
> -       if (use_ll_privacy(hdev) && addr_resolv) {
> +       if (use_ll_privacy(hdev) &&
> +           hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> +           addr_resolv) {
>                 u8 enable = 0x01;
> +
>                 hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
>         }
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 47bcfe2fb14c..adde92cf015d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3759,6 +3759,12 @@ static const u8 simult_central_periph_uuid[16] = {
>         0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
>  };
>
> +/* 15c0a148-c273-11ea-b3de-0242ac130004 */
> +static const u8 rpa_resolution_uuid[16] = {
> +       0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> +       0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
> +};
> +
>  static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                                   void *data, u16 data_len)
>  {
> @@ -3795,6 +3801,21 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                 idx++;
>         }
>
> +       if (use_ll_privacy(hdev)) {
> +               if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
> +                       flags = BIT(0);
> +                       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +                               flags |= BIT(1);
> +               } else
> +                       flags = 0;
> +
> +               memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
> +               rp->features[idx].flags = cpu_to_le32(flags);
> +               idx++;
> +
> +               new_settings(hdev, sk);
> +       }
> +
>         rp->feature_count = cpu_to_le16(idx);
>
>         /* After reading the experimental features information, enable
> @@ -3807,6 +3828,27 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
>                                  0, rp, sizeof(*rp) + (20 * idx));
>  }
>
> +static int exp_ll_privacy_feature_changed(bool enabled, struct sock *skip)
> +{
> +       struct mgmt_ev_exp_feature_changed ev;
> +       u32 flags;
> +
> +       memset(&ev, 0, sizeof(ev));
> +       memcpy(ev.uuid, rpa_resolution_uuid, 16);
> +
> +       if (enabled)
> +               flags = 0x03;
> +       else
> +               flags = 0;
> +
> +       ev.flags = cpu_to_le32(flags);
> +
> +       return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
> +                                 &ev, sizeof(ev),
> +                                 HCI_MGMT_EXP_FEATURE_EVENTS, skip);
> +
> +}
> +
>  #ifdef CONFIG_BT_FEATURE_DEBUG
>  static int exp_debug_feature_changed(bool enabled, struct sock *skip)
>  {
> @@ -3845,6 +3887,18 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
>                 }
>  #endif
>
> +               if (use_ll_privacy(hdev)) {
> +                       bool changed;
> +
> +                       changed = hci_dev_test_flag(hdev,
> +                                                   HCI_ENABLE_LL_PRIVACY);
> +
> +                       hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +                       if (changed)
> +                               exp_ll_privacy_feature_changed(false, sk);
> +               }
> +
>                 hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
>
>                 return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> @@ -3895,6 +3949,64 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
>         }
>  #endif
>
> +       if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
> +               bool val, changed;
> +               int err;
> +               u32 flags;
> +
> +               /* Parameters are limited to a single octet */
> +               if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
> +                       return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_INVALID_PARAMS);
> +
> +               /* Only boolean on/off is supported */
> +               if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
> +                       return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +                                              MGMT_OP_SET_EXP_FEATURE,
> +                                              MGMT_STATUS_INVALID_PARAMS);
> +
> +               val = !!cp->param[0];
> +
> +               if (val) {
> +                       changed = !hci_dev_test_flag(hdev,
> +                                                    HCI_ENABLE_LL_PRIVACY);
> +
> +                       hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +                       /* Enable LL privacy */
> +                       flags = BIT(0);
> +                       /* Disable HCI_ADVERTISING flag */
> +                       flags |= BIT(1);
> +
> +                       hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> +
> +               } else {
> +                       changed = hci_dev_test_flag(hdev,
> +                                                   HCI_ENABLE_LL_PRIVACY);
> +                       hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +                       flags = 0;
> +               }
> +
> +               memcpy(rp.uuid, rpa_resolution_uuid, 16);
> +
> +               rp.flags = cpu_to_le32(flags);
> +
> +               hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +
> +               err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
> +                                       MGMT_OP_SET_EXP_FEATURE, 0,
> +                                       &rp, sizeof(rp));
> +
> +               if (changed) {
> +                       exp_ll_privacy_feature_changed(val, sk);
> +                       new_settings(hdev, sk);
> +               }
> +
> +               return err;
> +       }
> +
>         return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
>                                MGMT_OP_SET_EXP_FEATURE,
>                                MGMT_STATUS_NOT_SUPPORTED);
> --
> 2.17.1
>

Regards
Sathish N
