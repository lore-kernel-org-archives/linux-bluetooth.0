Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19252E7542B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 17:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbjJCRt3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240668AbjJCRtZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 13:49:25 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE815A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 10:49:21 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S0QLR2WjQzydm;
        Tue,  3 Oct 2023 20:49:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696355359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zKHwBs1GVkDtC9I8vqMQlneiHzFw56wVry4kh+U85I=;
        b=IHtJzB/ISEHa6rooG210EdfWfVQvu5dU1VFJ6HqH/5TnVbBsmOvW1sAggRxbOtnXeEmNXR
        4SaHQDuBvJO9rEJ/j7YwDwrXuRTQUAXhr3f6i5zO1j9kiwPXprYxoX6neF0xfuL1RM5KYe
        cOCMsGwl5AnGLBRcsNFTAvjSXc5RE9w=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696355359; a=rsa-sha256; cv=none;
        b=BSrpYVKR64OoRDMDOnIL1GP97wRPXZPs3clICFO7GabRdj9rgQ9JU/4s8KcPeTXkRtSuGF
        V+0HbikvF9YhhLStftR/AG4UqUedrF/onTuoiMZ1gobx+cLudD7VAm608afT6FqkI3UJAV
        aoDRdTK2HqJHFl7gKRPm2bnxs5wHMic=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696355359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zKHwBs1GVkDtC9I8vqMQlneiHzFw56wVry4kh+U85I=;
        b=pmaLN9g38zQ/GejvMbfY2sabTaWH7L6phUYCXqYYXQKoxTEsnw2UkHXSK7oCclh8Wcrioq
        T2Hu9Fp7acU/Ea+Hxd1Gk53bPG8mrXsd1LEJycSJV82IdzAhYoyqK47r042C1591i8b8ca
        Yt9SCGISadltHBNPn7DNyBttYSPula0=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] doc: clarify org.bluez.MediaEndpoint documentation
Date:   Tue,  3 Oct 2023 20:49:14 +0300
Message-ID: <a1cd22d65600f06977e8557066d5c8a618d33dc1.1696354690.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <112613bc64e4d17573b75a9d245b5fe5e51b5fa1.1696354690.git.pav@iki.fi>
References: <112613bc64e4d17573b75a9d245b5fe5e51b5fa1.1696354690.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Document the actual input and output parameter values used in
SelectProperties. These differ from SetConfiguration.

Mention SelectProperties is used for unicast only.

Document SetConfiguration input parameters.
---

Notes:
    v2: put SelectProperties QoS things to "QoS" dict

 doc/org.bluez.MediaEndpoint.rst | 48 +++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 0e201ff9d..6754d6e3b 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -24,14 +24,24 @@ Interface
 Methods
 -------
 
+.. _SetConfiguration:
+
 void SetConfiguration(object transport, dict properties)
 ````````````````````````````````````````````````````````
 
 	Set configuration for the transport.
 
-	For client role transport must be set with a server endpoint oject which
-	will be configured and the properties must contain the following
-	properties:
+	:object transport:
+
+		Configured transport object.
+
+	:dict properties:
+
+		Configured **org.bluez.MediaTransport(5)** properties.
+
+	For client role transport must be set with a server endpoint
+	object which will be configured and the properties must
+	contain the following properties:
 
 	:array{byte} Capabilities [Mandatory]:
 
@@ -59,13 +69,35 @@ array{byte} SelectConfiguration(array{byte} capabilities)
 dict SelectProperties(dict capabilities)
 ````````````````````````````````````````
 
-	Select configuration from the supported capabilities:
+	Select BAP unicast configuration from the supported capabilities:
 
-	:object Endpoint [ISO only]:
-	:Refer to SetConfiguration for the list of other possible properties.:
+	:object Endpoint:
 
-	Returns a configuration which can be used to setup a transport, see
-	**org.bluez.MediaTransport(5)** for possible values.
+	:array{byte} Capabilities:
+
+	:array{byte} Metadata:
+
+	:uint32 Locations:
+
+	:dict QoS:
+
+		:byte Framing:
+		:byte PHY:
+		:uint16 MaximumLatency:
+		:uint32 MinimumDelay:
+		:uint32 MaximumDelay:
+		:uint32 PreferredMinimumDelay:
+		:uint32 PreferredMaximumDelay:
+
+	See `MediaEndpoint Properties`_ for their possible values.
+
+	Returns a configuration which can be used to setup a transport:
+
+	:array{byte} Capabilities:
+	:array{byte} Metadata [optional]:
+	:dict QoS:
+
+	See `SetConfiguration`_ for their possible values.
 
 	Note: There is no need to cache the selected properties since on
 	success the configuration is send back as parameter of SetConfiguration.
-- 
2.41.0

