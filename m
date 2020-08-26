Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F95C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913152076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="o+G+dhR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgHZURc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUR3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:17:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1320C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:28 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q15so2088424pfu.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8A7xpmrr7m1zruibMkh52mGk5SyAjYE9eZwX3Vft4m0=;
        b=o+G+dhR1lqYgg39p8K3R5QaTMpv/JQmfFTL/gz67THL2lGfr1NPZ/mE4hG/KTzCyjA
         hxWtngR7G5cRomyyxV89sqEtaQBW2KAdWyzql/feEWtVccFVfQlh7I5fWlMHKs1+jZwZ
         w/Fsn/FgRIAVkDNFews/GAadPa9zo9prrGslRJu0kowpZVTUzZ9FucRAJKrifR9h9tG6
         QmSBTiDVPCrpuRRcppCKPmqyflV4XvIGppL78hyd2W06dHhnVVJwWSg0WWIqG86Uo0OQ
         8UWMcW7au7mpEAhjs/NIz89Rw3xp+7SY3YX2DlF2uoMQEYT0tGXk1Ng/VkLXoRxk98s8
         3BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8A7xpmrr7m1zruibMkh52mGk5SyAjYE9eZwX3Vft4m0=;
        b=H6RkaAshGbrmBkcOSX93IEn+VWfsvSiR0wH8VLhldReLlll5Y1A/mgMBOhsnBnN9Fp
         n8IS3oJheJDU8oDKaInvzyJ+s24Qg5WIQYmPkF/7GIM2ea0BihI3aM+3QRdiouSN54Q+
         nFoo9ZbkMyZEqr75M3St8PnrEBnCabw9s/2E8r0k93i/suqn3uA8Q+wHxZHLVbC/oHXQ
         N7awYvP7hyybmGbkdulYBE3vk9CmRUWWimYl98P39s3XeIm4UcljH2bBYPolFpTS9hoW
         WsPFWUqSEm9z0UcIZeT8fZYGu24npvFPdlw4AJww0PNFxQHC8QevCesUsM+IshqYtNHd
         6K3A==
X-Gm-Message-State: AOAM531wdATIiAiBi5miQNP/iH2y4IUY6zBKpVZBqwpigjTVNC7716gR
        2iRf1afif7og7WlVxT0ufZ10htorepgfkid4JDX/VWgZ+pyJvqbxsBJaRfGM01T1H8uK/v89IoG
        iT6z5usilO31pjqGP4n9MkYIZAPJEdr465MMrDahVnjsLE7OV6y0sPUjiuwuw77oCe0yiJhxfZh
        mJXIdh4izAYncenAfE
X-Google-Smtp-Source: ABdhPJz8nNSZI6BVW+zkvDlh3BDmJbMRmDSBx1axTwqMTRb+K8SCDYGQlw/05B/blD4RTMrMcwRjapk0dVDC2rkWbAWe
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a17:90a:f290:: with SMTP id
 fs16mr7472481pjb.35.1598473048230; Wed, 26 Aug 2020 13:17:28 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:17:13 -0700
In-Reply-To: <20200826201715.1911816-1-danielwinkler@google.com>
Message-Id: <20200826131610.Bluez.v1.2.I33cf8432f94675b635ab429b3125f54048c5b66a@changeid>
Mime-Version: 1.0
References: <20200826201715.1911816-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 2/3] advertising: Add adv SupportedFeatures to bluetoothctl
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

