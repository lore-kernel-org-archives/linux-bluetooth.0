Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEC2C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC752220B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pN44wtdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgIPX0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIPX0K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:26:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7CC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6so389473ybi.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UdDPzO9OECkeo70fdtQdo6JOo5V7BHm0lOgDeLw00GE=;
        b=pN44wtddLVSWcWAfpjNRZ/C2EljFnOW8pU69igLU/NLa9aym0SV+Rem6pzEKPje3OJ
         xpdwI7soeGun/PR4AhLKidwOG2zqZZqwfPxAxbsv4xv86yQ2ahmv/Be9XwXwogaBkFf+
         D3CyBPvvtYodl+wCVTbemhsMqqhOZJSYtbAf5RnAkCPi4rGHFyMvefSy5ZGhVkOgHj1A
         C/yGQ04AduvUdXPFEexAinn0wZX6XfK8SD3Es6x7X7DmJwsL2kSIfyN0GflWBkBzdN7I
         X5to0ES4z2N/NIQoJtNxT80OQ7K8cPc4kMDJISnXtQmj5ydXFbS54WMO/X+7TqgFhFV+
         Es2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UdDPzO9OECkeo70fdtQdo6JOo5V7BHm0lOgDeLw00GE=;
        b=GQlN2pDRiBrzSCZDcuRjGS+r0OGyqOK90MQajJVPRDBfjTjdo6mWyauvxWqmMNb+R0
         XuwvITPpYudRNPraOgicOwBYavgnn3qLRYvEIVKifSdADFPIdcf6exm5VIleVcCTaoQn
         MLIwCmzTcV2inf8RDpo8rEm19IGhHObk10uOYlb77IoRvRvnSdEvfK/xUPEgnlzbkH9z
         uz7i1t3eQkkTYQpSpYIF15wtSaDNAa5PrdBcRdbgTyHms9KJU6eI/MNiOeabr3M+kN8T
         aYBD5JElCJ2os7FbCIHXrXtYa9/+8GKyOkq//W8YA5p2AiuT/ORvj4WyQbl5W2F3i6fu
         QyUA==
X-Gm-Message-State: AOAM530TMItIwYQZtG7XdkwzRlmVSWcWPIf8SWh0mZ0xiRqyesXXUUuM
        tbJ0i47RYJTEBmwE+3xoUZo8f2xNdOd9MCXvqQSz
X-Google-Smtp-Source: ABdhPJwVp1Y4v4huZ5Sz8BrFVkxmSlUInExt6o5RL0MqZ/4kJRxO+Azk05BT459om59z5PThbW7tjyEnvU77BuMW1lcq
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:a305:: with SMTP id
 d5mr11744783ybi.180.1600298769343; Wed, 16 Sep 2020 16:26:09 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:41 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.9.Ifaa96e71a871158e5d9d454073b2b6846eae339f@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 09/10] doc/advertising-api: update API with new interface
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
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
---

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
2.28.0.618.gf4bc123cb7-goog

