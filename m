Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2735BC2D0EC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC848206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 23:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8r5kmho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDGXhm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:37:42 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40937 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGXhm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 19:37:42 -0400
Received: by mail-vk1-f194.google.com with SMTP id k63so1390737vka.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoE+uneWYwwuNLnDGS2+oTbdDTisiVBvo4mJPAI/+Es=;
        b=I8r5kmho+ZFqC8+nSiszXKEV8ITComtCAYPXQoXBCi/kIzF/EwR2AvFNVHuMZ2CrbK
         gG0vL0zZ0hx/Bvy6ckN4uOSNuaAGhsM80px/8WB+r63lSIo9wnN+WVOGoRDgQALsOiJO
         qf9IKoZMBhFVAgA+E/hwoQ6s8TK2yvJAhHG3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoE+uneWYwwuNLnDGS2+oTbdDTisiVBvo4mJPAI/+Es=;
        b=ksdyaNPDi+gMUsRGWxp7RTOaqAnLbYD+jeccGt9Rb5YdjlVXwE3u1/7lUVysUs35hf
         3VeM66eyfEoFuSaZeGzO8Ag052ezvjZqEuY9U6/UX2tX9D5bGRM1OCEYOYQntM3Rkx2M
         TSaGNBnAyyoSHX2hlLApqSZb3N0+jE15gTQwhHYghepaRrQkbgZ1BvUKGdla9nOpZKo0
         PPnk8kNRhO2r0meKIAMFWV94OK/DMGD2RU4XA1EW2R/9Q7ofcEWKdQlLWhUFSyq3rIi1
         6bqffa5AnSHjaAjlDaH2nEYaZwfuP9QO/UBcYNhck53ppzzv4+SuuiKiY7fH7ib92L9K
         zgvw==
X-Gm-Message-State: AGi0PubDvvfxD6El5AcQQGmdbeybT5jMNo0UDKEH9YZwEi0IBpF3j2/9
        jSFa6e5eA3o2QQijyhGaGu/Uy8Re6GvoOcl3AWRt56tq
X-Google-Smtp-Source: APiQypL0QCaEqz0IpwUInQDk6TYp5R1nCbnEhL5Opms/VUam3ehjhpV5OurlIJvazKk1fwTnA+Pucjtg3p1bHcfGimE=
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr3445539vke.77.1586302659616;
 Tue, 07 Apr 2020 16:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200407205217.1002534-1-marcel@holtmann.org>
In-Reply-To: <20200407205217.1002534-1-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 7 Apr 2020 16:37:28 -0700
Message-ID: <CANFp7mVSQEOyT7GrOa4NhAGozt5SMx3yU_ma6tav5bJ8GXJn8w@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Configure controller address resolution if available
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

This looks good to me.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>


On Tue, Apr 7, 2020 at 1:52 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> When the LL Privacy support is available, then as part of enabling or
> disabling passive background scanning, it is required to set up the
> controller based address resolution as well.
>
> Since only passive background scanning is utilizing the whitelist, the
> address resolution is now bound to the whitelist and passive background
> scanning. All other resolution can be easily done by the host stack.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h      |  1 +
>  include/net/bluetooth/hci_core.h |  4 ++++
>  net/bluetooth/hci_request.c      | 26 +++++++++++++++++++++++---
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5ef4547760db..58360538d42b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -459,6 +459,7 @@ enum {
>  #define HCI_LE_SLAVE_FEATURES          0x08
>  #define HCI_LE_PING                    0x10
>  #define HCI_LE_DATA_LEN_EXT            0x20
> +#define HCI_LE_LL_PRIVACY              0x40
>  #define HCI_LE_EXT_SCAN_POLICY         0x80
>  #define HCI_LE_PHY_2M                  0x01
>  #define HCI_LE_PHY_CODED               0x08
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2f3275f1d1c4..663ffde9bd1d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -645,6 +645,7 @@ extern struct mutex hci_cb_list_lock;
>         do {                                                    \
>                 hci_dev_clear_flag(hdev, HCI_LE_SCAN);          \
>                 hci_dev_clear_flag(hdev, HCI_LE_ADV);           \
> +               hci_dev_clear_flag(hdev, HCI_LL_RPA_RESOLUTION);\
>                 hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);     \
>         } while (0)
>
> @@ -1277,6 +1278,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define scan_coded(dev) (((dev)->le_tx_def_phys & HCI_LE_SET_PHY_CODED) || \
>                          ((dev)->le_rx_def_phys & HCI_LE_SET_PHY_CODED))
>
> +/* Use LL Privacy based address resolution if supported */
> +#define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
> +
>  /* Use ext scanning if set ext scan param and ext scan enable is supported */
>  #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
>                            ((dev)->commands[37] & 0x40))
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 9ea40106ef17..efec2a0bb824 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -676,6 +676,12 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
>                 cp.enable = LE_SCAN_DISABLE;
>                 hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>         }
> +
> +       if (use_ll_privacy(hdev) &&
> +           hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION)) {
> +               __u8 enable = 0x00;
> +               hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> +       }
>  }
>
>  static void del_from_white_list(struct hci_request *req, bdaddr_t *bdaddr,
> @@ -808,10 +814,16 @@ static bool scan_use_rpa(struct hci_dev *hdev)
>  }
>
>  static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
> -                              u16 window, u8 own_addr_type, u8 filter_policy)
> +                              u16 window, u8 own_addr_type, u8 filter_policy,
> +                              bool addr_resolv)
>  {
>         struct hci_dev *hdev = req->hdev;
>
> +       if (use_ll_privacy(hdev) && addr_resolv) {
> +               __u8 enable = 0x01;
> +               hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> +       }
> +
>         /* Use ext scanning if set ext scan param and ext scan enable is
>          * supported
>          */
> @@ -885,12 +897,18 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
>         }
>  }
>
> +/* Ensure to call hci_req_add_le_scan_disable() first to disable the
> + * controller based address resolution to be able to reconfigure
> + * resolving list.
> + */
>  void hci_req_add_le_passive_scan(struct hci_request *req)
>  {
>         struct hci_dev *hdev = req->hdev;
>         u8 own_addr_type;
>         u8 filter_policy;
>         u8 window, interval;
> +       /* Background scanning should run with address resolution */
> +       bool addr_resolv = true;
>
>         if (hdev->scanning_paused) {
>                 bt_dev_dbg(hdev, "Scanning is paused for suspend");
> @@ -936,7 +954,7 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
>
>         bt_dev_dbg(hdev, "LE passive scan with whitelist = %d", filter_policy);
>         hci_req_start_scan(req, LE_SCAN_PASSIVE, interval, window,
> -                          own_addr_type, filter_policy);
> +                          own_addr_type, filter_policy, addr_resolv);
>  }
>
>  static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
> @@ -2725,6 +2743,8 @@ static int active_scan(struct hci_request *req, unsigned long opt)
>         u8 own_addr_type;
>         /* White list is not used for discovery */
>         u8 filter_policy = 0x00;
> +       /* Discovery doesn't require controller address resolution */
> +       bool addr_resolv = false;
>         int err;
>
>         BT_DBG("%s", hdev->name);
> @@ -2746,7 +2766,7 @@ static int active_scan(struct hci_request *req, unsigned long opt)
>                 own_addr_type = ADDR_LE_DEV_PUBLIC;
>
>         hci_req_start_scan(req, LE_SCAN_ACTIVE, interval, DISCOV_LE_SCAN_WIN,
> -                          own_addr_type, filter_policy);
> +                          own_addr_type, filter_policy, addr_resolv);
>         return 0;
>  }
>
> --
> 2.25.2
>
