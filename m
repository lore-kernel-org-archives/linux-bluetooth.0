Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F744C77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 22:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEAWoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 18:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjEAWoU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 18:44:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B091FDD
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 15:44:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6762fd23cso25481045ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682981058; x=1685573058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OoodNuFC9rdA2+izagBZMWlqnDFcXypL0rVTicRmfg=;
        b=qA6OX2KRDjBgPMBu+U12yhgE5tY9+LDBfEsIJFyVi8O0NUWrgnKLwm0qlo3ya38pvm
         8yjxYxx8di5cOAwor2yUopU2nW5TQKSR9xhZDnj9FtZoeBojGaRAHDfShnHrmjPjIQET
         0kNWJzSEgQZSqWfnFoQExRcwcWRlfwM7Ux0CcVnjKqtQfnyOLP1RnDx4Yxg0xQQTZli2
         XblpSZ8U+nTzmF7XoTCPw7Yjb1I2kA29nT8Dm7tmaelEkDPYnfsYUO7zvbj5FwWaErqD
         O3Jfc52fLx++UHsDmJyfuvXScCl09BIVI5pw7we/qmeH+oJw8xf8HYe50E4cOjw8iJ0c
         W8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981058; x=1685573058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OoodNuFC9rdA2+izagBZMWlqnDFcXypL0rVTicRmfg=;
        b=EN5apEMEnrZf3NoLRIu1vVtv6hF4nfToHDSOlEnoZHTSaFZWLFM8FiA1ac+Vo+h5Fc
         xoNHZPD1BCrAJ/lWhDG7QcjJ5eSKziDCa6oODP02zFB5MbKubHN8/APGDBgXr1CMhLDp
         ic4x2r7reBbRn6LR2z9EoaGsagBijFC3sRUc/MXM701olEwQZWLkmvUN260I6xkFodyJ
         Y4UdfFaVjqN3TsjLOnyujlE+3xWH0bakfnOMwrtJcUSMm8uRVSzbA9ov33ZiVIKPlPuI
         XY4rTh0HXF/ZT/daG0F6Zgco3IYmfSY4ZfmzeND+C0anE9dD91NqZ/VuMpNiQAM/KZbC
         6Fag==
X-Gm-Message-State: AC+VfDz5Bw9CjSevXU3fNbB51cFtwjxdxTH/IoAmaLa4N3tc5NHSzNVN
        M4MHuIk87z5yJ4vSiwLett31sLZce8g=
X-Google-Smtp-Source: ACHHUZ5PDSwZ6KuAL1B49gE5Cswncf4PECO1Wtldw6mUS8pbxXQYLqwKyJOIva95gOn8mwz4IFmzqw==
X-Received: by 2002:a17:903:294c:b0:1ab:ab1:f8aa with SMTP id li12-20020a170903294c00b001ab0ab1f8aamr204584plb.17.1682981058215;
        Mon, 01 May 2023 15:44:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001a6756a36f6sm18279806plq.101.2023.05.01.15.44.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 4/4] shared/shell: Fix smatch warning
Date:   Mon,  1 May 2023 15:44:10 -0700
Message-Id: <20230501224410.1119023-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501224410.1119023-1-luiz.dentz@gmail.com>
References: <20230501224410.1119023-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

src/shared/shell.c:615:21: warning: non-ANSI function declaration of
function 'bt_shell_usage'
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 757e16199ddf..db79c882ca3a 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -612,7 +612,7 @@ void bt_shell_hexdump(const unsigned char *buf, size_t len)
 	util_hexdump(' ', buf, len, print_string, NULL);
 }
 
-void bt_shell_usage()
+void bt_shell_usage(void)
 {
 	if (!data.exec)
 		return;
-- 
2.40.0

