Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D93C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbjA3SjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjA3Sis (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:48 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD55B44B
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:02 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 3FF4D1B000A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jdsUT2XSJyrD2X4/zPGnfk6UagSBuq0Oo+Bi3zY6Q8Q=;
        b=e6P2PT6IBC1Q0gBKEe1ZORyMyTno/5YjMIw0OIoTnFLZ/+Qf7AkVSNnosIpclQ8mMF0eCI
        cUIkAUwaM5k3crTe+T8sOPRXzObJgfjYSpH/OMWjwzuVjpc0CKjh5UsP2k+CFuHeBn9EAy
        hfdJ7DLZRAvyGRc0tKcUPy4BYoNj+vXGJb8QIxuTOpPsqw7axTzGh7kYR59Ex4PvIYVTlv
        4vJFIblo1zussjJyNVD5budt4L8kwfmfxalSVOAxNn4KU2BDFAa+9lVeTPTZIatHaTb8Pd
        gpcdRrSUbcoY2c+e8MjbDHv1JsNex/9jJsLOLhVd5cYhxrQ5pywVOiBbW+uzlA==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 7644F200E5;
        Mon, 30 Jan 2023 20:37:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jdsUT2XSJyrD2X4/zPGnfk6UagSBuq0Oo+Bi3zY6Q8Q=;
        b=PZ8lqfnXV4lkg0A+KV49zGii2Rn4cYrZFxcqjMNiFQxkSroQTWG2XPUdI9sPChWDevQxOp
        sscxHOKcDPUznb40FY4rtveuw0ZICED8RDvJOQwwJzV/Ha/cI0LqLfxhn0gsO9W4KwO9eF
        ou6uSN21HMhcx/PM/RqGKPs2s9gS5YI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jdsUT2XSJyrD2X4/zPGnfk6UagSBuq0Oo+Bi3zY6Q8Q=;
        b=cMVfd/eJN3GQgPWxynqRm9flwZ0vjfP7gxU3hUHPgcBPOcjhXqywHV2R03LnlUKsEnu7rz
        RNW2/NXZlWhncKYo4uvNqSh7wfh9r+6r1C+/qHxLxgMWvJdaYuIdPDEI7uskKxFR0nf6Tg
        NmXefN5WZ9GZtYgI3lLUlM9Kd/0M33o=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103874; a=rsa-sha256; cv=none;
        b=kpudVUNNcf5j3proY2BZE4MnRGumyqi3JWTMdx7oYe0Hpbgamkz1Kr4r1M55WncM3CZUEh
        Gbm/Vex1R24DYOqTg/FUyZeqE62LnLtKUrz0L6TR5omUJKf7t4ZzSNbhzfux5IK8nshRNo
        MS8BOgF7FrPc90sjh2toeVfA/XMxJqo=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/8] doc: add MGMT setting for CIS features, remove Quality Report
Date:   Mon, 30 Jan 2023 20:37:32 +0200
Message-Id: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add definitions for new MGMT Controller Information settings bits,
indicating adapter Connected Isochronous Stream - Central/Peripheral
feature support.

The Set Quality Report command was removed in
commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
but the settings bit was not removed. It's also not implemented on
kernel side, so remove it now.
---

Notes:
    Was the quality report setting bit reserved on purpose?
    
    From the commit log it looks like it was forgotten to remove from the
    docs, but this is not clear.

 doc/mgmt-api.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 90d612ed8..58395dc90 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -332,7 +332,8 @@ Read Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
-		18	Quality Report
+		18	Connected Isochronous Stream - Central
+		19	Connected Isochronous Stream - Peripheral
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -2925,7 +2926,8 @@ Read Extended Controller Information Command
 		15	Static Address
 		16	PHY Configuration
 		17	Wideband Speech
-		18	Quality Report
+		18	Connected Isochronous Stream - Central
+		19	Connected Isochronous Stream - Peripheral
 
 	The EIR_Data field contains information about class of device,
 	local name and other values. Not all of them might be present. For
-- 
2.39.1

