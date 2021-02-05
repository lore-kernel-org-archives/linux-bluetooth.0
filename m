Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E181C433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773F164F9F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Feb 2021 22:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBEWcK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhBEOOq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Feb 2021 09:14:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805FDC061A86
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Feb 2021 07:52:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d13so3781683plg.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Feb 2021 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7xx8pWkh3n+iBuXpmAVObC559q53Rc9MHbJQRudHTKg=;
        b=l7vkxPNqqCooCkc9U1eVJ6xEP90+iPReCEdUI9A4vpVs8AZpV3G/C9CZ2lbM2vmN5e
         nLjgJ+CFsZAW3fPlguz8qv9iSnNWeOTKzLyYmxK6WrGpBM/O++ahoA+I6d2HF7UXB+rY
         heO1aLzAIMtKIdMksopP5veqx2zgVfxQT4DcMGQi+cVMHUu4Z9g6ZvszCQjqdsUL76UT
         LoVOb782UX1AdA6iL4zMwVUzdfqdFp/ARlQOXtTAW9fErSBrJibAtBAlE5QYd3BGBjp0
         KpHCcUrxoW0HVdWr77D/ylRqjVKq/HP/gQomZVarYDfgpjkyEINE68Cj4wMlYFZESDrX
         ruXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7xx8pWkh3n+iBuXpmAVObC559q53Rc9MHbJQRudHTKg=;
        b=EhEqz+sqQ3TaJbmlLs/+lVkg4GI4RQTJVB6WexT8iC6d7RDD4cJpJTYee9kQsYBd/y
         JLR0PYdyEQOnt96IXZ15MqNu+blBAfPG4uZHqxCLBA3LYxspsM/5uIoZaA05LablCObo
         ggqBYOjHPKGrM1iBuXJwoEPo+TlTCGRMXcfc88j4kn/Tv86WPOgWOHQERFsbNk5rp4b0
         Ts/yCt2q/G4OlIRrnaKQxbjVN2W0fIDTGx6G9LuNmLbLuflqjOpsgC0ThFK7dX/AmYjb
         1/a1qHC/Td1Mde75JL3jjqRD0W6s2IADm2sIT5/2BNUC6jW8MS+yHGsy6XP2M52QkF5N
         /RGA==
X-Gm-Message-State: AOAM531CgDZ6TU+r5hxUrN+2U+/sKrF/Xsv4Sq3DMzn8QtaYr6w2iqEK
        QHKSsn7SdmNwFLXSU/2w98htL0hlA8k=
X-Google-Smtp-Source: ABdhPJyf953WlY858O9wI90LNi0XBeW4IWW6eRzZ7v9IkDXVEO4lEVBwDSK6WZ5wx1rIORaUp383FQ==
X-Received: by 2002:a17:90b:17c8:: with SMTP id me8mr4982655pjb.197.1612540346777;
        Fri, 05 Feb 2021 07:52:26 -0800 (PST)
Received: from localhost ([122.172.229.231])
        by smtp.gmail.com with ESMTPSA id u31sm12056408pgl.9.2021.02.05.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:52:26 -0800 (PST)
Date:   Fri, 5 Feb 2021 21:22:23 +0530
From:   Sanchayan <maitysanchayan@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Igor V. Kovalenko" <igor.v.kovalenko@gmail.com>
Subject: Query on the patch series "define HCI packet size of USB Alts"
Message-ID: <YB1pt8WXsHO2gP5A@core-precision>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

We currently have an opened merge request on adding mSBC support to PulseAudio.
https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/254

There currently seems to be an issue in getting the correct MTU. In the test
setup it works with the ofono backend, except for the assumed MTU. For getting
it to work, we had to use a MTU of 24. 48 does not work and renders silence.
getsockopt(card->fd, SOL_SCO, SCO_OPTIONS ... returns 64 which is too large.

The missing bits on the kernel side seems to be the below patch.
https://lore.kernel.org/patchwork/patch/1303411/

Second patch in the above series seem to have been applied but not the first.

The first patch in the series above, when applied seems to fix getsockopt
returning 24 bytes for the MTU. An additional correction on top of that
below

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fd0dcfa9a390..35f9c0743014 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1669,6 +1669,8 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
                err = __set_isoc_interface(hdev, new_alts);
                if (err < 0)
                        return err;
+
+               hdev->sco_mtu = hci_packet_size_usb_alt[new_alts];
        }

        if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &data->flags)) {


seems to make it work for all bluetooth usb devices.

Has there been any further development or way to push this forward?

- Sanchayan.
