Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D81E2616
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844678; cv=pass; b=pzhSPBFdarn2LhuvVZlv6l7cYHmXVRZlCLNXmFc7TBdWt+ew054oYqe7SjwmlfKj+FS4dta5B6ps0KqCd4ybel0KDNqK3oE1sAf4VB+WY4zzhikuZ5nfDmZGkz9ZYNyQf2nF4bRYakki2jKbhWtP+S7+Z96OPpYzcJtD6W57NKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844678; c=relaxed/simple;
	bh=stWgJ+O85uEr95Nl9bercZpz8zC1xflPqMpdjtUVNOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIxcYI5KQmb4zvw0ckPPIxaC++WU30pJMLgnp1d5bchkoq41CBG+9DCLiHQfY/W2n9sa26/y0L3jFU3gGLK76HexdosJ7FOxWpyZnkx0mEY6Rx/g1SPcCUhiIGIA47zwQJIdrEpBtBKLShlPOVqyrLN9igMxpxCudcL42xOv52w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=b1UIkpWm; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="b1UIkpWm"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z4qV32pl3z4BKHW;
	Sat,  1 Mar 2025 17:57:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740844667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG1uo1/mrsbdo8oiNsGlIvnIFNBikeqzXJ9l3A08nEY=;
	b=b1UIkpWmuG018izmcntrHrn15BOCFZiWVMtg3wEW1GIDsxgMjdgC7qRkZjZt1dei/juNqn
	+o2Edlfzag4TgN5/5aFxxqwxtv1sMBmOUstdSN3MZti7VbnyRsOq7nMwgMN+sU32NCiYYW
	0eOT4fl5Jw3dk2z5ZAzXN/tgUHwC0nUUJgdOLhMPUomvB55mPnSX6/8gfidpJ9N+HFOtq3
	+WrltmTlbGM2XlsKgJ3Us2n99kF9iYZkHLrupHjwJefZZeQiGlO840cz6w7x7IZETYkdVn
	8nJJ+RAYqCqvCT97ZzJaVUOpuovpqCC0e8vf7phAB9y9hP7Lw8S2Qp59fndNrg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740844667; a=rsa-sha256;
	cv=none;
	b=YYZd3iJGJiTHmb8lKvnoBgovCwHEClAWr6CwgjUC2/9ojEBzm24SEkHuzsMRyG2RZPy8LH
	Ztff+LxUANWirIX505aj6tUVohyskJGXOIT7DOwElAQ/W1pCYW+/0QE3g3xceweeh6FUL1
	tH2cbNTZrpppuBNKc4fl2+Ra4N/gZPBgQXqzQfJn9+ZwNV45naR7Mp0yAjQn/GuHed+LXj
	L1oANeNEri0ncGlRgPiNlsdwXrnSboY5JA59imXad+BZ6gqtMzrQqLMzrbyejvcxindEUq
	euLfmP1t8xayuwwAQODaEpN3SGezOLUzkW5kNXBcNMIeUW1Kn12WZ4Fqn96C3Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740844667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zG1uo1/mrsbdo8oiNsGlIvnIFNBikeqzXJ9l3A08nEY=;
	b=tF+RRBazVz0L3nPY9KtCH6nzdHQosRMxFh5UQe64LEUUU7/AIPMv9s+4ZQHCzcJoGAU5bz
	k3TdNveeatAZEv5bHiJtralntXNPJpXrVjO7zEzAZDxES0WXixoCcXOFOkH6o8fQjWgnyL
	G8mkf1CDR/W2j6JyGm9//q3rZVO/2rQdyxbyuyqzuT2sO5StLZ23ZQO8MTobGSS/Bjnk67
	lr/UYq9SWr8KGZnhkP5rTc/AnQehAXmAl+/fW5uT6RI3QQlKbz8OXbyP3OsDjVEubrbhbt
	Q4PUoGI5wGgOmCgFBPk1d7ZFurQBEmhjUhOrSiAPSNv5ukBitwMSCatxOEhsEQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ 2/9] org.bluez.MediaEndpoint: add client role SelectProperties
Date: Sat,  1 Mar 2025 17:57:33 +0200
Message-ID: <e6c11514c61343d0991e5d6952f800076a941cf3.1740844616.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740844616.git.pav@iki.fi>
References: <cover.1740844616.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple way for the sound server to reconfigure a BAP unicast
endpoint, by calling org.bluez.MediaEndpoint.SelectProperties().

This shall destroy all streams of the endpoint, and restart the
SelectProperties() configuration flow from the beginning.

Since it may be necessary to reconfigure multiple endpoints at once to
correctly make bidirectional CIS, add Defer argument to just mark eps
for configuration.

In future, org.bluez.MediaEndpoint.SetConfiguration() could be changed
to handle unicast in the same way as broadcast: only create streams.
This allows sound server to have full control over stream configuration
itself, and not rely on bt_bap_select().
---
 doc/org.bluez.MediaEndpoint.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index b81106f0b..5c42b878c 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -69,6 +69,8 @@ array{byte} SelectConfiguration(array{byte} capabilities)
 dict SelectProperties(dict capabilities)
 ````````````````````````````````````````
 
+	**Server Role**
+
 	Select BAP unicast configuration from the supported capabilities:
 
 	:object Endpoint:
@@ -104,6 +106,25 @@ dict SelectProperties(dict capabilities)
 	Note: There is no need to cache the selected properties since on
 	success the configuration is send back as parameter of SetConfiguration.
 
+	**Client Role**
+
+	Reconfigure a BAP unicast endpoint. This closes all existing
+	streams of the endpoint, and restarts the configuration
+	selection flow which e.g. triggers calls to *SelectProperties*
+	allowing the sound server to modify the configuration.
+
+	The following arguments are taken in *capabilities*:
+
+	:boolean Defer [optional]:
+
+		If True, mark endpoint for reconfiguration, but
+		postpone it until a non-deferred *SelectProperties()*
+		operation is made on an endpoint of the same device.
+
+		This is necessary to use when reconfiguring source and
+		sink streams with the intention that they be combined
+		into the same CIG, possibly forming bidirectional CIS.
+
 void ClearConfiguration(object transport)
 `````````````````````````````````````````
 
-- 
2.48.1

