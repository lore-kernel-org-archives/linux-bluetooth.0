Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C86CC678DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 22:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355807AbjHQWli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355799AbjHQWlJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 18:41:09 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA513B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:41:08 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc73a2b0easo2862445ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312067; x=1692916867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8AkT+XbMJGmmldcsgFM4Bvk9OwSgkiuO67EBOYO4IE=;
        b=TWMP1DqGB+srh6q1mQCPqtGU+bCT6x0QqjlYsFMwo6253Sgmif2Fok9zXliO/pGyx9
         2FcKAoq0BcATAuwc3IlOunNA9eVrfEge9JB56Sm2ZYAn4+7AZ7dy1CCNyN6bI30GIuTH
         +g2Zjum1Vf7rJQf+oR5dsoecOz6ROX6eW0Cqn0lMvw7fzdLSr2iR67JnLim+uGs8rrGQ
         /TeNsGIbJEYUpcgA+5eg5qqz6cqO6X/DDmxsr5CUEqxkzJQ4wV+UGRe/w+3PA6GH4+A2
         uB995fI0780DXhin9kky3P8ovZn0cLDc8oGHi4L5gI+7diJYXy+lvkgdOA7QLKb8TIxJ
         V7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312067; x=1692916867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8AkT+XbMJGmmldcsgFM4Bvk9OwSgkiuO67EBOYO4IE=;
        b=TeH4P9sFB9boA8eIJ2Gv2xFu9j4gyMgKXOUB6lgd8RGp8z01n67SLQeriXWbLcgBh+
         uAbeTjoPpBbuimJmSTvdJkE6qMs6qUhtdFL0almD8lwgQmOmz73Gg474DXggANN8V+V1
         5JbfmnFuYQI0hQrA1K/scjhJ94WSz2pDL1+Xc2Kpg4x9+qX6B3Spe0va+ASqyPDDXvBD
         tRWCsljJsHUBxACl2bDqSAAgxVdxtGV2OCXgiYz5yWrVHkHPsK0RSMTeGPHEcNB2ppcg
         x1xKZyBQn41qZF57c1DEMkYVJZU8kXkTt7VHd4gGY2bT5Mc/xqLugP+9or8KMKhWQ2IZ
         1mIg==
X-Gm-Message-State: AOJu0YwAx/vFxUStEbx984ZEoyFi90CM80f3Jw1xpr1W94UczhbDMu7a
        lM5zdl5vyA/FOwmdq1Oe4y6sSi8c61Q=
X-Google-Smtp-Source: AGHT+IFWeJ3cBOUu4rygqjqWclwUw8vDWkt3Xr9yvaTmgumW0dS2c+StJbEe1UasqvN/9jNUUPwCuA==
X-Received: by 2002:a17:902:d486:b0:1bd:bba1:be78 with SMTP id c6-20020a170902d48600b001bdbba1be78mr831561plg.23.1692312067438;
        Thu, 17 Aug 2023 15:41:07 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id iy20-20020a170903131400b001b89b7e208fsm281877plb.88.2023.08.17.15.41.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:41:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] device: Restart temporary timer while connecting
Date:   Thu, 17 Aug 2023 15:41:03 -0700
Message-ID: <20230817224103.3042055-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817224103.3042055-1-luiz.dentz@gmail.com>
References: <20230817224103.3042055-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is temporary restart its timer when attempt to connect to
it since it can interrupt the connection attempt prematurely while it
still scanning, etc.
---
 src/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/device.c b/src/device.c
index f6b0167bf55b..9b58e0c4e6c5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5754,6 +5754,10 @@ int device_connect_le(struct btd_device *dev)
 	/* Keep this, so we can cancel the connection */
 	dev->att_io = io;
 
+	/* Restart temporary timer to give it time to connect/pair, etc. */
+	if (dev->temporary)
+		set_temporary_timer(dev, btd_opts.tmpto);
+
 	return 0;
 }
 
-- 
2.41.0

