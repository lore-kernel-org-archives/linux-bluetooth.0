Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED53AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D596139F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhKSJkK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233761AbhKSJkJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804844"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804844"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179379"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:37:06 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 5/9] avdtp: Add a flag in struct avdtp to control MSFT a2dp offload
Date:   Fri, 19 Nov 2021 15:12:31 +0530
Message-Id: <20211119094235.2432-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Define a flag in struct avdtp to mark the support of MSFT
a2dp codecs. If the flag is set, for a2dp streaming offload
path will be selected.
---
 profiles/audio/avdtp.c | 7 +++++++
 src/adapter.c          | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index d3dfbf96dda3..58d419fb3148 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -409,6 +409,9 @@ struct avdtp {
 
 	/* Attempt stream setup instead of disconnecting */
 	gboolean stream_setup;
+
+	/* use offload for transport */
+	gboolean use_offload;
 };
 
 static GSList *state_callbacks = NULL;
@@ -2425,6 +2428,7 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 							struct queue *lseps)
 {
 	struct avdtp *session;
+	char *use_offload;
 
 	session = g_new0(struct avdtp, 1);
 
@@ -2436,6 +2440,9 @@ struct avdtp *avdtp_new(GIOChannel *chan, struct btd_device *device,
 
 	session->version = get_version(session);
 
+	if (is_msft_a2dp_offload_supported(avdtp_get_adapter(session)))
+		session->use_offload = TRUE;
+
 	if (!chan)
 		return session;
 
diff --git a/src/adapter.c b/src/adapter.c
index fd5ce614bec5..235748c52780 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9796,6 +9796,15 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+static bool is_exp_feature_uuid_the_same(const void *data,
+					 const void *match_data)
+{
+	if (sizeof(data) != sizeof(match_data))
+		return false;
+
+	return memcmp(data, match_data, sizeof(data)) == 0;
+}
+
 bool is_msft_a2dp_offload_supported(struct btd_adapter *adapter)
 {
 	return queue_find(adapter->exps, is_exp_feature_uuid_the_same,
-- 
2.17.1

