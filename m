Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B25C388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 01:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F37520936
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 01:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="Wj9yhx22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKTBmw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgKTBmw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 20:42:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA76C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 17:42:51 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so5888626pgg.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 17:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cTgYjKWN5ZaJuT9dDp/4xB0eKDGdh/xAaZZ4YQrUElQ=;
        b=Wj9yhx220T3LiTg6SHuuiskUPhPyKhaplV9dAEFZWuxiMK3kC+gv9P73AIdtcoHgID
         uJ0ghWXR4Fdik97L+Z3Kcz5sfUEonQCK5ifOAr/sVIfoUSCEYscZ90dlCGk7LWuSAt/j
         eOrhNhcXHO7iDoLSV6n0uYXZ7+CIElc0/FbntjkUXSU5tHDKwcxipjMc5oYwGmR0rYHE
         PjrlHJpqVBEYzeKjqS7XYcaFAPDPvsvGg1QbDB9MYvKUrw0nqF+9dy53IDhogeDuDV9c
         2b4FdsrEwgQrxuxS+il156yvNBQbsikVbxmktyBQUNJEZOKrmIKwpeLGwV1z8U1xD3SU
         2wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cTgYjKWN5ZaJuT9dDp/4xB0eKDGdh/xAaZZ4YQrUElQ=;
        b=LtzLC2DB2S9+cMpKX6t/pI5KzKleQYu5D4sYvrF/4SIb2v3Xw3WzwV7V4nhvQfK4w3
         glUAgVLLK2YH6bMU4F0JOyiCUA/fiANAp1s9C2NknymHSp54ULcnsNLW49eqLF52MoG5
         03DBJYocldIBBW45Vj8rZvKphOT3eRRATf7TGyLvTZGPxJQjhbIJGh0wOgoJDA4iw+0W
         fOGNIXu8TBYNjvi/rm7YE4327S1p7mBQ/AOQKv7wgEkyfPs4zstpuaVgDbDYzwio3+MG
         UmV5zOT+qN//iPvzMrhwX3cBjcrlp5bUG59pn3YASBVPdU9G1rZrSaqVvJKgxM21k0xx
         AG2Q==
X-Gm-Message-State: AOAM532QRu8+sixmsNiv4SczkN+8EG0IU0bjhUm1bgwQuJCM+1KsGDxG
        eNJy94m54xrh/9wBjlZh+00iPwOvehlsx0gf
X-Google-Smtp-Source: ABdhPJyzuf4bZIa6gYjFdawHeXg79rjgi1bBGI3c72EADwt3RqqHBiCt5JqHSu5ss1ougiTtqadIvA==
X-Received: by 2002:a05:6a00:225c:b029:18b:d208:a366 with SMTP id i28-20020a056a00225cb029018bd208a366mr11553095pfu.5.1605836571115;
        Thu, 19 Nov 2020 17:42:51 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id 22sm1167508pjb.40.2020.11.19.17.42.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 17:42:50 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   Dean Camera <dean@fourwalledcubicle.com>
Subject: [PATCH] Fix HOG profile incorrectly stripping off read report bytes.
Message-ID: <a542b260-7eb1-8917-9379-e945003d7817@fourwalledcubicle.com>
Date:   Fri, 20 Nov 2020 12:42:46 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If the HID subsystem requests a HID report to be read from the
device, we currently incorrectly strip off the first byte of the
response, if the device has report IDs set in the HID report
descriptor.

This is incorrect; unlike USB HID, the report ID is *not* included
in the HOG profile's HID reports, and instead exists out of band
in a descriptor on the report's bluetooth characteristic in the
device.

In this patch, we remove the erroneous stripping of the first
byte of the report, and (if report IDs are enabled) prepend the
report ID to the front of the result. This makes the HID report
returned indentical in format to that of a USB HID report, so
that the upper HID drivers can consume HOG device reports in the
same way as USB.
---
  profiles/input/hog-lib.c | 18 +++++++++++-------
  1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 78018aad3..49d459e21 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -779,7 +779,8 @@ fail:
  static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
  							gpointer user_data)
  {
-	struct bt_hog *hog = user_data;
+	struct report *report = user_data;
+	struct bt_hog *hog = report->hog;
  	struct uhid_event rsp;
  	int err;

@@ -808,13 +809,16 @@ static void get_report_cb(guint8 status, const 
guint8 *pdu, guint16 len,

  	--len;
  	++pdu;
+
  	if (hog->has_report_id && len > 0) {
-		--len;
-		++pdu;
+		rsp.u.get_report_reply.size = len + 1;
+		rsp.u.get_report_reply.data[0] = report->id;
+		memcpy(&rsp.u.get_report_reply.data[1], pdu, len);
+	}
+	else {
+		rsp.u.get_report_reply.size = len;
+		memcpy(rsp.u.get_report_reply.data, pdu, len);
  	}
-
-	rsp.u.get_report_reply.size = len;
-	memcpy(rsp.u.get_report_reply.data, pdu, len);

  exit:
  	rsp.u.get_report_reply.err = status;
@@ -846,7 +850,7 @@ static void get_report(struct uhid_event *ev, void 
*user_data)

  	hog->getrep_att = gatt_read_char(hog->attrib,
  						report->value_handle,
-						get_report_cb, hog);
+						get_report_cb, report);
  	if (!hog->getrep_att) {
  		err = ENOMEM;
  		goto fail;
-- 
2.29.2.windows.2

