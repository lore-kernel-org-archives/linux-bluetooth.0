Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841CEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHAXVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjHAXVx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9968F26A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:21:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68706d67ed9so3897309b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932105; x=1691536905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhHzgYxpkySIP9sxo8gNiJ+G7DvpijjrVJOTxAgVnsM=;
        b=VhhRxqVSQs9zHULXPFJF4fvyucLWWYINw901Pl/fj8GPCvTJA/AXySVxY1uNUJW5TX
         ntJ/3mwoPJuaYL2Zz4m9PxP+nrYuRzJZamVwbVbnrQo5WJ7Ljyj4xnf/oli9mM+yuPHo
         x7mNaY9uweTPUslKaBIPgVJEri84weljEsOluzHs5qta9ZmFnKqtYw6JA6V3/yhrhxIq
         aKXUF+Wk25Ig6QZx6/u7sqWyMyyk1x8QbPTWa53ma7vCLvBgPrMkOuBFrrYrkEhDBhPN
         SySI9WkFKKGLBsH8dttkAkSQiyFQF5imbyg+GIAXbbeI/qInBHF3gJZas4HGhaTpXzGp
         xZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932105; x=1691536905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhHzgYxpkySIP9sxo8gNiJ+G7DvpijjrVJOTxAgVnsM=;
        b=Ko4PJatfy7YrOACn15zYT3HiLva90x37ANIopE6B623YqKeXHxqJ2aBTydIAl3SV/G
         FouWK0cYjmwlhQx60LijvCk7cp6RLJaksmq2x9f1DNrpDH3caWXj/sAtT74IVzM3kapr
         Mfd4jCI3SqCvPxxnlejGsSuPaiCjh3JPCMMqXc7in8J+iIPhWeiic4RevenSh+KxQKlv
         /KyIqKo4l6ZPswTcTWheacnb2fdp9Ej1iSVhVON8GZ0STTgRprgxRvpLDa0Q04y5synR
         RRsDQ+YVGtRtdViPPDFXS4yiH/HmEG0J4NFRWK69YwuuwNWlBfXwdDJTWmduztsCt9KJ
         /l0A==
X-Gm-Message-State: ABy/qLYsc/BLu5K/bZx/bmg2IprmItqpMeFoJ4oZsVUFv/nZDxF4lyhF
        fAuSGHA4zMuSl3cHqvJerYylHqJO/IU=
X-Google-Smtp-Source: APBJJlGWQBG4MWWhpaw9iU0Kr66QJzOm477GWJXocvLTjDuauaqO3DQw2xgHS3gko1WHMNSw76zxEw==
X-Received: by 2002:a05:6a20:a108:b0:13e:23bc:f4cc with SMTP id q8-20020a056a20a10800b0013e23bcf4ccmr6011708pzk.37.1690932105404;
        Tue, 01 Aug 2023 16:21:45 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a8e600f0sm9856157pfb.35.2023.08.01.16.21.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:21:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 5/5] monitor/analyze: Inline data to gnuplot
Date:   Tue,  1 Aug 2023 16:21:35 -0700
Message-ID: <20230801232135.535733-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232135.535733-1-luiz.dentz@gmail.com>
References: <20230801232135.535733-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead of creating a separate file just to write the x:y axis inline
the data via gnuplot $data variable then use it to plot.
---
 monitor/analyze.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index d0ad70d5dc74..687595cb249a 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -112,35 +112,29 @@ static void tmp_write(void *data, void *user_data)
 
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
+	fprintf(gplot, "set log y\n");
+	fprintf(gplot, "plot $data using 1:2 t 'Packets' w impulses\n");
 	fflush(gplot);
 
-	fclose(tmp);
-done:
 	pclose(gplot);
-	unlink(filename);
 }
 
 static void chan_destroy(void *data)
@@ -166,8 +160,7 @@ static void chan_destroy(void *data)
 		print_field("~%lld Kb/s TX transfer speed",
 				chan->tx_bytes * 8 / TV_MSEC(chan->tx_l.total));
 
-	if (chan->num > 1)
-		plot_draw(chan->plot);
+	plot_draw(chan->plot);
 
 	free(chan);
 }
-- 
2.41.0

