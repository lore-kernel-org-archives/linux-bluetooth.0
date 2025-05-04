Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C2746E
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374519; cv=pass; b=f4XIOGv1dQ3dgb3RLYj6JsKKEhngNJ6S+ZJJav6Kl3JwkSqtKjtlqjmCgJgkZteiBTouefpXFXJXok21jt1rLSY8GI5p+o/qBxQVRe4cB62EU/keNFZKkCG/ru6fqE5E/lzOufAV4CGBDhqSpRenyDD/RP6OdF8RP7waFa7kbOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374519; c=relaxed/simple;
	bh=mT0gdvBJeiu47wyrF8Nbef7AIzSwgfEQZO9pcf0k4Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h17T5ny2OYNV7NhUql27zTb5NC98G6yLzsL49XcZ8AKGaR9BEvnmUyZdNQTiJ7BzSx3T2NWgYhh7wOvHQbhBaJvqtpPyPWc4g6+PtWbTMKN2JJJLvLMJZlCc/ep7Jhl8yhv/q+YLsHfhIL4LEca0dBNDr3rpXWp4+Ms0HfTRs1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=JcCwlJ4W; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="JcCwlJ4W"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zr8Y33spdz49QGw;
	Sun,  4 May 2025 19:01:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1746374503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5ATRzSEdlEHRHON0Vd/Laqho58L9AH19ahm2wENUhM=;
	b=JcCwlJ4Wp5EpXBUREGj3Gbew7HJD2ulyLH8dlZXEL0DOaAkVWjtKRdPMdQddrvjM+JfE1W
	lGM94os1zJ5NAf8XuQGmMNMCYWT8uvrF4y+XtmOdB8JFWiSBHA5o6oB6PNfjngKIGlQRFL
	NDoBu32VzcI3NK6tgvC7if1FrBkzHUVuG3uq+Xndg+T6DbIWr1Otei31qR+ysmpyAXQfn9
	dPzpQ+5oWJ2RNLgAQnnLBTPBfT4/+sqJSG9fv5GwDvalboSv9yltNdIT6jKUwbTBiBP9he
	c6KB0T4tYcRl7yj3nwapync4J7MUUiz2sAL/TRPXShYgOkrieeL/aglQRHqC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1746374503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M5ATRzSEdlEHRHON0Vd/Laqho58L9AH19ahm2wENUhM=;
	b=hdMxvClVp+x3vXLlvdixUbqNz8DejZiezya0Nrf0rgSs/DGnOlNsA6e0lLcetCaeOpZncD
	PJH4M7aP4pbjVd3tuEcQreWbSAkJ4qPZdLDWne5BnoeytMWrbBJUgHR4UKXPIscdiB4vBj
	sInRsgvSUb1yLBU+kReZ/H02aWoBFt9cAWBoUEH+OyiHg2cQMmKQrm4XQTGV4Nb9Yw/FL1
	51qbnpqe/0OqXcDhkzSy5s06xqBLP8ZMsCsZ/4VtTe7ZzepgoqMvWC8kewOGRIemecMANw
	oX6SGmkijWijRG+dFnnk91iw6oo6+ay71q3TfUGdqOCR73rqquGcgLxWAE4Lzg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1746374503; a=rsa-sha256;
	cv=none;
	b=hgpUi2k6/2lu3D1CqZu9mIJsEhJr0th3ZavxlOrZ9PRLp5tR5Rbkt2vFF2zh7o6MXRWrDn
	I6gScZbv3+MtbgyRZrzL8feTSSUKf8KN5XFFi8ybubBypxsd3xfn+aNybfuRi4QpymVIi0
	QmFVcMV0tvjN9e7V9LPguoeXs9+VkLxglau3MfqydQ38Qp7YZ5I6dJYJoyZop9PnK/1IYv
	/I3okcKYPXSK+tQhd0hhwmiDecBIj2pQESC3PPcfRdRd2LiZ6tPOAbZCCmFHCFso6l9at8
	0vAausapKWJM+TSXc4mFZJYtOOHEY16q2hTSRM1wCW9axfdGJ7FnCmq+zpv/8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 01/11] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
Date: Sun,  4 May 2025 19:01:29 +0300
Message-ID: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374483.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.
---

Notes:
    Whole patch series:
    
    Pipewire side: https://gitlab.freedesktop.org/pvir/pipewire/-/commits/bap-codec-switch-select
    
    Tested with
    - Sony Linkbuds S: switching between AC 6(ii), 7(ii), 8(ii), 11(ii)
    - Earfun Air Pro 3: switching between AC 6(i), 11(i)
    
    TODO:
    - Enabling/Disabling while Reconfigure/ClearConfiguration is in progress
      should be handled better.
      Stream QoS should be delayed until CIG is no longer busy.

 doc/org.bluez.MediaEndpoint.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index f2b830ab0..b81106f0b 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -109,6 +109,12 @@ void ClearConfiguration(object transport)
 
 	Clear transport configuration.
 
+	**Server role:** [ISO only]
+
+	Close the stream associated with the given transport. If the
+	path given is the path of this endpoint, all its streams are
+	closed.
+
 void Release()
 ``````````````
 
-- 
2.49.0

