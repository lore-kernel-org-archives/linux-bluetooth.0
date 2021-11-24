Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Nov 2021 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240713AbhKXCUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbhKXCUp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 21:20:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE4C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 18:17:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so1162624pjb.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 18:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3Fae/dNBP0EH2ThjovcGL1ZODngc4nnff0N0anompQ=;
        b=J1SNK+BfdByV84GFGkWFSqmr/PTTmK6ICvamceDmtltj8xY5Q3E3skyZSFTCHPe4Rr
         w+NRRKs75BFK+UPa4uHkNIJ/9Xm5tDDULftJ49ozp8916gKTU2OLKcm2cf2wl4X7vcy2
         ukknBM5AJkaNdAmKXJR0fimtyM3OLR9++QA96/7DwXD35vYlwzJ4b24QY6OIDS1TDEWF
         Rn1tG8kv5PrdQZyFzBjHW4LeL/N7llEdA5/kyXZgqCZ5/aSkxaruOcx4TMNvhz1/VxZ5
         GJvjdI7kzPoZpO45PRL/xBeLYxRRiUv7VQmCkG/vzEhrTIXHywjQFXSjvaTqwold51bo
         9tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3Fae/dNBP0EH2ThjovcGL1ZODngc4nnff0N0anompQ=;
        b=GvuWXHlryyeiLGcwcjPfnq+kK3jcG0Xdwzv8OSq2dKJ25jTY6qjbqxzPjEs3kTCOYU
         giSgYTASDKJ8LZxQ2m/qys3LDdxAhwIzklZoN/ozdMyO0GMB/ZdNaAjXpMaMdx/P7rlA
         Xn1EYbhq86dX1U2mbHuPNiLlZsOP7SFmyNnUEgbkuxf1P8PdTorsm4y0lYqCXiQuStug
         L6tvtZwqedNNge27PsFcbFSrj7paM40GQKEumxLyLoCZ99wnI/8pRud4SOLNG/0qdd9C
         SYEFMjBcIhy5WNlvccWbLNEbW4xHR05j/FYBbVF0siUdu64TsYJRVSmJ0DN1Q/VVxLD4
         Jyow==
X-Gm-Message-State: AOAM5319fpiTbtWYcBq1kRHkCrNvCMZbhLkVTXWyOXy/flLNQIgfZo3G
        ZaDFO4NDe4KC/+JKoUv46OAwrS+AsAQ=
X-Google-Smtp-Source: ABdhPJz4m2nponkDwIS50oBty0G/9or9rXv7UXDA9Exe3aBSHt6DAwq11foEQ7Ild6Ee7BexhHN05g==
X-Received: by 2002:a17:902:ab8d:b0:143:8d6f:2b52 with SMTP id f13-20020a170902ab8d00b001438d6f2b52mr13575341plr.78.1637720255919;
        Tue, 23 Nov 2021 18:17:35 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d10sm9338374pfl.139.2021.11.23.18.17.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 18:17:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: HCI: Fix definition of bt_hci_rsp_read_stored_link_key
Date:   Tue, 23 Nov 2021 18:17:34 -0800
Message-Id: <20211124021734.2769798-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both max_num_keys and num_key are 2 octects:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 1985:

  Max_Num_Keys:
  Size: 2 octets
  Range: 0x0000 to 0xFFFF

  Num_Keys_Read:
  Size: 2 octets
  Range: 0x0000 to 0xFFFF

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 84db6b275231..5f95de7367d5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1047,8 +1047,8 @@ struct hci_cp_read_stored_link_key {
 } __packed;
 struct hci_rp_read_stored_link_key {
 	__u8     status;
-	__u8     max_keys;
-	__u8     num_keys;
+	__u16    max_keys;
+	__u16    num_keys;
 } __packed;
 
 #define HCI_OP_DELETE_STORED_LINK_KEY	0x0c12
-- 
2.33.1

