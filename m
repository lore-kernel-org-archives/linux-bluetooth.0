Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30888C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185A206E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLofLdyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgC3IEg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:36 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:37995 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbgC3IEg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:36 -0400
Received: by mail-pg1-f201.google.com with SMTP id n28so14289578pgb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VzELVSkza2NBbJ60g1fS4kM/+lVRPquVxHqN+RjbPbg=;
        b=vLofLdyW4xlcHe8x+w5SGq68i0lZ9xIJc+QKhBG0QvoXzbKhFNnOYgBlDPZgY46v3e
         izg/EGZoexQAeQRwQaW+Erazryj8p0uClfWx1cvilSV2Jq03ifQpTlX9jTTW89ZIUVhX
         rYdOFMSCmsfHw/+JAvcUbyAiC+b1TdOOAvthJj9Dz0Sh3za0DBLoB0YWCU2ceB7PknDE
         WwcHKT5qGI/YQf/oKmWt+lRpHjPrnppBoMTGlJQ9ZYrTJ5ZqfHNJ6nccTyMm9wQU3jZj
         S9IVINQVwXGUKj/TOrkNERvsFiDjWWExrk7nXUohFyvMVOZfzZuwp8baBUfD4gNxMn8h
         8ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VzELVSkza2NBbJ60g1fS4kM/+lVRPquVxHqN+RjbPbg=;
        b=MO7ewU8UpwXXJWznBU2U+8eaeXe7qVjtCx3JeJ98uDoRZZlh0afBT80cePZvj34RZ6
         hTGiGFkd3SJyShKGCZLdc0eY9z3xhRGXMtJVPvG6MimgwP+mBxjZ9ctxwqWSSkBIraMo
         7ot9KmujuYFuBpkfSeWDYdQ6juv8tKlHZxFAuGz6jv0DCPNeb13HfGD/LIQsPFUBGnn6
         bbUQKsRUd9KPKCSKl7Q3W4amhsFQy/VfTUMSTBDFUfh2ZDCbTfsF/yVI+ju5x05zZnkw
         MRa0/+26PVCr/rX2UJq8T3cn3SOi8jTDUM5syygN0QyMGvNY7dCsnE3fD/D1dEvBKDNr
         0big==
X-Gm-Message-State: ANhLgQ1ZWmOP5WDVqR3zuA93BUh8Or1FXPZTFwtfOMSJ4HhYUpQoT6cy
        xnCDvwiEwUsyzxJ7LciLTcappmEKpWdfmahnomfaVzxLQkpWt6wsQ6FOFU0I+1L7eJm3XSFGDCE
        kCMybJ13J1lQXp4fL5m84w6lOwwJYJ9wGuERMlSegsk87EWhuXT4+R37vCzltCkmW7TRbqsXad7
        6o6UedxR3OVzE=
X-Google-Smtp-Source: ADFU+vu8XXO0GAslRBTQAbVjtN5biw36pvtGkKzIoP+Q3Pb3eWveAScsR4WMX3kS5A228rvAbe/9mqlAuVPCCZlEUg==
X-Received: by 2002:a17:90a:2503:: with SMTP id j3mr15061972pje.83.1585555475151;
 Mon, 30 Mar 2020 01:04:35 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:03:57 +0800
In-Reply-To: <20200330080357.96989-1-howardchung@google.com>
Message-Id: <20200330160343.Bluez.v2.6.I469418408aadd72a98d675c7d8835cb79741835b@changeid>
Mime-Version: 1.0
References: <20200330080357.96989-1-howardchung@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2 6/6] tools/btmgmt: Add setting string for LE Set
 Advertising Interval
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

$ btmgmt info
    current settings: powered bondable ... advertising-intervals

Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v2: None

 tools/btmgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index b1820b41c..91e9c0b40 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -355,6 +355,7 @@ static const char *settings_str[] = {
 				"static-addr",
 				"phy-configuration",
 				"wide-band-speech",
+				"advertising-intervals",
 };
 
 static const char *settings2str(uint32_t settings)
-- 
2.26.0.rc2.310.g2932bb562d-goog

