Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF9C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 07:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCPHMR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 03:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCPHMM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 03:12:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07BCACE01
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:11:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so965496ybe.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 00:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678950682;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ONiyvATRP+sYO0cUaYvRRKjkxrSOSKrIRA+wHss4tjQ=;
        b=H+FPljJIIomYtc/NnrAnTTyoSPEooxmuWOrMvbKEhQcBQTU6TLkGYtIcd72fxkZvyj
         ie4ciSX2lkqv/NX/kCkLwzLilcEM6aXv10YrWNeWoQaLO15Xermeog90+uTvTpnHWn9a
         LCOzRiuMI2QAQcQ3ma6g8fWFPt11FPw6Kek0XN71XeoLf/ax/V0r1XeKEtXoKoPH8i1z
         jtATqW2Mjg6A4sHs1ca+plj8mOV4o48m7NU7R0ctNpQTVCx/mhO54JK46OaytnhUD81v
         zPTNtMnHE9ZDYVprOfQfORuUbZXvSbZE/QRBIsu0UrRtZEv9Vy2XUXNP/S1TumsnPT8D
         2lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678950682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONiyvATRP+sYO0cUaYvRRKjkxrSOSKrIRA+wHss4tjQ=;
        b=3aK5NNdBHrC/hr9eeS0ova+HgL7EIVC3xeaCl89gp/qwcTgACtVYH+rVVQKPQTpCzC
         B5OYjPY5Oo0wqJX0ZZeJqg68cwDPF8z4C2q6l2sEEdjSQv+doPubv/4AJdaeVfyx8A0U
         0Ty7KTTj7MyhgBfpjJtJO+i/tpqZhw9/jZH9p8bz+Ul2gfuiqosW6357H0hqmjzc+lB8
         azT4XBkMYS79wSCc2QnSmmxcWQUSQ8l9nDB9JkmChGU6xCF1G1QTo6/1kRx+44d9t1tS
         GD2m+stgO+rE5bAvyVVKWCKKFEDteQVQLImisfpzeHRdFEm0r/t6y8kPoTnCnzCpfg7z
         GDgA==
X-Gm-Message-State: AO0yUKWEOhjp7TJ65UbjHwAcPlJJa14Zy5KVjXf0L6sDc4tnVqf35CfA
        8L6s0UF0az9XY+kQ3kjpCSZTtOP9hTqJm+u7+0MjQ9vBZyP8ZdaA0VEAG2zxrLP/JuJ2YneKDO/
        fOnzqwJPw6dGXy5e5ejlhimPxZM8okj91RdSfTDE2gRWNSeBC/WbALoA4WG+10GXvh63iZAkz/5
        1ffM2xe40pC3o=
X-Google-Smtp-Source: AK7set91b5nUXx5SrhOK3n4qjarCprO5irMkIBZbqna7UYe5L25YhwrToCIxOTjZ6NIUBw4kz/evVHiPgmdEpjmCwQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:17:5470:81fd:9c7f:513a])
 (user=howardchung job=sendgmr) by 2002:a81:4317:0:b0:52e:f77c:315d with SMTP
 id q23-20020a814317000000b0052ef77c315dmr1629424ywa.3.1678950682470; Thu, 16
 Mar 2023 00:11:22 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:10:58 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230316151018.v1.1.I9113bb4f444afc2c5cb19d1e96569e01ddbd8939@changeid>
Subject: [PATCH v1] Bluetooth: mgmt: Fix MGMT add advmon with RSSI command
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        howardchung <howardchung@google.com>,
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

From: howardchung <howardchung@google.com>

The MGMT command: MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI uses variable
length argumenent. This patch adds right the field.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Signed-off-by: howardchung <howardchung@google.com>
---

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

