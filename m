Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794544070;
	b=g9phRFAsHNcMz+OblRtf4y+yoF4vHjnYuItlRH2YWCW3+mMgfdJ1sDRSxVD2y9VEXMdU
	 mYgQw6/2j38UHot0gUVuT8HTISxviQGTjg210LRPkC0BM6i2HJYskZTDSVS+MJCIHlvZP
	 vSR8CQ4d9I9a2L2rpuPBhtL6L3UqIGzzPdZDA62OF923+NwnBH//wQUz9p0jQkF3ceNy9
	 fa7EIW0lDcj/5f8bTj5Tp4dZaNsoC5CzUk9FTgo2JHp+ramad1EGcjbihxKM0WLiv5Wxs
	 PVZBPKznolKFdO3dw+/MRsTOsb2PIdlvPQ2rD8jW3xPsFJaxMeJK+XYyp0+ClVHorjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794544070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cjVPvOc2bHuLnURsPKm0WI/IKjtYH93wa6wvHqjM2uQ=;
	b=tD1piCVQUTj1yyC+lccv0nDdBiLH2wDdx/o5GaDay02j4XAKDQeTQZCMOzRRboR2HhmK
	 yLiN0VGIShCXyWw2lpKPSdVqB4MfxxVsoojz8f0SeBvzohvM7laETZFthTCpdK3S3Fdav
	 z5aSdhn72VKc1leIcqgMxjrGXwm28pVWGVvRtrH9Y96+at0WQbDSi8lMxqqdh20Mf0wv8
	 RmWTHxtR1rQ7RILbdQLsaN9ZkogWPIAMN17GLzG/9M5lDwK6pUqBjtlkpfz6DGdN68yRF
	 flOgoflwut6X+yfXTjdlhhReaKFa+D5/rLU4xVVz2+wtOuxuW1l90EEaOMS4D92OKQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=O6y8DlYq;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9216606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 04:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9216606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=O6y8DlYq
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2761c69fbso1233010c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794544068; x=1795148868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjVPvOc2bHuLnURsPKm0WI/IKjtYH93wa6wvHqjM2uQ=;
        b=O6y8DlYqkpbp3Jd4SK2NKrt9UzPTLEG5WGZ2C57qnDXD9ejSINnnJ9qeuVx9XkzdjR
         orUxaamFFum0/m3Iue2xJVYUxqVvnUD92BwK+v9XhbyTdVB0Mg/x+VSs4bAd/vXGp8m8
         Gv1VFVcu9voCJxQ4R9vObON00jtNZfahAU2Se4hocqTTf7J3c+h7cc/pKgTkKz1Tcjon
         SwGRkMWz7vj4us/dypljdTP9tVXjgWpOXAdMsPFv/04JBXx0frdzR/D3WgRwfxTROKoF
         aLl0WmMuekXMTK2TPYu3njZ5ZefGCsCrnI8sQxGDaSjrtyUjzwx9/d8QmvlzUc4Gj5eI
         7+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794544068; x=1795148868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjVPvOc2bHuLnURsPKm0WI/IKjtYH93wa6wvHqjM2uQ=;
        b=u2dS3xeTDx0qh5Bb+WaydqufNBr1NjjAyxiHVghnjCpMC/xWovwqGXa3AsWyAoCe3a
         esp23d2WIcGjMPkrgxChuO7wDpTbaIuaiCwihd+CqH/MCIL2dWLwEkzrZr/p0Nhainao
         ZQndf46c25gJCUTJsbX5U9+hi8u238kciHltrvMOVEu/hIUhgAAbKbpMYMwQFBBRIglo
         gPQyreb3WzjMCtLN073kp3QWIFlIRuRLc4GXjmaZ2o0qOdN1H4JEbTS/veTgeF7+RlZW
         aiGCMtVQtKx22mkqWxZKNjdL/rzbLwp7u8YEIINWd1/+focZWp7AlgOlJFMgWi1TmBpT
         PPeA==
X-Gm-Message-State: APuU4Z8owiSa/JOIURN+JIqqmDtabtRM2JcZLj/vmN9hKYv28GkamROL
	YiJrfYGvKJXxzrrpi5IRhsq0PEAC7RbwfQjr61ilxtcLkovb3fMarNrMFakVgHsGntyyiv/8I6B
	7a9KytVY=
