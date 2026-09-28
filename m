Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18224E7810
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616809; cv=none; b=pVpqlehdnB/4Gt9mHyzKAJU8U5b7VWxuGZz8eHQd4aylz09StSqybyM4GljRptzqj8dyAC1EUUq7o5cRkr82d8ax5iHfQzZ7eso88NWKMtwo3mcPd4Jzb0+iyYP61aQfZ0HMlStz2cN+JRG7RX/y5zmySvQuGbnB/ch7cdp5OrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616809; c=relaxed/simple;
	bh=6F2wGlcLFdi5e9+GY58oy+JRIYpmOylnLyvKYoSAoXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td7dCIk7UWJsRhDOugcf1A82N/7SnnQqtoOa149L7MXGAmO7yL568+udYS+V4MPHwG5OiUY3TqK8i8m0rxCaDg+dLbaJQ2oYXS4Vtp4qz0l6ALrJ8Ev3+PszfRuatRC0RRYRmuuq9hf6ZKWZ5vQRYT05y6J9dBx+CJ3+64pNSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC4FePgh; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC4FePgh"
Received: by mail-vs2-f38.google.com with SMTP id ada2fe7eead31-7b3a6aa10c2so710234137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616807; x=1791221607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=VC4FePghlueoAJk8+aMmsP2aok5qigVxuJwlKv6QvpjgdSB+eKCmdO9po9CYMOrUcx
         90X+smHMKBY485vnyfCUAo6ANbjzTz7Pc8/oea5Tu8AuMwd9FmziH+nPR+flGYX3pxm5
         C7iRz4C67/AQr2PQDb7WZ4FfVVMBEEwkpNIUJ9PCoAbBPt9WOCd/KGYg9oKp1HuQ7sXF
         BCy02iSPjgHcc+JTcpthQbfwApD0au8dZYcUCbiWvFVVpj/hmrlcoQEJRYXmxrGfxSCX
         u1FiuwQflBx5Ek+ksit6xBHAJ/791Wn95HLDbX3JOdXfv0wNpHIeaNwjXy7wSetqMavH
         xzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616807; x=1791221607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kdtul5kQ3tdjkQenjhTtE2ahfxZCGeAX7k9lx3BO/a8=;
        b=O2F24H1WqfQpuU4itIHMf+VkUBBpGmGi1Q+/sErsH+d/Uz2dn9CkmIVZS3QHEPwkA0
         4on25xRPpwkJm/+dyVHzjYtpZHYM1JePJiGlVlrcd0BDh9P1Iafo6JVPmH42nzRe3GmP
         Hb9ctAFECALcIz8AERCI2m6Kdt4bMkmkIV71ZJCUNfsXxW2icPGER+xHbbh3lOM6DHWU
         miX4WRp4rkVWYBEhcGfwYZ1y39yVnDxznkVBewcZjO2d4fyYLqj5xJo9LlmWnqrtw1lN
         D93iqfdfoCw+6xr8cPsg80KB9tfO9EaTGzNoWx/FS1dUEOl1ZWV6gVy8C1hPwMLE5TgC
         ktxw==
X-Gm-Message-State: AFq9FYKlg4CLKYOtWj6Viy4fgExGUI7MfyNtObfGk+2JYBZXTJWC8W1Z
	NPBYIsHlMFBe5hSFxcS9rJ2gRp/b3dSDByR+LAAukQOSEFS+iPgQGRLh4pn5D9JzIcg=
X-Gm-Gg: AYBFou2fWb+eOcEPqztISwRzUNmvVd+dfj4TPe0LufZlJMS0PWbnDb4q3z6XEs051aT
	9ADMzaAjahMK8cHsC4TR0++Sa5mplgw/1PZqVeBZwhILMDAj7AKBn6XFVHGDAaMYRcyMaKueAc8
	wckMB1gprMYANYMatEGPr3BNOl5NT9PhMR7kkDIzetRRsLYbM5Xid9nSWLFvYblx5Uc8rPrTBkG
	gt7eJXVeIM7mGarlkURIGlLcc96lMcM8BQRWjWr59tTyMHmrxSQyqr/edWnYEnOpZXH6Mhr51MS
	gn9s0VhedUyEl3D7EV+sewlBpS2sUQm4pCO4Pq9mUQmQIUgp9l7/rVZs7ayOqqxXg3f5Ql2uUBN
	qzzeM6WMD2FuQdvu7WMsnMcBr6wBgWHo2yF3DBviENbskNez9odBqQix4in32BECZkmR9+SJ0cg
	oVesz9HOR8r1HbzKKlMNQ56PD7fiDoAe7/+l/J3SZIQ//rqsCzgN1i+BsRMFzZ0xGDCtJxJWyxh
	tratQcu00QL5jqKvhMMCnI0FvaZyB30M8IRyU374oJhS4rVtl7pa6ZFXmLTvatn
X-Received: by 2002:a05:6102:3306:b0:79f:5d5e:11cf with SMTP id ada2fe7eead31-7af1d09c695mr4017886137.11.1790616803114;
        Mon, 28 Sep 2026 10:33:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 17/21] doc: Add CONFIG_HIDRAW to the tester kernel config
Date: Mon, 28 Sep 2026 13:32:36 -0400
Message-ID: <20260928173243.1073509-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Enable hidraw so unit/test-uhid, when run as root e.g. with test-runner,
can request reports through a hidraw device, as HIDIOCGFEATURE does, and
check the replies to the requests the kernel sends to the uHID device.

Assisted-by: OpenCode:claude-opus-5.5
---
 doc/test-runner.rst | 5 +++++
 doc/tester.config   | 1 +
 2 files changed, 6 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index dc1e51305c51..52178244fce8 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -205,6 +205,11 @@ Bluetooth
 	CONFIG_UNIX=y
 
 	CONFIG_UHID=y
+	CONFIG_HIDRAW=y
+
+CONFIG_HIDRAW is used by unit/test-uhid, when run as root e.g. with
+test-runner, to check the replies to the reports requested by the kernel
+through a hidraw device, as HIDIOCGFEATURE does.
 
 For 6lowpan-tester, the following are required:
 
diff --git a/doc/tester.config b/doc/tester.config
index e68740dc0f44..34f1530e174c 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -54,6 +54,7 @@ CONFIG_CRYPTO_USER_API_SKCIPHER=y
 CONFIG_UNIX=y
 
 CONFIG_UHID=y
+CONFIG_HIDRAW=y
 
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKDEP_SUPPORT=y
-- 
2.55.0

