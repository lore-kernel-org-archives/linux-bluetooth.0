Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365FFC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 19:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBXTxT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBXTxS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 14:53:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E944E311DF
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 11:53:16 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 62-20020a630241000000b004fb3343142dso111050pgc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 11:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8YOzDd/6L/vKBnSebEe4nvaSdZD321OF0FG44WHcog8=;
        b=WT4/T85dVBxjE51E8WWLMhAavndjTBa0+BF4I0xQ0fDPyRnA/YzJQWGmLvkElaKV9m
         rQ0inlp89lgMu9ePvEB6QEv7X2KTJ4G8sjeEZyJtEvwcKX5TE2HXHesglNzDcXaYi7W6
         KJiY2HD9eKG8xBQ/wjBjvncL+2JIJ5wyLsVqIl7a5AWftGl/olQXcrPI0/CAI0FfZPvL
         yy4T+xereVFACpDEWXIH/gu2WuCAARPJIL072MgQnFEkwtkEtA+Sbcp0OxISt6vcu1S8
         VX05yw1pxu40eyDduVaiI3qwuWmbrkRH8Qny8CKmbLo74Rd5g88xKeAzMpOsPK7iROj6
         zFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YOzDd/6L/vKBnSebEe4nvaSdZD321OF0FG44WHcog8=;
        b=iFkpaIcbR19+M8xYWPrGWRg7ruxipPHKOtVksVP9sgMPSrORwASVCSJpQoqnct07KV
         vbVXvMU49hX9I28uQmYbsszdPwKw9/yTnHy+yWDFhlVgER82/k4373Kbvs0vdG3nmUE9
         z7o/5Xi+2C0Qm7X3PcvbU9Lj7EHEsDdqStjUhsZ+5HIFOUL4PdVZxhuVIRwsU5z2C1z/
         bGw4QotRR2aA9te8N3Gp/zLSKxNI6P35ELjcdsVNu1G46k3ruAmx9X0fYL3NQPcYvtkm
         OJHL0FzEx+hCaSBvQc1UXw/Pxi7yEV9mp157VWU1qNnUb6hwpTvVw7+pnN1dOYsQ6POA
         JrSQ==
X-Gm-Message-State: AO0yUKX+uw+l6xOn4zMKhMoiw+2GLUre/VIE0aVwaTZdj9pg+6EnzP5u
        NEjmrFlZJ9HXJip+UP6CR1Vf2TfsBOFzZFNIiMTdayljDPjaQ88C2o3F5BSshQZ3ot4wgqRQEc9
        TKmoQ3Re89rOKEYXF97dc5p50IjkgfE/oOjfOP3PXw1oC4/UzW/C6OzYjmQnembycGDfbIFBLwM
        rI
X-Google-Smtp-Source: AK7set+ODXNARgX9D6pi5xqfai89uMIZfQY62hBezj+LIOPmnNEWOBHm2uXgyNid4m3LOd11OtLnPqn+jS1c
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a62:82ce:0:b0:5af:db19:b1c with SMTP id
 w197-20020a6282ce000000b005afdb190b1cmr3505514pfd.2.1677268395963; Fri, 24
 Feb 2023 11:53:15 -0800 (PST)
Date:   Fri, 24 Feb 2023 11:53:12 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230224195313.1877313-1-jiangzp@google.com>
Subject: [kernel PATCH v2 0/1] Clear workqueue to avoid use-after-free
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


After the hci_sync rework, cmd_sync_work was cleared when calling
hci_unregister_dev, but not when powering off the adapter.
Use-after-free errors happen when a work is still scheduled
when cmd is freed by __mgmt_power_off.

Changes in v2:
- Add function to clear the queue without stop the timer

Changes in v1:
- Clear cmd_sync_work queue before clearing the mgmt cmd list

Zhengping Jiang (1):
  Bluetooth: hci_sync: clear workqueue before clear mgmt cmd

 net/bluetooth/hci_sync.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.39.2.722.g9855ee24e9-goog

