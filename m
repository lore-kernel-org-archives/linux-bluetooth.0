Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8EC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872582075C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 14:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COcuh+9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfCNOvK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:51:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38464 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNOvK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 10:51:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id e10so968866edy.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2019 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAMudjfWH9I0szq3Vpg5WYIVldI/ajl/gQlR4HKW+2s=;
        b=COcuh+9djAdHce3reK9szbfyMQIbP1MYJ809EVfFyCW8WRy2cLZE/QYAZMZn/0AcKb
         g2eV4COzQtMZn2ZPO1s0/lGiVN+FoElzFSgAaSLYCuTNfmJdf5MiVf6Gbfm6pX2dCo7z
         dINNcbIzzmzMkb7Vom0ZmbsKpP8uRj2XBli1NF9C6hr2/h16v6DDLTmrLGDi1CHJmxj2
         XAewFJYeY6gU10yjALyUJZqAAEjHrj0Q/2+9GNh0yfg4K7lxxacls7jnGRZ2t3eNG01W
         OF1dGDq29aV0h0sE/eVnAan+x5HcpRfVWf6KEZrVbz9Nle83zlT/YOa3RqS5xl56TdnG
         5flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mAMudjfWH9I0szq3Vpg5WYIVldI/ajl/gQlR4HKW+2s=;
        b=uOWUOy93ssJlgn+4SsGAL1OrTJ6EoJ2+BdKe27fW1RpkHr2SP/4XccB4JnJpgbNndR
         NuMVuD9knJ5zKi4YSEVTDiY9oX/mbI9di5vPV8rjwgzNi5igQpFiVgkDuXcgOqd7ECc0
         E6kdEKUP5Fqw6oKhhqEbs0QmX2D8L6Rxc6zBI72S35e8V8Q6gmJlBMmyquPX16Ntcr8G
         ccMrE40GgJURvp1KPtFaF5RWKWZ5KhVn+rHWXcH8vAcFW5+oGd27sSwhEz+FUt+dZ0hR
         IhkR7O/ACOUzkAq7cu/808m2Wg32MW1GZDYdYDGuFizbDzeT2ALOIWvvvDnn3HexzgAu
         9rEQ==
X-Gm-Message-State: APjAAAU9dLXuJXYsxqylflCDJQs414N660/cnW9jl0Aq9JxnOgUW2CDy
        nATNyQ8Gr5B87DXeBZMzleTTSgpderM=
X-Google-Smtp-Source: APXvYqzKmoXg3HMOB+3izS4ESG1YPMRza/SDSbI7Cukau1pAM+TTYaaITSwoSLe8Lt+nvtN4E1BtRQ==
X-Received: by 2002:a50:b2c2:: with SMTP id p60mr11556423edd.183.1552575068284;
        Thu, 14 Mar 2019 07:51:08 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id e1sm1467213edn.22.2019.03.14.07.51.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 07:51:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/shell: Fix colors not using proper escape sequence
Date:   Thu, 14 Mar 2019 16:51:04 +0200
Message-Id: <20190314145105.25524-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to readline documentation \001 and \002 has to be used to
delimit characters which takes no space:

  'Applications may indicate that the prompt contains characters that
  take up no physical screen space when displayed by bracketing a
  sequence of such characters with the special markers
  `RL_PROMPT_START_IGNORE' and `RL_PROMPT_END_IGNORE'.'
---
 src/shared/shell.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/shell.h b/src/shared/shell.h
index 8b7cb7f30..e14d58381 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -22,14 +22,14 @@
  */
 #include <getopt.h>
 
-#define COLOR_OFF	"\x1B[0m"
-#define COLOR_RED	"\x1B[0;91m"
-#define COLOR_GREEN	"\x1B[0;92m"
-#define COLOR_YELLOW	"\x1B[0;93m"
-#define COLOR_BLUE	"\x1B[0;94m"
-#define COLOR_BOLDGRAY	"\x1B[1;30m"
-#define COLOR_BOLDWHITE	"\x1B[1;37m"
-#define COLOR_HIGHLIGHT	"\x1B[1;39m"
+#define COLOR_OFF	"\001\x1B[0m\002"
+#define COLOR_RED	"\001\x1B[0;91m\002"
+#define COLOR_GREEN	"\001\x1B[0;92m\002"
+#define COLOR_YELLOW	"\001\x1B[0;93m\002"
+#define COLOR_BLUE	"\001\x1B[0;94m\002"
+#define COLOR_BOLDGRAY	"\001\x1B[1;30m\002"
+#define COLOR_BOLDWHITE	"\001\x1B[1;37m\002"
+#define COLOR_HIGHLIGHT	"\001\x1B[1;39m\002"
 
 struct bt_shell_menu;
 
-- 
2.20.1

