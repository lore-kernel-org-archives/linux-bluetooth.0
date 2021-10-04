Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6331C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B4D6115B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 17:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhJDRD1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238108AbhJDRDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 13:03:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A342C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 10:01:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t11so314790plq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yHDE+pdyim+dSveVTksGayMc+DH3XrBdNG3cNm/zRc=;
        b=Jb93qr6vK6axnMRJ1776/SFY0c9qKCaEzWC4XnD9HsRDo05sv7m/J6XYOrfObAbrgP
         RC2jlxMuxlP9+FnAKzlcfGFHsFXH/of+oepF4dhxaFdSlDyJvPp53BiHDNb+41SLHwUu
         d+RTlSwJSlPiwXqZKCK6znQQlv889Na5p70eW2eBikkBHeSkaMVon0b6ddp/Vk9i+Vzy
         aYMaKh+D48VSs32ppLG1Y+/3yhM+LshwrBVKgO2LkwWsLp69CaoiKBWXn4Ek6Mky4wUM
         ZpfWKFv39KVaw53wO0M0DwR9nfQNFRw2Ky7nmy1K1ZuA14cwrdAunMlta3Si4xWmb4M3
         prDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5yHDE+pdyim+dSveVTksGayMc+DH3XrBdNG3cNm/zRc=;
        b=zANWF7825ZverMmEb2RAQhASeA1DkQXt3X4HgeLmK38k9u67VNxGfdEoRB5dzypzlM
         TnHu5RAPL5MWMkoKRAzYQar8fhar/YlaTVNPEoZh7nbV68QiWtFzCCb0wH0QO6Si4dYF
         fO+5D59Lv+PmotE1ZB3U135TUyJYmOi9pZ4D6XpoCsO5mmLin098Y4lfeOaoyTVrpChR
         35XuX6GIkNNOi0muA8Jdl9tJDK6DiRIzYTW6RLiie2ngyk20OupKDC6xYzhEprVxsvW9
         Sj0YjEqJXzlW1gqve1BrQsP/PvnpmFg0N6YfMZnwuZIv6ZRZxCx2bVbi4H8LBY3Jo3h4
         LBBQ==
X-Gm-Message-State: AOAM530GHW1DCYSeOzP6ErHv9+pUlid3apURWI2OM9TUdq1cGj6mdZPi
        s/kj6ECSBlDZXdaKvqdCq4eRVR3Ynxc=
X-Google-Smtp-Source: ABdhPJwWsf2Fy45/WE5J0K3dQJxI76dlsqXarHu4JOJxiOEG2fUv2W0OZq5ExcZ07ZzX/bo4FSJoLg==
X-Received: by 2002:a17:902:e78f:b0:13d:f99f:34bb with SMTP id cp15-20020a170902e78f00b0013df99f34bbmr696535plb.48.1633366890297;
        Mon, 04 Oct 2021 10:01:30 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::d9e])
        by smtp.gmail.com with ESMTPSA id gn11sm13574454pjb.36.2021.10.04.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:01:29 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH V2] Bluetooth: hci_vhci: Fix to set the force_wakeup value
Date:   Mon,  4 Oct 2021 10:01:26 -0700
Message-Id: <20211004170126.206054-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch sets the wakeup state of the vhci driver when the
force_wakeup is updated.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index b45db0db347c..5fd91106e853 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -176,6 +176,8 @@ static ssize_t force_wakeup_write(struct file *file,
 	if (data->wakeup == enable)
 		return -EALREADY;
 
+	data->wakeup = enable;
+
 	return count;
 }
 
-- 
2.25.1

