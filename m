Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344105;
	b=CweGPNpztijLl6FuK2MOGtMbks/7gZqPW/qCeWXOX5icpk99tbeT7EG+mSAY6Ey74/eO
	 EgseBmGoeYEbbvGhSxdRJ73nIvX0AJDalgk3fAf4IkTc9kcCREt9v+leEZIqP8HGiyOo5
	 CUMggOOVS+++Eq+gacCNEH2GmINry3TntWjBgt1Ki+vd1sm3oi7dwMH5Lclh0oJYHIUWQ
	 MuMvIDrIBE8czPIyjabBoVFndsoBye5kE9pF7eKce9uAfCZ9hlfghrnOTwdVM7CxLZQ2j
	 USGneKadk+5DPknl0CKoM83m/vWANCxDFto2YSUv3EGb/aXgWrTOA6Mim6uDsQglQmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Cogfy8qK9tyPBwJJx2dtQfE099xK0Fuh+OXXgeWjZBY=;
	b=MqaPoaQJuiKSVnFsEZ0esvZLMUI5tnaiN5KXbjqpDkSSpUPSWhihw51W+N2zB6SB0SdY
	 N9Ryp/UXu3bx33xu6z5bqMTqxbrPw+EeGkFL37ptZU0LiElqNDZztLZm8ypDmxLuTs3mt
	 /P1Yn2DGZjosgceqaN8G7VH0JX6qH5clmEfVFvSZyfhH4jYkuTToA+hq5DpxCjehJsOGt
	 Dmi2yjTCxEBNO8mLMtPyvUjluEXmACPKh6Yc8fpPATLf95R5OtcmlcFNecworGsCjOvbB
	 qUO4D2UTx/SIrhgef+XvaJz6MhA6Dyp5hNL42xadx8CfRsczPgvNftcTDmPgX6yujTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="fJYlX/Hy";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571B606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8571B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=fJYlX/Hy
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so22155715e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795344104; x=1795948904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cogfy8qK9tyPBwJJx2dtQfE099xK0Fuh+OXXgeWjZBY=;
        b=fJYlX/Hy9I6tLJVecsVLSiGUMVlx2DI89k/8jz7t94NQAZhJDzQ5kHFH9a2S9Uqxiz
         ZIjKhK7FRF+gy9eTidS41hKDJ08F5bUE+leEMIt7e8B1BdR+jCcKcxluIko0tj+h9+68
         P9YnUlT/gRqNGVEv9NBzpBT3o45zDbarOYNkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795344104; x=1795948904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cogfy8qK9tyPBwJJx2dtQfE099xK0Fuh+OXXgeWjZBY=;
        b=JQFtk2waAj1XVCyS4KnpHRFvuHo23FFb4SqCyKWUE9HGuE3EgBW/+beK8cLUJEZp/X
         5a2Z5T8HSYa71mui+2iIfYwK7+dzXIrdbu7WFXHKBSWrwLQ1VCLvEdDuhLI+caflqX4h
         Qj5SCALIspbtKxNxlACijcQwM6T6nL9MZEdlvRb9UIee9uG8aENKr0LqQMrGRLkIScAj
         BDsgdWzzD8GRZ7dwEOu8qhnNrrIxNsXNXXzJ9zDX6pZsNoLfIHy5+ZUG0xmH3EryUnYf
         gGFbKSUXo6oECCRsFZvZ6dY66GAu5t8FMbWfKR77V4xITEYLzME6r/32LsV258LllaO4
         z3hg==
X-Gm-Message-State: APuU4Z8U3ETjr1kSOEmVHuXe3VBgXOEU7ilbnUx3Rn0vEZjPMQrm9tqr
	x6Z8TVf8+84Y0Hjjb8CosaMBEHaTeY35OJXmZ+dxMb0Q51MPVSWYqrYiT4JvvmgV8XghrzuKoPn
	YPz9Z
