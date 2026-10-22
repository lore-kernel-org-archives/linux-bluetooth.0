Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684033;
	b=T55Dnveplu2PI7ceXPxj/eamRMYtwvNXRYHC2awk6BI4uNe5BqUOZGQiY3N1p0BqUmX3
	 ls9q5aZq4ZFyUq4urJu3XY6tHDZMINCdqcjRc7K+b6uSlRkjBx1XG/Mk+lmOOWJK0sCV0
	 42lyU5zxT2BOkvvRhlJ60q3NIUWnP3neaCKNN4KiDEzaYENoi/cB/bPhMkdIEk2QVj3fg
	 IC3b4sP2k5VSvZj9s0gKGLspf1AuGJKizXV63rpqk4XvWsue4bMjSWbdvbpq6FBNREkCW
	 KxUo10hJ2e4QiXCKd5pjL3ks3bFCz9iPRlP7Oz/of0duut90JGoUaTqliGUMYa6bm2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HvGudwHpv1nfHnOU4Sd8e783HjF8u8Sv2gzuxGD1pSE=;
	b=d01+/INq6oOE5YEvhLrA6xcu4OIU3D18V5mc3d6n2eVkZONouUxiMWZNyHeA9lcQPOqq
	 tkyfRsb0PKezIAt0IV01UwAQL4K2vIT1e+cNFTnGjxBQ6tJN4L8IhaHavZS3jNE66Lbhy
	 QTGXH97xffxc57ro2dmXuCh4JTaIVE+929PeqUq3TLC6EdEKFZc8Wv2wFx2UsmoJe9aI0
	 IEooUBQ5wXBIerNNa0N2lt4E7m6CP0QYxt9FrH+plvClPFBgLHlu6hjUFBSENbYM/SUnM
	 2teFUH4UioLkf3LhYq82ZpSIpFxmzIUS++CxjnRHnUgFQ94g7ZCD08lsgabuZoEUkcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5xgMYaj;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E4606A333
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74E4606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5xgMYaj
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso19283e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684032; x=1793288832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HvGudwHpv1nfHnOU4Sd8e783HjF8u8Sv2gzuxGD1pSE=;
        b=a5xgMYajNvf+XEigi/5cdDhqERKV+5l2/NZl9WmBI/KrI0EDVfT3Dgo8dt78CCrKH9
         jSoABY9nK+EBUrKwNUcSDveEw5RkooqTChgNkQzd86xkjdjAp3eauTS4s822Wu5Gw7Jx
         qsNMzJ5bF/DXJfk6R5tU8Ddwk56qM4MJnDwoyKAunI60honOw9uxK60EDfQ152u13fY/
         3BWBk+iACVC7AOSJQ4QjlEwReGO5UpI3Tg1p30VOIty4yINYEZ6KrPFOGcpUhFuDONaR
         qfxcQB/sYdyULLJA7GDAFPiOUeijOFTLGxxf6wUUMbbv4Ryx9r3T//MFKYeqSr0nTNBK
         cxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684032; x=1793288832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HvGudwHpv1nfHnOU4Sd8e783HjF8u8Sv2gzuxGD1pSE=;
        b=Q/plAYLRUfuD/y+RZyeBESfz5xHzIfJMrr4/QUM4DVL8knkv9rlV1X8hy1S2Q8sqT2
         e6CprTbqL4hAPUJ5x/Nq7TydslPSm9S54SFDp3PGilCT+p6tt1dP/9JhTutpo631oYWp
         UURFVajcxHKgMt0mHSXwv7GyeRz9AzgNdSENuYvFZrFt+eLEOg2irokSgVPI7ULJv+JL
         l4jkKIEl5PYPUrg8WO7hXilZv7OyTe+BA3/dMuujhiBKmxXr7eZCXk4dMI3GCBri/nvZ
         DbWvLKLitgSF/HruR/LasJRwyuwFxoPKd1VRR8jiqM4dMD3nI9QlXifYIxjofm0y6O2C
         mJbA==
X-Gm-Message-State: AFq9FYJo5NUy8ixo1zLpv3qw2mvqN8+cZdP+E6lHQklaYpQ5fnrWQraT
	LNYMewyq97oSM+rwXLufSw9ymqg74Jp7BZyq+pN9413cIi9DcYDjXuWxfa9X0ep1rs0=
X-Gm-Gg: AYBFou3eJ8aaPX3VaAD6UJgZnPju/wlL2msM8+YsUZozYC8fAbdcFDSx6tsKMcyl+li
	G1apu/KEeUx0Tj1a8qV58c2Uwp6XWSBs8sqMrTEU5dLXkcVB5ZqXPzAPWS0OqWBgvBbQnRdS1dL
	u4/mSVR691AVi725Swjxk094U6yPfoy6W+k6Oxq8OoAPxdwDDmChlnzfrrI5glFpxwK16YY/ebK
	qs3D1iliBL1qvG1wLpNz9ET0nox63+mbz7qf4POJYHskBoQpGwypRxKH6h+W6Rf/4aNHK8zyzv6
	ALICBTgtPOWPiE8tDldmS0cZIS/kePwr8asZjRsRppaiw+FYVGUfq8k0SkEUxZ8PKfLTAAndvEo
	Xty3/o/smt9bZkBEdwwJBotwPdibtHKGplVAlbgJNrb3VvYEVpy/JVZkln4yz/ft+nN+U8oYc2H
	4DDXMAoSBYhWIKrSd0XVwmYGUOwZ7BbQydLMhajvtftyCKrOh5a5ma1e/ot/O4s0DpCEA5VSq5l
	KWt8D5hcGuGZSeSk7kcw+uuvnUeLtrKDSiZPLgFZZZ6qf+52c0jfBzMs7eA/PlPxQiXa6PueOZE
	pW+wDGx2IqBHbprsjl+zgHZxDynL7A/NYgy4XGsjYM081Q==
X-Received: by 2002:a05:6123:420b:20b0:5eb:8606:3425 with SMTP id 71dfb90a1353d-5eb860635f0mr621164e0c.10.1792684031794;
        Thu, 22 Oct 2026 08:47:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 01/27] tools/test-runner: Do not report filesystems already mounted
Date: Thu, 22 Oct 2026 11:46:34 -0400
Message-ID: <20261022154701.3959500-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With CONFIG_DEVTMPFS_MOUNT the kernel mounts devtmpfs itself, so
mounting it again fails with EBUSY, reported as an error on every run:

  Mounting devtmpfs to /dev
  Failed to mount filesystem: Device or resource busy

Only report other failures.

Assisted-by: Claude:claude-opus-5-5
---
 tools/test-runner.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 674ce072d959..21de3a50da5e 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -254,11 +254,14 @@ static void prepare_sandbox(void)
 		printf("Mounting %s to %s\n", mount_table[i].fstype,
 						mount_table[i].target);
 
+		/* The kernel may have mounted it already, e.g. devtmpfs
+		 * with CONFIG_DEVTMPFS_MOUNT.
+		 */
 		if (mount(mount_table[i].fstype,
 				mount_table[i].target,
 				mount_table[i].fstype,
 				mount_table[i].flags,
-				mount_table[i].options) < 0)
+				mount_table[i].options) < 0 && errno != EBUSY)
 			perror("Failed to mount filesystem");
 	}
 
-- 
2.56.0

