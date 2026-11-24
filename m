Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534754;
	b=R84j1LYdfvZmCndbC9eR85Rpg4RlDPTqo6m6inziyHUO+pAY9bwx4qIVi+3P7LqafLVS
	 2gLY+ukHl7AMLA7Rn9hx8Q9dBK0uKmJox3BOFjgshzxaPUsGuBlgDyZ7G+6snABrtItfh
	 A4HgInYsuj+uGder6pO0BbikFTTn6FXUaQaA5YordLMg2FY9fhE4Qh4ZQ5kcaVFD7W15V
	 /X5zaTmRgf3pdWeGNS9swVQk3UryXANLz2QodcIJSFD/gzRQLVd82bws+yj5hq3gBUv93
	 LgmPVFNQ39yml7fYR+WvbeR8WTEvxHQiDk5RhrRbHtVQ7yjg7ZUdZcOvGLRfrSZrsSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
	b=IsKcc4JSoW/Wcb923K6OvYlEdzYPpRdnXGJcUf7Fr6rh2xnr/3RljBfh1Uyy+w6gInQJ
	 zHmqbhLPNq7K9VLAFnGbmzyScyY6vBpx7tUF1SYboTv3X+WSUoRCSlM7Jd5WP2q81fd32
	 ztjc8WtcR7wooivJTHHNYS2ct/t6zyZYHv0BEnZXkLVMbkyneuBtwSYHlRiScu66IDMpE
	 2sOdCr9tolW7I1cbBm3zJq6GICo9tuy2vlnMovqKitq1c6Vdnkm9SP42XceoFiJczkkBN
	 h1LYz4z8RvXMvIzDVB79vXbcNqzV8Sx6lupOQartY3cMcyijMlaDQ6ogSeqkKP5GnWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+Bbzffz;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE5606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEDE5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d+Bbzffz
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99b49d6a5caso1326837241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534753; x=1796139553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=d+Bbzffzy54k/95Wl+vflRz9c+Ag2xjFpVFTj+0WV0Q7m/bKo4T8vjBLOVJAMreRvI
         IT+fjgTG41iDzgs3yhBcmCiucioWUSB8hgKvE2+LaU1v7ffQspR+CpZCqDTrsOS4GmHt
         s41377DcwZIv/Twtm4+CVMrTkxOrmFnfdXiRpA7JM5g5FRRoHtrNBFJ/0qbH9lBnC4pH
         Sx47UzCisXGO3oOulLLfcZ+e7EfJP+jTLaeFbBb66wmIn9xxZlMcGhD8VTuZ8P3sEPZ+
         JtdUz6uB6hRAgbA2oSthQfUdsSKduCC0NM3ei3WyVd54ElMmZF5Alaop0KC8c7uwlzNO
         5Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534753; x=1796139553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=CSVGfBaspsAkdRQ+WuFP+hBku1pAaJM2bqz6MER0iSxrlk1hBY/p8U8dAFVXfs07//
         sNfTHMiM6ZHuRl0tOMsVSBQfT0nh7tecU6CQ5RLA5wLMpCMleOBKwSurMsQY1uOdmTgm
         jcvCDVfShf+Zl4B2T1t052Hda3t6uQTzTZ+VZEOX6nk6j2eGRQkzZQfhBMBzyVVJU0OS
         i7Ei7DyWpvKfb63QkA123fCQ8pjOMGU3C72C0hM9pxgyLkaEGyaD8EJJYFcIb/q9luol
         5zmCfeQGJCDh+7+CefWqD5IXVW63V6UTR7FtesT409fyYZhbS/7jfL5b8XsfztG0jtzJ
         pj/g==
X-Gm-Message-State: APuU4Z8f90Bwb5jYJASzY32Jq3bKwch1MREduEH3cUzUmv1C/sENEolo
	Qtfec4DyiwdlMcLrqOIoCKNI+gq9rrwIiBvpblw16NAAbNcSr7ujTuvcFd2ktA==
