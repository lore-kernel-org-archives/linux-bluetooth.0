Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9FE7109E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 21:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjI0Vkb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjI0Vka (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 17:40:30 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DDD191
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b706f604aso5812007eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695850826; x=1696455626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSqrbmz8Eq3eGURMTY5TQ64HOx9T7355kkPHfm/hu4M=;
        b=EBBi8ncy1jKMG5Q1FhJRMh1WvJFomFMtClCX3Hjl0LW2wsriWvAm3qoCMcIpHOI0io
         Vzl1OqG239c/gffzPfc5e002y1dEY/w4+y0Q/uayLAd4q3BkO2w8uY+aaUat+erGgu7e
         BepYOMPMDwHuJ+RMPrjDngKoYkcZUv9/oPewvzTyVDkbw9sOWrLERt3h3+bOtCl4ZVC3
         fmUxTyO8mHaxvzR58O0FefCGXvchKJ4aCPADeED48arwTb7sI0zNGaXJmon42BAIydoa
         xPJu5xhis1id0uyB6Vxt2dYGrh/jm8C3E9OFvpAYkoNxhN+wkagzHd3GRy09kH9q4ryR
         DKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695850826; x=1696455626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSqrbmz8Eq3eGURMTY5TQ64HOx9T7355kkPHfm/hu4M=;
        b=Sw3kME/TwCfPsJDmKZoKJM4AyjSJGLxEH5lN0HsZXDxvwe5qzkyPuuOXl7RDDS5eNS
         3RZkWoXXtlnm4dIHj2o/p4jBs6mSw6ZgujejdCs4gBQLFARJa56YJdlIdvCL/0o9bpib
         SRaKgsvC8s2Z+YIgNMMQPHQ76NB42FJn9WnMl3qnK79xeDxOYyZTvYdnCUIdwW3nqQ8m
         WZh5vriejnWaJodQ+rtygyhhUO10JMh8ueU1MIiZo7Nikbr36HkTBueg3Z8/o9lPPnAw
         S/KO4mKDV/wjahAdktsArYH5uwsg7YdGQFq+izX0lwKGgfm7ddSUODVm09W3FaW2mVTL
         uHNQ==
X-Gm-Message-State: AOJu0YwYE/6w7lw3w4tAbYZm5RNsf+vN6vUQu5Xr1gRepN0rBHiYEdeD
        AXQKJGUw2xeAro+EuF9ijW+TNWbWIe3NL3gX
X-Google-Smtp-Source: AGHT+IHy1qlx9fPK4aIwYju5R9zUWCna7mImKGI3Vovg6os7kJS7Dms/idg+LgzJiiVP3pozSweB5Q==
X-Received: by 2002:a05:6358:89b:b0:143:8eb4:cf36 with SMTP id m27-20020a056358089b00b001438eb4cf36mr3355388rwj.5.1695850825576;
        Wed, 27 Sep 2023 14:40:25 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b00672ea40b8a9sm12546004pfe.170.2023.09.27.14.40.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 14:40:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 10/12] bap: Add support for missing MediaEndpoint properties
Date:   Wed, 27 Sep 2023 14:40:01 -0700
Message-ID: <20230927214003.1873224-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927214003.1873224-1-luiz.dentz@gmail.com>
References: <20230927214003.1873224-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Location, SupportedContext, Context and QoS
properties.
---
 profiles/audio/bap.c | 409 ++++++++++++++++++++++++++++---------------
 1 file changed, 272 insertions(+), 137 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ed02db40be8c..18872329d4ac 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -263,6 +263,88 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_locations(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	uint32_t locations = bt_bap_pac_get_locations(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &locations);
+
+	return TRUE;
+}
+
+static gboolean get_supported_context(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	uint16_t context = bt_bap_pac_get_supported_context(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &context);
+
+	return TRUE;
+}
+
+static gboolean get_context(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	uint16_t context = bt_bap_pac_get_context(ep->rpac);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &context);
+
+	return TRUE;
+}
+
+static gboolean qos_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct bap_ep *ep = data;
+	struct bt_bap_pac_qos *qos;
+
+	qos = bt_bap_pac_get_qos(ep->rpac);
+	if (!qos)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean get_qos(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	struct bt_bap_pac_qos *qos;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	qos = bt_bap_pac_get_qos(ep->rpac);
+	if (!qos)
+		return FALSE;
+
+	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE, &qos->framing);
+	dict_append_entry(&dict, "PHY", DBUS_TYPE_BYTE, &qos->phy);
+	dict_append_entry(&dict, "Retransmissions", DBUS_TYPE_BYTE, &qos->rtn);
+	dict_append_entry(&dict, "MaximumLatency", DBUS_TYPE_UINT16,
+					&qos->latency);
+	dict_append_entry(&dict, "MimimumDelay", DBUS_TYPE_UINT32,
+					&qos->pd_min);
+	dict_append_entry(&dict, "MaximumDelay", DBUS_TYPE_UINT32,
+					&qos->pd_max);
+	dict_append_entry(&dict, "PreferredMimimumDelay", DBUS_TYPE_UINT32,
+					&qos->ppd_min);
+	dict_append_entry(&dict, "PreferredMaximumDelay", DBUS_TYPE_UINT32,
+					&qos->ppd_max);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -272,6 +354,14 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Device", "o", get_device, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Locations", "u", get_locations, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedContext", "q", get_supported_context, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Context", "q", get_context, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "QoS", "a{sv}", get_qos, NULL, qos_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -388,16 +478,182 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 	return true;
 }
 
