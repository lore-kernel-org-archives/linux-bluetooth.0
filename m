Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3342C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2D723730
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 11:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbhAOLwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOLwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 06:52:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5606BC061793
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:44 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r185so5924974ybf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XSwZnH2kh3Ehe2Kkqwf/EwstAQB1eAD/12eZMBoUKH0=;
        b=U+BZTWn9OC/ox1fukWuanuAi9j0NbQf08J6c5kNeLXbRoWBjOsMkpyecqMEkg70E1R
         j4kECokR9igOMU2fKD0ZUxb35xUTAaa2WpCoMgS+Li+8JMGZ/CCfkbASHo8Q6jsynH6S
         tV6Y4JsLm2mILAi8Z6Isg3Q5ISxiN0WhEjsOyQ6F2654DMnTvaLsMH1+Ru0jqetdXEjc
         9tntfXR2Edk1qiV+OhHw03HaMpV6qJAac1BcKyGtMLIU61/FQ1H83rdNAS38nslD9APE
         aHW0DsIDtoiU0871XrEluOciYX9hYMVs+t/+yHxUD1xypVxumM+W5S3xvszif8rPWldb
         9BPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XSwZnH2kh3Ehe2Kkqwf/EwstAQB1eAD/12eZMBoUKH0=;
        b=lfXB+63E2xsKBlL1NviyVjD80kc7yRHmnA9kE/fANYj7hBuF6mYwXX+lVUTjh920Nf
         zzChh9UlTRLDaeaIwFIEJ5f9J80uK7y26KzG3k6H9VxdBn78XUV1V3gGRJLaoE8kmAg1
         owgNBpQ5DHJHQuipoJkMZQy8pTyIu6zJRQavPZmI72CtqpdtXTLIwfTEP9SFe7tm47QK
         Q33Bl+QdsN76vfncueP8UUPLbwzhA/E+E8RoZWR2dZaY6c4O5kvvM17vmPR09zo4POCj
         XHAWkKtWPzecuFzKoW/JXVnd1VjhEqEkuWcLEb4IWuxY3w9nrAE+TyVmmkqrG5HSliNt
         w3nw==
X-Gm-Message-State: AOAM531oCDRMuz1JlhFApRJ8SQUIIc86SXvtqfXiYtpMms2nEsD+YSW2
        2sos//Jog5/YLlitbbgFTmC0aT5PFSUzcpJmK88o/BD+Dfqz9iycYA3OZiORaW+T9pqVuCtqbU9
        XN+rGUSPVmsOM9Zlue3McTyI1a6YL6tYuJKQJ0ceRWFlVhAJn1M7IKkDlO5EfrZaawwax2rQd6k
        Sq
X-Google-Smtp-Source: ABdhPJwYB1KcA/hgk/xHinzSZ0yFih/2qPAcyexphqHsQgZBKjFLNyiVUaJmf9sE4mruWz+pKAVvMzBW9MoG
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:374c:: with SMTP id
 e73mr18082555yba.376.1610711503567; Fri, 15 Jan 2021 03:51:43 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:50:37 +0800
In-Reply-To: <20210115115036.3973761-1-apusaka@google.com>
Message-Id: <20210115194853.Bluez.v4.2.I5e5ea3e2d73840e65cd42fccafe14427f6f81de7@changeid>
Mime-Version: 1.0
References: <20210115115036.3973761-1-apusaka@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [Bluez PATCH v4 2/6] doc/advmon-api: Introduce sampling period property
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The sampling period is used to align with the new MGMT opcode which
also have sampling period.
---

Changes in v4:
* update doc

 doc/advertisement-monitor-api.txt | 78 +++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 92c8ffc38e..8100717c03 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -49,31 +49,59 @@ Properties	string Type [read-only]
 			org.bluez.AdvertisementMonitorManager1 for the available
 			options.
 
-		(Int16, Uint16, Int16, Uint16) RSSIThresholdsAndTimers [read-only, optional]
-
-			This contains HighRSSIThreshold, HighRSSIThresholdTimer,
-			LowRSSIThreshold, LowRSSIThresholdTimer in order. The
-			unit of HighRSSIThreshold and LowRSSIThreshold is dBm.
-			The unit of HighRSSIThresholdTimer and
-			LowRSSIThresholdTimer is second.
-
-			If these are provided, RSSI would be used as a factor to
-			notify the client of whether a device stays in range or
-			move out of range. A device is considered in-range when
-			the RSSIs of the received advertisement(s) during
-			HighRSSIThresholdTimer seconds exceed HighRSSIThreshold.
-			Likewise, a device is considered out-of-range when the
-			RSSIs of the received advertisement(s) during
-			LowRSSIThresholdTimer do not reach LowRSSIThreshold.
-
-			The valid range of a RSSI is -127 to +20 dBm while 127
-			dBm indicates unset. The valid range of a timer is 1 to
-			300 seconds while 0 indicates unset.
-
-			If the peer device advertising interval is greater than the
-			HighRSSIThresholdTimer, the device will never be found. Similarly,
-			if it is greater than LowRSSIThresholdTimer, the device will be
-			considered as lost. Consider configuring these values accordingly.
+		Int16 RSSILowThreshold [read-only, optional]
+
+			Used in conjunction with RSSILowTimeout to determine
+			whether a device becomes out-of-range. Valid range is
+			-127 to 20 (dBm), while 127 indicates unset.
+
+		Int16 RSSIHighThreshold [read-only, optional]
+
+			Used in conjunction with RSSIHighTimeout to determine
+			whether a device becomes in-range. Valid range is
+			-127 to 20 (dBm), while 127 indicates unset.
+
+		Uint16 RSSILowTimeout [read-only, optional]
+
+			The time it takes to consider a device as out-of-range.
+			If this many seconds elapses without receiving any
+			signal at least as strong as RSSILowThreshold, a
+			currently in-range device will be considered as
+			out-of-range (lost). Valid range is 1 to 300 (seconds),
+			while 0 indicates unset.
+
+		Uint16 RSSIHighTimeout [read-only, optional]
+
+			The time it takes to consider a device as in-range.
+			If this many seconds elapses while we continuously
+			receive signals at least as strong as RSSIHighThreshold,
+			a currently out-of-range device will be considered as
+			in-range (found). Valid range is 1 to 300 (seconds),
+			while 0 indicates unset.
+
+		Uint16 RSSISamplingPeriod [read-only, optional]
+
+			Grouping rules on how to propagate the received
+			advertisement packets to the client. Valid range is 0 to
+			255 while 256 indicates unset.
+
+			The meaning of this property is as follows:
+			0:
+				All advertisement packets from in-range devices
+				would be propagated.
+			255:
+				Only the first advertisement packet of in-range
+				devices would be propagated. If the device
+				becomes lost, then the first packet when it is
+				found again will also be propagated.
+			1 to 254:
+				Advertisement packets would be grouped into
+				100ms * N time period. Packets in the same group
+				will only be reported once, with the RSSI value
+				being averaged out.
+
+			Currently this is unimplemented in user space, so the
+			value is only used to be forwarded to the kernel.
 
 		array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
 
-- 
2.30.0.296.g2bfb1c46d8-goog

