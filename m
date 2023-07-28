Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBAC41513
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjG1Wmy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 18:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG1Wmx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 18:42:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC32421C
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68706d67ed9so1373296b3a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690584171; x=1691188971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq/xN/8W0GSGo1Vn6uul++xq/XHjSuMSQtXh1disr3g=;
        b=kMiv8/InQzceLzTcJ08BFpwazOjY0KYd3CMsnU81eOY7Tf7y/HhgoLh6ovRcWk7Y2U
         H2CmjxOHobhZ6h2kGWj/EYM0tCc5HApF5qwqNnxbXox4Es0g1SFuJPld4mDNuBiDfaQV
         oO97p3Ln1PFAlhOoIx45pGJXiUi7HfSV7jOuW/JcoeWzfiHpJjSw76Iahd9o5M40fDfk
         l3Rtb0xbpeulZSJmRsHV1Thhtav92t4+VqK43IuZ7hyrSyZZSJt/yVwcoTsajp8U5iOW
         R8Vu7d5CkeeHgXLu0Bq+62nPc/zqJHv+jieKUfNQXBnz0Cgak3HKCUJMJL3IMlkNtlTd
         gfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690584171; x=1691188971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq/xN/8W0GSGo1Vn6uul++xq/XHjSuMSQtXh1disr3g=;
        b=AayxOZgv2aD5hogjf7t7h4ePAiPPhVMjW4+4OxlrbaPWYfTe0YJjcjqZzeHZZm3xAs
         ZmCznkbNmvZPa8m8gB+vzWXMubCbiUCmCmAhIak2+sEqcZGEiMBPhgZ05BCPkG6EILYH
         mKjfSFyV1tQfUaq3sVdcZJesoxIQHt4UncgDPIuKRPRw0rwOJVRcdonpw/55g9xIjHe6
         caHqBAutHf/PNxzOIQLeFc8OjHYdiMt0KOV6pEtn2Ulv6cpJDvAVH3WdSrgjS/i/s/E4
         4rDFEYxo8Wg7fHHcWXiTz+YrD0E0gJnTkUSCy9VDkozVmQfEMVZrIHM/503x2KW8R1lS
         Nv7Q==
X-Gm-Message-State: ABy/qLYr2jS9f9xc4lr1GwiyfX7uT+MI5nvCzWsTKDMqu86lPCeCiVTq
        fZDSF5QRupwd5ByKhpnT8lRBRJcKunc=
X-Google-Smtp-Source: APBJJlHpuqHdsdkC1z+RrPMKXyDrGJhHtAmVGxTM5yM7hVVIZPmXta59ytyjM8ACQ7E2NuunQv/eEQ==
X-Received: by 2002:a05:6a21:778c:b0:131:dd92:4805 with SMTP id bd12-20020a056a21778c00b00131dd924805mr3234600pzc.57.1690584171327;
        Fri, 28 Jul 2023 15:42:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a000be900b0068703879d3esm2731041pfu.113.2023.07.28.15.42.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:42:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v5 2/7] monitor: Update documentation
Date:   Fri, 28 Jul 2023 15:42:42 -0700
Message-ID: <20230728224247.102057-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728224247.102057-1-luiz.dentz@gmail.com>
References: <20230728224247.102057-1-luiz.dentz@gmail.com>
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

