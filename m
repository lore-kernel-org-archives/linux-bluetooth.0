Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8121EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjHAXcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjHAXbx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:31:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD32690
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:31:46 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7909808a504so162915639f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932705; x=1691537505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhNC38rHJARy+Xjp7ygLG8chIPQNmXHx9lmwZL4Bu0s=;
        b=UupK7Ns0o/fJJMAaRF8f1C4AW4nc2U5kf+qVlm990D2uRl+gauX4dffGp7/rqHwhlY
         aqoFEqoNPmO9Fhc6rX6nOHkYYEOS1cmdFlxBh8EMkOTLIbYfHAAlhF00MOLTObZAvyfV
         9aPYOnzghd/Ubjh3Hkz0spbDiiNnZjuiG27g+vMdiWsF+9OOYZuxmYsraBLPW9kW4v9F
         Vw0ZuWgVFmlr7h0xZoKbZHzn6Ny2dD6zCIiRL2lItuamlEqc6WXdLyuJPO7MjMD3veac
         TZ+N0eEWwtL6FarggD5LEwm4OR/lebkR/oGRypwS5PB9zDZ42r1SXCM5to+yBUzfSmli
         /s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932705; x=1691537505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhNC38rHJARy+Xjp7ygLG8chIPQNmXHx9lmwZL4Bu0s=;
        b=NfXw6NcHU8zoPCDfKhQvCUpGgHhQhAVJFpb1lnqF28qc5l3CXzMI/+VQlrINjX/DHg
         tZI/cPzZU2B0c/A7jtOgHnszhjJhzctDSWCzq3d7/TVqVhnhpGT5ia4SI+hLAU3Jgk8a
         TschVPUAXcJ0xIWIH4BjAiMvGOiSNdmhQ39trERJx106YtWxaK8U1l6R9BZ7y7RkPF/X
         oYoFSgt+0iz2VhlstHXHEQvtJQa0WMBAKIkEQOp/ijNSjzyAP0LSysFZ4d8PXQdNK5rd
         Yjx8a4L1z7WFTG4WSFzQfreY66A+BZxQS38bJbOH3/785cQMHkc5I+NyKE21NqFVvRij
         57yw==
X-Gm-Message-State: ABy/qLasO/iz3wmTUKKaj+gFQdwZ4Is7p4sfcIpKzQSXJKUtFmv/HFkG
        +h1EtsTBNfQb0NgFnfisE63rGwrcpak=
X-Google-Smtp-Source: APBJJlGVzAhnpWgIG87wgMDbUlhiljHkM9fjwHuhLXKm0bkrKtXb7+nIZxobEoyqcEsxU/08Padv0w==
X-Received: by 2002:a5d:9e14:0:b0:790:a073:f122 with SMTP id h20-20020a5d9e14000000b00790a073f122mr9681659ioh.2.1690932704736;
        Tue, 01 Aug 2023 16:31:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm1286269ion.20.2023.08.01.16.31.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:31:43 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 5/5] monitor/analyze: Inline data to gnuplot
Date:   Tue,  1 Aug 2023 16:31:35 -0700
Message-ID: <20230801233135.537864-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801233135.537864-1-luiz.dentz@gmail.com>
References: <20230801233135.537864-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of creating a separate file just to write the x:y axis inline
the data via gnuplot $data variable then use it to plot.
---
 monitor/analyze.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index d0ad70d5dc74..9f882a6c8b71 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -112,35 +112,28 @@ static void tmp_write(void *data, void *user_data)
 
 static void plot_draw(struct queue *queue)
 {
-	const char *filename = "analyze.tmp";
-	FILE *gplot = popen("gnuplot", "w");
-	FILE *tmp;
+	FILE *gplot;
 
+	if (queue_length(queue) < 2)
+		return;
+
+	gplot = popen("gnuplot", "w");
 	if (!gplot)
 		return;
 
-	if (queue_isempty(queue))
-		goto done;
-
-	tmp = fopen(filename, "w");
-	if (!tmp)
-		goto done;
-
-	queue_foreach(queue, tmp_write, tmp);
+	fprintf(gplot, "$data << EOD\n");
+	queue_foreach(queue, tmp_write, gplot);
+	fprintf(gplot, "EOD\n");
 
 	fprintf(gplot, "set terminal dumb enhanced ansi\n");
 	fprintf(gplot, "set xlabel 'Latency (ms)'\n");
 	fprintf(gplot, "set tics out nomirror\n");
 	fprintf(gplot, "set log y\n");
 	fprintf(gplot, "set yrange [0.5:*]\n");
-	fprintf(gplot, "plot './%s' using 1:2 t 'Packets' w impulses\n",
-								filename);
+	fprintf(gplot, "plot $data using 1:2 t 'Packets' w impulses\n");
 	fflush(gplot);
 
-	fclose(tmp);
-done:
 	pclose(gplot);
-	unlink(filename);
 }
 
 static void chan_destroy(void *data)
@@ -166,8 +159,7 @@ static void chan_destroy(void *data)
 		print_field("~%lld Kb/s TX transfer speed",
 				chan->tx_bytes * 8 / TV_MSEC(chan->tx_l.total));
 
-	if (chan->num > 1)
-		plot_draw(chan->plot);
+	plot_draw(chan->plot);
 
 	free(chan);
 }
-- 
2.41.0

