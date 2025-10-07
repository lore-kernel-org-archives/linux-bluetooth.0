Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB4245020
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Oct 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880281; cv=none; b=Hd2C2iMBJt3hNO7cLZKXxXrgLSmQ1Uz/DmK3TVI0ZtZ/A7/7raY0xrHCFOAp4JKEXYThzQgtacvNpLcqw2SJiGG8Sh456JOip6uiQFuTNTHcshr9rIfok5IN/ytAtIHRPtXx1grGjBGex6K3SiWp0vanHFRmE3nHtAW7nXZaFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880281; c=relaxed/simple;
	bh=h26x29s20hjBJODDc+mltJ1rrKTeU+LcB6figctfTWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xs88yRDM/qYwiSWmCUEUu2aCwMR7oRMfrOBsE1EpSqoY4TkfcU1BaYch9mT3zkv/hf2TGir09BV+s0bbv5YgSpoWVC/ky13zTxUabpdWNHlPHfsvGvoAlnGMkSD4x55AzXVbz5K6Bi4WmD6NHxqokJ3aF3jGYd8EA8QdQzrwRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apz0RRnJ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apz0RRnJ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-854585036e8so708232885a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Oct 2025 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880279; x=1760485079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PLxpd9kbi54qSwlv5nU44o57YQdg6U4+ha5MoJ07Q4g=;
        b=apz0RRnJSR8eH+105kHOth9iqPn054UtK/j/Kz0qb1C+A1IxNURZiWDiBQq9WPJU2c
         z2aoWLdMkfiavHyiFwyfK4raSKoKq/pS2D2xThFJ+lbBfQgGIaoBvw6gccYiaj2dqrS4
         caRFZKQ0tghyj+ksfiBJl5C4a7TBGhx14Ap+dBcb7aOnz98s03JTftf3oJhw/qceVp6s
         MuAOPe1yTpqSK2Ct7QEWZJdYJME33nqlGO8DLlC6txODjXlp5qJONCYLJXAAovReXBd9
         lhO7YraHnFwcZERsVzn4myBG8HIPDWzGPTu9OPA7kN8OQj6aIbk829dzIeUzCcIYfp6O
         xnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880279; x=1760485079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLxpd9kbi54qSwlv5nU44o57YQdg6U4+ha5MoJ07Q4g=;
        b=IElIAk4+lMP1u1z+XrRTvCeeuiM4sLj+IAxfG3QKkLDBt/ImQDhau0ClfdOohkASgN
         LaDsnbsz8C8ALr8fuM/+I0OVqgW1kAcuzOKHlGf1MlKmHkTLka7o59na4KSAazuXZudn
         NEADy3sd7DXDYGyNObac7NmqXNxlzW+nQczRtdv91PNhRRoTMe95JKh7I172SIveU1bE
         QhxE+fV/2S424XhKCEZHwhEAni3EhdgU03MBLtof4NVeJbkxner6yK4PiMA20E/2uZR4
         b4oUZrB0XMoQib/+e2Sev6iJtvy9pmaSuEp0i5h7ieOV3TB4PLezT0ipiymPXVN53uTh
         qC8w==
X-Forwarded-Encrypted: i=1; AJvYcCWgz4ewA0XQ8xs3qNEK0YbJpPpdh2/Bu+xMdo32vmwU/f7U08HHN+vUiQGrc6CUisiEQWUMYuH1jXmWHlCmL3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj01JppgxsDfoGM0lmHi350fr8yPIwaDxff/7BDV6+rwcmfQpS
	JlWQQlcMDxgsKzqm1Ry5+dym77d72IwY2aS28H2rkZT9AGoPau6c2YUV
X-Gm-Gg: ASbGncvd7oKxBrccD18uC7e5anW6tQVRSEuT7UEmUnBcLpVW6NCHdj29/HQ+uWOi8Bi
	d396jbkHIfo2sYeVlzd8baMFc21/aftZkTDuyr8ddcpMSVWgKOCuVRDrT1OleNL9JE7hy6aZ0h4
	G+/9Cxd5Jk823aftHpJuxkzWkb3MhzOzZxejBjgA25aebl8AIlwaZbRaIUi38cxKE08krRatTjt
	cmoDDx5anhbkLZAHL9YUM/ceNsLqk5tblhbllTOZZ9Z1+ZBnphGUQfiYhd+P9yQgV26peYHgtSP
	e8iTAQ0+u8znED+SUCFPfXtnYJgpG7noAwqWMnrygzzrqD2DNluoky/mIVejG81DkVgwIJFJAzw
	97CP8pZleOCy0azZWEmdoMtAJVZvCQhxrcRrdspmXy3+it7TB3sLrHgnCDLBN/25nZkFQCUDg4m
	/3Hzv7NNIiaD6fcu2rGXmbwTd85f/iYn4=
X-Google-Smtp-Source: AGHT+IGWuoyjLBHTvXhdCeOdSV6cJByJ0Y01xALhTW3Q5DEdDg5DMyRj8M0bafbfIIx4igMJsj0h+Q==
X-Received: by 2002:a05:620a:29d0:b0:826:a2b5:d531 with SMTP id af79cd13be357-88350a7881bmr266619585a.32.1759880279064;
        Tue, 07 Oct 2025 16:37:59 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87a0e9bd554sm14351366d6.32.2025.10.07.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:37:58 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Tue,  7 Oct 2025 19:29:42 -0400
Message-ID: <20251007232941.3742133-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in while loop.
The logic does not sufficiently validate the remaining buffer size(count)
accross loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/bluetooth/bfusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..f17eae6dbd7d 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,10 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+            if (count < 3) {
+                bf_dev_err(data->hdev, "block header is too short");
+                break;
+            }
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0

