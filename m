Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878E4F68C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625667; cv=none; b=n4koYK9lm46QAbQdIfB7mL3r1zdjG2nBt5Wl2gpBrFD9I/WeDdfRXOcLve7HynG+/FUg+1yP8PHGPwmbZtDt34HcwLqkI/BN+1kMlTWr95ONuwLObSblLDp7J9lDk2LTxKiHKDWCAK5dtfOE7QZW0BQ5kLfcXQtbQ5W2Nkx1TeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625667; c=relaxed/simple;
	bh=ncqkUYW50ac0++iN6nTDr/JlZhpfLWfwrOoC6057Ed0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3FIz884rM+ykjqmPoCodyYukWg61w+cMnYGH90Swb80KWuasU3HcXOC2W7lBZCa75w0+mVEH1p51lChKoqb44cLj2EPB9g/IMW/CvH6c8wt6B7ZFIzf4o/1Mrivaxgq406lVR+gij9Sm1q7I9RsHQzA6987HsJdEWZz1LRVduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=op9NyMj+; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="op9NyMj+"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccb36d5a57so1800546e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625665; x=1791230465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=op9NyMj+doch9n6/2CHt1/PJ13ay9nBxl8yvoq6pHUGIhs1L02E3R5W9WswxMKFuxR
         W1x1ZpEdCvvEKbCtaGUbD/HEO8hjNBMD/Ok3yz0/xS5lkA/fBBS3lR+uhvZ+ohOsBX2a
         bGaTlpaPyujaLzdaAs/2epmB0vkaDgrDTlvuURpHjhXpkRrjc6uxNHvtb9BKRdpMyuTg
         IqCf+GiHzDJhSghQjdzSl5fXuH9Xwkau9kaNRGLGSLeGURyWIXdVCMvK5MADpyiiEvjn
         Ops5m5Z9Xc95X3KHve1r+nmV8Cplaho4ctLASGDJj38zehzX2dLcL+Oi+GvF3z0bz8NI
         f/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625665; x=1791230465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gFs3sSjC3QU/qGM/StIg9u+W7HIgI8p0VPqO4E/7wSA=;
        b=TYGi44Dnv/ntPSNzltPESzakQjL7BnKyWHwABAwaslvrqGqQb6Tn6TN5a0jdUQiwup
         +ACVWhAlbmQr9+EH17l4B8CP0RPRSJucm9g5XUqIoGSzHKVs9X8TD/l3lg/rNJQquUb/
         Fag9RmzN3z260GmZdUSTHtJ+3P7mVQerw6/p5fLXWe9tUAr4c6qVD8QlPpdFKrgnj4Ko
         CN/8DSxIkwwpv78DEarchGJka+/kYBdSb94qJwQ5hnHM71qngPybyGQ1/qi7YR0N/7mO
         TkhXBogZnTkQAMXG2+7/UHUhavAa9vv0aVXMGto5460K4ktjg+ziJI4lg7BPnIL+tUPw
         C/XA==
X-Gm-Message-State: AFq9FYKXlqjvxECHKH9g+0IIrHZ79TqXNcAbO6FtHhkVFtlgV1KviAFK
	pZjwjK1N1dIKXiMs2X153SSVYDozkW4OIuF5HiumykBV/M+DLDkga2Y5fld77QBpLgs=
X-Gm-Gg: AYBFou3TJX0Ej1rKqiynSH3/YsLtYxWe1EN2dKZ6XLyIaueERO1p/5dYAIWuEh6Lj1F
	UEP5Yp9d3uLCXzaJAFnrtw6YgRzNL+v4cb2+lRzd5HdCshVUv8yy+Gj4dN4umQXrLUfy5rOOwJC
	TOxwFn5jwB4DSpeGuD0ydzp4zHQHEJs+UniTFFuxFCAzuinLcOU7E0xqe8ldhx4HsbLrviUmxnU
	qvugi/0U9gjSw5CeCI7vVWgfPViXHHwLeY64WBv/txMly+a6uHpnjm8bwdEGXLZwew4FU3CdtOZ
	g/E8v9L2UJIt7qFqMsXcEBWs4KROqQo5owCb3ux8fCtMjH88wepcv4JlmrLOtRUxi9qkeFWGlck
	1Y4Uf7ABbOOlEp0tuShMPvO7GsrwKz+HnIhvF7nLCqSxPoeA1qhfyvL/rPgttwqG4uC/Mz4FoLA
	RDw4OzsQTqpxd14wDui+xB9Kd6d/vXmFF5iHkef4G3vzc6L8P0tJVR2FnKDGbRyE5k48yimI9UZ
	s3k+jkR04WSFttDd5tD3H3356Y6V56RX69+Qa2xSXEx8RtfdmZP4FzjY0xVsyVc
X-Received: by 2002:a05:6122:2895:b0:5c9:8bbb:3f13 with SMTP id 71dfb90a1353d-5cb08b3d4d9mr6057276e0c.7.1790625664414;
        Mon, 28 Sep 2026 13:01:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 11/23] shared/uhid: Keep reading when an event is not available
Date: Mon, 28 Sep 2026 16:00:17 -0400
Message-ID: <20260928200031.1209311-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the fd is non-blocking an event may have been consumed by another
reader of the same fd, e.g. multiple instances of HID over GATT sharing
the fd of the uHID device in unit tests, so keep reading on EAGAIN
instead of stopping.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/uhid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 36a16c331e83..20c55f63b82a 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -169,7 +169,10 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 
 	len = read(fd, &ev, sizeof(ev));
 	if (len < 0)
-		return false;
+		/* Keep reading if the event was consumed by another reader of
+		 * a non-blocking fd.
+		 */
+		return errno == EAGAIN || errno == EINTR;
 
 	if ((size_t) len < sizeof(ev.type))
 		return false;
-- 
2.55.0