X-Gm-Gg: AZFdTZfiYonsonguQ//xrzQ3VGzlF2r8fxJCk4AFdvg6pxhdJ4D57H8acCbX/h9J+S1
	rABGEkumponnhd0zl3XkcL+I0/frWq3H0u+dfnEEIxBnMTzGbxDYLbAqet/1GZ9jnoxnP0pvOPT
	YTNGKPlEq3cKxT/0jKnteChWFAFrLr2k7sxvzzp3y7h8pOn2s8gxHdORRENNNgyhm8GSVOsGznD
	CfJlepxHtV5v1Q4FCxi3nPrUF5iUMexprTnsuxELAf0AYoHcswJjKwNaE/82GmWU+Gj7F1Vf8SN
	AN/XznBwxqQXQ6zh/3FBxsDM0CRxtaKJBML7HvXAAmGLHMJja/zZK784P28k61M2oJm9Ic44Fge
	zoLo8mJQ6WGgDW6QBXZmsjW+8mmdJJnXNqY9GiC3eKGqniEeSM9JQ8E6xVjdQecb5BA+lz+uDDb
	oYUubYYzShhaSVGftHAkaukRvTM8LwuOK+hqrSG2n8hBfUHUb2x0voJPMau9Q1m/c2FssvU/B7G
	KbVION0ghpI6ufTvOh8XzkpDBHob64xgD+D4i1l69LHhaFfCk4LwVl52Cb7l5dDQkvqQCyaP9Qr
	BkhT/VJSY9Nxoql4ppENlZp9XoBDxYao1VuIFYP/DKxRGhud5xOg8yhJBES/WCPNbhteCMQ=
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id 5b1f17b1804b1-4bb88817d91mr190578635e9.23.1795344103912;
        Sun, 22 Nov 2026 02:41:43 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88f148aasm96235895e9.0.2026.11.22.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:41:43 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] adapter: Fix discovery filter RSSI and Pathloss matching
Date: Sun, 22 Nov 2026 11:41:39 +0100
Message-ID: <20261122104139.714101-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_filter_match() takes a device as close enough if the RSSI threshold
is unset or met, or if the Pathloss threshold is unset or met. Since a
filter cannot set both, the one left unset lets every device through.
The Pathloss threshold, which the kernel cannot apply, is then never
applied at all, and an RSSI threshold only as far as the kernel filter
goes, which holds the lowest threshold of all clients.

To reproduce, discover a device with an RSSI of -60 dBm and a TX power
of 0 dBm, so a path loss of 60 dB, with a Pathloss filter of 59:

  [bluetooth]# scan.transport bredr
  [bluetooth]# scan.pathloss 59
  [bluetooth]# scan on

The device is reported anyway:

  parse_discovery_filter_dict() filtered discovery params:
      transport: 1 rssi: 32767 pathloss: 59 ...
  device_found_callback() hci0 addr 00:AA:01:01:00:42, rssi -60 ...
  device_set_rssi_with_delta() rssi -60
  device_set_tx_power() tx_power 0

Require each threshold that is set to be met.

Fixes: ebcb6aa7c527 ("core/adapter: Filter discovery results")
Assisted-by: Claude:claude-opus-5-5
---
 src/adapter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1439642cb..2f2832a8f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7610,11 +7610,11 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 
 		if (got_match) {
 			/* we have service match, check proximity */
-			if (item->rssi == DISTANCE_VAL_INVALID ||
-			    item->rssi <= rssi ||
-			    item->pathloss == DISTANCE_VAL_INVALID ||
-			    (eir_data->tx_power != 127 &&
-			     eir_data->tx_power - rssi <= item->pathloss))
+			if ((item->rssi == DISTANCE_VAL_INVALID ||
+			     item->rssi <= rssi) &&
+			    (item->pathloss == DISTANCE_VAL_INVALID ||
+			     (eir_data->tx_power != 127 &&
+			      eir_data->tx_power - rssi <= item->pathloss)))
 				return true;
 
 			got_match = false;

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

