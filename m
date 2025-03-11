Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AA1925AF
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741722154; cv=none; b=DadVlmlOS6DgHGEes8sU1Sx+No27+bZKRwsMYaCHjKQ4yhqvj2IEVnLSg5+uOGd9hR5qbPMS+J6FsGwgViVLaeZ3aBUgAEaN4rcklk9bTBysBZrwGETeo5z5gYK3AIzBbi+Qme1etnwsetr+diECqfrTkcFrDBESNIvZYpbP3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741722154; c=relaxed/simple;
	bh=Ko0jBOdoAo1AWjppLROAm9IzU4HSRjCAHiK8FUnXd4I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ESfiOqYovq9Iy5fmiOgYapO22SAfv0NRjpvDrMsyJbIRUsbe5HKFv8D1XJ4HzZrOzLZlv7SgIr//kEsCLorpwW6nAzyP2n0l5M8DiUd+n+TOiw2//xu0dosjxtyfR9xgPMbo6diWh0uufdkeA5jNDwxICzLmYgvpeTg5/LyTgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON6IoubT; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON6IoubT"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240b014f47so1148116e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741722151; x=1742326951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGb67eVF2sn+5/9mL9joqAT4qRJl+/rix//hkbz1ciQ=;
        b=ON6IoubTTVLjLFoRb4qErW95pPt4ZIfCCmEVZO356xXqVBygP+4aXZ3vlMYXHr9QUF
         IX27eohg5SMdvv8xpPcGZDPAjF5AqvYPJJRUUKbnwdmOmrNP93Bs/T1yB0gLibOI4Hhs
         ZtU/1Abg3UVJf+CIV08xRPkMrDPF6JpYfTVTObqyrOOSPVvsBZkjEXMuEL7oOSZsGwZA
         qEcH4saKWbuNeVOAFjb9SE6l/lFT3w7fNb7FRfUhK0DgaHgmaEtDUSGd81K+Fu2shVn+
         AH5S6HRyCzaHIfVp0UwMUN5EzhMiQs1DWcHZGZr9HiY43W7avY1b6HMZ6KIuxOh0bt5+
         hrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741722151; x=1742326951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGb67eVF2sn+5/9mL9joqAT4qRJl+/rix//hkbz1ciQ=;
        b=t6pqNZVay8swfCY+rKIKsT3YTKKG+iPDbx1/NTZBakZvymA/ElW/z1/4iKty9iKijM
         M8iEeMAcEiZwRxBCaEORRPDnOJdy5Mh19g//lIYNs6m9OHIR9WHiFLqPdCGDKsWM4KXO
         NNoJ89xSIHVXoYEb00flllm/j5lR9bsBcI7fQx3tCWzOJRO1Uj+ME8uvu91EXWFylp0O
         RSz6JTnifSddFm2Xl2P8xuTOzOsbhkAQHc0UlZBGZLRee5wFAanuxVDodPpT35JVwH5f
         NyzybrbvJPSJyg5ZzequjLytW+zXdUqRW1ctKaVmWImOUlgrZYfVLDlUyU4vpdsE9uDw
         qc4w==
X-Gm-Message-State: AOJu0Yx4k+0OjYq6BmHkDtM1JvXfg7dtSkv9TOtQgkYpAUY7DqIklw1U
	rkQEg7IIpfZ5sDA9a/Yth5J/nD/1lZIJkEwBUpsbf2nwiR+Ph8I8usk4PnTy
X-Gm-Gg: ASbGncvcp2ie7AHg9aRqtSTJkAkar9w34569tzenOVZfo1vuV9f44V/oJSK4ImKuRW9
	UaipaQpobD2gBqaKnmDmK9dqymIEN9RO5cYrqk4rvgAsjdZY0BmN2BMQaI4TaPfuq8DlCTOO894
	kCQB6zbK0XuR322QSPDZuuEwPWhl7S8zqis/R8BffvM+WNdrzbydVrvI0qBYgYrh4prlDeIL7wb
	ldd9Za03NpF96EtKmBX7wY+0SmnRKz3zX7oD/uCPmflS661oG5fW1o8cOnnpZLMqe+1GREt8PPs
	BqLyOp7ygFQ9C2LEbW4Vr9AsHKWfQRVojYhihaol2a3vzNkN4ofWcL2xH1tYcxqWs6M4BtQ/e8J
	S4oLqrZKTxrS+ew==
X-Google-Smtp-Source: AGHT+IGCRCQctMRdjf4MM45ErGtZGm0rqmb9VDsQnPlGCoGB0u2lO+JS1iYQVP2Ldee4BpDYTs6WmQ==
X-Received: by 2002:a05:6122:1696:b0:523:a88b:a100 with SMTP id 71dfb90a1353d-523e4130b2emr11942692e0c.6.1741722151374;
        Tue, 11 Mar 2025 12:42:31 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5240718596esm935746e0c.9.2025.03.11.12.42.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:42:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] sco-tester: Fix closing the socket
Date: Tue, 11 Mar 2025 15:42:25 -0400
Message-ID: <20250311194226.15109-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When writting data the socket shall not be closed until all the data
could be transmitted or the test times out.
---
 tools/sco-tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index e6888348bfab..b88631d89034 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -821,6 +821,9 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 					errno);
 			err = -errno;
 		}
+
+		/* Don't close the socket until all data is sent */
+		g_io_channel_set_close_on_unref(io, FALSE);
 	}
 
 	if (scodata->shutdown) {
-- 
2.48.1

