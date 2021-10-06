Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B63C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69278610CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhJFVjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbhJFVjC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 17:39:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5245C061753
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 14:37:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p1so3505413pfh.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FS+cdrCmVOzroaJGgLnE3Tj/4MeEL/etrhBd9oBNXvQ=;
        b=hT/vLrTatcs7e60OeructsU39LY0mMWNMO3yKG71j8BEO+3ZEKt4tbsGSAfujLQ4eZ
         GHLbyocIdf5PcmiG/GyrphaaYWC6TIofidqKq1UIxTzTlSK7DxhTcsJoBPOXMpmAZ1/x
         Ci/z+gH/L0/b/y1K4PjaMZzRuyxNKmvB31asbWN8ZXaNZskIJUkZbeeYPGuEsGHQ99Hc
         VunW6Y7TxRyPHkyikxHBjyBJ1mpWgovEJbbpAdo+tnPBumM8keoYgHifY/EUCcCUS4yV
         7xpEp7ryreCUmuyX2xYShqszq45xuFGRdcgMAViVLol5hAxPtS9YhUQT7mAIB7j6kX1q
         /SxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FS+cdrCmVOzroaJGgLnE3Tj/4MeEL/etrhBd9oBNXvQ=;
        b=RhTBYNvl/yruuISkOas1AYKIivXAVwKbxJ9GzlK3n0oaoXlyO3PMtXkNdYTzcYs1Jy
         EpRC2wc0+l+Ck7pJEpf9kPixknrNjmYwLcTbpChjCSW9dSbLI1AGv+fN96O/uyJAUCD/
         u6Zz3bgXoFKHXbNBsfNA2fev+5wN3pEF1rnq4PJepaG025GLo2EryI5IPBTtnjUHpY5C
         eFFZsKe9fCU60leI/mJYRe2tQxc1Taf8oaRLY+zS2X2Fv9WQaOEmLGLhyYAwrV/HZtRd
         6DnDpWuWxrhCpldQG2U8QWlhP8FiqHIvwBLneFmGfe7VlbnlAnfl16zQOcwAsCALFMVo
         T8Kg==
X-Gm-Message-State: AOAM533iK8lzvtjwJVT2Mkcxu2KaDjWpoSdTRMMqVqfUWFyh1UMrN7Vh
        yf9Bflt6Wmpkb/xPlO+96/3haj6nkWg=
X-Google-Smtp-Source: ABdhPJzLNQfN33J05y0J821hNI08IqgAgK+sXI0alhIzNub3M2Ug+vwEgCeMW0hJ3fvagi9CcKTkuQ==
X-Received: by 2002:a63:f346:: with SMTP id t6mr303181pgj.345.1633556229007;
        Wed, 06 Oct 2021 14:37:09 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e6sm11858763pgf.59.2021.10.06.14.37.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:37:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] test-hog: Update pdu sequence
Date:   Wed,  6 Oct 2021 14:37:04 -0700
Message-Id: <20211006213704.1093265-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006213704.1093265-1-luiz.dentz@gmail.com>
References: <20211006213704.1093265-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With recent changes to use bt_att_resend the procedures such as read
long will group the reads to the same handler before proceeding to the
next procedures.
---
 unit/test-hog.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/unit/test-hog.c b/unit/test-hog.c
index e6d4affc4..bc23b58ff 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -243,13 +243,17 @@ int main(int argc, char *argv[])
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
 			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
 			0x15, 0x16),
-		raw_pdu(0x0a, 0x08, 0x00),
-		raw_pdu(0x0b, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+		raw_pdu(0x0c, 0x04, 0x00, 0x16, 0x00),
+		raw_pdu(0x0d, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
 			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
 			0x15, 0x16),
-		raw_pdu(0x0c, 0x04, 0x00, 0x16, 0x00),
+		raw_pdu(0x0c, 0x04, 0x00, 0x2c, 0x00),
 		raw_pdu(0x0d, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
+			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
+			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13),
+		raw_pdu(0x0a, 0x08, 0x00),
+		raw_pdu(0x0b, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
 			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
 			0x15, 0x16),
@@ -258,10 +262,6 @@ int main(int argc, char *argv[])
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
 			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14,
 			0x15, 0x16),
-		raw_pdu(0x0c, 0x04, 0x00, 0x2c, 0x00),
-		raw_pdu(0x0d, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
-			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
-			0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13),
 		raw_pdu(0x0c, 0x08, 0x00, 0x2c, 0x00),
 		raw_pdu(0x0d, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
 			0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
-- 
2.31.1