-static int parse_properties(DBusMessageIter *props, struct iovec **caps,
+static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
+				struct bt_bap_io_qos *qos)
+{
+	if (!strcasecmp(key, "Interval")) {
+		if (var != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->interval);
+	} else if (!strcasecmp(key, "PHY")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->phy);
+	} else if (!strcasecmp(key, "SDU")) {
+		if (var != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->sdu);
+	} else if (!strcasecmp(key, "Retransmissions")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->rtn);
+	} else if (!strcasecmp(key, "Latency")) {
+		if (var != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->latency);
+	}
+
+	return 0;
+}
+
+static int parse_ucast_qos(const char *key, int var, DBusMessageIter *iter,
+				struct bt_bap_qos *qos)
+{
+	if (!strcasecmp(key, "CIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->ucast.cig_id);
+	} else if (!strcasecmp(key, "CIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->ucast.cis_id);
+	} else if (!strcasecmp(key, "Framing")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->ucast.framing);
+	} else if (!strcasecmp(key, "PresentationDelay")) {
+		if (var != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->ucast.delay);
+	} else if (!strcasecmp(key, "TargetLatency")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->ucast.target_latency);
+	} else {
+		int err;
+
+		err = parse_io_qos(key, var, iter, &qos->ucast.io_qos);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
+				struct bt_bap_qos *qos)
+{
+	if (!strcasecmp(key, "Encryption")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "Options")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.options);
+	} else if (!strcasecmp(key, "Skip")) {
+		if (var != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.skip);
+	} else if (!strcasecmp(key, "SyncTimeout")) {
+		if (var != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.sync_timeout);
+	} else if (!strcasecmp(key, "SyncType")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.sync_cte_type);
+	} else if (!strcasecmp(key, "SyncFactor")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.sync_factor);
+	} else if (!strcasecmp(key, "MSE")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.mse);
+	} else if (!strcasecmp(key, "Timeout")) {
+		if (var != DBUS_TYPE_UINT16)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.timeout);
+	} else if (!strcasecmp(key, "BCode")) {
+		if (var != DBUS_TYPE_ARRAY)
+			return -EINVAL;
+
+		parse_array(iter, &qos->bcast.bcode);
+	} else {
+		int err;
+
+		err = parse_io_qos(key, var, iter, &qos->bcast.io_qos);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
+			struct iovec **base)
+{
+	DBusMessageIter array;
+	const char *key;
+	int (*parser)(const char *key, int var, DBusMessageIter *iter,
+			struct bt_bap_qos *qos);
+
+	if (*base)
+		parser = parse_bcast_qos;
+	else
+		parser = parse_ucast_qos;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var, err;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		err = parser(key, var, &value, qos);
+		if (err) {
+			DBG("Failed parsing %s", key);
+			return err;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return 0;
+}
+
+static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct iovec **base,
 				struct bt_bap_qos *qos)
 {
 	const char *key;
-	struct bt_bap_io_qos io_qos;
-	uint8_t framing = 0;
-	bool broadcast = false;
 
-	memset(&io_qos, 0, sizeof(io_qos));
 	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter value, entry;
 		int var;
@@ -422,149 +678,26 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 
 			if (parse_array(&value, metadata))
 				goto fail;
-		} else if (!strcasecmp(key, "CIG")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->ucast.cig_id);
-		} else if (!strcasecmp(key, "BIG")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->bcast.big);
-		} else if (!strcasecmp(key, "CIS")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->ucast.cis_id);
-		} else if (!strcasecmp(key, "BIS")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->bcast.bis);
-		} else if (!strcasecmp(key, "Interval")) {
-			if (var != DBUS_TYPE_UINT32)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.interval);
-		} else if (!strcasecmp(key, "Framing")) {
-			dbus_bool_t val;
-
-			if (var != DBUS_TYPE_BOOLEAN)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &val);
-
-			framing = val;
-		} else if (!strcasecmp(key, "PHY")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.phy);
-		} else if (!strcasecmp(key, "SDU")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.sdu);
-		} else if (!strcasecmp(key, "Retransmissions")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.rtn);
-		} else if (!strcasecmp(key, "Latency")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &io_qos.latency);
-		} else if (!strcasecmp(key, "Delay")) {
-			if (var != DBUS_TYPE_UINT32)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value, &qos->ucast.delay);
-		} else if (!strcasecmp(key, "TargetLatency")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-						&qos->ucast.target_latency);
-		} else if (!strcasecmp(key, "Encryption")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-							&qos->bcast.encryption);
-			broadcast = true;
-		} else if (!strcasecmp(key, "Options")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-							&qos->bcast.options);
-		} else if (!strcasecmp(key, "Skip")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-							&qos->bcast.skip);
-		} else if (!strcasecmp(key, "SyncTimeout")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-						&qos->bcast.sync_timeout);
-		} else if (!strcasecmp(key, "SyncCteType")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-						&qos->bcast.sync_cte_type);
-
-		} else if (!strcasecmp(key, "SyncInterval")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-						&qos->bcast.sync_factor);
-		} else if (!strcasecmp(key, "MSE")) {
-			if (var != DBUS_TYPE_BYTE)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-							&qos->bcast.mse);
-		} else if (!strcasecmp(key, "Timeout")) {
-			if (var != DBUS_TYPE_UINT16)
-				goto fail;
-
-			dbus_message_iter_get_basic(&value,
-							&qos->bcast.timeout);
-		} else if (!strcasecmp(key, "BCode")) {
+		} else if (!strcasecmp(key, "QoS")) {
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
-			parse_array(&value, &qos->bcast.bcode);
+
+			if (parse_qos(&value, qos, base))
+				goto fail;
 		}
 
 		dbus_message_iter_next(props);
 	}
 
