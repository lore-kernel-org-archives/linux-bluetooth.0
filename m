Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737114A4E7
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897305; cv=none; b=Cx3i6EF7k8DlIRKDE5LExcUXNSc1fLb8YAEh5TuAT40BgUCdZbpvUQ1zpviS1Cd77f8X6ZXbcQNUG/SN6wntVAf/KS92fujYmh9WGmphq1GhbG+J9S50ZyX3O21MRMYlxryockAyqc/aiskh6BI1QLE7EgCVMJioa4np1Bc4ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897305; c=relaxed/simple;
	bh=noVu7Gz9T38iHLFsn3sDED8wsSDVBORKOfktNr1tIao=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rPYhFxua1J7lY2GblthF63rW6Psnq05UO54S07DVHaN17uCuLYDOKq2YkDALCHhe13fQr3tiljFleltVRLkxx2KhXUQbo2d8aY+I+4WqL2QYc+A6w0YSZeCo1mr0LGlNvmP9rKEaBhbqYrz+XvCgs9bgPuBLsV6d6auTdAnlsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2oXxDhj; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2oXxDhj"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f8c58229f1so47367757b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 08:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897302; x=1740502102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=USJegm9LXZqon30Gz/CP8nemmFPUenQVXm8+2cllYQ8=;
        b=m2oXxDhj/3opZA4JbKMpdYuJHpUHgRAph0O6yW3rhoTC9vxAxhG6IhRHgmo9aMI6kV
         einMHmtY3yBr8pRQbGp2p+fkiLYNEYDpzQSrxHld9U+FO7HFDFen3xnOkZ1NelaDvTL3
         wdUladHt9P68xOUA9VbaI6NNJyw5Vx1FejmDTDIIer+JxrrIiJSx2eA0GSkh0lqWnqk9
         MjBTXrYcGZ4uMwMJUuMoRBzigs/o2ZIHV7OCTAg1KkG3xlBflWsBX6OCqshzEuoOOWva
         xcEaqWfqYQ5CS2oM3STSkNJgnr711MK7Gy8N6Xwo/KeRs6rkpApnZfe/G/8jOuLJ/6Ud
         k3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897302; x=1740502102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USJegm9LXZqon30Gz/CP8nemmFPUenQVXm8+2cllYQ8=;
        b=S3sNxIgh0fkf5gjtGKqsvagk52YkrB18fLkIz9j2azscggI7LsHZfzEMQSqXOTMz95
         od/AE8nWhjj/K55xa7DkR4UbwHoXQdoag/xk/C4RZOrE79iyEFzj4sNyAvXe59rM89QF
         TklkodcO3a4yNl28bHgfbzbnYFkM3oftQek/hE8/EKw0nFZK4s4Hzy61dql7CJ6kmzNO
         IfnCRdEHrE5buWWcmaXQx5G9qHsPDiNO2/G17PHom5MotZ/s42EV7Bv5w9oIm6PdXCrX
         YjTNHvSXiLqWpU4G3YqShCzs/45LcJsPuS8fyHZhBinbsxYRklWUo1E29MAKB9jTDdeW
         KaQA==
X-Gm-Message-State: AOJu0YxjxETeK5goYFiJW+fPOSWmR195/hqRs2dVT2QDpW7lNaYc6QD1
	Qr8aV7NVIvn3oYga+Vk/LdDHZ+i/KGte3QyfY4vNejL5+t3sUOoJQh0K4Q==
X-Gm-Gg: ASbGncthp5I+wh+zUjNgY2cwuilj/3fACQp46bAypzlz4Ti65O4sM9M08wocpUQYfez
	MYKH0wnc/dQ6PdW4dvmN4+fJ3+nn4H+nLhIu2UNYdIviaVjNWBJfqUIVzHDQ99gLvX0+alrSFzU
	KYUksm64bWX8GWCsONGIvF+7z0nA3x1aom6ICIHVmSXobqqrST16guAIKQLtNiP7yRMt1FO8XYY
	GgwwRa6ijp61XQMdwZJJt2qeTkCqmNjMx5oN5qmp6XwiS5a1CoCBhrHDn3936pG4fueB88QCJ6T
	7XazEEgb0zPmkDWEQNFRSc24crxAWT3H6k5XgKftBk9m0C656eHBUiH9UmioIag=
X-Google-Smtp-Source: AGHT+IFc6dw0DvA1/1VOAKDuYgoJyVzyiIXU2v2Z3juPVUCGXXz+4ke+DJLFRh9BDHgDEq2XCgtYqw==
X-Received: by 2002:a05:690c:28b:b0:6f9:4244:329f with SMTP id 00721157ae682-6fba5158894mr6034467b3.7.1739897302520;
        Tue, 18 Feb 2025 08:48:22 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb7ca441e0sm10644847b3.100.2025.02.18.08.48.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:48:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor: Fix crash due to negative max_len
Date: Tue, 18 Feb 2025 11:48:20 -0500
Message-ID: <20250218164820.1458561-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While calculating the max_len for printing the packet details that can
come out negative, so this discards extra text if that happens otherwise
it can cause the following error:

 Process terminating with default action of signal 6 (SIGABRT)
    at 0x4A800F4: __pthread_kill_implementation (in /usr/lib64/libc.so.6)
    by 0x4A26FDD: raise (in /usr/lib64/libc.so.6)
    by 0x4A0E941: abort (in /usr/lib64/libc.so.6)
    by 0x4A0F7A6: __libc_message_impl.cold (in /usr/lib64/libc.so.6)
    by 0x4B0E3B8: __fortify_fail (in /usr/lib64/libc.so.6)
    by 0x4B0DD53: __chk_fail (in /usr/lib64/libc.so.6)
    by 0x4B0F544: __snprintf_chk (in /usr/lib64/libc.so.6)
    by 0x11F3E6: snprintf (stdio2.h:68)
---
 monitor/packet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 2eb50896b55b..b186431cf135 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -490,6 +490,14 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 		int extra_len = extra ? strlen(extra) : 0;
 		int max_len = col - len - extra_len - ts_len - 3;
 
+		/* Check if there is enough space for the text and the label, if
+		 * there isn't then discard extra text since it won't fit.
+		 */
+		if (max_len <= 0) {
+			extra = NULL;
+			max_len = col - len - ts_len - 3;
+		}
+
 		n = snprintf(line + pos, max_len + 1, "%s%s",
 						label ? ": " : "", text);
 		if (n > max_len) {
-- 
2.48.1

