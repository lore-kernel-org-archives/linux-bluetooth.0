Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B4C282E3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77B1217D7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 08:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex6N4uqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbfDYIDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:03:05 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36692 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDYIDF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 04:03:05 -0400
Received: by mail-ed1-f45.google.com with SMTP id u57so18351249edm.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2019 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=Ex6N4uqr23CX4F0GKs8HWoCyi9NJCuH2XiiUmlEgVnyfXtaeDJ5OYURIXujUaf8Lzo
         n7RWgNlhQI34RG+5y/pWIrper/BnOH/o907uFkEQQZrAcJzrWuJ5kTpUqQc5QuKIT68d
         ejRzbOhj93ESeYNBadEU+7T59DsIypUrAehnaHuC0Ma/W6Pc65ZNKdMkSCfDK8V36Aiq
         mFobSRKfckfx//Kt3aYpppzXfZeRdVrfZhtnogra8Dz7snMFlXydedQWucVWQ8ggTDyC
         lgIb9iwEHJAf+MaCyQmXF1e8S9NU06qCKAEP/r2Ruu+rZWWS9zOF5adf7QGwKmviHIQ6
         xXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziLQF++THfmGlS5v4VvJuBeywwctjd7oWnZg0WevTus=;
        b=Vbm11aRoXAGwyL5m6P1pPdKawhOGpRyYFXDLGcFzbLV21pvekp6H/GcEuig6pTHhwD
         ObwpZ+Hz+opOjgHMbI2ceFBd2jK3gPg1zCBmkKbXOSFENoFgPlm/lLEj4jBizHyJwTgo
         2bCrtgeBGICNQ/eCbQfgm5/Of05URSVcu6Wt3NF26X6lDnswaQlEoZ6Ji01/g8+vmRxa
         XcTFsmsahW8AcL9JXi4QxZHwtm1ClKkiZZomYmuTv9cP9cNXJ/Is2Qyp55Twdrc/wuz2
         4B6amxl30wyMK6lzUSMJidbdYo84eF1Tz8PGPofp+RFUItlfimXbQTIu5gOarjmaDGgw
         ytNQ==
X-Gm-Message-State: APjAAAV3uK4PGAiKPHZvwv1rYiAqVFdyevxiENW89dVUgFX/MZsLi7wJ
        sNeohMcPDIpPpPygNAatikfVk7n35j4=
X-Google-Smtp-Source: APXvYqyRiXHi1s/OzgKPXpfOu5C7xvI8tOxYvm8vFZiG5WTkRyWHwzEcweCKZ9HwXPGh1GngwUmSAA==
X-Received: by 2002:a50:b69c:: with SMTP id d28mr23259646ede.126.1556179382924;
        Thu, 25 Apr 2019 01:03:02 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id t52sm6144877edd.54.2019.04.25.01.03.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 01:03:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] doc/settings-storage: Document LastUsed Endpoints entry
Date:   Thu, 25 Apr 2019 11:02:58 +0300
Message-Id: <20190425080258.7649-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425080258.7649-1-luiz.dentz@gmail.com>
References: <20190425080258.7649-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the use of LastUsed entry inside Endpoints group.
---
 doc/settings-storage.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 44b0b4961..f595f9817 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -169,7 +169,9 @@ In "Attributes" group GATT database is stored using attribute handle as key
 all data required to re-create given attribute. ":" is used to separate fields.
 
 In "Endpoints" group A2DP remote endpoints are stored using the seid as key
-(hexadecimal format) and ":" is used to separate fields.
+(hexadecimal format) and ":" is used to separate fields. It may also contain
+an entry which key is set to "LastUsed" which represented the last endpoint
+used.
 
 [General] group contains:
 
@@ -220,6 +222,9 @@ Sample Attributes section:
 					followed by codec type and its
 					capabilies as hexadecimal encoded
 					string.
+	LastUsed:<xx>		String	LastUsed has one field which is the
+					endpoint ID as hexadecimal encoded
+					string.
 
 Info file format
 ================
-- 
2.20.1

