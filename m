Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ABFE82CAC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 19:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbjJCTTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTTN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 15:19:13 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649B9E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 12:19:10 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S0SL14G5Nz49Q72;
        Tue,  3 Oct 2023 22:19:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696360745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umKvnpc2BxwnTv73DphDtJ2wfGT1y80IkgnusF+PSWQ=;
        b=bW9ocwco5AGFn1yyOTqgLpwRdxzzvdCt9fFb1qo2HJhTWrq7s87P71MPgrMfCQtfe70lfI
        pCWK8386S0kesl+mqIbM3x5RcGgzfGmqS517/eAc7jI1U1HWq1JEmee90eZhtV9oX+Egmo
        GGHKN8vi+i3if+1l94leb3g5rGhVRiWx4yqwAnqcx1OHwREZmHvTX/9/TJd7kCiM9q7Y4/
        tvcQRjBpSbkUfYykiC1xayAWxkgXPtHeISqaBUMyC+/Ap6P+7yabSHZngcgpvtDUJ5vqYW
        ZF4FexY3QRnJqyXhkf/Hp3bYB2dwgG0S2l0zJxMeY8/HtdvAQirZEEFJGWL5sA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696360745; a=rsa-sha256;
        cv=none;
        b=lRRbMxhKFOG3AzcH5VCmOwzd9eQqG1gUurTZp1lshgyYAloJjoO9V12xhJ+faLFGUbH06u
        +UnFna7S1zzrXEjg8SYQH5uLV5rreU3skxAANjT6yrwrnYjU+N47hbl6yMKDe8Fx+H76+7
        Zz28HOKALgOtQWk2D+zyl4dn3je1u/fkUhoFyjoWIrEXci9J/beNIotpWIvH0+kVdInpMv
        BqXS+CCa8CSR08kBTLBGHu8C80p0igsUDJY7ULjpWBkwFQIz9CO9KOFFmtXUK5epUSMdoD
        SpPt2bfQ11Ks1IgSLZWqYfjMmYIG2uenAEnqTGe5c0t/fGAaAY8ub0H4bYExEw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696360745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=umKvnpc2BxwnTv73DphDtJ2wfGT1y80IkgnusF+PSWQ=;
        b=i2O4QKch9mf5R/8h6/ndz7/+bi677fvwZPO8WJtmvq92mMcybarh9JqlIaukl+BzXd36WN
        7xlk/kK0TxggY8MA1bKqTzQymAQ4f5EGZ5KOncDzLzi6mnxjURaCzDcM/0WIOVFul0wdOj
        6A+VZarO1ewIVNOITqf3X3bN0JyBAcZFqWxoaqBmXpsXogkJ5cLSZCTPyChkFvnVCGE351
        woBoD/4oc1+lQLkKdKhwgl1TSv2/eu7+0VjV02J3FFSdvEPGBVQ1AnJWTnbM3LVAOr3sgi
        YVEOELtVRyX3KxTOl8MjaYUqCPZFOYlJNz5/+kQjTFG5wAf9alAN+vfmfPk9mQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 2/2] doc: clarify org.bluez.MediaEndpoint documentation
Date:   Tue,  3 Oct 2023 22:19:04 +0300
Message-ID: <0f7548e9f446e6547f56a0fd355a0a7d9f2f3133.1696360700.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
References: <530fedd2233740d401c67bc1470756c86cb578a2.1696360700.git.pav@iki.fi>
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
    v3: no changes
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

