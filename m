Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC06ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiIMXcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIMXcC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 19:32:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D0171BD7
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:32:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so13390914plo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=Sth9s6jFuAgyrkcRmgl3qDDWKNFIt5yzW79ugW82O8E=;
        b=b1TAbHUvUSmMva7ETzGd/2dJOh1gjLOnBBiy53mS4RC5YIDyvk5XynEEZimYjcDQeb
         5rlAQBe6s0hptP3ECuD0mJKyql7DzKq4MDut8LI20Nz2CFQXp+dH+31sOzdxOsxmtZEM
         O7isnHd9ZIdfPmIg3UvZgINU9PE4w9SLYu/emKrO23fNdSiSiWSSMt8OtzL6LXR/Vkd0
         pWM3u4/kLdEoA/ljeFycPmD6+083QkUDHWOcamqQAAfVJeOQtgmrP2QvBSzlaF0PwvuP
         Sis7LvXBCpj2pa5CmKC1JXktp4bp81aKbTfpWDirz3PXQ9wIrIA/Hk25uq/CBwAWBnTB
         smJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Sth9s6jFuAgyrkcRmgl3qDDWKNFIt5yzW79ugW82O8E=;
        b=ohFSbnAl5rkGSzSkOdLZgedQl+7cbILLZL3kzwBHvd6m14Pf2cvdUFTuoN9BghitVn
         wSUUgLs3Xg4uMKThPxZnT3w97WJSGqa0A5xvtM450q44JT44irgjFpBPcVUjPTltdqf4
         s9dLffU/Rcgfode4EfCkkWQhCtwdkKcXKNn82Vsxnhg949hNkwwIqAQQEkjW7qQ/f+Fa
         YyAqdsZUxdYEF0dquIOf63wg15bDKxApfDjHcVFuDmc1sUBEuzN+nWzfqjO+lCMlKBFe
         4KxNHEeB5ix3QgiKXicukaZzoP9P149JiJEVeEaas73i7H2qU3SSXMFt6fPP8cdvaG2U
         l2kA==
X-Gm-Message-State: ACrzQf0yArHDz1yqLFWFGJZYBWwuBvY2Iekd1f8SPh20b+7c9jcERFwz
        6CMw0lyTd+PbhqK5X4tfCpbbR2RyHVzS/acs
X-Google-Smtp-Source: AMsMyM4QxuRv+9qfrAnU34/SN0HLN2WfSM/+CahAeeIh4j/iUmeopxmtOyxH9fhBwt6oLXvgclYc5w==
X-Received: by 2002:a17:90a:8b92:b0:202:c361:9dba with SMTP id z18-20020a17090a8b9200b00202c3619dbamr1655341pjn.62.1663111918942;
        Tue, 13 Sep 2022 16:31:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n18-20020a170903111200b00174d4fabe76sm9010599plh.214.2022.09.13.16.31.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 16:31:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: RFCOMM: Fix possible deadlock on socket shutdown/release
Date:   Tue, 13 Sep 2022 16:31:57 -0700
Message-Id: <20220913233157.526041-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to change to switch to use lock_sock inside rfcomm_sk_state_change
the socket shutdown/release procedure can cause a deadlock:

    rfcomm_sock_shutdown():
      lock_sock();
      __rfcomm_sock_close():
        rfcomm_dlc_close():
          __rfcomm_dlc_close():
            rfcomm_dlc_lock();
            rfcomm_sk_state_change():
              lock_sock();

To fix this when the call __rfcomm_sock_close is now done without
holding the lock_sock since rfcomm_dlc_lock exists to protect
the dlc data there is no need to use lock_sock in that code path.

Link: https://lore.kernel.org/all/CAD+dNTsbuU4w+Y_P7o+VEN7BYCAbZuwZx2+tH+OTzCdcZF82YA@mail.gmail.com/
Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/rfcomm/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 4bf4ea6cbb5e..21e24da4847f 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -902,7 +902,10 @@ static int rfcomm_sock_shutdown(struct socket *sock, int how)
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
 		sk->sk_shutdown = SHUTDOWN_MASK;
+
+		release_sock(sk);
 		__rfcomm_sock_close(sk);
+		lock_sock(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
 		    !(current->flags & PF_EXITING))
-- 
2.37.3

