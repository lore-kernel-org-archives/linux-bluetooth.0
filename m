Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191BAECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJaX0I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaX0H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:26:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9692D1116F
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:26:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so21443911lfb.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtIuvq1//1lJzVDLh1Y5DuWOGj5ouJ7nmpP7cB1TNSE=;
        b=mPhu+8JUKj0areUFe5EvclqSmEAafg8f+7mNSjtqWR/sRXToPjSYRT/U8E2v+runqM
         vE9rm6pyOer6RYb3GFSV9DE75MmiECGtQFWj0mChPM6Imxojrc4oCYCFq3QxqWbU0Mw0
         slvByUAnsymXoQSv+LSxp6+Vr4JqR3BnwaHBBD8Ec//j3+fPli1GFjalmUa5SyrH3ejZ
         zLjXRiUYkbD/N+gehPawtBifI7nuwRAeqEzHEfwbeNgpZ5d2HXhJoM+0yFGjGUdGDvZz
         xGmzO/UQHPKmYz0uvHVqMGLN3oIRkE5t5k7Xo2bHKUHYODAzNWrCICleQTHFn4QwADqV
         xwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtIuvq1//1lJzVDLh1Y5DuWOGj5ouJ7nmpP7cB1TNSE=;
        b=RogMKYGnaK7X6PVnbTnXkhiPEgz72QGg4UKfIW3xxQoCbYDJ3vq6g09v7jzxNkb4ev
         1SgAwRUKACArJPR4DD38EV/sabMKdLBvl0SWGaENHAnZzr9X4p0mVfhrvyPEHZqogYM3
         Aj2WTSttqGKuB5uDDv8wIL2mDif+bBjXPQlzMVWFGDmmTJ9vY0+sB1wQEGDhx5K8xekW
         gFwce7rBnHE/lJ8pwdS0LZCun4EmfC7kyIIqSxfoxtwYyix/xLePRJ6hK5iO+3SShk+v
         9ZI8CvKAMp+vTQc1muFYuiCSZWfT5IUbwhDmTSYOOsY4yBT7vWiPWRBQ/FaWfzrIHD3g
         Unow==
X-Gm-Message-State: ACrzQf1tP1Eo4IQdJrhDuLdIqolYEPmx3U1gZkjX+SYosfwc5ad3YYnx
        QAYq1ceJ1K0lfiIbJVUL8+NV6dRnBdLyyVFy0FpnHVny9Tc=
X-Google-Smtp-Source: AMsMyM4zhF+aF0cv/Gmd66O+IPr2LOj+h7EpBQnkKbfC0DXWTBpL1BJHhZ/IFyBCab5fzdsV0GAABQmwP2VRCjnyOoE=
X-Received: by 2002:a05:6512:483:b0:4a2:6905:dfae with SMTP id
 v3-20020a056512048300b004a26905dfaemr6555455lfq.57.1667258764720; Mon, 31 Oct
 2022 16:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221031220205.91975-1-brian.gix@intel.com>
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 31 Oct 2022 16:25:53 -0700
Message-ID: <CABBYNZ+myLec0HOja45=U=QuvkQEyLjRAuacT+Qwbi36v7qOjA@mail.gmail.com>
Subject: Re: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Mon, Oct 31, 2022 at 3:02 PM Brian Gix <brian.gix@intel.com> wrote:
>
> The msft_set_filter_enable() command was using the deprecated
> hci_request mechanism rather than hci_sync. This caused the warning error:
> hci0: HCI_REQ-0xfcf0
>
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
>  net/bluetooth/msft.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> index bee6a4c656be..bf5cee48916c 100644
> --- a/net/bluetooth/msft.c
> +++ b/net/bluetooth/msft.c
> @@ -743,17 +743,12 @@ __u64 msft_get_features(struct hci_dev *hdev)
>  }
>
>  static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
> -                                                      u8 status, u16 opcode,
> -                                                      struct sk_buff *skb)
> +                                                      void *user_data,
> +                                                      u8 status)
>  {
> -       struct msft_cp_le_set_advertisement_filter_enable *cp;
> -       struct msft_rp_le_set_advertisement_filter_enable *rp;
> +       struct msft_cp_le_set_advertisement_filter_enable *cp = user_data;
>         struct msft_data *msft = hdev->msft_data;
>
> -       rp = (struct msft_rp_le_set_advertisement_filter_enable *)skb->data;
> -       if (skb->len < sizeof(*rp))
> -               return;
> -
>         /* Error 0x0C would be returned if the filter enabled status is
>          * already set to whatever we were trying to set.
>          * Although the default state should be disabled, some controller set
> @@ -766,7 +761,6 @@ static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev *hdev,
>
>         hci_dev_lock(hdev);
>
> -       cp = hci_sent_cmd_data(hdev, hdev->msft_opcode);
>         msft->filter_enabled = cp->enable;
>
>         if (status == 0x0C)
> @@ -804,31 +798,23 @@ int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
>         return msft_remove_monitor_sync(hdev, monitor);
>  }
>
> -void msft_req_add_set_filter_enable(struct hci_request *req, bool enable)
> -{
> -       struct hci_dev *hdev = req->hdev;
> -       struct msft_cp_le_set_advertisement_filter_enable cp;
> -
> -       cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
> -       cp.enable = enable;
> -
> -       hci_req_add(req, hdev->msft_opcode, sizeof(cp), &cp);
> -}
> -
>  int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
>  {
> -       struct hci_request req;
> +       struct msft_cp_le_set_advertisement_filter_enable cp;
>         struct msft_data *msft = hdev->msft_data;
>         int err;
>
>         if (!msft)
>                 return -EOPNOTSUPP;
>
> -       hci_req_init(&req, hdev);
> -       msft_req_add_set_filter_enable(&req, enable);
> -       err = hci_req_run_skb(&req, msft_le_set_advertisement_filter_enable_cb);
> +       cp.sub_opcode = MSFT_OP_LE_SET_ADVERTISEMENT_FILTER_ENABLE;
> +       cp.enable = enable;
> +       err = __hci_cmd_sync_status(hdev, hdev->msft_opcode, sizeof(cp), &cp,
> +                                   HCI_CMD_TIMEOUT);
> +
> +       msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);

Except if this function is only supposed to be called for a safe
context (which can block) we should actually use hci_cmd_sync_queue.

>
> -       return err;
> +       return 0;
>  }
>
>  bool msft_curve_validity(struct hci_dev *hdev)
> --
> 2.38.1
>


-- 
Luiz Augusto von Dentz
