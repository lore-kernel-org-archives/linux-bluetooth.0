Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE72253B0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028678; cv=none; b=sEX2awpJUpeUP/13gKKoofE6ef19VsKb65adTPkiaSNh+s/1PfyZM5jDTYgW2+m3B1j4slWDS8VVYmSnrRN2XsQPMnT6RCrP4ZKkFN2mIwvz4R7JEV7w8NxAvpbn/HY9z++GfHSDG3QFC65rWqpIw9K4g2f6jajp68gClkyKsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028678; c=relaxed/simple;
	bh=bSULI9f+euykcipRhqd0laADfcpo8VaHK0Bofko8OAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbRe9hG2sm3C/kJWsPfPLaD5/KaUXXwDHhpVNbFT2m3FF+PelWoIzT/i5HCQAMMDbZm2KPQF0al9dI5dq0R/KTKRWe9tMTVtYtJ5drQtkN/7iyuEWP5n4aZnCrKKRkBZFBpn528KSZK6FemW8AbgWZvFIpPdwXBuVLPXTmpO6XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRxZXibc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRxZXibc"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-879b99b7ca8so13775436d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028674; x=1760633474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxPWjMVHD3JpD/tJd3lWXNciFLmIC7SPnsETCC2Sg4E=;
        b=BRxZXibcDRtWwnL8THZjG7UwR2Zgg4kE9ib2naVMeZts14zCuwhlOdAqQw7HNyuRTJ
         YITFIBiZTcvg2P60wZiJBsi1QdeyMTQpPb8+gcCReRZ4ryZZz4T1cKNj3kkdN3SuswWI
         cgZE+s8nl/3jx/eXQagZqUNQk1bs72N4xyjBDAGEdjmW58pFSmx5JPasJXLtPogFGXru
         ulw8DdQumqNpGTDfeB0rnfy8Ok//hRoffI/8/myDCeI2t5xsr83OT1/gcs5EqJRMAAUp
         cR7yCaj2I49SEKz6QTfeqnl5r4VgjLTxhd1epIh0evsXuIZ2sW9WyfQbD0jx16Q3iBn6
         HsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028674; x=1760633474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxPWjMVHD3JpD/tJd3lWXNciFLmIC7SPnsETCC2Sg4E=;
        b=vxTjMWU03xh7mEnLyTAXanEMRh9lkOrRoCAbHFbwoES3EPdYLgPP0M8UMZKYQvklNh
         1c6pxJR+fRj95SOJO3GrT5X5Vx90zyFzw+YBQXtSYa71Cu82B2NUJKsaL54CatwpHPi7
         ZHsKN9Io5C8Pstx3/nkFWRl6YnoiEEXjKuXv9jUSFmm5xkRl49DqTReJBlRqGvyeXoEz
         pvU+mnZU9xl2cBQQL4tLja9cC0gYOSOF9xkH/i2085B9F/32cvm2TH0qJ9kL2+g4pJpe
         CqEjzA+E2QuRzco10mZ0X/rfvNr0Jl9S/O3X5swPUeuqQVLJmoxo3BcqrYOuNFM+3ppB
         TpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCGAyjoITZkJ1tJ+aN2ZJhulcQsxnHctKk5tlKK4fQtTsNaps/80xOsXtrsstr0ypWPe/T/GrheAsCpUtc0Pg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1O4eWrywDFhA4TYbXYerh88KixxwjtQF4c4AOUgZY0YR0Ivxu
	YyJQY19RC5BwiSkQgBR2eKf/76pMC7bNOa9dEsn01pAdzT50bLREDwQs
X-Gm-Gg: ASbGncvcHvHTXBaYXQP3eKyvxikac7WQ/n7npuHuTSluf7rNG5R9BmDtbKTOM98bRl4
	D8lRjoy4JBufW/hO9/CIYUiQ5XYDctVEHKy4rJKL3hii/8zyLZXDD+DonrOTu59huFTA+bDrFlz
	0F2lmwF9ZdmmsimhbU4CMsSrkfD3xHx80GKH20gJSmi5nrEUKD3etKxwPlNQl8BA8Ae8b2oW7AJ
	XlLlPsmyr/IZ+Wgd4CkueOuLqVFsCAFQ3YXtsU426AxLQaJly0nAumwY0opP/sVqGioIOn+bZCT
	TZG5OF6cen+jml8/ah+gsrVuEbpPRkvVEQ/NftC8LeNuhrzOkzyHohY3Jhog/e24n7zVff3Gvnm
	swFlsw7D8ohXQeJHTcJtJnvZiu48w8JF98sbAUGYXPMPKRo7N+N73UjnI534Jaav1K/u7NqkVG/
	7WHyHeaczNvdmbpR6WG5h5KrbOFDged1yAtAt2Amzxug==
X-Google-Smtp-Source: AGHT+IEmFjLt2SYiuU5RDKLLiDCSk74xNuT+5x0tojzgJe36FuA1P9ps+/00iZzayGg6ph9RL0gTgA==
X-Received: by 2002:a05:6214:9c7:b0:879:e666:c2bc with SMTP id 6a1803df08f44-87b2103c76dmr71921636d6.1.1760028673927;
        Thu, 09 Oct 2025 09:51:13 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb91sm182464266d6.60.2025.10.09.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:51:13 -0700 (PDT)
From: pip-izony <eeodqql09@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Date: Thu,  9 Oct 2025 12:48:18 -0400
Message-ID: <20251009164817.3762787-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de>
References: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The bfusb_rx_complete() function parses incoming URB data in a while loop.
The logic does not sufficiently validate the remaining buffer size(count)
across loop iterations, which can lead to a buffer over-read.

For example, with 4-bytes remaining buffer, if the first iteration takes
the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
only 2-bytes remain, but the else branch is trying to access the third
byte(buf[2]). This causes an out-of-bounds read and a potential kernel
panic.

This patch fixes the vulnerability by adding checks to ensure enough
data remains in the buffer before it is accessed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
  v1 -> v2: Fixing the error function name
  v2 -> v3: Addressing feedback from Paul Menzel
  v3 -> v4: Improving the error message for the block header count

 drivers/bluetooth/bfusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 8df310983bf6..02ba16775004 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -360,6 +360,11 @@ static void bfusb_rx_complete(struct urb *urb)
 			count -= 2;
 			buf   += 2;
 		} else {
+			if (count < 3) {
+				bt_dev_err(data->hdev, "block header count %d < 3 (too short)",
+					   count);
+				break;
+			}
 			len = (buf[2] == 0) ? 256 : buf[2];
 			count -= 3;
 			buf   += 3;
-- 
2.43.0

