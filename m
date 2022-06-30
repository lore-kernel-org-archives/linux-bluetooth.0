Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71632C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 07:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiF3Hkl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiF3Hkk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 03:40:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C43A73A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 00:40:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 79BB55C01F8;
        Thu, 30 Jun 2022 03:40:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 Jun 2022 03:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adrake.org; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1656574836; x=1656661236; bh=4RjzQkICd6JShLQpf6JLO602P
        G9BdxNyoon3ms2HCpg=; b=TpGYmn8u+3UHzo+Ze40VKHbwgK6HnpDhBQ6EyDcdw
        nq0791CYVg+OC3T84WvVXF1fJrQWTTkorvIodLYyBoBqD2jco4kBCWn/bVBLqxm6
        sl3oiIbz3DO/aSoP0+6NU2DyfNr4LDqcoWPLXB3slkIS/IAQjep4qbCl4GLr8L95
        a6u3qPQMmFjJqxIUcr/upd85n7XSDfqNBc9gD94aqtNEaWOlwS+4Kmd9alp68C3s
        VABo4mWK0N0mg5mkdcZ7q22+5iGsqiyhZeOY9ghj+hOYjfosZebnw/Lf+2pdbz94
        6fu3bXqzNVcgu4np5Pw7PAZsGkMbpX1JAmD0i91S8SoUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656574836; x=1656661236; bh=4RjzQkICd6JShLQpf6JLO602PG9BdxNyoon
        3ms2HCpg=; b=b99zl0qxz0UbwTJO2gIGCaYOF6/oxUGLtijr1dhVXSh5ydb5688
        ybcpZsWjgU1tZfw1uLrTckyx39V2xxaFseUgzOtjh3LZCdEpCkGLQg1XtfEB1756
        rIh2XgCL3AuUPGFs4ZWjtogQlhm5kLSIFQd8m3hzwU9vHi0+72KbxHb4KShfFJt/
        r+/nxVYZ0vxWSXvNlkuI06mOoV2wSBaddD1KuuNrryYbeRrozfzoeivDPyPpaEcv
        0Q3AZnseWLRCCB0V2AaJLDE+f5/fvJBjn6gx9MrihnSqqVyB4VzCBZEDLptikUrl
        yQNvPzhWMkHjP1+icRKp8Gkp6Fo/0h1LEIA==
X-ME-Sender: <xms:dFO9YtYIDoc0UhXzin98M8ob_tuZHSfif6IA-eWQtXU_0d0yeW6BMQ>
    <xme:dFO9YkYjKB58sbsl1t8klmz-DhC4rVILuybdAcl-_zaL0YlFqG2R8n-rI52XETbGY
    IpqhXsHCQtHfIZkeg>
X-ME-Received: <xmr:dFO9Yv9AsBa-tefaOHsUO4Sxr4jepxFWgjEvcgaEYDkI6Rqryl-44TcOBcQVRorg0rHuL8actF2vLhoaS-TQLnDneAb2KyhujmId5wFt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehtddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucffrhgrkhgvuceorggurhgrkhgvsegrughr
    rghkvgdrohhrgheqnecuggftrfgrthhtvghrnhepueevvdfhteetjeekudehteelffeuud
    evffeggfevleegffeitdefffffgeehtdegnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrug
    hrrghkvgesrggurhgrkhgvrdhorhhg
X-ME-Proxy: <xmx:dFO9YroyaFUlU57MChsgZkT5rKMJpYemTo3Xk-hEDdUgssb8L10fmQ>
    <xmx:dFO9Yop5rEa_OxciMl1P6PV1NG6KCukX4YWE7Qy_ouESl-te8DOx1g>
    <xmx:dFO9YhRYwES1Ohydo1QxGPynNqC2DkVPOKJEyZDlwBmc-EBb0lIrlg>
    <xmx:dFO9YvTePlOSkn4zhXY9v5lrkLiiYOEx_ntqMOKBxmiLpeTkoJKIFw>
Feedback-ID: i7cac4098:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jun 2022 03:40:35 -0400 (EDT)
From:   Andrew Drake <adrake@adrake.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrew Drake <adrake@adrake.org>
Subject: [PATCH BlueZ] adapter: Fix advertising monitor on Linux 5.12-5.17
Date:   Thu, 30 Jun 2022 00:39:58 -0700
Message-Id: <20220630073958.34468-1-adrake@adrake.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The existing code assumes that, if a device supports advertising monitor
offload, DEVICE_FOUND events can be ignored since the kernel will send
ADV_MONITOR_DEVICE_FOUND events instead. Unfortunately, these new events
were added in 5.18, but offload was added in 5.12. This patch adds a
check on the MGMT API version so we can process the older DEVICE_FOUND
events when the new events are not supported.

Fixes: https://github.com/bluez/bluez/issues/357
---
 src/adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 16da20034..62ca42ffb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6909,7 +6909,9 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 	bool duplicate = false;
 	struct queue *matched_monitors = NULL;
 
-	if (!btd_adv_monitor_offload_enabled(adapter->adv_monitor_manager)) {
+	if (!btd_adv_monitor_offload_enabled(adapter->adv_monitor_manager) ||
+				(MGMT_VERSION(mgmt_version, mgmt_revision) <
+							MGMT_VERSION(1, 22))) {
 		if (bdaddr_type != BDADDR_BREDR)
 			ad = bt_ad_new_with_data(data_len, data);
 
-- 
2.35.3

