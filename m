Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180AFC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0950207DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="giPa4T6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUGiv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgHUGit (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:38:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB089C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:38:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so556868pgf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCAHQDySYVytSsRNqhn2N9L1L4hHyPd2rGsJSHa6Rf4=;
        b=giPa4T6ByZXUBXOlrSZmX+/K1NLQe+yALhKjc5JGrrE56YeTc8rfYzEO3IIqGoC9lH
         bKNtdCmkC5ti8Cv48BBp1nbzYBNdonm771S9dwy8uhu1moeovIRmqNXsZ2FUQsUAojLm
         HMvyVCICVnGBAyQovcPtMZ4xQTQxoiyrjcR9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NCAHQDySYVytSsRNqhn2N9L1L4hHyPd2rGsJSHa6Rf4=;
        b=SMZg6yHBYN+xhNtyLt0b/MhaGQ7iTQCTK++7tXU3TaQEUEhyW2O6KHHw4JQjm0nHhH
         /SvsScXgt5w7boFkNdTlS43qwwE3mrwSeF6bKALwoO40dSZDGyzcoWCw1R0LGLCRj5Bf
         4se6UGPZgVbMBcEw8AqMOHTJ0+5p1UrXFF4e6JGN0+2DKYZjU1UEWyq8Igj3+7tmBoBt
         SzIxeHvlpG6l05tIIVzSFmGuDdhzY52i1MmcZZi1jAHuUeS+QcjoxtTW+5xJCjJ2OGCO
         gGWPqwLlE/GElKrNFSfJNnTc3dA0MTSfeRTwDcqRRFXKQhSi4bz5mGo7h3965WoaRATB
         J3VQ==
X-Gm-Message-State: AOAM533u6UWVtI2TFSY7OHpKRJY7L+VnuBYlH2KPkR7duDHzYyoZoVXp
        8eseWg1tE7OrBnhwXMFncI8cZVYR2PnkRA==
X-Google-Smtp-Source: ABdhPJzIx+0tnownHaG/a0n+eEOk2FJJwQ+sX8hIRLVS6FTyppAWNrWi/xya3nrQN6PH2ts6B2pEvQ==
X-Received: by 2002:a63:705b:: with SMTP id a27mr1172355pgn.405.1597991927713;
        Thu, 20 Aug 2020 23:38:47 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id q82sm1350106pfc.139.2020.08.20.23.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 23:38:47 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] device: Cleanup att of a device object before assigning a new one.
Date:   Thu, 20 Aug 2020 23:38:44 -0700
Message-Id: <20200821063844.17349-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For some unknown reason, sometimes the controller replies "Command
Disallowed" to a Disconnect command. When this happens, bluez kernel
strangely reports 2 MGMT_EV_DEVICE_CONNECTED events to bluetoothd.
Unfortunately bluetoothd doesn't handle this case so this situation will
lead to bluetoothd crashing due to UAF at later time.

This patch protects this situation by always cleaning up the att of a
device object before assigning a new one. This way the old att will not
at later time fire disconnect event which would operate on the already
freed device pointer.

Tested by repeatedly connecting/disconnecting to a device until the
situation happens and checking that bluetoothd doesn't crash.

---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b7808405..e696ba1c6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5304,6 +5304,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 		return false;
 	}
 
+	// This may be reached when the device already has att attached to it.
+	// In this case cleanup the att first before assigning the new one,
+	// otherwise the old att may fire a disconnect event at later time
+	// and will invoke operations on the already freed device pointer.
+	if (dev->attrib || dev->att)
+		attio_cleanup(dev);
 	dev->attrib = attrib;
 	dev->att = g_attrib_get_att(attrib);
 
-- 
2.26.2

