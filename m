Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BAC3279D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EA520853
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 03:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAZBdDQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJGDBQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgJGDBQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 23:01:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB09C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 20:01:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id bi5so409515plb.17
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=V0qJCj9XkDH/wx4wMpnuu0GUAzrWembJIZOJ5vlztdw=;
        b=FAZBdDQKYrhQp8rtZY3jzEFpQfCe8UZhr68hgMEC8Go6S4lzbiM7sVB3VnTbznl99L
         UfUzcQ1xMNvRyF+N3qXUZlP1F/HaTG131WmeRMRAImeV+pcvYx/moAA5IGKRh6anH4uk
         tJ8MKflnC6sqPUhoCKKSGIkthK63TY7lMFXgLSATcoq9AP29tP+lngSqsB8E/kud484O
         iCR5r66BfL+dgfANKguBS3+A2ozOYlncf0dVKmPSflDDgvQjvNauAvUf2Hl/DSoZsruY
         +D1+0ujWJKubgngPozWChbeq9oxr/M+30AZB5wVDwCyRweSLUjegrFLGOhYkt7yQR0C/
         2sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=V0qJCj9XkDH/wx4wMpnuu0GUAzrWembJIZOJ5vlztdw=;
        b=HdXoAQIk4pZ8wnb+iagi36otGl4iyeNv+p/ZGiTl+X5O/K5QUcTn1K9aqLqMfd3yyj
         o6Bs8ewrvBdggEd6BjOhhl3pkGKq3KQNY9YRf5c2UWhhbQYWHSntqnxER9F11GLj97Qn
         5jYKCcmKqJl4KfST2/ayrZu4/qxTJIPoSdO9z+Y0g7HgAbVN/k/I31YAMBP0QNA9AxmP
         4Syy5KjyaMCfn3mr6H3NFhBZP3+OwEdAr1CtjbHdWTohxu/Ofbd7ag5R/Kc1Jwzh2MCo
         NRvGfQ4zVePk/E6XriYHBGbsTTlTkquPSZANWU19GVn+Depk7N4+BL0LuERwewqfRM+r
         P8fQ==
X-Gm-Message-State: AOAM533pXddpp3VmQWq8kx6cxXZYUp4cbTlX0bJIaR4da3CzGT4D5K0J
        iJn/xpxqAUudu1woGqkgVu1qKQ4H8VJHvsAdicTAOhLnapzD6BcmauR0Vvsd1GYIatviJMtphIw
        aHZlbi1EgdtV6YZ3zWaoPcuJuOW5Ul8xfIooOUvC7/uWAmBb8UtvJfRvfGPoUPA9OW7Hc2lFRMi
        r//9I+9WV/DUw=
X-Google-Smtp-Source: ABdhPJzK19w+Qm+i87nn1pvXWKedKaGEMhgLH3wJ3YE5nrujV2BR1pbCYgpSElrh1fVen5+LHM5pN6cR8DVCwzBXLQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:902:6b44:b029:d3:e78a:8ab6 with
 SMTP id g4-20020a1709026b44b02900d3e78a8ab6mr913593plt.72.1602039673890; Tue,
 06 Oct 2020 20:01:13 -0700 (PDT)
Date:   Wed,  7 Oct 2020 11:01:06 +0800
Message-Id: <20201007110032.BlueZ.1.I09f767132567613957435203a827e5151b26a15e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [BlueZ PATCH] adv_monitor: parse AD type as hex value
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     apusaka@chromium.org, luiz.von.dentz@intel.com,
        alainm@chromium.org, mcchou@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently bluetoothctl parse pattern as a decimal string, but the
Bluetooth SIG website uses hex value instead.
(https://www.bluetooth.com/specifications/assigned-numbers/generic-access-
profile/)

Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

 client/adv_monitor.c | 4 ++--
 client/main.c        | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/client/adv_monitor.c b/client/adv_monitor.c
index 90ab0be093d2..74f19d2d93e4 100644
--- a/client/adv_monitor.c
+++ b/client/adv_monitor.c
@@ -435,7 +435,7 @@ static struct pattern *parse_pattern(char *parameter_list[])
 	}
 
 	pat->start_pos = atoi(parameter_list[0]);
-	pat->ad_data_type = atoi(parameter_list[1]);
+	pat->ad_data_type = strtol(parameter_list[1], NULL, 16);
 	pat->content_len = str2bytearray(parameter_list[2], pat->content);
 	if (pat->content_len == 0) {
 		free_pattern(pat);
@@ -542,7 +542,7 @@ static void print_adv_monitor(struct adv_monitor *adv_monitor)
 			bt_shell_printf("\tpattern %d:\n", idx);
 			bt_shell_printf("\t\tstart position: %hhu\n",
 							pattern->start_pos);
-			bt_shell_printf("\t\tAD data type: %hhu\n",
+			bt_shell_printf("\t\tAD data type: 0x%02x\n",
 							pattern->ad_data_type);
 			print_bytearray("\t\tcontent: ", pattern->content,
 							pattern->content_len);
diff --git a/client/main.c b/client/main.c
index 60f1eb86e26a..16cb0234c48e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2724,6 +2724,8 @@ static void print_add_or_pattern_with_rssi_usage(void)
 						RSSI_DEFAULT_HIGH_TIMEOUT);
 	bt_shell_printf("pattern format:\n"
 			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
+	bt_shell_printf("Note: both ad_data_type and content_of_pattern are "
+			"hex string\n");
 	bt_shell_printf("e.g.\n"
 			"\tadd-or-pattern-rssi -10, ,10 1 2 01ab55\n");
 	bt_shell_printf("or\n"
@@ -2734,6 +2736,8 @@ static void print_add_or_pattern_usage(void)
 {
 	bt_shell_printf("pattern format:\n"
 			"\t<start_position> <ad_data_type> <content_of_pattern>\n");
+	bt_shell_printf("Note: both ad_data_type and content_of_pattern are "
+			"hex string\n");
 	bt_shell_printf("e.g.\n"
 			"\tadd-or-pattern 1 2 01ab55 3 4 23cd66\n");
 }
-- 
2.28.0.806.g8561365e88-goog

