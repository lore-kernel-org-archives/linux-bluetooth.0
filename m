Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031938;
	b=MaC0ahNFyp62zGr5K8zLIcnhk2JsXtkGILvln7hk9ovu1+xhjmXM9Tfw95GP/O4S3D1/
	 2MHySLIpnRgoiL0HQYG/kJp7SQOF6MZe/V+dUDhTuZfOk+dNgXMPX5vDAPwp93S/HQGyr
	 Y8/LjIg8qixoC2Q69+H5gGP73DD+32CJyOisHtW/AZTWBIJuB+eAeneb/oIk4jFY/FJKV
	 8SZp2mk4UIYBTHtDO5nXsy4ybS0ft+dsoRrEyFagxqzQcM1zMq7mRY+n/Y6p8MSElPUx8
	 bNo9y4e7yQMgkSClgzJibCs8YfRPNI9U0NYxxqInDCvoAxAZdZ4J8c/PoK6uDLZpgOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qXTKYjpFrai6v8rLGD0yMT2Tbvm8Nml9BdSrw5HdnKk=;
	b=wX0HUzuf0Tu6VGr7KyHs7MW8RiYMsGD/XDLpvQJh7mb4oSUT2RsBUYSXne2UGr46ZYVU
	 Ya+ayqiU+G1nH+9/UyqCXfFbd7foYJR++bLiNQseJB3pmD0k1XApFIV4Yu7LFQV9wk541
	 M+ItZdFmb4YTRGRjTTnfE5DeKrWk9SlYfZALqe4cUQT8TJiNle5QDhtHorvpdh1JJfMYC
	 HyfLZ6YwZGKCjNEuBAKvmpqqCpdps9jmcmCqmMV6n9HRoYkRAGlDy0UnxjvOIWW2lTOeB
	 DKsV1kEcqqHL2NCvk5i7s+iVSILYCgc1sUzanpIm5057RMP5W5b/4uHohbSiJCAz/7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8sgx+ei;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF1606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEF1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y8sgx+ei
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7cc0ccc2fddso519319137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031937; x=1795636737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qXTKYjpFrai6v8rLGD0yMT2Tbvm8Nml9BdSrw5HdnKk=;
        b=y8sgx+eigQGOfnWKxdKnmTJ5SyW4KnGJ1V4TrjnIzfP4IRZ2TvGhbkqrWZupGD3Lak
         aFKjT7B1J41ME9xdn/RErmnO0zc56SKLb59kXRSGcovfUVCQimxS/N95+cy80lakyR3w
         jzr6DGEl+RXngk61nY15l0ULV0oQc6SLK+zfWCpSmHT4omOzN8OVB2Rr3Dx+I28g9ybD
         wmLLuosYOxM2vNtYSB59SZW+DLPO1OqE80jGYhTPuS7Z9B86RO2c/Lz6zIPSdAamzJsq
         OgVUFwRrYdp5erqvqzMCY366RD/TK5qcSWbyfgW6TFeL05UHre1hhesPuzO+WLD58F0H
         Ad0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031937; x=1795636737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qXTKYjpFrai6v8rLGD0yMT2Tbvm8Nml9BdSrw5HdnKk=;
        b=d+D9gcCJC131cS4CBgB7HMxDGD+H75vHl1/2/8qgdxppDoL/MANQhd9jES578oz4jF
         IoezyAQdzkvhDVjAiEqUdpe2ykUqBfoc1sXTEYNJpSMz5ls+waeXoXnPfgIGBwbdncE0
         IOp5v2HOO6i7pfkWBs2gBYgc+kEIXIdJHLadtQEMlsmtgtAiZYJhlo7JW48JlEai6Eix
         9YOXMhX66N7NZkAUASNMV1pb2Uj78/qDmoOpzcxfP/kOTyVj8sTYC4tp7ApaW7zk/sXM
         4nyQgx8GbPhBRWDFoTncMT63sCv44WVGRPA6YtvL1y5T8O78ZnACWBIrMVXHytMgUPFC
         eqUA==
X-Gm-Message-State: APuU4Z8um5zMh47WyFkk9vT2RW9alZb+1s1FF5LSXROc4HC3KeyqOL9s
	sDIZBch0Ye0Ibq8jgqUhD+jmorWcP+xkuf1i+r5nNLKo6bUMCykMpWx2F8SSSunB
