Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FA2F8BDF
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338473; cv=none; b=AT/aeoJRIgVIM/j4hq9voQyeYYj50x+Sw6wnLocQdjUJ8ZcYhhmXOrAHCy21pRYZl3VNC62Iq6JfYGD17ybVdxK7mMh92lagIjTy9uF99KNI20YTppdSb8+FX3ixD8QsM7grmjtXY1I2P5pBdJzvqcLQswHQ5H2Ys7Sg55hFLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338473; c=relaxed/simple;
	bh=pnpqVlgWpLXKkpCovp2yr2M3xCVDrUWGSLn0ih/LQ14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT45DHwavIVnZO1kGaMKuGlFk4VlWMKheFV64ZgZNyltqoYgDdeRlGaOpMRm9u464eZogm1Fa70oa2Ml1wmY26YfyvEDWhKimRZtRMI3qVydJODMmQq953//tmJi1v4CS6PMR8LxzTXdqIrPKdiN2e6SO1Gt2r+jYQAiQXOMJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNqjEFbs; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNqjEFbs"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-556694876eeso1439792e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338469; x=1761943269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S97djthjvOE16v9gtPxDN2MNMKmdQnLF3noNAjA4S4=;
        b=UNqjEFbsol4fZBa9hVoVWVbkgvkbfAdnPcuBatNAh+vVGh1r64yYeJdi+0h0rM04JF
         PMgBjXkpM5yHKR1uqXSif7Vtvt2wNh2GEWIgHSzNeGojpZ22IuBlU47Xx2krap5+b1I6
         oy7XsGtcbCqW/273sUNcap+KtBxiiLRNiuMsSRnBhIwbdBWei3mVLSiDdKSE+H3OuoOA
         jtiAtbvAyRxy7Hg1YS4OCkrELpUs5qWgMvJh7gXhCr410bn3+xE6NHK9VN7kb2xBAuiC
         gB2nvnumhjKcxioA1jxpK99aljM2IQCjy4n+l5Y3A0k9hlWlG7L7Co7syDfuH/y2RYfq
         eZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338469; x=1761943269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S97djthjvOE16v9gtPxDN2MNMKmdQnLF3noNAjA4S4=;
        b=FRQX4r51MdW+OicW8dRUDCt9SorRorOFOEw9EYeppZzSzzdKF7AFgdHEP5B9H7Yuf0
         sP/pwYlExTL0zTYUliprP4hOzg0JhgPeKie0fN7TFM8C4v9IUqyGtFxXaHhCHhgC5/B4
         eQ+PtBSWBb4yDVEIbr41UmAS2MNBeZrL1Zr81dasPi4oOZSTimTFQM+X79POoQqkPgPb
         pkvIoGykV3dvWt51LwkN7JlRAGEVopMauSqro7I5fVgnOcqToRfweSWMBKGNcs89fxW0
         a2QjKcKOS/A81r0I2jrlnNlnLn1qShIiZJ0+cQ+Yd1TuJD6ozkKTUDz5t67fDhe1SVHI
         8WRw==
X-Gm-Message-State: AOJu0Yw9XFCCFGhdXrIdQjDTywxg679rAv2RUb1SdsV2lk3MQ7nx7VOF
	Kuu5G7sZrg6UNHjmxGt5GXujLbbMt+25gv+X7zrms9vRE/O0P2WKqOKmJ6we2Q==
X-Gm-Gg: ASbGncv7eM3Sfr5ePLQWCE7G/4o0cA5p6bIA9tdVv4BeHokNOAOrcbPYyqw8byWB1Bb
	ynOZw2CJWOoAeitxI8ea0mMFVdTxsQeOvCkhBmh/divCyWptIdKCXvExuzIx99mCnm3D4Vc8lkv
	IbKlhL2eQkDg8E4Mvf+jbfE3C3oWCED8yrhj+jXbpSfVhpbqLmi+GEqQliBs75OFTOmCQ9K37Rr
	oEUAY48GHTXDh3eMwvaP4xjvVYC7A6EjC6dtE2tTaV5NFGvx7S1r7WcQxXY8igO16cHs/1ZDOtU
	MzpNEn4cpfseH8BFsEOPG16yAmrBeY2klCyxFRVEpbXuCX+2fJyUdJ5OV2TXC7Hj3ypLWV72kra
	kYKfNuNhEMZl6lQVsPmLAxZQ1gELnFvlvg8c7Ctt14f9KshPqskqHGGDFO8Ho/Q5NG/n/2Fs3ut
	Ao3skfaENDFSdIuA==
X-Google-Smtp-Source: AGHT+IH8UdNpCwA2gvcMl0/TAnn6h+27B/cOfaKAhpKkASwQb9apKIkwSE73e9bV6b0Ai7Pu451RUw==
X-Received: by 2002:a05:6122:208c:b0:552:2554:7d69 with SMTP id 71dfb90a1353d-5564ef3cb2emr10561167e0c.15.1761338469651;
        Fri, 24 Oct 2025 13:41:09 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.41.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/12] client: Add script that setup a broadcast source with 2 BIS
Date: Fri, 24 Oct 2025 16:40:38 -0400
Message-ID: <20251024204039.693918-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a testing script which setups 2 BIS Broadcast Source, one
for the left and another for right location.
---
 client/scripts/broadcast-source-2bis.bt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 client/scripts/broadcast-source-2bis.bt

diff --git a/client/scripts/broadcast-source-2bis.bt b/client/scripts/broadcast-source-2bis.bt
new file mode 100644
index 000000000000..35b1846334be
--- /dev/null
+++ b/client/scripts/broadcast-source-2bis.bt
@@ -0,0 +1,19 @@
+power on
+endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+a
+a
+1
+0x03 0x02 0x04 0x00
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+a
+a
+2
+0x03 0x02 0x04 0x00
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0 /org/bluez/hci0/pac_bcast0/fd1
-- 
2.51.0

