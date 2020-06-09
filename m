Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4421C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3802078D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XRN2mSgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgFIOEN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOEM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:04:12 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29761C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 07:04:12 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u17so12012419vsu.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pgMDFeLv3CuHVdyC+7IG9SC7auMQmM+m1GRNNNhmUP0=;
        b=XRN2mSgB+LEcAb0ppXrYlw4xDWYbfWDQ/ACT9m3u/UupU5biOyPZTwjLB7m8W5KbOB
         zrL1FvpBzT3Va3hlbpp4ENoYDPtfkkm0xxqhbHxUUooDDPUdtJevfpuajjCdYy3JbAdE
         eTsnZl8ffQVgCS6nxENsxSEJnRNLcCasWZ7ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pgMDFeLv3CuHVdyC+7IG9SC7auMQmM+m1GRNNNhmUP0=;
        b=lU+tq4bgEd+x8cnwwwVuW1Zn9HnC1zh9YxVszzQFb9b3bTA7/Eqh33FTnumYgc4bSK
         4VB8DcYTA7hRGx9ynbBy4DRW5WTzXiC85yyvdFnui5iLToAXkKXGUEc/kZkOARtfKp9T
         Lim6zlyYrCcY0Ow0w84dI6+H3sf8+ivC+OK14EKtMLLGd3j6holLU/oF7631WKpYpMsV
         vIGPue3njtCjHv4TfB2MTrGE+XR2lv6m0mTzUh8k567O2zhgUW8XoWOT4wOFfVI+1+Jo
         VxBjIgGROFZwb7Hpuey0sK/Gx4GLl3R2m9czUtOuam7rnaggbXV3zfFgcGmUs/f0zecN
         i+yg==
X-Gm-Message-State: AOAM530NrTo6BU4CGhu9Brvd/jGkprFmy2EUKV3tU68DEtuG9+6DJYoQ
        MXfJEoFjdXBWKn3SF841caRp5lpLx4c=
X-Google-Smtp-Source: ABdhPJynWyXxn/ACv1Lvwam9LP1tfy1XNc8wcj97SNnooT980x5nG/al996yPy0K31O0A1FoC/30Ww==
X-Received: by 2002:a67:7c44:: with SMTP id x65mr3327813vsc.16.1591711450897;
        Tue, 09 Jun 2020 07:04:10 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id b7sm403849vsc.13.2020.06.09.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:04:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Yu Liu <yudiliu@google.com>
Subject: [PATCH v1 1/3] mgmt: read/set system parameter definitions
Date:   Tue,  9 Jun 2020 14:03:50 +0000
Message-Id: <20200609140351.153833-2-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200609140351.153833-1-alainm@chromium.org>
References: <20200609140351.153833-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch submits the corresponding kernel definitions to mgmt.h.
This is submitted before the implementation to avoid any conflicts in
values allocations.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Yu Liu <yudiliu@google.com>

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/mgmt.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 16e0d87bd8fa..1081e371f03d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -702,6 +702,24 @@ struct mgmt_rp_set_exp_feature {
 	__le32 flags;
 } __packed;
 
+#define MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS	0x004b
+
+struct mgmt_system_parameter_tlv {
+	__u16 type;
+	__u8  length;
+	__u8  value[];
+} __packed;
+
+struct mgmt_rp_read_default_system_parameters {
+	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
+} __packed;
+
+#define MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS	0x004c
+
+struct mgmt_cp_set_default_system_parameters {
+	__u8 parameters[0]; /* mgmt_system_parameter_tlv */
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
-- 
2.27.0.278.ge193c7cf3a9-goog

