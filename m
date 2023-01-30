Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3EC54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjA3SiZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbjA3SiD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:03 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD646D57
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:37:20 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 1ACB51B000A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:37:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrrPNgzRVqp7vR+ixsL34GK1Djqb3owOb8ATvbWnni0=;
        b=ke9GmqZ7v83cjF6m6H5Yl7rnk4Z6/Vptbb2SkcY55G+m2UWQpIKU6t1Ia79B/SXAzL5HM+
        HsGD1VKawryOE2W+em32jSCKiD7IVevdWoZxBnI4LRiUTzeckZ3qtE7wVX+VqcRrJC+D1s
        IC7BMYckDxMzmbHjP5uznpbEULWMPunxbcAIqeXGXMPhtmFzDj0BQ4mrAhBtaPVptYtAH3
        zTO7QmA2EEE2Et8gGQG0DhCaYDpA2D2ZLMztrW8xjxeJ/vPw4/PhUPAKDp1/ejoVRyt9LN
        h/pi28hv9nrZVzCuUAZSjgYTSeme9XbVNDH1plgdqAH7P7Jk0vXWe3ywAqeXEg==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id A0EBE20035;
        Mon, 30 Jan 2023 20:37:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrrPNgzRVqp7vR+ixsL34GK1Djqb3owOb8ATvbWnni0=;
        b=oMwNBLeKiaGQBJrd9qbuu1L/R06NyrxJk0FUD4yzHksR1+esQtJDz1145Ek/Y68UXv2LpS
        /A2m6gmyX6/5Qnic2RJxwP8TC+qbryDtKjbeR9+B7Jj2a6Tt8w/DKsvbFcaFTfBwEFQmmL
        WD3yY0Ck1IL7HYlkuOhT04vemgkP+Eo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PrrPNgzRVqp7vR+ixsL34GK1Djqb3owOb8ATvbWnni0=;
        b=dKrJyd0nxxZSIdsvy5wawalQaBjQsF7gBZcqQA8w6f/R61fGgj9cLpUr7ScvnIKkcEthzH
        lJNWqJwNphCgnkUWSvPfaw1y22KktTRm2gc10FtadcB/rhUxI2LyUmpsf5SZ6glptZbNY/
        gVBsKaC5/2G7CTmp1i0QMuydKaDedhE=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103832; a=rsa-sha256; cv=none;
        b=akp0SGLIB/cGm/SLtMy2/eoOt3fVpCrfOZZT9B293XCXH3Or3B27I4cy/qauPhwsxOlfbe
        inDzfj4bk29Rsm42ew3yVFYHfUIYAvrYMsLw27c7LbQidxx+0BlXIKM4PiPEGIEBz0P0pk
        XAu0jsOmz5OP/xKny/5851UaqurHoqw=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: MGMT: add CIS feature bits to controller information
Date:   Mon, 30 Jan 2023 20:37:01 +0200
Message-Id: <229cb2a6ecc8f182471f87ed527883c1a8353af5.1675103818.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Userspace needs to know whether the adapter has feature support for
Connected Isochronous Stream - Central/Peripheral, so it can set up
LE Audio features accordingly.

Expose these feature bits as settings in MGMT controller info.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    In BlueZ doc/mgmt-api.txt, it says bit 18 is for Quality Report,
    but that's not implemented on kernel side. I'm assuming here the docs
    are not correct, since it's not implemented on kernel side.
    
    In principle the Isochronous Broadcaster / Synchronized Receiver feature
    bits may be similarly needed. These probably can be added later when
    there's a clear use case.

 include/net/bluetooth/mgmt.h |  2 ++
 net/bluetooth/mgmt.c         | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 743f6f59dff8..e18a927669c0 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -109,6 +109,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_CIS_CENTRAL	0x00040000
+#define MGMT_SETTING_CIS_PERIPHERAL	0x00080000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dd30a3beb77..a8d23770d469 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -859,6 +859,12 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	    hdev->set_bdaddr)
 		settings |= MGMT_SETTING_CONFIGURATION;
 
+	if (cis_central_capable(hdev))
+		settings |= MGMT_SETTING_CIS_CENTRAL;
+
+	if (cis_peripheral_capable(hdev))
+		settings |= MGMT_SETTING_CIS_PERIPHERAL;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -932,6 +938,12 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
 		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 
+	if (cis_central_capable(hdev))
+		settings |= MGMT_SETTING_CIS_CENTRAL;
+
+	if (cis_peripheral_capable(hdev))
+		settings |= MGMT_SETTING_CIS_PERIPHERAL;
+
 	return settings;
 }
 
-- 
2.39.1

