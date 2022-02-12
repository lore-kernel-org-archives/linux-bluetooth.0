Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 15:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiBLPWk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 10:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBLPWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 10:22:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46C2214
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 07:22:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o24so17240816wro.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 07:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mW8dqxBm+IG4Y6Q1qXfaqxW4iPb0EgpCasprPGiMdug=;
        b=Y/BW0A03jgEgF7HKNsRlvOg58xuCvCRSdIOmHlAtZ8E+voaQmUal7bYSRkU5t+E5Yu
         Njej+IZqHeoLzNkwOgGDOV+pjbS53cjn90K/19v6n96xZKFrWnaqYRw5IqnN7hqfeRB8
         5IruOss//Qy/y5Y+WQhL81qX/lX+UtCp38tt293690MDLLOfTJeVU9zzb3i0mrymTf+0
         ea1vUR6c+Zv4zf1a+f7Y5yO0sxp1nAzttbwqejtltsDY3VAoAwXZU0Oy/9x4k+fHmbiu
         oPcKvqHz/0kk8YFzlXOrLqT/IZfhUpxB/KYh5K689rIvaeEYzdpKeu4lZuJl/TCN4vUI
         07/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mW8dqxBm+IG4Y6Q1qXfaqxW4iPb0EgpCasprPGiMdug=;
        b=GtNGECFVPtCHBPsmq+7sDwTvIppzi4VeW4/pLrLRRQAlW5k2++q9CPY4SsTxD4SdJG
         yecgezDz7g7M3Q0v+ZBPpUYruB9oflDgNVfvunNEkqOL9C/c87SQbd6vECEfRbjpTRz/
         DQotbEPA+ahgh/Iw1XcfSpR0YLb1M9KJM+1thhGFTjnhojAm+q5jhBZt2lWU7FeNu49T
         xfjdyfqBZcSMrp9AhSg3pvPceA17EC2HS238Zi7fUC/04Rfrxx9wtnQsvGh67UujPI01
         aoSX5s9t0f0HN6f1wKNyc4VYC4CRtKNqbQBPx2Wdg3fuhe/7yz30B96ozdzf7kmdQ1z1
         y3KQ==
X-Gm-Message-State: AOAM530ezfn7iqs0a7ziMoYdZV7LjHpgsP/xXTEEZu6nTMTmQ0YxolMp
        XGRIjxa6WJm4sKLuMaaxAmSi8HD9gTE=
X-Google-Smtp-Source: ABdhPJxhyFpZNZrmVFUOAYFIqfnB8PJrS4nCIxRjhWFAn7g6uHbGq1CJJILHUQSaEwznf97Yw8AtQg==
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr5088479wrw.563.1644679355164;
        Sat, 12 Feb 2022 07:22:35 -0800 (PST)
Received: from coreI5.home (2a01cb0c055ede00ea40f2fffe0a4e3d.ipv6.abo.wanadoo.fr. [2a01:cb0c:55e:de00:ea40:f2ff:fe0a:4e3d])
        by smtp.gmail.com with ESMTPSA id l7sm4600309wrs.46.2022.02.12.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 07:22:34 -0800 (PST)
From:   Fabrice Delliaux <netbox253@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Fabrice Delliaux <netbox253@gmail.com>
Subject: [PATCH] error: Fix typo.
Date:   Sat, 12 Feb 2022 16:21:20 +0100
Message-Id: <20220212152121.11032-1-netbox253@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/error.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/error.h b/src/error.h
index dded9f93d..cc7790a23 100644
--- a/src/error.h
+++ b/src/error.h
@@ -27,7 +27,7 @@
 						"argument"
 #define ERR_BREDR_CONN_ADAPTER_NOT_POWERED	"br-connection-adapter-not-"\
 						"powered"
-#define ERR_BREDR_CONN_NOT_SUPPORTED		"br-connection-not-suuported"
+#define ERR_BREDR_CONN_NOT_SUPPORTED		"br-connection-not-supported"
 #define ERR_BREDR_CONN_BAD_SOCKET		"br-connection-bad-socket"
 #define ERR_BREDR_CONN_MEMORY_ALLOC		"br-connection-memory-"\
 						"allocation"
-- 
2.34.1