-	if (broadcast) {
+	if (*base) {
 		uint32_t presDelay;
 		uint8_t numSubgroups, numBis;
 		struct bt_bap_codec codec;
 
-		memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
-		qos->bcast.framing = framing;
-
-		if (!base)
-			return 0;
-		if (!(*base))
-			*base = new0(struct iovec, 1);
 		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
 		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
 			&presDelay, &numSubgroups, &numBis, &codec,
 			caps, NULL);
-	} else {
-		memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
-		qos->ucast.framing = framing;
 	}
 
 	return 0;
@@ -686,9 +819,9 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_properties(&props, &ep->caps, &ep->metadata,
+	if (parse_configuration(&props, &ep->caps, &ep->metadata,
 				&ep->base, &ep->qos) < 0) {
-		DBG("Unable to parse properties");
+		DBG("Unable to parse configuration");
 		return btd_error_invalid_args(msg);
 	}
 
@@ -855,7 +988,7 @@ static bool match_data_bap_data(const void *data, const void *match_data)
 static const GDBusMethodTable ep_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("SetConfiguration",
 					GDBUS_ARGS({ "endpoint", "o" },
-						{ "properties", "a{sv}" } ),
+						{ "Configuration", "a{sv}" } ),
 					NULL, set_configuration) },
 	{ },
 };
@@ -931,11 +1064,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	switch (bt_bap_pac_get_type(rpac)) {
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
-			adapter_get_path(adapter), suffix, i);
+				adapter_get_path(adapter), suffix, i);
+		ep->base = new0(struct iovec, 1);
 		break;
 	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
+		ep->base = new0(struct iovec, 1);
 		break;
 	}
 
-- 
2.41.0

