Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121570;
	b=0RMFi0YLiU5AWI5tAQZeIwTxHWJe3Gd+estuO3ACPcdRfUDvSWxftOvbgXh5Bf9BRrk/
	 cD+uRxnty72NXt+u53U6yJ9tyj1cRpiObFAfcX0G5k5QZwBnY8dWHOKVfpcc9gJYd7AYE
	 MX6j3mqY5I70auNLA/GVXK2LqhQeom71RGkx4HdwbZl79mh9/Pvbk4Vt81Or27p0IPj6q
	 Sw6eAb9VBSvr7UeAbz+8WU9/h4FePNRIh3J/nMfuVW6QZn+ZjKFHiIFh+7ZaM1pn9kvdT
	 Wwp5QuxyQOKyrDfPAJwFL2AL1KnzMuW+/lSlrp6iVfCpXL5TGHRRrefn3+MQqD4eHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mUJarnHGuHw1qhdcWFBNiRFmEhMGkFM6O2XZqqnPcrU=;
	b=4k2ou2kupMqftGz1pZj/n8SwWaH63GFQ5OikbuEcSd+CCJKYAx87dyCe7jTTQ2bTr/un
	 I6ZK8TcFu1vq49ohC2cwoj7GaClcs1RwmeiUL1/wbqlPUYpv5qSc4DS8uoQsdawYRc6US
	 DQ5BCOa6kuTFxX+A9O9VbXUZG7+ln7A4pAF/sRIY4uA9Zdc3dahzh0mbYRILrYG86xBvJ
	 38HUCy/oENLx4L9DBLBC7PYQuZ2gksw0xDpOHp2TbMlv41JrL9OQ3tkxZVPfwTi89uoAJ
	 zmH8bBFqZDjJLBAkXnryTV28wiln8IJNNl9bzsmAei3lN0ehnmZ1DtamXcycu/KFP6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=nC3lzQzr;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09845606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 17:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09845606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=nC3lzQzr
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-181516de561so68188c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793121569; x=1793726369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUJarnHGuHw1qhdcWFBNiRFmEhMGkFM6O2XZqqnPcrU=;
        b=nC3lzQzrroNXynuPSosh/mApytTPpuRDlSvA6zPzvIIZSEIe+EnlQw1eueXlEv5ng1
         ByjeigN7ZFrlS5yWi5+Zv/zqedg24GEQJhuGEOQhZCNIvNA5hH+Y2jrq5LwM3F2trenA
         oiQwjSM4YsNbwEGbpZL66XkwMefyeS+R2IawO8+kaW9jvig7vhkEJucwa4IeVvqw1iPb
         83thN0e9dK6raUY0B2MoKCjP7Pmgf2oAhezO3GMXOFPOr3t+RX4zQOdMTO+HZ8FnHlbN
         7Cpwx+DUaU2PXiLW0TgRVOz13XaoZPbZlJmH5zSrYNAfiU10asEIykaHY598aMFHSs1a
         Hy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793121569; x=1793726369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUJarnHGuHw1qhdcWFBNiRFmEhMGkFM6O2XZqqnPcrU=;
        b=0mXppoR7GM5nip/ARBqh3iMwvH2nDK/j4AWkBjcRcaIUCpexoVCifZ+d9nhOtU5gbb
         zhrnUXpiqOip4OXHmc16WboVnaX40N3xaUuqEHazVM2PckliWcBIOukFVvs70pEOxIKm
         VRtXxx9VFhvDQ4Zr6Bg9JGkCtDgRL296rX4VWNeGVTZ608RmGssyf9xiEUePPVoF6IN8
         NOdY+JjHSPId0kdQeEQaVUu9okauJuEiiBLaciSaNzax8Z6gmUOH0S1kdCVu7nuJyBMK
         fZmbhEv7K29YZpPH1iLQIAYqP7iAXyJ7yQyDbVzx3b2PS42VI3XKbPdRsoqMGaH4c+dX
         8AQA==
