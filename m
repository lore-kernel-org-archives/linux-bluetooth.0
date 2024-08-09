Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237E198848
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Aug 2024 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216933; cv=none; b=h/aG7hUJp/FcKSjvqoTzce+CvSVpb2pxJl84fsktiC5zuIZ0IEXgxC0Q2QJMgAF58DRvlBGmd0pCkTQ4LC5+VcEdk8vCmd7e/yuwb59dcZB2Jw7ivD5IU8z4iSI9kDmDScxO7yWzWgVqcngxjXZaVYxtBB2uglMy8Vd0rb5lGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216933; c=relaxed/simple;
	bh=yEKFI8cUbL3of9oDie3/60MUHfVZxdJUj/XsSj/KA6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZYsWks8QE7rQR/tmDr/qIeTAXyYpFM5VdRBfB7wsijRGI6YPxZRYbbeSJ/lc5aFHYJh3z9HymmQqCrzM5uBa4lfZLBBcbTYgC8wUVkrcZL5ib2rSIVQzirU1IVlU733THrmGKUY9+75K9LHvgH4nniZFdYDGCiLQ7b2n93/79CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV/6GoAO; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV/6GoAO"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c669a0b5d1so1421758eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Aug 2024 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723216930; x=1723821730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMeTR/D7D3c8DhRI3iv1zk0eUzGQXTfrxlPDiGFb2qQ=;
        b=TV/6GoAOYSyBiFBFIGJKhroIK56t8RALGQumsZ+IsY3UlXCN7hvaQiickgUYkWu/RQ
         0GNN2W672HAw/yT8Doi69jo2MJkScLLZyZAKBPdOyKDFIR+PZ7XNd7Sg4rM2ie6WouFa
         g23gX1yHe1eK51tz0Rv17pV/62cJKABHWNMyLU+95shagv/AptYKBJ8LE6XfHBcIFWiB
         xCBPcvRKj4dPsXevtnCugg2f/GoVE5dVOggyo54xIXQHSKimpP7HmfKzBhRsn5Jsv73+
         zO66Q+C1NuuY2r/hIxT+EVzs2UA1NzrFrO6aSYkoR9upb6i4NI2BX4kQPaKXZW0+oyRC
         gcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216930; x=1723821730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMeTR/D7D3c8DhRI3iv1zk0eUzGQXTfrxlPDiGFb2qQ=;
        b=KKXQmRmrOPx0X0VN02onxjHgZbKexTrlJu9YrGPFSU06eNbvvELYYBBQlgf0opQ1Ny
         TLUobvQZi9IHf/JjN+RKegFooR9CQScvx7EhQkmOgrrLZqACTZBW7hcuIaNeqTmg63Hq
         L46A7DTsXfQQbT7UvAuK6ghT46Wa9UFZn+uEPwiNYz71TpEO6FQF7KMz6Yn6W3Z9DA8k
         JjCC/aTwiNeqYNfQL7hPgXrxLPYxQCksaPfaduGEJvO09v3uJ02tXlNDazWbY6e2Pvo1
         hwtuJ9mpsQLG8+0r2WEChOZevN1MfuM7wZAxQHlJ3s13Y28ScOPsf04Ij2G0O/t7xHn9
         MtEg==
X-Gm-Message-State: AOJu0YwqLKoYwf6oUKvzipTn91laXx2Pfu4xHxCdBgp21wOL/sUu30II
	slP9g6qEz9ML7FPILiOnIVZHT/tPrXe/z0+x+pY7uLQLuAf/UklJISvZkQ==
X-Google-Smtp-Source: AGHT+IGJm9cYkoGF4LLAijfWE/nmJZBHAoiNhwl3YbOxirhgP3M4NfdTLfWGfxh5mLOvlyRGGfaZaw==
X-Received: by 2002:a05:6359:4582:b0:1a2:89:298a with SMTP id e5c5f4694b2df-1b176f1d10dmr244933755d.8.1723216929950;
        Fri, 09 Aug 2024 08:22:09 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84104b909afsm1011175241.12.2024.08.09.08.22.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 08:22:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc/doc/org.bluez.GattCharacteristic: Add missing link option to ReadValue
Date: Fri,  9 Aug 2024 11:22:07 -0400
Message-ID: <20240809152207.989730-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Just like GattDescriptor.ReadValue characteristics also support link
option which indicates in what bearer the operation is taken place.
---
 doc/org.bluez.GattCharacteristic.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.GattCharacteristic.rst b/doc/org.bluez.GattCharacteristic.rst
index b7e4a7b69c9e..a43476d2adbd 100644
--- a/doc/org.bluez.GattCharacteristic.rst
+++ b/doc/org.bluez.GattCharacteristic.rst
@@ -62,6 +62,15 @@ array{byte} ReadValue(dict options)
 
 		Device object.
 
+	:string link (server only):
+
+		Link type.
+
+		Possible values:
+
+		:"BR/EDR":
+		:"LE":
+
 	Possible Errors:
 
 	:org.bluez.Error.Failed:
-- 
2.45.2

