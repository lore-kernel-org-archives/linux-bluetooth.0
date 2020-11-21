Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C1EC388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231D02224A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="xSED78ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgKUJKj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 04:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgKUJKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 04:10:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7128CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 01:10:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so10227399pfg.8
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 01:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jMFqMo5XFj1Sz1to39QVI7rWVzDXTy+uwh6/4jomblg=;
        b=xSED78ckWopDcr49JUX2Ue55md4gLkfTbIKEsL/XZ4vphcaoaU3Tmemd7oKi82Xma6
         akXAoX2y3/Nm/gNS9c6RxOy4A6HYhlg4DGgFhPaxcpLdvTFpjFA+H14GMyGYpp3x1uQk
         wjRA3EZYx7ek7gW+PDJJ1nLjMOOCBpz3AwUKVSV3RqqNLKo1UePHbsYWly6ECc3epTax
         U6a1pkMwHci065KVlLWuG6lb3vKF1cHQL3X/b2KlrrO/P0rEYz4Yyd103+HycY/wbdKH
         E5oIJmgcTokTaRmes/VKyCF8nFfYo7HOhsjXr1HsAJWc+GqLkJQkrEFzF1E7BH1/vren
         IIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jMFqMo5XFj1Sz1to39QVI7rWVzDXTy+uwh6/4jomblg=;
        b=jdo5EJrOX/tEET13JcHQCda+j6useaFr4gExc7Ynlq0GwLO4cKz6gy1XdmAOJzFRUz
         pfEiacyy2TTUKiD+qIJC6X9u6+V6Za2/HLiF2lEOdP0apVxoclOeW2yvENGFWGBuUAlx
         xSwQG826KTAPYdIqD6mi9D32BDRhfYBzSaUSp1skcTmSC6ZibrTjaDonE/d3xcKT7Ec2
         spw/i+F686q0BGBiJKf+oYX6ZYMFscskNYAuTi6H3Z4ZQh4GYIorRlN4n3BH692Mn7hG
         km6f0VqDpd/ObiQA87GaG4yAGM4VVHfjEnIpFr5ISbrq+GR5042NzaPN5ADyN5YmolWq
         AZxQ==
X-Gm-Message-State: AOAM530rOgvUT4hC0gmk39MQMzg89UuLp1442q0bZgR0Er2q+9lGXOtd
        zmlfPUW2+fWDhpAVJOuxxYr7Q27YclLa8flx
X-Google-Smtp-Source: ABdhPJxr21fn3j72yyjmIYl8cMpC1wk+sGjjStMkM0+Wk9MspOzPpntt7hu27Nkym/SIKTh7vL4WwQ==
X-Received: by 2002:a17:90a:e00d:: with SMTP id u13mr12800485pjy.56.1605949837556;
        Sat, 21 Nov 2020 01:10:37 -0800 (PST)
Received: from [10.0.0.4] ([203.123.108.233])
        by smtp.gmail.com with ESMTPSA id f6sm5742026pgi.70.2020.11.21.01.10.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 01:10:36 -0800 (PST)
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   Dean Camera <dean@fourwalledcubicle.com>
Subject: [PATCH] Fix gatt-database parser function potential NULL re-reference
Message-ID: <c0152fe7-830c-a39e-2bc5-546467f6c09a@fourwalledcubicle.com>
Date:   Sat, 21 Nov 2020 20:10:34 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The desc_create() function calls parse_flags() with explicitly
NULL 'props' and 'ext_props' pointer arguments. The parse_flags()
function then in turn hands these to parse_chrc_flags(), which
dereferences them unconditionally.

This adds explicit NULL checks in the internal parsing routines,
returning a failure code.
---
  src/gatt-database.c | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 90cc4bade..fa3d79aab 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1597,7 +1597,11 @@ static bool parse_chrc_flags(DBusMessageIter 
*array, uint8_t *props,
  {
  	const char *flag;

-	*props = *ext_props = 0;
+	if (!props || ! ext_props)
+		return false;
+
+	*props = 0;
+	*ext_props = 0;

  	do {
  		if (dbus_message_iter_get_arg_type(array) != DBUS_TYPE_STRING)
@@ -1673,6 +1677,9 @@ static bool parse_desc_flags(DBusMessageIter 
*array, uint32_t *perm,
  {
  	const char *flag;

+	if (!perm)
+		return false;
+
  	*perm = 0;

  	do {
-- 
2.29.2.windows.2