X-Gm-Gg: AYBFou0wRnjfozOy4+hFZcz28yQWG+LmObyHmIO10K40mSEtp8fjsMBG8H80Wuw0vjd
	1bAerHufovi8JztVmmgDUI6XGgnE/IsKeg4JbSqQoLMbMyomAGlq1voyCYsAYIStXvZ9vDzu5vW
	QhZI+z4U4AII+m4hlNcQeBpC0RxSzzy8xzkGBvuTKpQQyOhrY/qeWDPeF4EE6czGstgU1ZXD1uH
	8807pyAIShIYDHLG9iBNymGFX82CCOtAHUjCn2DPWgOKx+bKBjtTiKqwvu7Wpx/1rBTYW7fORFz
	t0SRvI/Yl7iX6N/QecZEgA05mexOoQcc0akw3T4mRQ6w89MOQSBSVt2QIK/8ue/0moLvxMfjlMX
	ITyGY+2G8oQjSEq0Suov0SvDX4IV4y7wHSZQMJzWD8Jv8w3QxWOuqM6Qxxorb7BmZBk2GhJtTD+
	q3bquIVRKFJQguYnTJ3Nm53wN+zQHqX3Bs/WY2biLo+a4t4eMoPfbD/YL9pFFTwdhP7m9grgR6h
	pTOmZECHgCQw1VOAm8QQvGqbo2VMJbGlcET3ToZj9YSpUubRpAIsV9Lywo3Gr0x13wTCmvYFUl6
	/n0scbHwOjPTH8FVUFvTcVYQZhRiRiZmpT1xyclBJkQwgiJgAHQLiuOpM3epI3Eu0B7FbhKMUB3
	NaV899yMwI72f0EnIuJmCB+ndnjBb8PnvQ/UxUwTSJRqL5GsenU/PauFCisjvngLaPppL9bj5g1
	YY0FQ=
X-Received: by 2002:a05:6102:3ed4:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7d6ba39306amr1734856137.9.1795031937175;
        Wed, 18 Nov 2026 11:58:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/16] profiles/ranging: Keep a peer-driven setup from being rewound
Date: Wed, 18 Nov 2026 14:58:39 -0500
Message-ID: <20261118195846.393710-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

The Set Default Settings response moved the state machine to
CS_STATE_WAIT_CONFIG_CMPLT unconditionally. A remote Initiator does
not wait for the local setup phase, so its configuration can complete
while the capabilities are still being read over the air or while
this response is pending, for instance when the local Controller still
has a CS role enabled from an earlier StartMeasurement(). Its Config
Complete now advances the state on its own, so the response put the
state back and, on an Initiator, created a second configuration.

Only advance from CS_STATE_INIT, the state the setup phase is in until
then.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 39b167ba80d1..1d59eaa6efb1 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -458,9 +458,6 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 
 	bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
 
-	/* Transition to INIT state before reading remote capabilities */
-	cs_set_state(sm, CS_STATE_INIT);
-
 	DBG("Sending read remote capabilities for handle 0x%04X",
 		sm->active_conn_handle);
 	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
@@ -537,6 +534,16 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 	}
 
 	if (rp->status == 0) {
+		/* A configuration created by the peer may have completed
+		 * while the capabilities were read or this response was
+		 * pending. Do not rewind its state.
+		 */
+		if (cs_get_current_state(sm) != CS_STATE_INIT) {
+			DBG("Setup already advanced to %s",
+				state_names[cs_get_current_state(sm)]);
+			return;
+		}
+
 		cs_set_state(sm, CS_STATE_WAIT_CONFIG_CMPLT);
 
 		/* Only the Initiator creates the config; the Reflector waits
@@ -1834,6 +1841,12 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 		sm->measurement_timeout_id = 0;
 	}
 
+	/* Enter INIT before the asynchronous capability reads, so progress
+	 * made by a configuration created by the peer in the meantime is not
+	 * rewound by their completion.
+	 */
+	cs_set_state(sm, CS_STATE_INIT);
+
 	if (!bt_rap_read_local_supported_capabilities(sm))
 		return false;
 
-- 
2.56.0

