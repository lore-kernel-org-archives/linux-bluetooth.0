Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A3FC27C49
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Oct 2023 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjJ1Ojk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Oct 2023 10:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ1Ojj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Oct 2023 10:39:39 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FE9EB
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 07:39:36 -0700 (PDT)
Received: from monolith.lan (unknown [185.77.218.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SHhxx6CdJz49Q1r;
        Sat, 28 Oct 2023 17:39:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1JoB0vBQeH9DHZhC/FVS19u5LaJyPeROD0zgzxDh1nc=;
        b=VCgcUmX3NmqD3k48nTLj4qWDAcNceco61J7KjjKPHupI2vNtwkwordaSjD/eBg8xwRuSfv
        PIn2BKrhK3KKGdwO5xSS6arBQMgktGqFSZGUPImdQkI8NVT9CGeK3+Bo367lmq+G29W0f+
        UW3mWdQPx6iX7nW7AKGvgIpC8MLZIr9TM4+XQW8DgbeqcOvmp/3a2GUdx0L0nDEsPlETZX
        SmxlrI8RHkRJ0y+EKHMS1KkI0SIstMj8JJ8h0oWh54oarHGdOSRSYEWuy0OU9Fk6GjtqRY
        BZ8Zf2Bz7AdsbW+dedz1GOEGtcaSrgKLGe61Go1wx/rqfLJ1JMHFAEy7QL8r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1JoB0vBQeH9DHZhC/FVS19u5LaJyPeROD0zgzxDh1nc=;
        b=mu2AZTSS1jd2DazkvUJET3+YorA0AAlqeLaPDOwamZZz5+PEcrg+iNN7AOihQDO48adywT
        ZVw9nOJl0rctVvKL2aHEFR+RrG8/2dWjvhnwewF+ohsHGKVevLHrr8uNDYIQMSWFbXN83e
        2tpO1bWogfUov1c2kOMyuGUM0d6/6nUB+fLjaA9W5lS/yY7FaTaG9E9J+cUVPMf61xz1A6
        T/2kp6wbCa+dJHr9e4jjjqeNErRPPYyB8NVsdEaVIzjgOuqJktu9BamNr2dH+dl+wyM5WO
        HZaB7d0UzMmxKpCbxIDp+DihIs2md/OMNROsQQEmJOb5KS7LZK+PHgv/wXQRKw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1698503974; a=rsa-sha256;
        cv=none;
        b=J81bWAh04MB3FaiUU0MybGj18icyzjVrKZONqTFGYqrGjX/gZmE6OYPX+CapMkZhfQwMlp
        6uv3p70JYWI7HeKPVSUz7EGH5ByFHlk0PeTSWsMDNvXPAp28tqriObH4DJZzN580uKRMFj
        SwKRj1lhwHp/ZkaX9l3QNNtMoEHKYEZgw0DP82jEhHnSaSodHvAB2MinvSj7vceQ6y+1bA
        UJFfCXf4E6wkt4Ka3Y08PZXUlij5Y9XnGUIB5+J0U+d3d4oHH+GFQt0faNT2n3KjV0qYqT
        gQlYbkFzNk4nLZaYH9C3k77VsxPAuK1jWEWTZAKT9k9ZUakLUwvEOZhPiK+pMw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/4] doc: extend MediaEndpoint1 API with SelectQoS
Date:   Sat, 28 Oct 2023 17:39:26 +0300
Message-ID: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Change unicast BAP configuration to proceed as:

0. SelectProperties(endpoint)
1. ASCS Config Codec
2. ASCS Server notifies ASE
3. SelectQoS(configuration)  [optional]
4. ASCS Config QoS
5. SetConfiguration(transport)

Previously, SelectProperties had to return also the QoS
configuration. However, it is impossible for it to provide it properly,
because the values supported by the server are known only after ASCS
Config Codec.

This resolves the issue by adding a new method call, which is supposed
to return suitable QoS values.

Remove the QoS input parameter from the SelectProperties() call, as the
server supported QoS settings may depend on the codec configuration, and
are not known yet at that point.

For convenience, e.g. when mandatory QoS presets are used, the endpoint
does not need to implement SelectQoS(). In this case the QoS values
returned by SelectProperties are used.
---

Notes:
    Alternative to this is calling SelectProperties() twice at the
    two different stages of the ASE setup steps.
    
    However, if the second SelectProperties() call returns a different
    Capabilities configuration, we'd need to either (i) do Config Codec again
    or (ii) fail the configuration.
    
    Doing Config Codec again introduces a chance of getting stuck looping,
    if client is not behaving correctly, which doesn't sound like good
    design. Failing the configuration raises question why have the
    Capabilities as return parameters at all. So instead, make it a separate
    method.
    
    ***
    
    If two methods is too much, we could in principle get rid of the
    SelectProperties() call and leave only SelectQoS.
    
    Instead, the sound server would call SetConfiguration() on a remote
    endpoint it chooses, and provide the configuration parameters there.
    IIUC, this is how it is supposed to work for BAP Broadcast currently.
    This might need some sort of "Ready" property on the Device1 DBus object
    or elsewhere (e.g. the endpoints), so that it's simple for the sound
    server to wait until all endpoints have been exposed in DBus.
    
    This might also be preferable way to do it, since only the component
    closer to the user i.e. the sound server knows which endpoint the user
    wanted to use, and when BlueZ guesses wrong it avoids needing to tear
    down the old configuration and reconfigure (which we have to do for
    A2DP).
    
    ***
    
    This series was tested also vs. this
    https://gitlab.freedesktop.org/pvir/pipewire/-/commits/bap-selectqos

 doc/org.bluez.MediaEndpoint.rst | 66 +++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 6754d6e3b..4ffe6951c 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -66,6 +66,8 @@ array{byte} SelectConfiguration(array{byte} capabilities)
 	Note: There is no need to cache the selected configuration since on
 	success the configuration is send back as parameter of SetConfiguration.
 
+.. _SelectProperties:
+
 dict SelectProperties(dict capabilities)
 ````````````````````````````````````````
 
@@ -79,8 +81,58 @@ dict SelectProperties(dict capabilities)
 
 	:uint32 Locations:
 
+	See `MediaEndpoint Properties`_ for their possible values.
+
+	Returns a configuration which can be used to setup a transport:
+
+	:array{byte} Capabilities:
+
+		See **org.bluez.MediaTransport(5)**.
+
+	:array{byte} Metadata [optional]:
+
+		See **org.bluez.MediaTransport(5)**.
+
+	:dict QoS:
+
+		See **org.bluez.MediaTransport(5)**.
+
+		The following fields shall be provided:
+
+		:byte TargetLatency:
+		:byte PHY:
+
+		If `SelectQoS`_ is not implemented, then values for
+		all other ``QoS`` fields are also determined by the
+		value returned here.
+
+	Note: There is no need to cache the selected properties since
+	on success the configuration is sent back as parameter of
+	`SetConfiguration`_ and `SelectQoS`_.
+
+.. _SelectQoS:
+
+dict SelectQoS(dict configuration)
+``````````````````````````````````
+
+	Select BAP unicast QoS to be used for a transport, based on
+	server capabilities and selected configuration.
+
+	:object Endpoint:
+
+	:array{byte} Capabilities:
+
+		The configuration, as returned by `SelectProperties`_.
+
+	:array{byte} Metadata [optional]:
+
+		The metadata, as returned by `SelectProperties`_.
+
 	:dict QoS:
 
+		Server endpoint supported and preferred values.	 See
+		`MediaEndpoint Properties`_ for their possible values.
+
 		:byte Framing:
 		:byte PHY:
 		:uint16 MaximumLatency:
@@ -89,18 +141,16 @@ dict SelectProperties(dict capabilities)
 		:uint32 PreferredMinimumDelay:
 		:uint32 PreferredMaximumDelay:
 
-	See `MediaEndpoint Properties`_ for their possible values.
+	Returns a QoS configuration which can be used to setup a transport:
 
-	Returns a configuration which can be used to setup a transport:
-
-	:array{byte} Capabilities:
-	:array{byte} Metadata [optional]:
 	:dict QoS:
 
-	See `SetConfiguration`_ for their possible values.
+		See **org.bluez.MediaTransport(5)** QoS property for
+		possible values.
 
-	Note: There is no need to cache the selected properties since on
-	success the configuration is send back as parameter of SetConfiguration.
+	Note: There is no need to cache the selected properties since
+	on success the configuration is sent back as parameter of
+	`SetConfiguration`_.
 
 void ClearConfiguration(object transport)
 `````````````````````````````````````````
-- 
2.41.0

