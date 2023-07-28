Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D327FC001E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 17:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjG1R7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjG1R7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 13:59:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354863C1F
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ea67195dso1839770b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690567180; x=1691171980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq/xN/8W0GSGo1Vn6uul++xq/XHjSuMSQtXh1disr3g=;
        b=rbHJ6S9UaimBrUN9ox/kvzs/5kjCsgOV17MMn/NoiaShd42axpKctPUpZvGCz4nVWH
         O7bBhn0LmBn6HIA7rfu1ftLHYvsTmVqsnD7OElf4RuhH3cfY93OZcwO27xg5kkqZJVgM
         FX+60JCQmO0nx9RdG6PT3M6uFd57Op+sKu8EZLX4lr+D4/kBJBVtQ4ID/tAoAOky/nZI
         iZ4Pyp2n6ciCwJ0hoBhlsnGyLdZOWlobZXEBmwLgNbIGVlkOw795AbinBKzQHeJcZU2T
         V5A1q8lmbemnoYSwNx8z5wG4HIVRk4IQj3JWF1W8sW/WRD7LHMtTSnvKORhnG9bIlIEw
         Amwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567180; x=1691171980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq/xN/8W0GSGo1Vn6uul++xq/XHjSuMSQtXh1disr3g=;
        b=JiX5wvyg15EFFMfXkSrObZo7lyXFqQN0W0NfxMws2eGI0W8ydkgFNBheLh7i+NT++e
         +GNrXEkdv35BNftsmAY7t97Cb4av1P2mMIf2pq9QOUy9NrtEYAPhVFzaf3CoKc0kUfUx
         qTAWDRynY1gjRAnYw+jYzIPEVGUgn2i59v3dSVrYygrbL8RDpuZIiVU8X9DvZrW+Y4Ww
         9nNi4RXlOIwv5E0Ic+oIHElec1/eQGRG4Uv/GtssSPrrXg08fY+WIFzQx2e1zS/O1PXO
         e3aoD0cWj+C46SpDBbA4hYxDCMD2OcbT4/L5rKXEEcmx/69JPh7BDH9ObGmnlRAU2zLc
         AqhQ==
X-Gm-Message-State: ABy/qLYuL0hLIO5bm3TX9ysBWeEbWfFdHahKKhVU8y3Jqnv1G41WmrF7
        6DfdnhfgtZBETFolWAWel1HggJGXC9s=
X-Google-Smtp-Source: APBJJlGpOMaKApM+xBV9g0DtUhyu8m34alunqobrXcTSuYGXhPZNYy9+peRsc1IURjGHRznksL7B7A==
X-Received: by 2002:a05:6a20:1447:b0:138:1980:1dd3 with SMTP id a7-20020a056a20144700b0013819801dd3mr2441488pzi.14.1690567180494;
        Fri, 28 Jul 2023 10:59:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b0068718aadda7sm427796pfn.108.2023.07.28.10.59.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 10:59:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 2/3] monitor: Update documentation
Date:   Fri, 28 Jul 2023 10:59:36 -0700
Message-ID: <20230728175937.42818-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728175937.42818-1-luiz.dentz@gmail.com>
References: <20230728175937.42818-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates the documentation to mention gnuplot usage.
---
 monitor/btmon.rst | 4 +++-
 monitor/main.c    | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/btmon.rst b/monitor/btmon.rst
index 0ab13eb2eb5c..82f9381c151d 100644
--- a/monitor/btmon.rst
+++ b/monitor/btmon.rst
@@ -33,7 +33,9 @@ OPTIONS
 -w FILE, --write FILE       Save traces in btsnoop format to *FILE*.
 -a FILE, --analyze FILE     Analyze traces in btsnoop format from *FILE*.
                             It displays the devices found in the *FILE* with
-                            its packets by type.
+			    its packets by type. If gnuplot is installed on
+			    the system it also attempts to plot packet latency
+			    graph.
 -s SOCKET, --server SOCKET  Start monitor server socket.
 -p PRIORITY, --priority PRIORITY  Show only priority or lower for user log.
 
diff --git a/monitor/main.c b/monitor/main.c
index decf7cc467f2..fa56fcb29f38 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -51,6 +51,9 @@ static void usage(void)
 		"\t-r, --read <file>      Read traces in btsnoop format\n"
 		"\t-w, --write <file>     Save traces in btsnoop format\n"
 		"\t-a, --analyze <file>   Analyze traces in btsnoop format\n"
+		"\t                       If gnuplot is installed on the\n"
+                "\t                       system it will also attempt to plot\n"
+		"\t                       packet latency graph.\n"
 		"\t-s, --server <socket>  Start monitor server socket\n"
 		"\t-p, --priority <level> Show only priority or lower\n"
 		"\t-i, --index <num>      Show only specified controller\n"
-- 
2.41.0

