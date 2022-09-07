Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA565C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 19:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiIGTeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIGTef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 15:34:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1365F93
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 12:34:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f11so10011947lfa.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zLTuqGQmkHrVFNbYO2qAqwZRMIgrGmRiklMvtT+NRa8=;
        b=oSJ4FjVZHLSFQd+HSGpDpZ6UYJFU2Gi9ycjbtnl+MtP0994XWD3JkNaE6f3trNQ21s
         1WAlUr+Rk3WekndA0TH5OF5sN9CyjDgv28ziLSNDGHRs8smKhrLQ0W2BqEmDkRQ22Qd+
         RPWNSGJn1IX1kH5BqdbPBHMLgSH5uxgSjP4OLnoVQ1F6r1XrQJJhCP2g4IeHLkw2u32t
         1HhXHgY6i8+Mzvscznb+hcXINS0fnYEooLxBUS5lsz4LbR4V7hfEQwxSqiulB4IC9OCs
         /neaMr+ZB9ozrJ1fsRsy04ZVM6/FLTulxXpqr7MGmsI488N+7p1YzoohdvxEJ4VZBLh+
         8p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zLTuqGQmkHrVFNbYO2qAqwZRMIgrGmRiklMvtT+NRa8=;
        b=N2b/pBI+Xm358v1JIXBJpvB81OFyaMYha9gOabZE8eXD/DuTceCBY84IWCqjLiVwds
         9NZE6+GQYECHMKanTgenYpB8+BvN+knyeN6JhzcAUyTH+D2nccXOAChwmeN1bqzG+xsy
         6NAne9vNjTQ6Msta7YaQg3GaHJ5M9joU0QTAg5noFvno0jmuo59f/rPEV7xPxrNuLIUm
         WGckO+BWBqJ6UmOyAwTOwC1QXhKdai5NidLiRMlr5u3js5PGy9R2sIrp87LKlM/GKNeW
         IaU494ZcTOxKUeKx9y1bSmEuiu+WEuQXl+oz1KWrhpFhsrlGuz8yE8s91Q9ucLgnJTBj
         ORdA==
X-Gm-Message-State: ACgBeo195u4/ejZTons4i+mU10BbygHJZOGtsr523wA5UfDB1Xb4kK+m
        OXcrYdJBerwtACzvC8dOAtlnP/Yv6SIjRzTQnQ4NOZXkGGE=
X-Google-Smtp-Source: AA6agR6XHIHS6WtqXxjTFHxY15kUQlTQZ1idJ7vEYCNPRpPmEywFfLbrKxZOwasyXQBl+PvgC88tEzqnewITTGYarvQ=
X-Received: by 2002:a05:6512:3d24:b0:494:95d0:5c02 with SMTP id
 d36-20020a0565123d2400b0049495d05c02mr1737892lfv.198.1662579270363; Wed, 07
 Sep 2022 12:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220907191450.38262-1-brian.gix@intel.com>
In-Reply-To: <20220907191450.38262-1-brian.gix@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 7 Sep 2022 12:34:18 -0700
Message-ID: <CABBYNZLp=g_SX6DgWuvu3QUr3LBtu=JN3ZhsxA1FuneWaiZ7yQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Bluetooth: Add ADV Monitor events to btmon parser
To:     Brian Gix <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Wed, Sep 7, 2022 at 12:15 PM Brian Gix <brian.gix@intel.com> wrote:
>
> Signed-off-by: Brian Gix <brian.gix@intel.com>

We don't use signed-off-by in userspace, also it would be great to
have a sample output of these changes in the patch description.

> ---
>  monitor/packet.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 46587e087..7447e1565 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -14914,6 +14914,37 @@ static void mgmt_controller_resume_evt(const void *data, uint16_t size)
>         mgmt_print_address(data, addr_type);
>  }
>
> +static void mgmt_adv_monitor_device_found_evt(const void *data, uint16_t size)
> +{
> +       uint8_t handle = get_le16(data);
> +       const uint8_t *addr = data + 2;
> +       uint8_t addr_type = get_u8(data + 8);
> +       int8_t rssi = get_s8(data + 9);
> +       uint32_t flags = get_le32(data + 10);
> +       uint16_t ad_data_len = get_le16(data + 14);
> +       const uint8_t *ad_data = data + 16;
> +
> +       print_field("Handle: %d", handle);
> +       print_bdaddr(addr);
> +       print_field("Addr Type: %d", addr_type);
> +       print_field("RSSI: %d", rssi);
> +       mgmt_print_device_flags(flags);
> +       print_field("AD Data Len: %d", ad_data_len);
> +       size -= 16;
> +       print_hex_field("AD Data: ", ad_data, size);
> +}
> +
> +static void mgmt_adv_monitor_device_lost_evt(const void *data, uint16_t size)
> +{
> +       uint8_t handle = get_le16(data);
> +       const uint8_t *addr = data + 2;
> +       uint8_t addr_type = get_u8(data + 8);
> +
> +       print_field("Handle: %d", handle);
> +       print_bdaddr(addr);
> +       print_field("Addr Type: %d", addr_type);
> +}
> +
>  static const struct mgmt_data mgmt_event_table[] = {
>         { 0x0001, "Command Complete",
>                         mgmt_command_complete_evt, 3, false },
> @@ -15003,6 +15034,10 @@ static const struct mgmt_data mgmt_event_table[] = {
>                         mgmt_controller_suspend_evt, 1, true },
>         { 0x002e, "Controller Resumed",
>                         mgmt_controller_resume_evt, 8, true },
> +       { 0x002f, "ADV Monitor Device Found",
> +                       mgmt_adv_monitor_device_found_evt, 16, false },
> +       { 0x0030, "Controller Resumed",
> +                       mgmt_adv_monitor_device_lost_evt, 9, true },
>         { }
>  };
>
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
