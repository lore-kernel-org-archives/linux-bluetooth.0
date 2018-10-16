Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B9EC5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF5820869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojOhJ7sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF5820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJQEMz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:12:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42082 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEMz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:12:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id s10-v6so17988504lfc.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=juoU2KlAoThEGkv20uTTP36QzCAWigU9eSUm85nARbY=;
        b=ojOhJ7skU2VTaRyYdEXAh8Amt9vVo7KypPu32R3hFdyN85F9B0f7JxjW0zzxGT6p0g
         XJHGYYWA6RzvlAlMkuyvpBjYHv3UXTi4irWAlUyGm6EOqMkSnASD+WLQ2JwDXb3Gv9pg
         x0VuiQoD6M53osIkfwp7QpoiseMKIG3TfxvW/irT1uwB92QA9jflCrSNj9xuJ4igQSDa
         lZWO+H55DmGcJwrwDXeqbwBmNkF85RRBjZJZhnlb0An7CCJp10hqVSNj99IgRxljakUe
         svd4xvsIc5pez4KUNJmAf5QeOsCibqiTo0hgXa6UhUun8elKDchpZMW/2Ll6IhGLXlqr
         s92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=juoU2KlAoThEGkv20uTTP36QzCAWigU9eSUm85nARbY=;
        b=HKK0xtXfcR3LnANeCN2U3BOsZIgXCv9ObxE7AaD7vrpBltZy8tOS7qaIb+m+SizSbs
         IfauDogDldAaAbiKd4KdnMaiS9h718dcGKhBJY3jJcbc25pOka3YP736ca4bwiIk95Ev
         ZTlLTMAupcZtaVQYshGNx7jYUNyLfR8scBZRzQBH2mFQoz+ABQXR0K7th43UId2QCSl3
         3yUYizYiSMdQzqcT410otenMT4+2Jf1dKVb6tcsEJrA5gkm8aPRxd8VnehDT8+5gZ8lx
         VakBzZ/YLn783aJUApnsxs+pmS31Se49QkGHBnmZVpHWTVEO8C/7s/AuHXCCzD+lvauZ
         abPg==
X-Gm-Message-State: ABuFfojpmqCigYqKLcifUDVTAuFsqwRGzXcmWt1zoCInIMBvF1xdh9ZH
        bBCsQrYn202cq8n0qS5hdLjqWsuFNbA=
X-Google-Smtp-Source: ACcGV62wq5BgoU5XriGYVnQjQrkV3FHv+su2tUdOmPUUnSVIhiP7mP14iXrG5gL0LqPzUgVZJLC4gQ==
X-Received: by 2002:a19:cb09:: with SMTP id b9-v6mr14312860lfg.117.1539721247304;
        Tue, 16 Oct 2018 13:20:47 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id x9-v6sm446594lfa.65.2018.10.16.13.20.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:20:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:24:15 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/12] btmon: fix segfault caused by buffer overflow
Message-ID: <20181016202415.GA85022@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Buffer overflow vulnerability in monitor/sdp.c SDP continuation handling
caused btmon to crash. This happens in global static buffer which makes
it non-trivial to exploit.

This is nasty bug in a way that this can be triggered also over the air
by sending malformed SDP Search Attribute request to device running
btmon.

This crash was foung by fuzzing btmon with AFL. Seems to be reproducible
also with Synopsys Defensics SDP Server suite.
---
 monitor/sdp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index 96fbeb864..df5ccdb71 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -43,12 +43,13 @@
 #include "sdp.h"
 
 #define MAX_TID 16
+#define MAX_CONT_SIZE 17
 
 struct tid_data {
 	bool inuse;
 	uint16_t tid;
 	uint16_t channel;
-	uint8_t cont[17];
+	uint8_t cont[MAX_CONT_SIZE];
 };
 
 static struct tid_data tid_list[MAX_TID];
@@ -410,6 +411,10 @@ static void print_continuation(const uint8_t *data, uint16_t size)
 static void store_continuation(struct tid_data *tid,
 					const uint8_t *data, uint16_t size)
 {
+	if (size > MAX_CONT_SIZE) {
+		print_text(COLOR_ERROR, "invalid continuation size");
+		return;
+	}
 	memcpy(tid->cont, data, size);
 	print_continuation(data, size);
 }
-- 
2.17.1

