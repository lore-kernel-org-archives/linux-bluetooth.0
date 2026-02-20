Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6593B7A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618518; cv=none; b=ZbJVH/pX5BtqeEuI1qp3K72DXmXxqKmge9JULQoWKyV9CQJsruGrE25ZwDM7314j3bTlyatkZdoF5WgInsX9rRHDy9o+9A3izDEVSrfTIH0s3yb7mul3dr+AusgVhnkakd81qi9SRK0YD0kLly4b+E7HPFuKvchoLSeMIK548W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618518; c=relaxed/simple;
	bh=NOyxWwwTDAVG/jpwt7yAtso0S3SRbEs0e0OCFiWIbBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NIElTwz3klnEaxl1UR7FAs/eCKWDODBzTzaspKxW07w9fh3g44mwDANqUkDLDs3vzsIPE5IuAqDFSuYiJn0Y4CkceWdUUaBL4LUMdbvNqPHHm/tXSj+R0JsfynYiz0exeP4AvKyJ9rCwDHvtFvU29hCXmGfG+g+e8S9YkVqRlno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDEvSrtL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDEvSrtL"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4acdacb2so311295785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771618516; x=1772223316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=i29oimvcmReMMWzAVpBPxc6Hy1ltH/uWC0nWai2+nvA=;
        b=VDEvSrtLmhuRML+IXzHkpGBLGHfqr9vCMcVe7ywIDdYY0c7aCh5kqALYZ02AZg2Bof
         0vWS2qrZx9HO8NyY70Gd9dpu5qyhUbLTFR1pHZugkRAF1N5PRoFx0JIw5q1674Y3vAUu
         /0yNYU2RnPy2WDg0ejqE8wsSsznn0xyI6NC1I+CjtiB4cV1QIdr/gaLPGzCTqjWQW98H
         w+7OOH39Or570xyuKIufqqpen16o/BIvg/fqGnkm6kCqkVXlPnXkDD0SYBQigE6y39Vs
         PUIm4yFF1iwc6XPbnmmt3LbGwu1OXfmtbLipziz4dZZ7mmUPAk4vTo0mgxByF0tTNOTc
         4fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771618516; x=1772223316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i29oimvcmReMMWzAVpBPxc6Hy1ltH/uWC0nWai2+nvA=;
        b=ZUp5bnzeiblAREiWSzF8/2fvdNWu/dTWT/S52RPJrcDku7zfM9qUkYIBPGxe3ITLvg
         THnu4bSVsUqjC/pCROnVa6x+M6jdOz0GPSaE6Fyp/ySTGCOAleKCYflfy0UzJCAUjf6U
         fq7vA3d+Mr6+ODMBUACrW1IGhZn7sMscx1BGrva1SgdBfJdtgHVNzXuC3hrOuhjaWlHO
         RZyZ/Pn1qB2rzryujoNovQ4BA4yJyqxDeeM/Xth2+Krnhb9UL013e58iuzQ6cHuhNPrG
         D+tIKOHgye9b7eMcHuJJ866aXzlzor+mhr6t8EALIEmR6eYzcvkjRK57hArkXuQHcePm
         P0xw==
X-Gm-Message-State: AOJu0YxbmVMTdSQ3GxMf/lGtNZN9nBjf+UkjiqsOKAUqx2Fby0zhh53o
	PSKofL3Yhog8JTYkNhmDJa3CRWoYo78OGRpQ15vgXzDQGKSsFOY3ZJBBXHX+xA==
X-Gm-Gg: AZuq6aLDDuDDZ38A83H9UCZuBXexKrUEnfXajPhGnIq3xyB9qO6EYkYX4HDao5BNwiP
	0cTCSICPqENMF5ixTft7uM6sYlcHxVEulIFCf+RwV0yqH2h2Edt0CzVwXt7noVayRmQbJ74y45d
	4ftlMhbdYLGbpmw+1WKsXO4kABa2L6eHkhDz/z+UiXpggzGSo9AgP7EbSmPdOU15x6jMIAZeSBV
	uktLn9GXk0zCvzkNf4McUuibhGFWck/4zCx9FbRaYYYYL9rELrMnuEzKdMWxtlt9YeDNht9/hNg
	ju/jVL4yQPq2NKi+DOLNQR8xPpjygReKKJ3RqBzEaW47VHOqwuF2btd0uDKda424nD4GUtOVeBa
	6RAtnT6r8LJzoMQFbFoM/WmbeCVhcomgdA7cjdmK8CB8gPXUGyMMkTPAWjfuHUOtwk5r52W9qyj
	uuAMfoPoliOrdjjCeiMVwFkJGImM43umIc+zvWerQ3snlgR08WlmlDRtZ0+tRyWeldJ1HUH9a0p
	U4jtj8cfazUnCq8uA==
X-Received: by 2002:a05:6102:6c1:b0:5f8:e367:959 with SMTP id ada2fe7eead31-5feb2e5ee22mr706693137.7.1771618139260;
        Fri, 20 Feb 2026 12:08:59 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5feb6245d40sm354354137.4.2026.02.20.12.08.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 12:08:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] l2test: Attempt to use BT_SNDMTU if output MTU has been set
Date: Fri, 20 Feb 2026 15:08:50 -0500
Message-ID: <20260220200850.3460177-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With the suggested fixes for L2CAP/ECFC/BV-27-C the kernel shall be
able to accept setsockopt(BT_SNDMTU) in order for an applications
to require a minimal output MTU greater than 64.

Fixes: https://github.com/bluez/bluez/issues/1895
---
 tools/l2test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 7eecf1364492..2cf3a47e7cdf 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -318,6 +318,13 @@ static int setopts(int sk, struct l2cap_options *opts)
 		}
 	}
 
+	/* Older kernel versions may not support BT_SNDMTU so don't check its
+	 * return.
+	 */
+	if (opts->omtu)
+		setsockopt(sk, SOL_BLUETOOTH, BT_SNDMTU, &opts->omtu,
+				sizeof(opts->omtu));
+
 	return setsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU, &opts->imtu,
 							sizeof(opts->imtu));
 }
-- 
2.52.0

