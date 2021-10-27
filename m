Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C7FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08C8610A6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Oct 2021 20:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhJ0UNm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhJ0UNc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Oct 2021 16:13:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BABC061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 13:11:06 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so4018503pgu.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Oct 2021 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wp42jdzlxwEdRFspy4+GyKXkZ/9tORYCiZe+BJe7mg=;
        b=m61kcHUxSUMNn9Av0rdYtQDqYdIdCpS2pbom9VsbxohSORY2Ev9RDIjqHfOh8jnqNw
         nb8XoWaHVYFfFvrxv1zl3ifBzK2U55XAF6h8XwTsfXJtwf8YF9bQ/9FACrcq3/t0kwfy
         +bu3Srb6LDM8MCUROZfBOJbAizf341/AGxeYK8y2QJLDLiluqcNqPns6l5LKV5u/Z6qM
         lGkKOcIzXeiP5fb05HQk+YosnnVYr/hTdVhh+xfQ1PPVixkWcp30UR/9K1fyIp0YG9hp
         jC5shhteUPGFUtUVwAC/QBtf/JpkZf5YjcRriLOl8MYURaMlXRgQpJmMPNGALtiHyDYT
         eqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wp42jdzlxwEdRFspy4+GyKXkZ/9tORYCiZe+BJe7mg=;
        b=jKB2AG/i9x7dVdkvy0v00igZduCDdDlSn1aS3pi3aB7NyPLHJmomC3THxTDiQ0kU2C
         dERCVexAgMHUZbj2TCWpHPZD2y7E/wDappZD+WHTp5xlv8UGouW4k4xAD7pl/DOAoVvs
         PI+CS3VNonmhCo86KVl9leNEa0dlV7aMWgAbcaFf5VPP7OpOqnxvA3QVfB5MApF92MUk
         VNXj7QDIRST8wqab5qjgcFI6t0grmJpbyuxq8oCmW4tCxMrVmPRN6NauUdnHwP/RJd6d
         /cvwGkL/BUG05CU5uBnYUeMTDxiIhXzrCVYhlK0zF+n5RL0cLfI4i90U7e0xofhu46N+
         JQbQ==
X-Gm-Message-State: AOAM530Mv/ichMAoQnCHJdGy162LtcG11Wgm0T8jR+gxxlBLZAg/4SEx
        3ELPTQ2Puta6IsFezxG3jKwJOsBCRlo=
X-Google-Smtp-Source: ABdhPJwQxkNEc8mVXBNj2aoeAgcLRDPEMkjos6croeboFNLOSUDuIwVuqKtjE9AntRGqyKQLRmoejQ==
X-Received: by 2002:a05:6a00:2146:b0:44c:2922:8abf with SMTP id o6-20020a056a00214600b0044c29228abfmr34935969pfk.27.1635365465917;
        Wed, 27 Oct 2021 13:11:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y16sm737592pfl.198.2021.10.27.13.11.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:11:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not clearing error on update_bredr_services
Date:   Wed, 27 Oct 2021 13:11:03 -0700
Message-Id: <20211027201103.1668266-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When trying to loads contents from file using g_key_file_load_from_file
it may cause an error which needs to be cleared since the gerr is
reused, also make sure the file is always created upfront to avoid
having such error when storage has not been initialized.
---
 src/device.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 8ad338419..612d093a5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4998,22 +4998,28 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 
 	snprintf(sdp_file, PATH_MAX, STORAGEDIR "/%s/cache/%s", srcaddr,
 								dstaddr);
+	create_file(sdp_file, 0600);
 
 	sdp_key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(sdp_key_file, sdp_file, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", sdp_file,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
+		g_key_file_free(sdp_key_file);
+		sdp_key_file = NULL;
 	}
 
 	snprintf(att_file, PATH_MAX, STORAGEDIR "/%s/%s/attributes", srcaddr,
 								dstaddr);
+	create_file(att_file, 0600);
 
 	att_key_file = g_key_file_new();
 	if (!g_key_file_load_from_file(att_key_file, att_file, 0, &gerr)) {
 		error("Unable to load key file from %s: (%s)", att_file,
 								gerr->message);
-		g_error_free(gerr);
+		g_clear_error(&gerr);
+		g_key_file_free(att_key_file);
+		att_key_file = NULL;
 	}
 
 	for (seq = recs; seq; seq = seq->next) {
@@ -5068,7 +5074,6 @@ next:
 	if (sdp_key_file) {
 		data = g_key_file_to_data(sdp_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(sdp_file, 0600);
 			if (!g_file_set_contents(sdp_file, data, length,
 								&gerr)) {
 				error("Unable set contents for %s: (%s)",
@@ -5084,7 +5089,6 @@ next:
 	if (att_key_file) {
 		data = g_key_file_to_data(att_key_file, &length, NULL);
 		if (length > 0) {
-			create_file(att_file, 0600);
 			if (!g_file_set_contents(att_file, data, length,
 								&gerr)) {
 				error("Unable set contents for %s: (%s)",
-- 
2.31.1

