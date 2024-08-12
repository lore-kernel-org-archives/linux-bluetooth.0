Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F9192B73
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493189; cv=none; b=qSL5ZaL3SGbwQ8t9N4sETxkwp5plVDQWWi7MHE2i5oBkeeiVgxOX7F2nP7cUK34+XbQozOZAZvhOvHjiaM8dOE2YO4JLOhaSQhhbHawf7ZCoCV7m+HYZoGc7e0fDLvmiCK1x6Q7AvnXenSsbVZbm4yLdv+iQbPWVgP14XjO3rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493189; c=relaxed/simple;
	bh=qtsvxChxMIC5hTBLqI79UNcIXqp2H/E3sx8lqi4Jr48=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvmEOoAO4xclnOAjATHhNugSwvN4NVPby8x5HLqJ4cSvB3T4/Yit3NU7J0qPtlOQJJIVSXQB9OvH9WM/9Qxoj6mkTp2y1g081I2oJ7v8EUPE+WHP0Jv3Ck1rM2CQp9juHhbf5UTBl+VVw6DHF7XPNoJYT0QLds23vYoF/L9Yk7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR6fXa7/; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR6fXa7/"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-824ae03efbfso1220431241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Aug 2024 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723493186; x=1724097986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBLfM2vsHT4jLmgHYOL0nBvUKdRAPtXLm6VYAK2hkJ4=;
        b=HR6fXa7/jJMYwIWQZHLjwDA44RqEDyN0D+RzNRELrVGeDeHDG9VXDmAGiTxy/y5ITJ
         fG/xhRN1cPOmn2Gwi/VaDrQOQ1IDgdcoK+wZhYYt06sKW+Dww7sM6ztww8zTZSHSkL5R
         p0R9AONBGzW56hWOSkugme+qafJJ9Jv+JGMEXgdg5TCf4kZb0OvayBnWWa+SnhgLBlxb
         5gK0Vp5AlTLqZesZX+1L/5uaXHKC6GDGBKqncPYRbewCsaclQW3LpSLmSEyJXHmeB7F3
         OHakeOHAyPuKfHItc9PKIpBMRRe9bBy1Qi3QJ7p13oTFiXv9kwlVzcIcmbYp7Udq+W8y
         UmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723493186; x=1724097986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBLfM2vsHT4jLmgHYOL0nBvUKdRAPtXLm6VYAK2hkJ4=;
        b=We7Y7hEh6Gr5LfSyVS+Pet1RRrLlOI80DRJz9Dv3qKHFSMWtKS5lGvSOgMJKmY7pzY
         1Xk3r8t+Vcef9uDXabL2+YttjkvvX3k0dWVqqDjnQsBa3iWjIeNYVQtQl8KsEgUOi/wC
         6IrmvMr6FVaua3T/FQCJsqGKE3OLCNLjEyQ27rn26XE2cXzxct9HftgD2SNGSwA1ZCzR
         SYawmZUOvI7NE3vJi2arrFnYPpxxd0/gRGPI5r36HhFXaT41xbWHUXDihWhMbAk4txTN
         BVUjxEYklk8fY5OiStoEyCc1uGSlFTxJV+c57UjIUOmnxYRyR88JNhxrtSlRpFwukyDW
         x1Nw==
X-Gm-Message-State: AOJu0YyRFt0qUn+ao9Upq813LHfQMaHV6XXJM0l1/qj205btlt8Smj59
	rO7Jx5l3mPCAyrqH+COgxG/Nn/pZ6y2s9uDvRMdarf21rmDqdLY3aCb5fA==
X-Google-Smtp-Source: AGHT+IH3yPCBljcUKdXuyTgKVbaq+D9B08nTHFb/bBGWME3BgL5LUL4Mg30vNJsiVPUkqhT6nnn8Dw==
X-Received: by 2002:a05:6122:a03:b0:4f5:2960:6ca6 with SMTP id 71dfb90a1353d-4fabeebe9femr1909955e0c.2.1723493186494;
        Mon, 12 Aug 2024 13:06:26 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f91f2b948csm736133e0c.8.2024.08.12.13.06.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 13:06:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] shared/uhid: Fix not cleanup input queue on destroy
Date: Mon, 12 Aug 2024 16:06:22 -0400
Message-ID: <20240812200622.351942-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812200622.351942-1-luiz.dentz@gmail.com>
References: <20240812200622.351942-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The input queue shall be cleanup on bt_uhid_destroy since that shall not
be carried to the next session even if the input node is not destroyed.
---
 src/shared/uhid.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index b0a436d7862b..37574f75888d 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -504,6 +504,10 @@ int bt_uhid_destroy(struct bt_uhid *uhid, bool force)
 	if (!uhid)
 		return -EINVAL;
 
+	/* Cleanup input queue */
+	queue_destroy(uhid->input, free);
+	uhid->input = NULL;
+
 	/* Force destroy for non-keyboard devices - keyboards are not destroyed
 	 * on disconnect since they can glitch on reconnection losing
 	 * keypresses.
-- 
2.46.0

