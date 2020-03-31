Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF6EC2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BA120787
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="jFCb/SCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgCaI2F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37835 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgCaI2F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so24832988wrm.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NjfpDgfF85/BorhabETGyOLsEUZ0cTg/HDVqLdwRhoc=;
        b=jFCb/SCTkw5VZRhK6XXne/gbHMd5b22AcRn3AIuvYkiWmdh7TL17i+BEdS2MV5Zseq
         pBRNHCFByDRsKWRKKfjE0wf8cvWpskBC10WXJak+y7YoAPVZYRRIPUX/XXMtcIdlFQ1C
         SMxN7IxaLA0+tNzh8/yo3/MfO9hePNym5mhfaxaU3g/nALAbupyXip4eJnYKcso7dcK0
         qLal0/eIxH1CwlKq/po5zTgVQhm2rjnHpA9ugnfKL1YU8ZWHAC50GGFiQMT+xrXHXYOw
         /BCxS7TCW4G0YcRfUQnsYZadvaqUZxoyekxeXRFO4j3mdi0d3OfwDtQMK6Ngv5lTYQbC
         U19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjfpDgfF85/BorhabETGyOLsEUZ0cTg/HDVqLdwRhoc=;
        b=YylIGL0uVIXlLFJonXJ277GLojH3nFinLlrfjtQMkJe6LTbiHt1JCj8d11La0Tdwm4
         jVUaz9mbJ9mWoF715FkkQIrF93bbaJwtBkD7PQzxjhSlE/jsIsq41BY35SOcALQIQ2R+
         qU4AWgh1liRCGD9oesJcSGVZTmxMk/eqdg0caQK6oho3d9xaK6fdchFGyV7i8nMtEnUS
         t+zfD6InwWEkjJ4LSHmOPgQcM4AmiLxMbvelWzwfH03s5uD+M12qYEhbUIWghLZrfjjL
         g5BjgNU1WRS+dtnY9BW0p5MrR/dsv7QpzwXYdMB7dNm1y7SR+VtWomFFfgfcvHxeKTTY
         3YQQ==
X-Gm-Message-State: ANhLgQ19agJnwIT+T7s7skUkhzkIONGLSLgvZYh/Q/OVN6Ep1sE0jZRB
        dz8IpEW971uubg+rUGFOiXME/gFD18Cm1g==
X-Google-Smtp-Source: ADFU+vvTZrgKyJe/j9lYHEVwuja42dLNAmCmZNxG7saaARPX/7KmtB2CRj58kD76SRUfquW71LggFg==
X-Received: by 2002:adf:aade:: with SMTP id i30mr19136700wrc.336.1585643283357;
        Tue, 31 Mar 2020 01:28:03 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x16sm6172296wrn.71.2020.03.31.01.28.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:28:02 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] tools/mesh-cfgclient: Display unprovisioned OOB data
Date:   Tue, 31 Mar 2020 10:28:05 +0200
Message-Id: <20200331082810.10856-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/mesh-cfgclient.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index ae13c4409..eafabf825 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1533,6 +1533,17 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 	bt_shell_printf("\t" COLOR_GREEN "UUID = %s\n" COLOR_OFF, str);
 	l_free(str);
 
+	if (n >= 18) {
+		str = l_util_hexstring_upper(prov_data + 16, 2);
+		bt_shell_printf("\t" COLOR_GREEN "OOB = %s\n" COLOR_OFF, str);
+	}
+
+	if (n >= 22) {
+		str = l_util_hexstring_upper(prov_data + 18, 4);
+		bt_shell_printf("\t" COLOR_GREEN "URI Hash = %s\n" COLOR_OFF,
+									str);
+	}
+
 	/* TODO: Handle the rest of provisioning data if present */
 
 	dev = l_queue_find(devices, match_device_uuid, prov_data);
-- 
2.20.1

