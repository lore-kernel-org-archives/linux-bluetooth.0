Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2171C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 23:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiCAXbi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 18:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiCAXbi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 18:31:38 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709F5E171
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 15:30:56 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id c23so20376039ioi.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 15:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiQE5c8qCZGLdeigVZyAAwK/Aob5Mvq4VXY5Stj5/BU=;
        b=nnMSrfKdJL2pDT1y7DU1bs8X3p79HZYgVP64pM/5Zttz770HdcdmtDpBHTb49SQvpC
         eA+iGLcza2W4n6rg+UxxezoixtG8/RuFqvDOIP8Uu/EIlukrCrywuLzIMmSfYo+NU4Qm
         ZoYHIRyStuPkGXFBcfdoCVpvsfHiahl6o4Ew6OZb1iozqV8e1YUUoPx7RvrYK5LUKBHA
         2i1p8N6ntW/IoT/t2QwkKEA+2Wl+1vcqrtxu9UfoB1FWj/+eAEULap38ujlAH8M99Dwh
         3K7aUi1y3snN1QcuSDqckMSSFIKpFm3iHKfBte3L4ck7pdMem9Kke2Ht6KdcrUOWRni3
         vYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XiQE5c8qCZGLdeigVZyAAwK/Aob5Mvq4VXY5Stj5/BU=;
        b=bzZ/xa937wg1VWkobbefM0vB8rxm5PuvYMSVBGksC5UHqHQGuZCZTSROacUil1TY7n
         HoVodm1rPXb2uoghwmbXdbQIDNXEXjngK3xzmuLzPFJOF6IQ8u7V//qKtfWVJahpaP2H
         8Xm5/paeDZdhYMxkg949J11f7D/Rs9XqdC/coRPXwPK35wKCw57qLbuYARC/eJ9tpQRs
         FQVIhPf+RAluUWDMC9UNEGHtsFPrn1iCM1ZyWTelXqkWR0S/Afx+kGY8FB9U03TYcbJf
         idHJFM7dBsMNRF+WdoEdxFcpalMo/Az7S5YHKvzBtLCIofcxi3XQvjF1zAO9eqHL+ko/
         0dbQ==
X-Gm-Message-State: AOAM530yF6UzvEOP2kobZlEyCGxGtCrPoYO5k0pzbOLgKlSphAJE8gbf
        /G9ssI5gfrfHkhMKiEZwGo1cUFnXIlc=
X-Google-Smtp-Source: ABdhPJxlEN6TA9tV9ojp8yNvspXBy0RV6I13zwiqWvfxfNJlZp83MY7A+Q4kxgkrcI4rcTD6OgieZw==
X-Received: by 2002:a05:6638:120b:b0:30d:ec04:4f3 with SMTP id n11-20020a056638120b00b0030dec0404f3mr626902jas.272.1646177455441;
        Tue, 01 Mar 2022 15:30:55 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e020e4300b002c242b778a5sm8414646ilk.74.2022.03.01.15.30.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:30:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] test-runner: Fix parsing of command line
Date:   Tue,  1 Mar 2022 15:30:53 -0800
Message-Id: <20220301233053.109920-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of parsing the command line, which can contain a shell script,
run using /bin/sh so it allows more complex command line to be tested:

sudo tools/test-runner -l -d -k <pathto/bzImage> --
'client/bluetoothctl power on && sleep 2 && client/bluetoothctl power
off'
---
 tools/test-runner.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index e0e002dd6..3dea38bc6 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -716,25 +716,7 @@ start_next:
 		argv[0] = (char *) test_table[idx];
 		argv[1] = "-q";
 		argv[2] = NULL;
-	} else {
-		while (1) {
-			char *ptr;
-
-			ptr = strchr(cmdname, ' ');
-			if (!ptr) {
-				argv[pos++] = cmdname;
-				break;
-			}
-
-			*ptr = '\0';
-			argv[pos++] = cmdname;
-			if (pos > 8)
-				break;
-
-			cmdname = ptr + 1;
-		}
-
-		argv[pos] = NULL;
+		cmdname = NULL;
 	}
 
 	pos = 0;
@@ -743,7 +725,7 @@ start_next:
 		envp[pos++] = home;
 	envp[pos] = NULL;
 
-	printf("Running command %s\n", argv[0]);
+	printf("Running command %s\n", cmdname ? cmdname : argv[0]);
 
 	pid = fork();
 	if (pid < 0) {
@@ -758,7 +740,11 @@ start_next:
 				perror("Failed to change directory");
 		}
 
-		execve(argv[0], argv, envp);
+		if (!cmdname)
+			execve(argv[0], argv, envp);
+		else
+			execl("/bin/sh", "sh", "-c", cmdname, NULL);
+
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.35.1