X-Gm-Gg: AZFdTZc8d8R8h2wtDh8ovdqsxD2bhskZiaKXx2KXgg0bHFsF3t3tMhc9slxlADMu/hr
	dnIACwstroN4Tci3DS+zzuJU30jXvHmvBiPGBwi312N5EhBdNEE2VD2vRmbSHKCx4zkc2NESZ90
	KZ3mTQaI44XfkQVghfSkOB51YwVBWwsSuwHhod/j52qDIIoo29VgwBVhDz/dmCGhINog6gIgduo
	RHd9vjAqHOcIV/97OqxmDPYCfMuxdr1z5qfJaznOyRC+tHKGbY60rQlX1vdERRV0wQzS9NVSd9v
	RhnZq7z8nzLe0/lLMvI7QVHTV49j3GGFZBrjnJK6Yeczz+eaO6kXd0SQPYkOaU3Mf0rEbt8esbw
	Yp9ClTd01j3pE5ExPXp8TK6qenHTxEf/bWdR/9H6xfDX81/DAh/j+7T6WOifBYqT/QDKAm1bKY/
	Ol2utuOMbJQat4v/vBtD2OS80v8eH2dTmeLxGGHN8NVykNWSUBq9FvfMlpByV8R3qXe8nSZrQEM
	ou+Q4YLGpfQJwzfyEhVSf6AjNcPORKYc910CSfby7O4dfqtQYBcTKI84FeZSpSrSE+IS6J6pnSl
	vsAw7N8Qpst2/k/R6xAdrL3u3nriyxKFSe+jSyqvWzwQrXLKpTM/tIZv7UxCIqI601YveduFPP6
	f9yt65uaSv1S2n8vPFhToZ/GzccTFpyFFnO2cHY37XjPRed9AnusSPT0EnoHTsCmYxDJDRQqi3g
	ONhsI=
X-Received: by 2002:a05:6122:9003:b0:5ec:41df:f110 with SMTP id 71dfb90a1353d-5ee8af6c74amr7449523e0c.23.1795534752640;
        Tue, 24 Nov 2026 07:39:12 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 16/18] shared/rap: Start the Real-time timeout when the procedure starts
Date: Tue, 24 Nov 2026 10:38:53 -0500
Message-ID: <20261124153856.216054-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

RAP v1.0 4.4.1.1 requires the Requester to disable Real-time Ranging
Data if none arrives within 5 seconds after starting the CS procedure.
The timer was started when the CCCD was written instead, which can be
seconds before the procedure starts, since the CS configuration and
security setup come first. The CCCD could then be disabled before the
procedure had a chance to produce any data.

Start the timer from CS Procedure Enable Complete when the procedure
is enabled and Real-time Ranging Data is subscribed.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index bc6f133b5da9..d4ce1751f052 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -411,6 +411,7 @@ struct ras_ccc_state {
 static void ras_ondemand_client_reset(struct ras *ras);
 static void ras_realtime_segments_clear(struct bt_rap *rap);
 static void ras_ondemand_cache_clear(struct bt_rap *rap);
+static void ras_realtime_arm_timeout(struct bt_rap *rap, unsigned int timeout);
 static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 				uint8_t opcode, uint16_t counter);
 
@@ -3352,6 +3353,13 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 
 	/* Store procedure enable config in the session-level template */
 	reqtracker->bcs_proc_data.proc_enable_config = *data;
+
+	/* RAP v1.0 4.4.1.1: the first Real-time Ranging Data is due within
+	 * 5 seconds after the CS procedure starts.
+	 */
+	if (data->state == 0x01 && rap->realtime_notify_id)
+		ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -4643,9 +4651,6 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		rap->realtime_notify_id = bt_rap_register_notify(rap,
 				value_handle, rap->realtime_ccc_value,
 				ras_segment_notify_cb, "real-time");
-		if (rap->realtime_notify_id)
-			ras_realtime_arm_timeout(rap,
-					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 		return rap->realtime_notify_id != 0;
 	}
 
-- 
2.56.0

