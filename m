Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD32D592F
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360170; cv=pass; b=bU13Cr3GveJxe4yDxFLScszFUYu7YhPTjWscGhzAI+KfbU9v6i4u8uP8FfF3nT6nUXW+pFly8H5d95CFxPIh9giiPZTzfyeh96qge4e0mhS3ohK4e4VSl9NdchF4eKmy/vq8RP7dKvBA7YVuGodkJBxTmoHW+bC4O54CaI1QHeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360170; c=relaxed/simple;
	bh=MFyZzI6VHwVkrQoSKCM0wJqD5RsPx80CbmRpFm9aBlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A49G/Js2KlWBhaMp3/1Vy0HP5IyFvtbpxRkqvhT2HPdBpqmNrpiDM5+AYtQedpK4XA+PU31cg1uejcfFj5GogNGt5Xg8heZobTCCrLYhs0L/GWOGsmk+nuHiyCHiPfLdw0xpNRZr1+QtTX6hNqGMBvfSWX+UxNQxWEYm+x7DwUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VATUkPc0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VATUkPc0"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ4343vRwz108j;
	Fri, 28 Nov 2025 22:02:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqXWgBKx1cri5DdPiZin2MsXgbhD1jdeKvce3V+Gu6g=;
	b=VATUkPc03lFilwWRrMe6KMRCLa9rrGGqGKgzFA9OgFawG8SXQDL25TdYbBfLytVxyE5KEh
	AwFlaIlTGp3eg+5CTXcYPvEPDZ8GpnuqFdW2iaM0UbgxpFxHC5aTS+NFRjJLIHZJDrqlq0
	2MZCaQPzvnzJhRvIwzg5ExLwFwfDaqk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360160;
	b=OHn2aW0PHdnR9qXtrZkWNoUQ3Lux19SlNH3kzo6CH1nHpyeP8Lq79ZI11UpOyQFQBvVTPE
	Q0GoW1hew6mSfJGdKFqK4P8M3DG7d15AF1hC6Ghyox8tAq94VjsENcUYX8Hj/1zz3g3N3k
	P7yt7kcnpqJ327QWNZSf14lJs1s2ahY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqXWgBKx1cri5DdPiZin2MsXgbhD1jdeKvce3V+Gu6g=;
	b=OwB9zB4M2lp2vABoKSucCiPzOa1B/4B7IFjFgWJ1WX6WnIWcByBtSZ6lps58bdB7Br/U9F
	dSQ1VQMOHJGSRYlcYkx/sRHyus2F4Lp550wQaCP8Rvcl/jCaLYipgv8kfWDTFS0nOWlpSF
	zxmYzwokCZ2zdzrV60TBJCvMFBwS0RM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 4/9] doc: org.bluez.MediaEndpoint: add SupportedFeatures
Date: Fri, 28 Nov 2025 22:02:23 +0200
Message-ID: <ffa3e8894e8cf9af76faa4e881190069e17a64e8.1764360140.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
References: <cover.1764360140.git.pav@iki.fi>
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

Notes:
    v2:
    - make it a dict of uuid -> features

 doc/org.bluez.MediaEndpoint.rst | 108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index c1ce1d562..8202b2fdf 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -299,3 +299,111 @@ Indicates QoS capabilities.
 :uint32 PreferredMaximumDelay:
 
 	Indicates endpoint preferred maximum presentation delay.
+
+dict SupportedFeatures [readonly, ISO only, experimental]
+`````````````````````````````````````````````````````````
+
+Dictionary representing supported features for different
+services. Keys are service UUIDs, values arrays of strings.
+
+Services:
+
+:array{string} 00001855-0000-1000-8000-00805f9b34fb:
+
+	TMAP Features. Possible items:
+
+	:"cg":
+
+		Call Gateway
+
+	:"ct":
+
+		Call Terminal
+
+	:"ums":
+
+		Unicast Media Sender
+
+	:"umr":
+
+		Unicast Media Receiver
+
+	:"bms":
+
+		Broadcast Media Sender
+
+	:"bmr":
+
+		Broadcast Media Receiver
+
+:array{string} 00001858-0000-1000-8000-00805f9b34fb:
+
+	GMAP Features. Possible items:
+
+	:"ugg":
+
+		Unicast Game Gateway
+
+	:"ugt":
+
+		Unicast Game Terminal
+
+	:"bgs":
+
+		Broadcast Game Sender
+
+	:"bgr":
+
+		Broadcast Game Receiver
+
+	:"ugg-multiplex":
+
+		UGG Multiplex feature support
+
+	:"ugg-96kbps-source":
+
+		UGG 96 kbps Source feature support
+
+	:"ugg-multisink":
+
+		UGG Multisink feature support
+
+	:"ugt-source":
+
+		UGT Source feature support
+
+	:"ugt-80kbps-source":
+
+		UGT 80 kbps Source feature support
+
+	:"ugt-sink":
+
+		UGT Sink feature support
+
+	:"ugt-64kbps-sink":
+
+		UGT 64 kbps Sink feature support
+
+	:"ugt-multiplex":
+
+		UGT Multiplex feature support
+
+	:"ugt-multisink":
+
+		UGT Multisink feature support
+
+	:"ugt-multisource":
+
+		UGT Multisource feature support
+
+	:"bgs-96kbps":
+
+		BGS 96 kbps feature support
+
+	:"bgr-multisink":
+
+		BGR Multisink feature support
+
+	:"bgr-multiplex":
+
+		BGR Multiplex feature support
-- 
2.51.1

