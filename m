Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE64EC25B4E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Jan 2023 11:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAVLLk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Jan 2023 06:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVLLj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Jan 2023 06:11:39 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8F1B55B
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jan 2023 03:11:38 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id q15so7684435qtn.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jan 2023 03:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8aNUOPbCLHUnA0LSzw3gH9FaCgPV+hxaxVHl1PHfPKY=;
        b=O9GBtoujjmrswqctxb8FuFTaMUuzYEay+vGaqnT4ZBB5oti00MnVWaUc2GgjDUtepw
         lvdoHVw5HKCeCPI+wm5fHiPxW30rb6bSXcrne+xOO3eoPhkGyx5vsM6Ce2c+9mqApmVJ
         lHnXGnliH5RYPmP+Gzr//VfG+TbvvIiy2Zfy5nmLppJnSDwHGmwXM6Qg4GQzZSLwB1dc
         pJbXaSpfybZZ4N8hUCuU8hEm/o9O8yqRz+RdvKFDFF/+6HhN5LOJEEaxw4ze0N+iTZ8j
         1RDaUc0xO3jpRB69bofA5ysY0EDo0qz6mrvyAEDBjn7qmNJlvW9U5fgQTCQIPBYEjaVd
         kWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aNUOPbCLHUnA0LSzw3gH9FaCgPV+hxaxVHl1PHfPKY=;
        b=usG3RJnC721wgIMfKiMDbqgEHys3eYYB4c9PveuBXshpkbXFKzh+CSgtyQuZJIfqph
         igt0tKsUXNmX0isNVciB/KyQncvDsqnsOoduyxGS0iD7raza07gEVlt6jWYFR7Ead1WB
         UpbJ2gAGmWN0B5PXW4wNSelzRd3i4RU07Q9a6YyoRlGj20+uKKbJQ31USms9bFCGJ9cj
         JPoq5V5/d0r0qvhfUSX11pslXufRQCBMq+QDUwrMGsDJdrTgvBCyDUsWvuo8t71A8MxU
         W5VwekGJnXGeGncMMSPPJJdHOVDBUOTRtxVa4rsHv5e9sBscnDN3AV6VSIWvjsjd/Bnw
         Cp8w==
X-Gm-Message-State: AFqh2kpFPULLIaNE6/sqkoVcMa7SWjPDVY77tWte8SVIavRAR7a+LcHD
        0pzUHn1RQ44u4jG1KjO4OAsCdb870mQ=
X-Google-Smtp-Source: AMrXdXseSiSaM7oNSMedRR2CDLHEGjUkdv/JuT2rJif7+Mr2UrlQWTdy2KNfke3Z2Td1TtZvw7wzxQ==
X-Received: by 2002:a05:622a:4813:b0:3a7:f6cf:a597 with SMTP id fb19-20020a05622a481300b003a7f6cfa597mr35862020qtb.33.1674385897446;
        Sun, 22 Jan 2023 03:11:37 -0800 (PST)
Received: from [172.17.0.2] ([172.177.106.96])
        by smtp.gmail.com with ESMTPSA id t1-20020ac86a01000000b003a7e4129f83sm23092309qtr.85.2023.01.22.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 03:11:37 -0800 (PST)
Message-ID: <63cd19e9.c80a0220.457b9.e801@mx.google.com>
Date:   Sun, 22 Jan 2023 03:11:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5937494530199524462=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, geert+renesas@glider.be
Subject: RE: [v2] dt-bindings: leds: Document Bluetooth and WLAN triggers
In-Reply-To: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
References: <0d0de1bc949d24e08174205c13c0b59bd73c1ea8.1674384302.git.geert+renesas@glider.be>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5937494530199524462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/devicetree/bindings/leds/common.yaml:98
error: Documentation/devicetree/bindings/leds/common.yaml: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5937494530199524462==--
