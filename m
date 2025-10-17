Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D82367DF
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Oct 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666296; cv=none; b=t1pTnVT11KBYnUh9L9hBXtNV6jwJjQo+9zStj4Ri56fevCR8yRRs/MzverzVFz40TKJoy0rotJXjXFQHApVCt92itNH8QzTg69YdeYl1wbnsZsaOd1obnADakX+8qXhRjf0nCxEkHdv2md3c8p2XF9ZC/frCD0tjN/2AqRSDvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666296; c=relaxed/simple;
	bh=qVW8PvHRlnYPxBTCMXWUrZsFzsAwgqsXExdS5nBE9lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Man7Eo186dCmOk2vqnkFdlknUGvLrJtwNrh8IIFV5PGSXUm39Nrg+egEPjfma0ReGA/ODepmXSqWRpMNEX8Qg/D4Jl+EV0QQTZVA8VX+cRnaAlVdh3GKpd2/G5SCn5GkaCV2++laIBxXyFz/ibpi2YNURcm1VrMDgAbfmn45FJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrZkd7mR; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrZkd7mR"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so1372085a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 18:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666294; x=1761271094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKQt+JIsBb4ZoV2hY9d7EUbApVuf2Z5uqCV+9FQFUgc=;
        b=SrZkd7mRGNPYVIU0jR4dAsEQTuSRtYMatKWe1ZdLYU0Hn4eUDTvdqM68yWtHaP3Dag
         f84eEAU4iIsIKMYeG0sT88JrehIW+uFKb/Rmwlf10r7sFzMuoQleqVykeo9wqvAmm2XM
         OspFTusj0B938T7J8DHXFu5YHMNzuKKf8t+qPJO2yjkSTknj0eDYFa89J59tcl7FvoN9
         ivOw01Z/HgM+9r3/XlhFTAFgQEXEIJbJypgdpdCUZ29cOUegDtqh0w5Brgqcytxnromr
         bEl1nmSiZHGHLN03+tQ4kZR7VhRgf77Pa/VVAIJrix93Ma5JEUGBwepX2oKAWgErbu4v
         M66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666294; x=1761271094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKQt+JIsBb4ZoV2hY9d7EUbApVuf2Z5uqCV+9FQFUgc=;
        b=jqOGxW1wsvWviJETx4dDA/Num7B+9hZxWSxn7r2PKN8k7KhgstUz6KTxg8FbzPbl7/
         0xATzGj+lXSD7iGuNvnJEwLrEZKuhUhhksaPwd/Ny4svTXu5CyTg7ci9qrb/8mz6osTz
         zvloDUrfLgPzOQUi1wlSr1jYDLrhCuvxNRoVcAvmounVTarm69pd/kiRFrsltYiVS/tt
         iESgWVpAkv2fAlG+lU/nufMXPyX6m/YKbUakonDYJz2HoQT1VrIy/zpUIXsB892qdS+R
         ver4AH/AObMJDTXKefyVQI9UGG9hQoSh9YT5Mls8ndgGAK1z372KWM/jfARrzMptJ2EY
         2xcQ==
X-Gm-Message-State: AOJu0Yy33Pd1WUNOtJnO2L+dIiIeQackaVCQlYF4jdm2PtdjazdhdUby
	6p9+53FPV03ecpfhDJQFFDOG1JxTelr2/w6L/s8kknxP7Mv+kzgxqiY/GnjNPw==
X-Gm-Gg: ASbGncvjTeA9p+9FiCpv9qeLYURzsctODnFP/NwgiayGgJxekVa2dCPaWZ7LOiM5LLI
	6KNrG4uNj5NnXD/Y1VdAXYzIKzNWex2+JDEHUPnLDGAZlNLZbtg33DDBNi8TpK/CW4Yb3q48eui
	ZeG3nF1KGN/bwKdkKYWriXxfYHafDSTEAIPQ9UJ4PpvZBYsJ4YMa4f8b6NzJyUEmEsABsOC6pkd
	OqXCF2FebLq7lw8gUDCnzyLp6iczPljucGiUYU8368rq3RH4xtVMA7r2Xjoh63/2aX2anhngLuY
	43K9XB/GDcmsqAG74wQSVng9swHMPa809WOsZOTCg0K7YX9o5DXWUjEZgcyXB8D67tKqFX3sgtQ
	s32hEkKIZSYFy61qB5kYMrlJlOueLlC+6dkTkd8BAU7o5E1VYa/aD72VysMCUZeFG0IQyLf/7es
	q2bAnzHbOE+8ZJX3tyqS/Muv+iH7oRI05Pl9TUyfSXGBfiW2rTnbUPLVkcjhpY+Lcu
X-Google-Smtp-Source: AGHT+IHDVun7feVNHfsUpaoRYDKgBYNGQTLnggziWOmenscFAA24rLJKQ45ZLfeBU2cJfZRp7RGtWg==
X-Received: by 2002:a17:90b:3d48:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-33bcf90ca9fmr1955749a91.32.1760666293585;
        Thu, 16 Oct 2025 18:58:13 -0700 (PDT)
Received: from pidgey.. ([2607:fb90:8be2:8e43:bc7:e05d:ff48:a60d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba96ca5d9sm1701979a91.2.2025.10.16.18.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:58:13 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ 1/2] shared/uhid.c: Fix 32-bit integer truncation
Date: Thu, 16 Oct 2025 18:57:58 -0700
Message-ID: <20251017015759.46326-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Id paramter given to bt_uhid_set_report_reply() and
bt_uhid_get_report_reply() corresponds to a 32-bit tag value passed to
us from the kernel side of UHID. Specifying this parameter as uint8_t
breaks the synchronization after 255 request and renders the attached
BLE device inoperable.

Fixes: 92ed637ab2bc ("shared/uhid: Add dedicated functions for each UHID opcode")
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 src/shared/uhid.c | 4 ++--
 src/shared/uhid.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 20bd26781..207afa55e 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -495,7 +495,7 @@ int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
 	return bt_uhid_send(uhid, &ev);
 }
 
-int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status)
+int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t status)
 {
 	struct uhid_event ev;
 	struct uhid_set_report_reply_req *rsp = &ev.u.set_report_reply;
@@ -514,7 +514,7 @@ int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status)
 	return bt_uhid_send(uhid, &ev);
 }
 
-int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
+int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t number,
 				uint8_t status, const void *data, size_t size)
 {
 	struct uhid_event ev;
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index e76a6e22b..be180297b 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -63,8 +63,8 @@ bool bt_uhid_created(struct bt_uhid *uhid);
 bool bt_uhid_started(struct bt_uhid *uhid);
 int bt_uhid_input(struct bt_uhid *uhid, uint8_t number, const void *data,
 			size_t size);
-int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t status);
-int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint8_t id, uint8_t number,
+int bt_uhid_set_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t status);
+int bt_uhid_get_report_reply(struct bt_uhid *uhid, uint32_t id, uint8_t number,
 				uint8_t status, const void *data, size_t size);
 int bt_uhid_destroy(struct bt_uhid *uhid, bool force);
 int bt_uhid_replay(struct bt_uhid *uhid);
-- 
2.43.0

