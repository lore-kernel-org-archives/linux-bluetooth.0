Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D552D94AB
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914656; cv=pass; b=VZmWPVijiNZKotkfXnfKahqQ6HUKkwWDtrjm3JrZRgpqZLo+E+wa0+/ylrqS3ltCFk15texnftaE4IHBFGLL8Qt6OZmslMxCQd13fmdrnV1bpmTNx3niRA/WU3lsaI1SkqJ2Z+PDNFN8igaiU4qflV/7HstQ23nR0VMnWb074XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914656; c=relaxed/simple;
	bh=r0myELQibG8aj4n79mQbyKqyt50zAwVxGidugmiEB98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6SU4D9tUdwoECmKcxgcBKpsP4WLtGls+WHjDOV747kRytJywHq9dWBcqUd8Kep1AlpzpTanyT7vpvrWCcN6WpaMy0+5zkt4ESHXqQHh4Z04ZRMhH+l4m6oueEjDl5cK/FHsQKRj+YjmgdYSFg14PoBqpGuKAQ4PlQU3m43fJ/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ciBQZDV9; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ciBQZDV9"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHZ0fmRz10Kr;
	Sun, 23 Nov 2025 18:17:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXXm1RcPM7U8GvvVFQFZIVV036m9Yvw0k00Yl0Baw7g=;
	b=ciBQZDV9CWPOifo6pIvE3ksq1gDXfNO4P9N7Iv8D1l1Y2VviCPFlHFmP9yMZfwG40EBiUR
	luBwCK5/SbqgxPVbt64wuWWMwQ/heOJ8uUjLfxaOJCl1i7x8OVaTlSPIRBlBhaP/DNNQUu
	rsngLjJyiQy+r/mfEB10I2GW7vcP3mQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914650;
	b=GzUfcCQe4cFrSfGS+W8qZ2vN6l2PtpSWeUKyMR5SURAaN+pzqbHCTG80cu3ub4lTbIiLuy
	9SCmbd1uScMqUC74yyuw/5/rxw5N6VUaDEg4Y/QqTdbjbllX0nLE+WhVbXJLlt+xBFVbqi
	nTeo9uAvZke5ovje4KVyfyVLtittPvk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXXm1RcPM7U8GvvVFQFZIVV036m9Yvw0k00Yl0Baw7g=;
	b=rmtAqbjG0SRAUWysAdHMDXpGEzjeePaf8hzX/UHJt9JF1otuSo+rUmpKWOAkzQIzbdxiij
	belCOJfovcNos0eAnxUGh7B14Oss4xWiR1td/HPAxvrE+AELiH5vVWAP6aeKCaniVbmdWw
	y15Z89r0hefDLLBZylJIl3lVW0dZyd8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 09/10] doc: org.bluez.MediaEndpoint: add SupportedFeatures
Date: Sun, 23 Nov 2025 18:17:14 +0200
Message-ID: <5cdb0dfff2fef6a269b6e3b990059ea8966df086.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SupportedFeatures field for indicating TMAP & GMAP roles and
features.
---
 doc/org.bluez.MediaEndpoint.rst | 99 +++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index c1ce1d562..dd4f03e0d 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -299,3 +299,102 @@ Indicates QoS capabilities.
 :uint32 PreferredMaximumDelay:
 
 	Indicates endpoint preferred maximum presentation delay.
+
+array{string} SupportedFeatures [readonly, ISO only, experimental]
+``````````````````````````````````````````````````````````````````
+
+List of strings that represent supported features.
+
+Possible values:
+
+:"tmap-cg":
+
+	TMAP Call Gateway
+
+:"tmap-ct":
+
+	TMAP Call Terminal
+
+:"tmap-ums":
+
+	TMAP Unicast Media Sender
+
+:"tmap-umr":
+
+	TMAP Unicast Media Receiver
+
+:"tmap-bms":
+
+	TMAP Broadcast Media Sender
+
+:"tmap-bmr":
+
+	TMAP Broadcast Media Receiver
+
+:"gmap-ugg":
+
+	GMAP Unicast Game Gateway
+
+:"gmap-ugt":
+
+	GMAP Unicast Game Terminal
+
+:"gmap-bgs":
+
+	GMAP Broadcast Game Sender
+
+:"gmap-bgr":
+
+	GMAP Broadcast Game Receiver
+
+:"gmap-ugg-multiplex":
+
+	GMAP UGG Multiplex feature support
+
+:"gmap-ugg-96kbps-source":
+
+	GMAP UGG 96 kbps Source feature support
+
+:"gmap-ugg-multisink":
+
+	GMAP UGG Multisink feature support
+
+:"gmap-ugt-source":
+
+	GMAP UGT Source feature support
+
+:"gmap-ugt-80kbps-souce":
+
+	GMAP UGT 80 kbps Source feature support
+
+:"gmap-ugt-sink":
+
+	GMAP UGT Sink feature support
+
+:"gmap-ugt-64kbps-sink":
+
+	GMAP UGT 64 kbps Sink feature support
+
+:"gmap-ugt-multiplex":
+
+	GMAP UGT Multiplex feature support
+
+:"gmap-ugt-multisink":
+
+	GMAP UGT Multisink feature support
+
+:"gmap-ugt-multisource":
+
+	GMAP UGT Multisource feature support
+
+:"gmap-bgs-96kbps":
+
+	GMAP BGS 96 kbps feature support
+
+:"gmap-bgr-multisink":
+
+	GMAP BGR Multisink feature support
+
+:"gmap-bgr-multiplex":
+
+	GMAP BGR Multiplex feature support
-- 
2.51.1

