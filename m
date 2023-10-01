Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E9AE748E9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 10:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjJAK53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 06:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjJAK52 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 06:57:28 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D86BD
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 03:57:23 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Rz1Hy21jHzydx;
        Sun,  1 Oct 2023 13:57:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696157838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ35q/P4+CU7zo6R1n/oJ2rODTOjJ+sM4iTry9nzjoo=;
        b=d+GYrNxR/T/ArLeC3Yer2uGotkB8qDc5Eqtz0NLRt9DG+R4RyCU+K1Rfy2p7T1HJ8ftRv5
        rZXWOD2puaDbxIhjNcIZRZ/qaDhc0Z0/qvfsKRyE8kP7MiE2MS8NFTsVcssmVMS06wW+hk
        RnCgMo7xJBIMrYp3bPlKIXupKksV3aQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696157838; a=rsa-sha256; cv=none;
        b=nyNAD7MDctjRYPf7LcfVQR8CUnxE3wDv3zHHXPATeN9r+T6QuGdGWtrkOPsDiniaXodp0a
        fDH7dkgIQ/OIQ76w13y/2u4TcTt5jJ7djICKOLofayChuSHMH3CsX+8OHbYp1ijft+EQJn
        MwVSJ8qxuEy5tcPaBlUwuZZFw24d1QA=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696157838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ35q/P4+CU7zo6R1n/oJ2rODTOjJ+sM4iTry9nzjoo=;
        b=CUP7rTQSMtjYCHFivot5wx71cRNSGkvrpS2cVGwIXZ5qHZSr4kCYxbYVfUwHfGBe6UHlqp
        +nFykwGmp7d+NEMj+4r3IN9u+WKxITBIJXFxIfvTChnEukkIBANppRFr7inXIfYvax1ClD
        kYgtsNNuvUESJzaBqJUztJ0l9cg+MRA=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] doc: clarify org.bluez.MediaEndpoint documentation
Date:   Sun,  1 Oct 2023 13:57:15 +0300
Message-ID: <d5bf0d4ac79bd447d78adad743ed5ae7e8f47048.1696157794.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
References: <3358dfd1591df242507755cea63d00db3d2c959e.1696157794.git.pav@iki.fi>
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
 doc/org.bluez.MediaEndpoint.rst | 42 ++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 0e201ff9d..11b7280bd 100644
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
 
@@ -59,13 +69,29 @@ array{byte} SelectConfiguration(array{byte} capabilities)
 dict SelectProperties(dict capabilities)
 ````````````````````````````````````````
 
-	Select configuration from the supported capabilities:
+	Select BAP unicast configuration from the supported capabilities:
 
-	:object Endpoint [ISO only]:
-	:Refer to SetConfiguration for the list of other possible properties.:
+	:object Endpoint:
+	:array{byte} Capabilities:
+	:array{byte} Metadata:
+	:uint32 Locations:
+	:byte Framing:
+	:byte PHY:
+	:uint16 MaximumLatency:
+	:uint32 MinimumDelay:
+	:uint32 MaximumDelay:
+	:uint32 PreferredMinimumDelay:
+	:uint32 PreferredMaximumDelay:
 
-	Returns a configuration which can be used to setup a transport, see
-	**org.bluez.MediaTransport(5)** for possible values.
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

