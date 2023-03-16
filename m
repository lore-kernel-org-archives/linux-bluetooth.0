Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24764C7618A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCPJyB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 05:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCPJxz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 05:53:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0C523877
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:53:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5416d3a321eso10268507b3.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 02:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678960421;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bjCe153iOuNj7g9n3mLBj55RjFaeThMhRha+2CIjg58=;
        b=L7iARbpeymUmXnXEVJnpiIISKCTwltbBWMk3ulSbqZ/u5i0TyVIsc3laU9TZh1/3b1
         nRidTjd8bBWgCFIKjvPJEMagfspUnA8tbwm3VRdUHSnr3WHA54FnmJeouZHR43RSDnN3
         UN0x+72VuKPYp8IRg375AkaqqeKs2B2HGin4Mn72jWS4muzY7rNO2xmzDkuyjxk5M/qA
         Aeu0XkMfsYkH/hbMLA4j3+Ov9WESa17YXouMYVeMaeXCYkKd9+Fh/oPT5D3JVNcMXCaq
         7o1Q//TD/Cc51GcMe/tw/jAV+vgVfU5lIgSQFdd0IsOV3+VNoWP0RGw/0mwvd0zVIWEP
         uoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjCe153iOuNj7g9n3mLBj55RjFaeThMhRha+2CIjg58=;
        b=xsPZYbntSyI/z1maQYjGmJl+21bx0NqwjcvQDqEbPsV2ZoVVeYRk3dp0oLB8OfJIG8
         0ljVpH+lHLiYelnh90WlEB5z1umTcaAs9MqkHccjnG+YQfS2+iNTeXiY7VwwT3Q68KGe
         RFOvN7QbR/xENyTYUWzvVEXNKKyLfmlB3oCww1uJPdvaYTB4fYqfJTWOOJ/xG74AknPV
         i/dh0XpQDbx+5nurlNlMXi64xA577wpsLOSB158+xHZUzCbQ5qFQBsCw/jJrup1TZ8Ln
         tnd+CI/lajRhSscHU382T34pLsnFN1j3C+e9/GcyL5+U0Mxo3db5mxUrZelGTjQ+Kusd
         nS0w==
X-Gm-Message-State: AO0yUKVSo7rZQs9pi5wuvvmGNX/+7Ag8NGRdDWnOOka9Cg5uKhRb7Qv1
        RjB+0jaBqBsOUcbRENiM7jAx++wA2oqjZxyyF7OKsAbR1VGHWVazeS76/GAmAE81gEd8TzcEqqU
        iYB3K+oL+Lik23zJvm6Nki2HdXOEpPz3nPknzbNLfSxAC6er4GaFe0AnjjaiMUmFEUloe196KtJ
        FF225/YJsysYk=
X-Google-Smtp-Source: AK7set8U9fdSS0J6aEPlJSn52VEtURjLi4jl0gbvhvaIIY02Wezvxl9WieMrcZN1zyljlXe/d5HiawIQq4/fbfrduw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:5470:81fd:9c7f:513a])
 (user=howardchung job=sendgmr) by 2002:a81:4005:0:b0:544:6455:e023 with SMTP
 id l5-20020a814005000000b005446455e023mr1753029ywn.10.1678960421286; Thu, 16
 Mar 2023 02:53:41 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:53:33 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316175301.v2.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Subject: [PATCH v2] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Brian Gix <brian.gix@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The MGMT command: MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI uses variable
length argumenent. This patch adds right the field.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: Howard Chung <howardchung@google.com>
---
Hi upstream maintainers,
Host is not able to register advmon with rssi due to the bug.
This patch has been locally tested by adding monitor with rssi via
btmgmt on a kernel 6.1 machine.
Thanks

Changes in v2:
- Fixed git user name
- Included commit notes for the test step.

 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 39589f864ea7..249dc6777fb4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9357,7 +9357,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_ext_adv_data,        MGMT_ADD_EXT_ADV_DATA_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ add_adv_patterns_monitor_rssi,
-				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE },
+				   MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE,
+						HCI_MGMT_VAR_LEN },
 	{ set_mesh,                MGMT_SET_MESH_RECEIVER_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ mesh_features,           MGMT_MESH_READ_FEATURES_SIZE },
-- 
2.40.0.rc2.332.ga46443480c-goog