X-Gm-Message-State: AFq9FYKe2v+FhZLMfoETKwj/HmWb9tAMpxpXmwX4iiYFFWhAs2tH/7sk
	NBQKIkIVpXEKYaC+LipUTa9i2jKA5EEUH0iwJFt2xgE+XCceBTTjn3xcNU0jbK9swkDLuDkIebp
	c5exWmfXZfg==
X-Gm-Gg: AYBFou1bIaW4xN4j8G0CEf1WhgNWHCDjyVyxrEechtflegIHx3CbxJcr8/yghXE9d4v
	LpC53NY7x0zDb2Gw+8w8n48Sez8a56npbzS3WIWge8oUzkqMoZdY//kq55KMqFrfxlcmg2H4HEx
	rESy5iTrAkjP0JYNT4f8OxwS3YHJQJsRMUzjCdlq5OHidS27BBCAUCr9uUDPYs2bfIWPRMa83xz
	IzYBoysVgsQBgEOxOOfTtyvRc5CEy9FYnCjoZwPl22pe30rnR0ye6GiYdWrALs6JP4++skVWxHF
	UzPesQMARwGfpWlKKm64mJKdVZVB3QelOssksDRCGNFPwqCNmImS1ztEBF9+pRbtbmy4D/ixHSo
	i/XWpjgMtpUNzqvnSXRtxp1CtWuhXjtIax2t0isaBFPn8COM3CGApUm9AYBZYeVN0aWeZ2SyCz+
	fKPxD4aTbZp/yxJX5IpuEnaKX3ccXQlZbTKilBxaffXsEwKxSV9JATS/atUI7tJ06Y64Ijxzgib
	8hdeYAP1S3nymBkCjyQDdfDefQFLSVNX0UEpS7pRB+cBXCwygqaj7Z83zcoozvHLLVbDPR0Ghsb
	VxBLkhmM7GsPpchSWfqJ1hXltkRuWaXn1Vbp2rbmo0vVaq/jlXJ8PF32cVujZrpqhwseJmYIC3U
	uIJbMY+k5sCPtT2ofqTr1wA==
X-Received: by 2002:a05:701b:450e:20b0:146:5f73:d45b with SMTP id a92af1059eb24-1a3c3240343mr4024023c88.3.1793121568897;
        Tue, 27 Oct 2026 10:19:28 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaebfsm34440562c88.15.2026.10.27.10.19.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 10:19:28 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/2] adapter: Fix Discovering staying true after a failed stop
Date: Tue, 27 Oct 2026 10:19:23 -0700
Message-ID: <20261027171923.82919-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027171923.82919-1-kevin@simpleble.org>
References: <20261027171923.82919-1-kevin@simpleble.org>
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

When Stop Discovery for the last client fails, for example because the
controller times out the scan disable, stop_discovery_complete()
removes the client but keeps Discovering true until the kernel reports
the discovery state. When the kernel then reports the discovery as
stopped, discovering_callback() only triggers passive scanning, as no
client is left, so Discovering stays true and the next StartDiscovery
with the same filter returns without starting a discovery.

Clear Discovering when the kernel reports the discovery as stopped and
no client is left.

Fixes: c1226f79ec97 ("adapter: Fix not checking status of stop discovery command")
Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4d753028a..c8889bee1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2146,6 +2146,17 @@ static void discovering_callback(uint16_t index, uint16_t length,
 	 * passive scanning attempt.
 	 */
 	if (!adapter->discovery_list) {
+		/*
+		 * Discovering is left set when stopping the discovery of the
+		 * last client failed, so clear it once the kernel reports the
+		 * discovery as stopped.
+		 */
+		if (!adapter->discovery_enable && adapter->discovering) {
+			adapter->discovering = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+						ADAPTER_INTERFACE, "Discovering");
+		}
+
 		if (!adapter->connect_le)
 			trigger_passive_scanning(adapter);
 		return;
-- 
2.54.0 (Apple Git-157)

