Return-Path: <SRS0=8q+o=TD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE18C43219
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610602087F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 May 2019 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJY2hnF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfECIqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 May 2019 04:46:06 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:34317 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfECIpx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 May 2019 04:45:53 -0400
Received: by mail-lf1-f43.google.com with SMTP id v18so1667906lfi.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 May 2019 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=aJY2hnF6o1G07AJHzp2Jaf22091qOJcuSoFBn0zg42GV2x1Ua0gL1HqAz7VC5BpaDl
         ycYNPcADf8tm+Eg/rvHacNP/dcKcz2jxd4SnYoL/rgCrBw51ZSnslzZA115+U9cGuyS4
         pL2nWqlF9J8K2YXpwMq9V6n7khiHWfwYchhUvkI/6Us96rvWv4rno77myv+BYt597RmY
         xmXZtSFLqPQUPWDadqKtsHKY23gEoEDIcQKjm6C2Gr4/dP/0vrb1NdYEJ3ZSce020dL+
         y4l06QWYMjYpb7ouXhL7G21Rm5bz7nR5vyAhzat4Dgdwy+9jRHDGJTYa9gnmDl7F19fM
         W/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EQOjhQ2HFe6BUiqvi74ZBwVWlvks5nOvCz0Wil3vdY=;
        b=AL1fkDt5YLHgQJ1zhkfJZsaIGLU78nZQIE+AzrDKsqPubWr7ZG2OKauWwhPBFd5YqS
         p6zqWaVxpfzla+cLy3Ue9sSH1Hs3+RK0hJqT932CLLcLpir3cOteuelq46B+MtadzuOr
         TBS0JdJOlWNsvTzUrPSHuIcILCZ3R8mXJk1pzy2nV2uoR+o5pWKUdJrSSIAOeg8U1sDX
         RDpTyZyMGjDnnxVNDDlXeYPyFUaFvRNG3BTYQt7fKlVfiQE+XrMLeRWj8W7sjU9UGcUD
         bHj46hXbx6XKNNj+nU/LCy2YrA2sBGIOZbVbVbAOWCEuzMwhyrHWRFeAFKAveEjToeLb
         QcnA==
X-Gm-Message-State: APjAAAVgZuTPlVba7qfwtywZRGpzo0sqAytTYOmO1G39pnoA937JXNOT
        vRtYBtzzXq2BXXzNlOARukZQ7UuwV9W1Ig==
X-Google-Smtp-Source: APXvYqzQqf5nB/Ew3g+Q8t1nCjC1WK3ipbvVgvdNsGVI/IFWaDpJALscuknQCMC7txXHtHCccUkFjQ==
X-Received: by 2002:ac2:44b2:: with SMTP id c18mr4293345lfm.86.1556873151066;
        Fri, 03 May 2019 01:45:51 -0700 (PDT)
Received: from localhost.localdomain (89-27-7-11.bb.dnainternet.fi. [89.27.7.11])
        by smtp.gmail.com with ESMTPSA id h26sm311360lfm.11.2019.05.03.01.45.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 01:45:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] a2dp: Try aborting when switching endpoints
Date:   Fri,  3 May 2019 11:45:46 +0300
Message-Id: <20190503084547.15743-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503084547.15743-1-luiz.dentz@gmail.com>
References: <20190503084547.15743-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If ongoing stream cannot be closed try aborting since the setup may
still be ongoing.
---
 profiles/audio/a2dp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 74ada3bbe..d0913b1ec 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1257,6 +1257,11 @@ static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return;
 
+	if (setup->reconfigure) {
+		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
+		return;
+	}
+
 	setup_unref(setup);
 }
 
@@ -1642,8 +1647,12 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 
 			err = avdtp_close(chan->session, tmp->stream, FALSE);
 			if (err < 0) {
-				error("avdtp_close: %s", strerror(-err));
-				goto fail;
+				err = avdtp_abort(chan->session, tmp->stream);
+				if (err < 0) {
+					error("avdtp_abort: %s",
+							strerror(-err));
+					goto fail;
+				}
 			}
 
 			setup->reconfigure = TRUE;
-- 
2.20.1

