Return-Path: <SRS0=Dxuj=4J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E1C35640
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD82073A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Feb 2020 08:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvNcbWKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbgBUIjf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:39:35 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33253 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731537AbgBUIje (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Feb 2020 03:39:34 -0500
Received: by mail-pl1-f202.google.com with SMTP id bd7so779040plb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2020 00:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qabS3Yt4uR7Wnjipl66o4GWZ5y8XuRMfgvjQy7cEXTE=;
        b=nvNcbWKu8TZNixlQBARlGWvQL9w2bfJZsHHUJB/opCZ64YXTz5gE1urGDpo+gRSCru
         ODY+TPoZeb0nOaehsVaJEbGtE58GPgpSRYb2shnRFE50uGpj+9B3fAyxnJDFxS+vmCLi
         o0Pd3d0cGDn3ldlssZpu/bccNKRtyGP1eXHT+JkwshorviJoNEvRzLSDnLN2KuFbDxB8
         N51pucLgRPl59FtYxPYUWZpD/Qa8Tl82Grx3akhZFbC4eUrbLTonRrd6wINl32sf+9y/
         gBmkJhjNm50H+TBHEwF65c8TUa0kKvLem17I3/RbtVV0+lPSxRWTV/3EhbR2EoPWLWzk
         xqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qabS3Yt4uR7Wnjipl66o4GWZ5y8XuRMfgvjQy7cEXTE=;
        b=g+tKT+O+gGDGof3lPiUOwMDLJcd6433vG7GUXGiKfuSDNo5R9+7N73EMp+wL6lFLBx
         bwYzRtfq394WoFhzQ8OWR8+GMJ6WbxWME/dV7coQvqdiH8r9aIh44jfJCUWC/WqCwDn8
         nIErWZRF2s/IXULe35q39BSJ8zi+kZo7MthSLqWpl8Eo181ipBKf+9rwEr5HJLxLUnV1
         8iR+qg1zRF97UF/2ERAJyqtKfE2l+zLV7o8ImIYTispVCQ42KWexJoEJ8PiAMphFNSy9
         BpGhdtXd6Y6yQIBi8SsjpK3QzsqkotMviN7OnQUgn/SB0YvJjR5FEtYw1jikHsSTdPr4
         mW6A==
X-Gm-Message-State: APjAAAU1zWjwDnsy5kR2LCeW5wuEZHs+o8p0lp0ZfX2L8AkCn5WIMvlM
        ipN+B01FUe+rTBYHUUKK49ZROcEfIhtfnryCm7TmIEhD5Cp9MTT94nyIlyHNNZM3MKvXbZa10DJ
        9tT3zBzb0pCzGlEMGaKyVLBZB1qtqh3hfGAvonuXPphni4mRMWULWEwsB8RTkK7Cuxm7l6kqnPu
        hN
X-Google-Smtp-Source: APXvYqxTNIWUWLbN1wuY/Ql4ptJf/Riaq6Kc3JJwW5j7Xe8DppMGeLf/ob71OgOGZ6oTTKkG/0McgYmK74Z6
X-Received: by 2002:a63:ad0c:: with SMTP id g12mr36851945pgf.228.1582274373240;
 Fri, 21 Feb 2020 00:39:33 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:39:23 +0800
Message-Id: <20200221163911.Bluez.v1.1.I3c505b4307094eb7a6f2c5949125a17c89b2e099@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [Bluez PATCH v1] src/profile: Ensure class UUID matches before
 connecting profile
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth spec Ver 5.1, Vol 3, Part B, 4.7.2, there
might be multiple service records returned in a SDP Service Search
Attribute Response. Also, according to 2.5.2, the service pattern
can match any UUID contained within the service record, it doesn't
have to match only some specific attributes of the record.

Therefore, before using the service record to connect to any
profile, first we must check that the service class ID of the
service record matches with whatever UUID specified in the service
pattern we are looking for.

---

 src/profile.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 192fd0245..1b481836e 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1568,8 +1568,34 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 	for (r = recs; r != NULL; r = r->next) {
 		sdp_record_t *rec = r->data;
+		sdp_list_t *svcclass;
+		sdp_list_t *svcclass_iter;
 		sdp_list_t *protos;
 		int port;
+		bool matches_class_uuid = false;
+
+		if (sdp_get_service_classes(rec, &svcclass) < 0) {
+			error("Unable to get svc class ID list from %s record",
+								ext->name);
+			continue;
+		}
+
+		for (svcclass_iter = svcclass; svcclass_iter != NULL;
+					svcclass_iter = svcclass_iter->next) {
+			char *uuid = bt_uuid2string(svcclass_iter->data);
+			int cmp_result = bt_uuid_strcmp(uuid, ext->uuid);
+
+			free(uuid);
+			if (cmp_result == 0) {
+				matches_class_uuid = true;
+				break;
+			}
+		}
+
+		sdp_list_free(svcclass, free);
+
+		if (!matches_class_uuid)
+			continue;
 
 		if (sdp_get_access_protos(rec, &protos) < 0) {
 			error("Unable to get proto list from %s record",
-- 
2.25.0.265.gbab2e86ba0-goog

