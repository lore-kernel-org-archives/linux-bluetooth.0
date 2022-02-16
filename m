Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D804C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 08:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiBPIPw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:15:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiBPIPk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 03:15:40 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F59254A6A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 00:15:27 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 195so1495272pgc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 00:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2TrrUJvMSS9r6nDjg8VXFSYq69Wj2ThIHgUyzlIIo=;
        b=YBLxiKIPo2TAHc8rAx95Jlj7n1WAai/8MsIuAvnD4OF+55PhUl8CFLK6VcmoE3qSeE
         qU7Ahjk69cesCDj4j6Wgmx6TSutbKRqcOQ2dNCWd/0L2thupEq2hI1Kp/ETd0rjdxnnU
         T94U655ljaShB+3LydMvKqO64lcIJYWvXq5Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2TrrUJvMSS9r6nDjg8VXFSYq69Wj2ThIHgUyzlIIo=;
        b=jHQQkAWZmnI2vE8DPsQiF6ChLGf5XYmfgqiPdV9hEl4B8fTzRJoWglzyBvbQNI3qhI
         qrweIhrIEmdQCXPISjB/HZNw/I+sasOqV87fyfvJNejFSI1Oa8phZL8UCa8vrS2JYk//
         CYZWRvkKBEw4UFDNpX4DxA21rkNFMHasBuVU1c9lDkrvkFNq1Fax5HuR7mMvV4m0l0O1
         CHkoi9MsniwG9xdgdttfQa/7WEwRW4U3stb6Rkolh5tGeSKGPRkVRMQFG1W+dIku0uOR
         gVPlGQ98eJ5+hfKMx/AOHoKQ7EesGRSaKbXfGphuarGNKMv1X+wlLzC+0lNXnWiwCeOD
         mviQ==
X-Gm-Message-State: AOAM530h3krsm304MTcWaOMw2+fghkukg6nhfAjyWDA2PRVwlhr4SW9b
        6WhdsG8nSmjvfuAE7zpoISxcThrtJQYc8w==
X-Google-Smtp-Source: ABdhPJzkScTdOeWcVLIp9sCLIJlWP4WekbWWGA+pfGW8kQpmMQ6jjfLiZrI9pswyvD9prTts6ZbU4g==
X-Received: by 2002:a62:2902:0:b0:4ca:75a3:aa1c with SMTP id p2-20020a622902000000b004ca75a3aa1cmr1507401pfp.65.1644999326664;
        Wed, 16 Feb 2022 00:15:26 -0800 (PST)
Received: from localhost (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with UTF8SMTPSA id h5sm8268043pfc.118.2022.02.16.00.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 00:15:26 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Shuo-Peng Liao <deanliao@chromium.org>
Subject: [BlueZ PATCH v1] monitor: fix division by zero about conn->tx_pkt_med
Date:   Wed, 16 Feb 2022 16:15:18 +0800
Message-Id: <20220216081518.2956782-1-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In a connection without outgoing traffic, conn->tx_num will remain 0.
In this case, conn->tx_pkt_med should be simply 0 without calculating
"conn->tx_bytes / conn->tx_num".

This was likely to happen, for example, when "btmon -w btsnoop.log"
was launched in the middle of a LE mouse connection, and a number of
incoming ACL Data RX were received as the mouse movements.  When
running "btmon -a btsnoop.log", it would encounter this error.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>
Reviewed-by: Shuo-Peng Liao <deanliao@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 monitor/analyze.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 0c74e8f2e..ac23e13bb 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -161,7 +161,8 @@ static void conn_destroy(void *data)
 		break;
 	}
 
-	conn->tx_pkt_med = conn->tx_bytes / conn->tx_num;
+	if (conn->tx_num > 0)
+		conn->tx_pkt_med = conn->tx_bytes / conn->tx_num;
 
 	printf("  Found %s connection with handle %u\n", str, conn->handle);
 	/* TODO: Store address type */
-- 
2.35.1.265.g69c8d7142f-goog

