Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D1C2BA2B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 10:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4188920757
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="J0qwv3Up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDIKan (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:30:43 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38250 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 06:30:43 -0400
Received: by mail-lf1-f44.google.com with SMTP id l11so7516030lfc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvc/pSvDtvjHf+8ZE2cIuXIWgP4mP4l69gvZW2PwppY=;
        b=J0qwv3Up7GCXS4wpmkgH+8S2lpf/i3hR4QUHnCM48wLBk+DQxkXIoVNcc9i50STnZW
         iXiWYRB+aMyiy4kHfLZyu3ydkUTULaz/21Lhf/B1IGkrDG1HmZSbZDckUkDhS5vMQX6y
         yygS2kQ65pe2uyFcYPJmatFZfE+G/1wflMmozznMfbCX9US8rJ8ONdVCwx1kGmeDtF5e
         67+oc0FBJHdwscBMoqdM7hbpH/OJv7n1+nD5fIZW5524TXJ8k+aLHo+fHn3mZtvk2i48
         OW5alae6Z0/4iqRU4rkdMMDTnI0TPTouTjCXcuH4briSWDAX7KgMvrfyK8dH3+yQ9wq7
         a9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvc/pSvDtvjHf+8ZE2cIuXIWgP4mP4l69gvZW2PwppY=;
        b=mYIRCARNHkASe1lcYEKLwhwxJHUxfYEYgd8pNj9kQ9bKj8cixIaWD6qb1kbwELglol
         rkrCAQXZqRw980vPH6kw3jzu004gsrqYfG+qGgR+cFLban9wqsYo4NNybCJxrbcGV9+e
         nZT45uyXjsuJR9IerdBDU7hzNKEkGD5l5vOQI2QnPAf0xSUVLs//rmT9M2a1thZDu72g
         OFTiu5BdsUZB8UA9OKcWxLC9WU4suLMuyjCso9Ue0I5WMa0mt5TRf7K/r3/WZ3bqEDFh
         oZTQL+TQpYVCKSECItW7PkYPZ+UT6ENYvEWOguIcm4p+CPb5m8nW5JAZz7m6uGE4NII2
         VYSA==
X-Gm-Message-State: AGi0PuaQhYwQscG72rd5IzAaZZ4fn+XzWsUVNQZYcOgg21/2maEy6ZBU
        ANQeK3hXRT51wktjhqEzxv+HEoTcGaA=
X-Google-Smtp-Source: APiQypKbzx07LA/3Al7Jp6fqso9HapaRKeaTegNPJCn+EKnQEljnuxhn7n+VV/KySXQib1eD4lLwmQ==
X-Received: by 2002:a05:6512:3e2:: with SMTP id n2mr2696930lfq.129.1586428240434;
        Thu, 09 Apr 2020 03:30:40 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id d27sm17042869lfq.73.2020.04.09.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 03:30:39 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] test/example-advertisement: Fix advertising when discoverable
Date:   Thu,  9 Apr 2020 12:30:35 +0200
Message-Id: <20200409103035.96589-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If adapter is discoverable (or LE-only) advertising was failing due
to too big adv data being set. Make sure there is enough space left
for flags if needed.
---
 test/example-advertisement | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/example-advertisement b/test/example-advertisement
index 88a27ab34..f116893b6 100755
--- a/test/example-advertisement
+++ b/test/example-advertisement
@@ -142,7 +142,7 @@ class TestAdvertisement(Advertisement):
         Advertisement.__init__(self, bus, index, 'peripheral')
         self.add_service_uuid('180D')
         self.add_service_uuid('180F')
-        self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03, 0x04])
+        self.add_manufacturer_data(0xffff, [0x00, 0x01, 0x02, 0x03])
         self.add_service_data('9999', [0x00, 0x01, 0x02, 0x03, 0x04])
         self.add_local_name('TestAdvertisement')
         self.include_tx_power = True
-- 
2.25.2

