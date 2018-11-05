Return-Path: <SRS0=YgmP=NQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5261C0044C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Nov 2018 20:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C3F20827
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Nov 2018 20:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=logic8.org header.i=@logic8.org header.b="YEeKUCgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C3F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=logic8.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeKFFw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:52:29 -0500
Received: from logic8.org ([94.156.174.12]:41814 "EHLO mail.logic8.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeKFFw3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Nov 2018 00:52:29 -0500
To:     linux-bluetooth@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=logic8.org; s=default;
        t=1541449862; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ammuDzFrPpY/Mm7AERNNO1UXF/oj34bCA6oLin3zMl8=;
        b=YEeKUCgEIr9M2/im0D3BkC5o1ngPRpAM2T4+MGzqApoCFHfhQV6+28SEPJivoO/qkcwMu/
        pBHgg061CttV3gjU/IcJZEHAeNIGVjDi3yjmTUUFF/QBFH65NQECZJ7rURh25SSH7GotkH
        b5XeqFcpu8FfTiw3Ppo3VbOcvYZnk+M=
From:   bluez@logic8.org
Subject: [PATCH] mesh: Fix check for MAX_APP_KEYS
Message-ID: <0672e88c-227e-aad4-48a0-ae482a92a970@logic8.org>
Date:   Mon, 5 Nov 2018 21:29:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=logic8.org;
        s=default; t=1541449862;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ammuDzFrPpY/Mm7AERNNO1UXF/oj34bCA6oLin3zMl8=;
        b=VG64jGmlTe81zZkRk2BM8n5rYzgP2x/Cb1p/5um8LQYz3yX7l0kP0mWsoSKS+1YDVi2qea
        pRJ1DV1Y9B/XX570Fm0ubLOOyL2+GhVK5QB5lBx+IuUWFi417tgzN96KYJ4aOKvXWYaU1z
        F9Ln1+4l3t/vfnXuIUHwE8AIh8QXrGA=
ARC-Seal: i=1; s=default; d=logic8.org; t=1541449862; a=rsa-sha256;
        cv=none;
        b=O/xX18YtIrxiG9yBMU4wcbA64bd17DNHJls1Lr+0BZzbl84z04H+YwKEEfsOy6mvhWF2KKJ4pS0U5nkOQj2cTyVVAz5P6QGgKmgP0SIwSArDvzPZLj7ByqOX9JTufbbuO5f9CP4Jcp9ZtgII/UVkZilEHWvBXebN6xLWNnFVH9k=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=catchall@logic8.org smtp.mailfrom=bluez@logic8.org
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=catchall@logic8.org smtp.mailfrom=bluez@logic8.org
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

appkey_key_add() checks if the number of known appkeys is smaller or equal than MAX_APP_KEYS, but it should check if it is equal or larger than MAX_APP_KEYS.
---
 mesh/appkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/appkey.c b/mesh/appkey.c
index 2ddb1eb..7578118 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -398,7 +398,7 @@ int appkey_key_add(struct mesh_net *net, uint16_t net_idx, uint16_t app_idx,
        }
 
        if (!key) {
-               if (l_queue_length(app_keys) <= MAX_APP_KEYS)
+               if (l_queue_length(app_keys) >= MAX_APP_KEYS)
                        return MESH_STATUS_INSUFF_RESOURCES;
 
                key = app_key_new();
