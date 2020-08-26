Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83515C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B142078D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EQBd6Tye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHZUMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZUMH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:12:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FAC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c78so1856934ybf.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8A7xpmrr7m1zruibMkh52mGk5SyAjYE9eZwX3Vft4m0=;
        b=EQBd6Tyeq7nGzis1g4BsMpKpHXXQw3Ij5YGb0+zOrsUJZbNvZqf+fmpvC1tel3RvVY
         giCVv8HqtKW25dmKQ4d/Z7zUkpZDKkskipBkxgYC6Gki4cdDoFC4aXCNbenq3k8DvPJz
         K4fchJ3PPhX9Esy5nzAGQJUMJ+jmyc0Mb6zC4dFGkuTnfyP3iZB0ErtSzaJ/8vdIwRau
         CmdAELb5o3mTzamCrhFKE+9BocLnEqrto4R1tyiTuMhQpAO9Mwq5BgSe4pG0cD4fe2z6
         KELMkedpI/hYK9iq4FQ4B7qDPYT8WeAc8RauwGa8ggAPaqq3F7NCvfCDZ30BoWhXpC5o
         BLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8A7xpmrr7m1zruibMkh52mGk5SyAjYE9eZwX3Vft4m0=;
        b=Uw9pmN0b0tqSZhmrG0yiWxGOrFoHKGPzJMVSVNlC1u3a8LkDrbF7DwlHhieLA9s6Qo
         u2wkQd6EpsJ536FtOcjpQuit4anKdWIZpVzfYscA9A917oSbjRsldVcXcVs8fhfETP44
         vRRpuwiwoTgCg3ACdw9WG2SGiQJI5BVjQZGHp4FhlG3t9FCWds6YUqlP0vCu3NdInErO
         dKFfL/b/gHPZxj+ZBkn51sGgSlpfz0CJcmy2uuGDMrsA0gkr+Ge0La2YfM644nh03ON4
         8quUqVsZkSRmzAtSnsbDtPbn/uNbyv9oY5Gs4whkfg91jZqtyvXyhee+ZrW/H1jpWah2
         euLg==
X-Gm-Message-State: AOAM531MynfkoQF1ws0CTYPKu0HwaNanY1qidbaXfgB/xaOSHEAsnftj
        WI24+j4nfbp7QNNaNg62TOudxjPdOaHK270S7hcl1Qq2dSzIEZgTd+XFriXwik9x5M++0uC0EWz
        qzmX/6Z7Z10+K5KxPqmC6/Rq3V8h4DKcRtptGQ9cg8T04R3WSeTjqSSw1D+in09XTMlV2dBZqMx
        smXhBAgQT6PtoLgvvT
X-Google-Smtp-Source: ABdhPJwP2sZGJ6OUBXde7GCsc1AQC5fSnaGsJhsGKYRenY4yZG+hm89XcG89mWb/91HD8DOV/hI5Rw4ixSm8IbH2vdpt
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:2451:: with SMTP id
 k78mr24201813ybk.335.1598472725915; Wed, 26 Aug 2020 13:12:05 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:11:46 -0700
In-Reply-To: <20200826201147.1908411-1-danielwinkler@google.com>
Message-Id: <20200826131103.Bluez.v1.2.I33cf8432f94675b635ab429b3125f54048c5b66a@changeid>
Mime-Version: 1.0
References: <20200826201147.1908411-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 2/3] PRE_UPSTREAM: advertising: Add adv
 SupportedFeatures to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds SupportedFeatures to be shown in "show" option of
bluetoothctl. It was tested with and without kernel support for features
to verify that they are shown or not shown correctly.

Change was tested by verifying SupportedFeatures were populated
correctly in bluetoothctl on hatch and kukui chromebooks

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index da877b546..6368cd516 100644
--- a/client/main.c
+++ b/client/main.c
@@ -933,6 +933,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedFeatures");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
-- 
2.28.0.297.g1956fa8f8d-goog

