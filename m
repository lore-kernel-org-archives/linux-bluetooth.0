Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 00:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiEEAKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 20:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiEEAKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 20:10:21 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD74AE29
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 17:06:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h85so3179378iof.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=HbiYWIdNVKwGTsgzPzqs9alYt87vKPF/fNKnqjlmsgTVrVKSY+BKH1moNiAadjnjCT
         uiDRW0O9WAAqxsblrrt/PcLBKUi1ujrk4w8FD2W2DUtx4pgXAGowXs2aacotN+tVhRkx
         q41q153OPp2qO+v9LxEEkxr62cDkf5PzcgvUadQrUJLz3/nlEBHWXGXlp6qMs+WZX4YZ
         HLAJLrDHwc6owOyil+7viEI4VAJS9yU60UCs1JqcZDxHIqS3LPHFi9EGI5D6hH04O5u1
         IOavKSuxbiL2sh1Fft8TkHt+KECYeHgXGCbmFerDwesgZeHQCIWcAdEbJmWV4kOImmBT
         jHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=jm46pidryHrof6nDwis5HGupXZCxO5PEaE5/8RdtG9A6OY+CVVXRws1EA4iMAu/8VS
         ylwhG/6b9/VtP2EXZcOs+JtyA2bVL2O/uCKltKNnzIg11paCJzHTnC6bpahTb+2aMwAF
         caW4fdS+rDlfPpTly2kBvVfU7ArSuxuQlmvtC2qNoyn7rraCfRztteW/hlPkah5NbMn3
         +pV6+GwqIYue6r1oaxfs3Y57F2QtCoEz1wrSzc9QxOsXI+4+nU5zuL55P6ikO3N4xUMj
         BSO6jGBrmvdudH0RsQ9dyMsTbUvFYx6CsG2i7M4tW+Amv9R67WQurIZQ+4SmzFbQzYYO
         ENIw==
X-Gm-Message-State: AOAM532XXxv1Jk/wK/9/tR/LJZo9HTYor2TxMCKq6stjQQ0qBYDgMiRX
        +N0saTnMIqPG6CX+lFKFuFWvf4lPEHo=
X-Google-Smtp-Source: ABdhPJzcfdtDfeHXLN3ohm27ZGuVplWF9dZcC34aYlZBqdxL98JgSqKKBVpdbM7gB/fAl/FhQsR8HA==
X-Received: by 2002:a05:6638:2686:b0:323:bbe5:4f6c with SMTP id o6-20020a056638268600b00323bbe54f6cmr10718557jat.100.1651709193468;
        Wed, 04 May 2022 17:06:33 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f5-20020a056e020b4500b002cde6e352d2sm57926ilu.28.2022.05.04.17.06.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 17:06:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use bt_status to convert from errno
Date:   Wed,  4 May 2022 17:06:29 -0700
Message-Id: <20220505000629.2903297-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505000629.2903297-1-luiz.dentz@gmail.com>
References: <20220505000629.2903297-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command cannot be sent or there is a internal error an errno maybe
set instead of a command status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 882a7df13005..4a5193499b77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -946,7 +946,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (!conn)
 		goto done;
 
-	hci_le_conn_failed(conn, err);
+	hci_le_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.35.1

