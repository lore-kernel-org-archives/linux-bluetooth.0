Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C56217A
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801909; cv=none; b=qqS5vKdmjamnGZGeEyksp4/VMsODKBjlExMe7lIlVpp41gdQ+mEMjo8cG6DWz+2ZiraQAx+3LQzsfYcWgpo2ClnYlyhKlCzFzkij8RLrv2B3+coIxfh+BCYo1JofwcJ+pFQ4Z1xJL68F1/tUfH9VOhCJITIFUub6LoRowNDPUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801909; c=relaxed/simple;
	bh=J/kS8l2g9RZhxNAzKJ52nEU68D48vn31wNKus36nRsc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7kkMp9dezHNfj3wlvvXZzB6RabPcrepp3EU4N+k03+pE88GJ289Y4EK6tNKhNqZbtC+G+KJiUs6USDuNBJUQ4RrSVec663aQ/BPvOB0/B3ITLGE2lLXQLUqJnq+0oklsQzsQUyrJaAg7KL4q2KIdmYI4sOzqmPCJsfcWvASB90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC0bXsCy; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC0bXsCy"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4bd8977f1c5so417753e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801906; x=1707406706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HC5SdNvCWeKEwtYq4o6Mizban1zGXB05RzkUe4htxw=;
        b=AC0bXsCyOF0Ogn+91VcTv94xvFcSoNKcwrQMcrkW/IyRCR6Rr8veTqVl4Gx0rXBkCC
         LtNRxe99hKc9qLeXv3l7V3VqX43hdbNozI5C7TrLmev297jI0OG7FIKMhYy+95+4LUm6
         f4HFYaZMm3WBKUmQ/RQ+od7gCSnshBPWd1or1UMQxCXkvGgHp3CBRghh3h7h9ilR1BHV
         Dj5ZCWLFfF7ZG8PF7ZA7R7a+D2V4bTvdALZ/RAeOV2KsBwN6yObV7Ql7zwN+gLFePMZP
         6u1s5bqDOLjb8BseDwroDyPGZSUnvElgzBnEtlzacapUZKid7sDxSXjAUgeS+qr49hBy
         nRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801906; x=1707406706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HC5SdNvCWeKEwtYq4o6Mizban1zGXB05RzkUe4htxw=;
        b=p5rl8pSHI0vFYVmAuTYitclajeuWCUI82URt/W6Gf+q1oiBzQXgyEBWPpS06mYP65h
         SIvJqULTaRORuwCB0gG4jKrclquD7rB0mvoZaUJmXKLKu+voKJyWQ+5ZbTNm3XisrQSt
         dljfv+FqOyZTmVdLDn0j+LXzXZrrGSg/qWwYTY7/4CcjOq2uGajiIuvNMxm9gllCxE8F
         ngP60yucp1tufR0iJDo60GXDaJup+0s35yqCrCAYpJLS1n8Y7Hzv2sFtuRR5EU1X0xUL
         FFZQJZotNAgkIbTpN0Ml84NLG+ZFnmOx5h8UyKITH7t/jbKYi9U33TgzNYgBbkUUXTWE
         7Ueg==
X-Gm-Message-State: AOJu0Ywmv17+H2gZlcNrk9wxPwNuLP7dhG5qtEK3OwrNUcVBUuCVpOOd
	XQ951NOgCGIP5tYLJSech0ljWznFWKoHc4sm+gs248ga8aBUSBTFiZ/JUe9j
X-Google-Smtp-Source: AGHT+IH8e5UiSlZMl10l9BdjyjWqM7K0Vwzdu0FFdXqMWmCZ7iobK2iQR0Tf5ypkDJsovNJykzn71A==
X-Received: by 2002:a05:6122:4a06:b0:4c0:79e:6653 with SMTP id ez6-20020a0561224a0600b004c0079e6653mr764510vkb.0.1706801905915;
        Thu, 01 Feb 2024 07:38:25 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca5-20020a056122400500b004bd503f054asm1624586vkb.42.2024.02.01.07.38.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:38:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] device: Don't remove object if a service is connecting
Date: Thu,  1 Feb 2024 10:38:18 -0500
Message-ID: <20240201153820.1016507-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201153820.1016507-1-luiz.dentz@gmail.com>
References: <20240201153820.1016507-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a service is connecting just restart the timer to give it more time
to complete the connection or disconnect.
---
 src/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/device.c b/src/device.c
index afd073c6c2a5..1db96d9a672c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3276,6 +3276,13 @@ static bool device_disappeared(gpointer user_data)
 {
 	struct btd_device *dev = user_data;
 
+	/* If there are services connecting restart the timer to give more time
+	 * for the service to either complete the connection or disconnect.
+	 */
+	if (find_service_with_state(dev->services,
+					BTD_SERVICE_STATE_CONNECTING))
+		return TRUE;
+
 	dev->temporary_timer = 0;
 
 	btd_adapter_remove_device(dev->adapter, dev);
-- 
2.43.0

