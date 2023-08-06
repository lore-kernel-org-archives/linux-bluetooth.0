Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01EC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 08:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHFIBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 04:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHFIBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 04:01:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F481FC1
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 01:01:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3174aac120aso2765556f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Aug 2023 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1691308895; x=1691913695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljClwd6RT0VtKU2pAa16ata/SJq7/BZombob/nsC6kk=;
        b=qBGp1CYx6+w0ISmxvCdGsWG/tULq9H8y3bsdPedVf7/szn8otWI1iNFWz2mhMRANRx
         Wu5rSZa6H6i92XbXVhb3tyXq4JOZhwnoRrbyzaWFUItkcGaa1ymfLYbVeV/DERn2DJT2
         ompopWEiLpPqmoemV2RQgnIfRsPFXSUdbg/VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691308895; x=1691913695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljClwd6RT0VtKU2pAa16ata/SJq7/BZombob/nsC6kk=;
        b=W8ZgEU/fSJ/CflDvVi/n7K0u0d5IhJpGvHdJIuU7sbxMDPA4kaeqGqK5NNqspbk0aG
         qdpk6tTDtaI8sbyM5f7f6ER1HLOVHCi5UNQ5SCwTlll1pAF7bcd2qn/HFsJB4u/u0iLM
         5Kna2QsVNSL/IT9OfCP0XdPnlWb8CaX5vgT62v3w8CKCe3JmtC8wP2JfbunRB+Rd9Hbl
         3ShAEXee7EUZzUSL/jkQojZIgg+e6InDfy2rCPQQxIX324C1v+1CfQaDLNsGffb9lwMw
         wSemzA5sXj37aI4u3AAuTvDebFmEwdzXn5Q1gYAEXaelnGSLUFWrtZtxmB06EWbSoxqo
         fzBQ==
X-Gm-Message-State: AOJu0Yx/aMtu9Nf1UVumBSMejTBADJfQrZkx/UfPPDR+goQwGu1QvJC4
        O0sFPY1EgaR9KhgFNk2veo08ov1InpjEM91ivfo=
X-Google-Smtp-Source: AGHT+IEKoTQ41PeFPc6czK0fwvxDftxPj7+ItoJtas5HsjxycKoLjsRFry7UMG1RbvFOLOOxn6j4Wg==
X-Received: by 2002:a05:6000:11d2:b0:314:34dd:aaec with SMTP id i18-20020a05600011d200b0031434ddaaecmr3733553wrx.8.1691308895485;
        Sun, 06 Aug 2023 01:01:35 -0700 (PDT)
Received: from Legionbuntu.. ([2a01:c846:10c0:200:9bf4:d5f:8c8:5ad6])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0031437ec7ec1sm6974156wrt.2.2023.08.06.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 01:01:35 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] error: Add "Invalid exchange" mapping
Date:   Sun,  6 Aug 2023 10:01:08 +0200
Message-Id: <20230806080109.1639693-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806080109.1639693-1-simon.mikuda@streamunlimited.com>
References: <20230806080109.1639693-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This error is returned on this event:
> HCI Event: Auth Complete (0x06) plen 3
        Status: PIN or Key Missing (0x06)
        Handle: 11 Address: 00:00:00:00:00:00 (OUI 00-00-00)
---
 src/error.c | 4 ++++
 src/error.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/src/error.c b/src/error.c
index 29c071067..f179e6cda 100644
--- a/src/error.c
+++ b/src/error.c
@@ -171,6 +171,8 @@ const char *btd_error_bredr_conn_from_errno(int errno_code)
 		return ERR_BREDR_CONN_ABORT_BY_LOCAL;
 	case EPROTO:
 		return ERR_BREDR_CONN_LMP_PROTO_ERROR;
+	case EBADE:
+		return ERR_BREDR_CONN_KEY_MISSING;
 	default:
 		return ERR_BREDR_CONN_UNKNOWN;
 	}
@@ -209,6 +211,8 @@ const char *btd_error_le_conn_from_errno(int errno_code)
 		return ERR_LE_CONN_ABORT_BY_LOCAL;
 	case EPROTO:
 		return ERR_LE_CONN_LL_PROTO_ERROR;
+	case EBADE:
+		return ERR_LE_CONN_KEY_MISSING;
 	default:
 		return ERR_LE_CONN_UNKNOWN;
 	}
diff --git a/src/error.h b/src/error.h
index cc7790a23..83206cb48 100644
--- a/src/error.h
+++ b/src/error.h
@@ -43,6 +43,7 @@
 #define ERR_BREDR_CONN_LMP_PROTO_ERROR		"br-connection-lmp-protocol-"\
 						"error"
 #define ERR_BREDR_CONN_CANCELED			"br-connection-canceled"
+#define ERR_BREDR_CONN_KEY_MISSING		"br-connection-key-missing"
 #define ERR_BREDR_CONN_UNKNOWN			"br-connection-unknown"
 
 /* LE connection failure reasons */
@@ -63,6 +64,7 @@
 #define ERR_LE_CONN_LL_PROTO_ERROR	"le-connection-link-layer-protocol-"\
 					"error"
 #define ERR_LE_CONN_GATT_BROWSE		"le-connection-gatt-browsing"
+#define ERR_LE_CONN_KEY_MISSING		"le-connection-key-missing"
 #define ERR_LE_CONN_UNKNOWN		"le-connection-unknown"
 
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
-- 
2.34.1

