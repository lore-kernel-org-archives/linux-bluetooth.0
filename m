Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F7C4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB5420796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovxZHKoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgJAXCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgJAXCC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E2C0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a13so234107qvl.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mel/1In0Lf92d7qXG3/Av8r0mdAiJcM6HVra3dK3s3U=;
        b=ovxZHKoQUnoQiBW9HkixR3rtMtE2Cxm+EgO9lEFnZ2jrFQ5YaZ9AqiTe9W4rapfaSF
         LzJz/aYFtOzgn5xwpqpUhHCMxMJIzDJZWeKAEmWh/oXs7aFNlu6kwgIlCV7XskYxaTSv
         52AjNut0YFSxdKzwTJJOOZU+nGulqY0ikuHxWGK6Jxo06E6Pj+i3PmCV7agduYNhG2Ar
         rJJpBl4pTiIIZ6PJC9MzIO0voQsGT/8x4tzGnUR8tDNF3+hWrxx2V+NDwpL0MHtoZedw
         SCv63KuCkyI+gBo4bXYV1GKpnx1BG9IzMv31zDRs5KpoJxpdu2mxfVyejqnrcK3AQ5NG
         a7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mel/1In0Lf92d7qXG3/Av8r0mdAiJcM6HVra3dK3s3U=;
        b=SzvIrYOtnehfAOeisdYbaXm4K7azam0Oe/V6SlgNHDOg6vYgkv8Ntqb8wj+71y55xT
         P/7/ZhyJ4HctxQ1jVYwg6zr94s/TeJoBbYAyK2qnrRcYjU8qakvJ40wid4g3Eq7BrGVO
         U15Cmb6biYeSuGz9WNad+sJX6HLvcNNsIYF51ZinH9jffsvUxOeJ7shy8iD807HHgs6t
         cxZwMci81EwwpbbAa6meCyTxSusr93OC4CgNiI29+ltOjzFnMgIsw8xv0wEoVGE1t0Lo
         zVAkMyeKOLHH9LRnO7KZujE0lg6a66s0CUG4ZMQChnbqagU+8ZIMF7TvZSxAFoE9m2xa
         zgHg==
X-Gm-Message-State: AOAM5336517HEXkQAnbIwqVxq3vA4ezl74c1Db5sV1ECYYBqEmXtsznU
        KuIqj6z/A1pr4swhvWwu7mIjguUy1/6Z4vRoB34a
X-Google-Smtp-Source: ABdhPJxUd1dwdgFC2ZkquEBWLNwVCXMnKb7lksbbm0/Um3ztL0QPbgaEzwyvxZ8/kkZ4IzmP3OcYoD1qDbIWX+kPW7Iq
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:a4c5:: with SMTP id
 x63mr10277305qvx.58.1601593319903; Thu, 01 Oct 2020 16:01:59 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:43 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.1.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 01/10] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the advertising documentation to include the following
features:

LE Advertising Manager:
- New SupportedCapabilities property

LE Advertisement:
- New min/max interval properties
- New tx power property

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 doc/advertising-api.txt | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index b0565eab2..3215a52f7 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -138,6 +138,33 @@ Properties	string Type
 					"2M"
 					"Coded"
 
+		uint32 MinInterval
+
+			Minimum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		uint32 MaxInterval
+
+			Maximum advertising interval to be used by the
+			advertising set, in .625 millisecond slots.
+			Time = N * .625 ms, where N has range
+			[0x000020, 0xFFFFFF]. If the provided MinInterval is
+			larger than the provided MaxInterval, the registration
+			will return failure.
+
+		int16 TxPower
+
+			Requested transmission power of this advertising set.
+			The provided value is used only if the "CanSetTxPower"
+			feature is enabled on the Advertising Manager. The
+			provided value must be in range [-127 to +20], where
+			units are in dBm.
+
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -209,3 +236,26 @@ Properties	byte ActiveInstances
 			Possible values: "1M"
 					 "2M"
 					 "Coded"
+
+		dict SupportedCapabilities
+
+			Enumerates Advertising-related controller capabilities
+			useful to the client.
+
+			Possible Values:
+
+				byte MaxAdvLen
+
+					Max advertising data length
+
+				byte MaxScnRspLen
+
+					Max advertising scan response length
+
+				int16 MinTxPower
+
+					Min advertising tx power (dBm)
+
+				int16 MaxTxPower
+
+					Max advertising tx power (dBm)
-- 
2.28.0.709.gb0816b6eb0-goog