X-Gm-Gg: AYBFou28ga84Ejy2oBoeoQGu3OzXzzPpuMoCXzP4flVX8GywYUV8XCJSewR0tC9AI2M
	vdDirj/D+iu+LYjhLz9Kc7aBHABcAppO45XAMEE9oIEp6zUBvYku84pvzB5ANzc9VhLEoSG+T0Q
	gRpttqJXxJbGcXKH9OdQrTHbXXPjImIk8RGo6NYcv5/u319XBsmgtwnLQt5GwWfdGlW342CLR4Z
	pJai5M4z2X+etZu/fDElKgwFQe/MlObvEF1p9D+DIX4AMcOdD6hvocKOlG5GMI9s4y1Bw98drDv
	qx8JROYC6qM8dL2hJaQDCNCwAELxg8pJEJsYDS3vs/2jPYuP+501FRaXvq5yM8C2XMce/lxPRrk
	rGOU7oC3pMRPYImu0DslevHXnaQk5NIk6caz3gMOVoDM1A50OLXU0G+CfqvUdh9cq6t22mxWkUH
	vMNsAQC6UXfBuBh4Cve7ZqmYSDG2CElGJSXzN3qT6fmWWJ2EtKDM+kLWf7HhM0n71xxX9j9aY1g
	ycY1Im5tJSbC5KSBZIv+tzcCY2sX8tdg2LFvo3PjlOWGLxwbqXP2PXKS8/6x9VNPfhym3/46KdG
	h1Nndd2O+W4WPPrSg9G3Y3ArMUN5OBJkDiaKvJlpuIxQGIbWA56o43ksZX6tl7axzD78uhd82xK
	pskVp25T8yut0qjPYeNPeuB2I0MIcFQIiyQiZWuUNXu0GPmvD5PyXbW1PhtFk9eS71Pa/dOc=
X-Received: by 2002:a05:701b:4213:20b0:1b3:b4cf:8f18 with SMTP id a92af1059eb24-1b5031a46bamr1600400c88.41.1794544068458;
        Thu, 12 Nov 2026 20:27:48 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm5109219c88.9.2026.11.12.20.27.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 20:27:48 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ] bearer: Fix LE Disconnect for devices with a random address
Date: Thu, 12 Nov 2026 20:27:44 -0800
Message-ID: <20261113042744.55832-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
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

Disconnect passes bearer->type to btd_adapter_disconnect_device(), and
the LE bearer is always created with BDADDR_LE_PUBLIC. The kernel looks
up LE links by address type, so for a device with a random address it
finds no link and bluetoothd logs "Disconnecting failed: already
disconnected". The link stays up, and the Disconnect call is not
answered until the link drops some other way.

Use the address type of the device for LE, as Device1.Disconnect does.

Fixes: 4e21ebcaa5d0 ("bearer: Implement Connect/Disconnect methods")
Assisted-by: Claude:claude-opus-5.5
---
Tested on an RTL8761BU connected to an nRF52840 with a static random
address. Without the fix, Bearer.LE1.Disconnect got no reply within 10
seconds and left the link up, 3 times out of 3. With it, the call
replied after 2.3 to 2.8 seconds and the link went down. The functional
tests use public addresses, so they don't hit this.

 src/bearer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index ebcdc2b4c..e5fc2ee3a 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -109,13 +109,17 @@ static bool bearer_disconnect_link(gpointer user_data)
 {
 	struct btd_bearer *bearer = user_data;
 	struct btd_device *device = bearer->device;
+	uint8_t type = bearer->type;
 
 	bearer->disconn_timer = 0;
 
-	if (btd_device_bdaddr_type_connected(device, bearer->type))
+	if (type != BDADDR_BREDR)
+		type = device_get_le_address_type(device);
+
+	if (btd_device_bdaddr_type_connected(device, type))
 		btd_adapter_disconnect_device(device_get_adapter(device),
 						device_get_address(device),
-						bearer->type);
+						type);
 	return FALSE;
 }
 

base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.54.0 (Apple Git-157)

