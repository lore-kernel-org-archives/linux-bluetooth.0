Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F3EC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3A02146E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 20:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ve2fHHWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgCDUb6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:31:58 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:46506 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgCDUb5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 15:31:57 -0500
Received: by mail-ua1-f42.google.com with SMTP id h22so1201242uap.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 12:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E15tbHALq6nVn9BQmrydPcISrGd27YfhbSBMTzwCpJg=;
        b=Ve2fHHWez4SY15rTWihb5lQI4XmV1cgx0PgGSK7wvwnN1DiesyF9a94wCg8t/wiP88
         XhPyg9meg9Rn5iikFBpPQ3BwaHvGRHJm2eCpUuLoiK/IDjKfbA5q8jfFCTQMJbAWTryD
         Ygp8FgxoGWYEAOYrn2poJ+CQezxnlkSXPQqh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E15tbHALq6nVn9BQmrydPcISrGd27YfhbSBMTzwCpJg=;
        b=rti5fohOiGZlSHP8DCwY0ne8K5CUhK6gAQcMy1s+Qu0TQJfeblJsDajUY8vi/xRVLk
         lPKpfynqixc2YHIKjEnrW+0KrxNBAunNWU3FqP5q5WEzcwesHK9mj7hmc0qCM2NY5vjR
         gTjGT9WiwbiEZAauC9vK+UlE9YjYoldIiNEzP6pgXVbOtNFMR9zspAZRHuB5Xpx82FsH
         KBAGOa3e/N72iUxSrPzq7crS28zzIrrJaT4J/vzt9HE3eNZdKkJJQ6VrjIwVSAPBml2D
         RI28hIfWsIdTJ2i8d+dRDVD4bOY1/jwkYgGNRzMPOFMeyUyT0cTzus/DUAzIKKb0q2Rd
         MoLw==
X-Gm-Message-State: ANhLgQ0GcqM696NPelAFgyPXS7RtKqV26PIJKTbUbRSl6EP7kJqkdbPg
        u9FWfFNOcMIFsHhe/UvmfiyNiVZSjMQ=
X-Google-Smtp-Source: ADFU+vtbN02ViJTgJLA0mPprCvhTbIGW2i0vdrCf3aAVRm6c3NJMC1naJXOfiRDxy0qYGGctyJy0lw==
X-Received: by 2002:ab0:1653:: with SMTP id l19mr2646131uae.8.1583353916287;
        Wed, 04 Mar 2020 12:31:56 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id h139sm7786311vke.34.2020.03.04.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 12:31:55 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] Adding definitions for Wide Band Speech configuration
Date:   Wed,  4 Mar 2020 20:31:52 +0000
Message-Id: <20200304203152.111935-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the corresponding user space definition for wide band
speech.

---

 lib/mgmt.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 101cf5f95..d1f0a6053 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -101,7 +101,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_PRIVACY		0x00002000
 #define MGMT_SETTING_CONFIGURATION	0x00004000
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
-#define MGMT_SETTING_PHY_CONFIGURATION 0x00010000
+#define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
+#define MGMT_SETTING_WIDE_BAND_SPEECH	0x00020000
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -599,6 +600,8 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
+#define MGMT_OP_SET_WIDE_BAND_SPEECH	0x0047
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.25.1.481.gfbce0eb801-goog

