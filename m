Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6423ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiH3WAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiH3V7s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 17:59:48 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F53061129
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:55:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x14so5302133qvr.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=TucAG9rZhLPFUqqSZyFxm7GU+bmlAjsdmyZ0/Tfa2uA=;
        b=cPbsCO+7rmlvgOIADR8DqGb2ALwCbYCcHxyAV5FToS/AQT3+nFDJ0RDxmlP8Ivmh1t
         DNo/tE7kBZt9fMkaciKAREBbL69T1/LQpbis3CNomX1mNK/L8fDNKb55ToNGp6sUyTIP
         k9V5/8dBuoo8JR5NyTJWIjG2bE+l0C89R06Mmryweza+MwxuBXT/4UE7m9fueTvLOwq9
         U+AsGZ9no3uEh3itQI7ObxyOh9TpCGy0dspxbP9le0swOObRwl97lR/IqG4WwZkEFZt0
         y2rHkb7FoIFeUcZ3zps1QFPrEirUAPQRGl+mXpOwRREWDBbCRkg58uGtNsACpbQuLgRF
         KlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=TucAG9rZhLPFUqqSZyFxm7GU+bmlAjsdmyZ0/Tfa2uA=;
        b=KfTu29aHvPbA/ojJ+nqvr+iZCL4RDErdRtLbom2CIBElMHu2I4AFOoXthlXcJ0NMtN
         ulEjdrUfiJTStOXgOtA2maGiDBnZK7VMmHOqEXSPKwIihsmlmwVsNnsYTyhwx4A6WxRJ
         M3hfkSRqJQF9A3pP/hI+BkK5KcUa9Sgx/WEjopWVJlnhltoUA2lBkmJZSehuATp7o/M4
         AWPfzUw83jKQEmWYhCMEp4gCO7xvKpjBoTqrFn3Xm3TprhBEp92qLoSaKBwndo5+InQj
         e4wvTuqhWhR83ZKE4yoDxI2UAHGJ7aGYCXXKYve1ai2qAhwZhQfAKeWJXouEXSzru19Q
         BnrQ==
X-Gm-Message-State: ACgBeo0Q/XJfS+9B4pAUxN+AIarflkEETwbBpT419UOpUCSegb91vcQU
        mSCOkzsSt+MEc2n3T5fCh8PS0ExJcrc=
X-Google-Smtp-Source: AA6agR4taO09WxzPXNVZLMDQ4hweSbVzkIDgeCd5zmEPK6m2fdZt+oXVKFyTYzcwQdSaRdtCJIvl7g==
X-Received: by 2002:a05:6214:21e4:b0:499:3a0:47fd with SMTP id p4-20020a05621421e400b0049903a047fdmr9626444qvj.61.1661896486559;
        Tue, 30 Aug 2022 14:54:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006baef6daa45sm8644289qkl.119.2022.08.30.14.54.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:54:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix registering PAC endpoints if ISO socket are not supported
Date:   Tue, 30 Aug 2022 14:54:44 -0700
Message-Id: <20220830215444.1141653-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If adapter don't support ISO sockets the PAC UUIDs shall not be allowed
to be registered as they depend on ISO sockets to work properly.
---
 profiles/audio/media.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 85278a6d9be4..a7fa85d60310 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1254,20 +1254,23 @@ static bool endpoint_properties_get(const char *uuid,
 	return true;
 }
 
-static bool endpoint_supported(void)
+static bool endpoint_supported(struct btd_adapter *adapter)
 {
 	return true;
 }
 
-static bool experimental_endpoint_supported(void)
+static bool experimental_endpoint_supported(struct btd_adapter *adapter)
 {
+	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
+		return false;
+
 	return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
 }
 
 static struct media_endpoint_init {
 	const char *uuid;
 	bool (*func)(struct media_endpoint *endpoint, int *err);
-	bool (*supported)(void);
+	bool (*supported)(struct btd_adapter *adapter);
 } init_table[] = {
 	{ A2DP_SOURCE_UUID, endpoint_init_a2dp_source, endpoint_supported },
 	{ A2DP_SINK_UUID, endpoint_init_a2dp_sink, endpoint_supported },
@@ -1315,6 +1318,9 @@ media_endpoint_create(struct media_adapter *adapter,
 	for (i = 0; i < ARRAY_SIZE(init_table); i++) {
 		init = &init_table[i];
 
+		if (!init->supported(adapter->btd_adapter))
+			continue;
+
 		if (!strcasecmp(init->uuid, uuid)) {
 			succeeded = init->func(endpoint, err);
 			break;
@@ -2971,6 +2977,7 @@ static const GDBusMethodTable media_methods[] = {
 static gboolean supported_uuids(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
+	struct media_adapter *adapter = data;
 	DBusMessageIter entry;
 	size_t i;
 
@@ -2980,7 +2987,7 @@ static gboolean supported_uuids(const GDBusPropertyTable *property,
 	for (i = 0; i < ARRAY_SIZE(init_table); i++) {
 		struct media_endpoint_init *init = &init_table[i];
 
-		if (init->supported())
+		if (init->supported(adapter->btd_adapter))
 			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
 							&init->uuid);
 	}
-- 
2.37.2

