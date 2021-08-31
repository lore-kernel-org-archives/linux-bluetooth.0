Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CFC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29896101C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 05:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhHaFph (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 01:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhHaFph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 01:45:37 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B8EC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 22:44:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g73-20020a379d4c000000b003d3ed03ca28so6724898qke.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Aug 2021 22:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=z4TKKgrRsdnniVVn0CdIX9ICR2CveZ1wtLngem9pa+I=;
        b=GbF1TcztpWKIdykcC0+SMexd2bXIHsVuGDL0olSrFRTshWwXIPlFb17UUFgbnmVkfM
         /BQVAfn7WG8Tv0rFdrXaQpl4L2mx2Ceq70SVfQPEseoSeNTp6AQOSZH7qelo1yEPeYvo
         Cg+l3JmHxff4NHDVVwRUYplPe6JjI7j0mVsWzylOu/UUAuIxXdUlTivVUl4CC8/mQ+/U
         jsaq/Pdua9yH5trOPfSxGTMoCMkLmv6XSQ19Ec2gdqry2igjuE0XKN8QdAv4bSyUW+Dm
         FTOIb+RHEJGh/Zgoyx9tgW1IKdLov1ka1eAaKWKtrmIxyLt/GwH9plhjy2HSSQXoJz0x
         fWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=z4TKKgrRsdnniVVn0CdIX9ICR2CveZ1wtLngem9pa+I=;
        b=Gb1M1M0QNdypxFYdbruGQZKHnuveCyzeOJRERujhG8m1vfJK3jzI1fPXnSRSjfVtsk
         5KM3PXV5mNDTa+gFU9Eb3DirSNMk3KrVxjHzby6Yglmk9Ed9TYoZPOjopr5/gbrqQoiK
         2wc+4vQodE5G4trhPOoiUdrAa/ULSjlcWN+ANeG7TMQZq6SagZUTL+Wo6/wMI2iQNtv6
         YhEDTmzaKcBdv9CGCS07SsNyr+KKbQ3XVH3ej0J5tOxTskkhJaZVV7gSPC4fh03Lyi5i
         GASkMvyNDCH0kveVXCbowelJveHwwosswn2Su3LDjsQebOdNsHFx1wh4gIJd4/y49am/
         XV4w==
X-Gm-Message-State: AOAM533GurjebXdvgpcyjMtp8Wz/xLCDnh6wTT7PnfUUu9p7QjvbUL9V
        kTyAMNEEYLJD+k2EpQTeIHw8MqCGixxu/xq0rZUwOu02rEplLphV6LcVNwaUWdTPAHzGOuTZITf
        zXTVrHkdCSRrXp8isLnIgtabXK5CdIHdqjs0fhUXh9p6yDkk8L6nkY/u2d3aIOGFJRrCkX7FFYt
        tyjhIoCR/xqyc=
X-Google-Smtp-Source: ABdhPJyGkc4xmksLBWirlJ7lHTAAJIBL3hOC1qFdWNlPLrtAjog/m1GiiUo2b18NHQwMpTpjFvfTcmnT0kY4cFgMXQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:93c2:6f3f:e782:13b0])
 (user=howardchung job=sendgmr) by 2002:a05:6214:621:: with SMTP id
 a1mr27430578qvx.12.1630388681710; Mon, 30 Aug 2021 22:44:41 -0700 (PDT)
Date:   Tue, 31 Aug 2021 13:44:36 +0800
Message-Id: <20210831134420.Bluez.v1.1.Iea4821c4c33d0a0f1986b97a1f6cd885427348a8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v1] btmgmt: add non-interactive quit on read-sysconfig
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This fixes the erros that read-sysconfig doesn't exit in non-interactive
mode.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
Test with following commands
run "btmgmt read-sysconfig" and make sure it exits correctly

 tools/btmgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index a840c428cc74..42ef9acefaea 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1906,17 +1906,18 @@ static void read_sysconfig_rsp(uint8_t status, uint16_t len, const void *param,
 	if (status != 0) {
 		error("Read system configuration failed with status "
 				"0x%02x (%s)", status, mgmt_errstr(status));
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	tlv_list = mgmt_tlv_list_load_from_buf(param, len);
 	if (!tlv_list) {
 		error("Unable to parse response of read system configuration");
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
 	mgmt_tlv_list_foreach(tlv_list, print_mgmt_tlv, NULL);
 	mgmt_tlv_list_free(tlv_list);
+	bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static void cmd_read_sysconfig(int argc, char **argv)
-- 
2.33.0.259.gc128427fd7-goog

