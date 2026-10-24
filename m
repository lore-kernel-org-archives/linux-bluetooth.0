Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792838041;
	b=3jiXIYysy+BvJccSONwBpwjcleO5qk7rykokub3NzjtK2oD5fPpzKtU9aN+l+zU/79Nf
	 a8Yw3heZT0hn4YYfyhYh0A7eMx00DD42jkG1AQyC3PZJhnnemGqF6tarj3AQpmRzYXM+X
	 iCFPQFRuVjdR0i8IhyZCxxlU75Avx4CQrthXDzkKk3xappGBnyDubuK9TQJRnxB2bWft0
	 YSSxDh2K0Sdc/e8P6J4zUZaJxewYJKbpKobkKbkIGo7/xiqmXIkmhcarBHSZ9UxS294hf
	 Ub0aCRbYLqCHX0chUyxGJe8wtNLGblH2H1Ov7B0UjEePxyvcvNJ54boHvBCWpidUh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792838041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KNaoHxAB8gHqb367OXek7XWTOVPpKL5MAFt+xsGWk3k=;
	b=S7Z1cOCYDsNxjSZEckBlR7vUXD6VDTdO4IbJQd80D32QzNB85wQC3E/7MCn7LhVdldxG
	 P6x+T+KByDJUlj1Bd4sDNJmTXpaz5ezehLBaqg8D2HVywyvZZbhLS3G9v3F/OMlYwW7LD
	 VQ51wXhT0pZ/GFuICBATMLs76KS7Nqnx1oVxcn4E7kLaPKSnTnvIom0JzH0hnPHJH2lmb
	 IWboWGUkcOT69vUnmSFswcndxeu5xDE5pwPGeRD6jS6ehN8D1UyH8JZRNLB8L4BMP9PCn
	 ca883uyz/jEUFEyoW9bj6kojW0Fn8LWi/pzGxzM1tAncf+0CJHXIuV1Mcv9iOJ9gFTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tooangel.de;
	spf=pass smtp.mailfrom=tooangel.de;
	dkim=pass header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=Kyfu6Hxf;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89343606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 10:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89343606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tooangel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tooangel.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tooangel.de header.i=@tooangel.de header.a=rsa-sha256 header.s=google header.b=Kyfu6Hxf
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so233822966b.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tooangel.de; s=google; t=1792838039; x=1793442839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNaoHxAB8gHqb367OXek7XWTOVPpKL5MAFt+xsGWk3k=;
        b=Kyfu6HxfMyNSetlAIavCD4XM4U92lpTP6sC7MoFmTz77ORZvuIbZi8lh27SBnisWD9
         Uo9xov1JpCUi7g+OVXW5+Ot2kf+EuU/m824yLHO9q++0glf8K2azDQpyZaqCmLwVuB+D
         JGorRtqxwmm4mqQQnwLxJLyDHCdM41kLHmvbe3Vz923aT7YvqwlsY2/2Cb5yxsWGdFpv
         3Prx6frlQOgPjTQlYLhPdBlHEYDfniOkG/QjWgsGGvnfUqgi/xcZ/TDbaZqyS/wJxq3d
         vVZaPAxZboIJvuX/Me9qpbYAWQWM2oQJBYrQG7VMISieYrhpy9TnY2joFXpUsFdzCR3Q
         X6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792838039; x=1793442839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNaoHxAB8gHqb367OXek7XWTOVPpKL5MAFt+xsGWk3k=;
        b=1ZkyAPHufW93Kk0W6ehoMIQ1fUPifTJqJ208Pusol6ivV8DGqS6kJtrXrndBoFT4YZ
         pQvEoeeJKQ91ca0CpDzmUBNVWBVnI6iFpZTEjHQErhsaWQZAm85VPC9IccbA/sWcMmpN
         GRs3M8CLKUOkvUCXfnoOKAOnS9mQj+8Hdb28o/w65O5myWUcjKBxXW4Xp7R0H9aEmocB
         ULBJ97srQkvmCxaHGIXLfHq95O2vdiLXf8dhQERa5Rl5y4il4yBmOS1JgWyaeLbxPu+g
         LksOGrQNxp8hhrJ38YD3Nfr15Dre7cMTbOph5eqRUcniDDng151cqJ5Q2x27kjD2Jsbq
         mjbw==
X-Gm-Message-State: AFq9FYJ/D8ueFff/s2B+3Ol3EAYmxpS7CnjiocoYUnTjE7adtzZP5xtg
	1WwvMvSah52iS3X+VkDFqLs4IEKyxGPG1QdUaBKBJIgOw72WsKq+KaSn5S+r6nm81fneC0JYy5a
	yFEGXacZbyQ==
X-Gm-Gg: AYBFou1A74IjX8Fo0/NR/DMGqlonqnn5/IDKyYw7U6VF8Tag7wQodQsQFlJu0BqfDim
	2PSQ2dfD0baNjocv7CU/9IF9H2lUVcFH8SvejzFN+ehLtiXQ/u8csXEcLRCwFPg5ckIVOfEthv9
	l0qIqnBvKo5jB3o0A8CPbJRcGnoE8SDq7I1jsVrM/apHVMk+BisEoRi7R5aVEKxNksHjcxXIXUz
	0i9ds9O+S7vSR2VjQVDmtWfE8V9qowx7GTnTG0bhXmYiQP4Z8r+LW9RskvdsoGi9Gn6XPDqf+ui
	Baeop8gwGNrt0QuVmRnBZpQ19RzGe3p7JQN0ZkXH3gOXCrNzorsOI799KEEEnKrLI87jAG47Mh3
	mbbX613FhtpeEQ1wPyhkFnx+pf7ArThLT04xcEZhReT7vlb0v0C4wJb2e2jH9Qieum5+7aHUoll
	E+XJqV8YucqrR3bkCmiHuAAdIgTthQzTMzdlycGgtOdBXR38tPbMQPwjd0dmKZWCRHoNRoovUgt
	h+TKB4F/zebbSRlsHjopYH4C1w3s/ljoQMwAeDz2xLGWz68tiKC2gdLPN4TEBqOHs9iYGCRGZOf
	dN/E1UWMB4G2dcg22GOLMg5+I7v99nbu/c0PfmCDSBgKK1aD9K0aIfDE1st8FNRl3mmBotfikYV
	B4K+lHFwhfEvYGMRWqlozEQg0IdC0N7fw75EGKSxzeScyTyYgoXXjEccXtjU+Ew==
X-Received: by 2002:a17:906:dc8b:b0:c29:659e:2fd6 with SMTP id a640c23a62f3a-c46bddb549fmr161119166b.10.1792838038377;
        Sat, 24 Oct 2026 03:33:58 -0700 (PDT)
Received: from toogaming.fritz.box (2a02-8206-7d2e-cf00-f0e4-3f21-43d1-d408.dynamic.ewe-ip-backbone.de. [2a02:8206:7d2e:cf00:f0e4:3f21:43d1:d408])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4ea0ccsm76501566b.16.2026.10.24.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 03:33:58 -0700 (PDT)
From: Tobias Wilken <tooangel@tooangel.de>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Wilken <tooangel@tooangel.de>
Subject: [PATCH BlueZ] adapter: Don't power on while blocked by rfkill
Date: Sat, 24 Oct 2026 12:32:55 +0200
Message-ID: <20261024103255.81769-1-tooangel@tooangel.de>
X-Mailer: git-send-email 2.47.3
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

btd_adapter_new() reads the rfkill state and sets PowerState to
off-blocked when the adapter is blocked. With AutoEnable, the default
since commit 180cf09933b2 ("policy: Change AutoEnable default to
true"), the policy plugin then calls btd_adapter_restore_powered(),
which sends Set Powered anyway. It can only fail, so every start with
Bluetooth turned off logs an error:

  bluetoothd[1212]: Failed to set mode: Failed (0x03)

or, with a kernel that reports the rfkill block:

  bluetoothd[1212]: Failed to set mode: Blocked through rfkill (0x12)

Don't send Set Powered from btd_adapter_restore_powered() while rfkill
reports the adapter blocked. The rfkill unblock event calls it again,
and that powers the adapter on as before. If the rfkill state can't be
read, keep the current behaviour. Setting the Powered property over
D-Bus still sends the command and reports the error.

Assisted-by: Claude:claude-opus-5-5
---

Notes:
    Tested with bluetoothd built from master on Debian's 7.2.9 kernel,
    Bluetooth soft-blocked, AutoEnable at its default:
    - without this patch: "Failed to set mode: Failed (0x03)" at start
    - with it: no error, PowerState off-blocked
    - bluetoothctl power on while blocked: still fails as before
    - rfkill unblock: adapter powers on by itself, PowerState on
    - block again: off-blocked
    make check passes.

 src/adapter.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d3aa03f..1561ea3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8260,14 +8260,23 @@ int btd_cancel_authorization(guint id)
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
 	bool powered;
+	int blocked;
 
 	powered = btd_adapter_get_powered(adapter);
-	if (adapter->power_state == ADAPTER_POWER_STATE_OFF_BLOCKED &&
-	    rfkill_get_blocked(adapter->dev_id) == 0) {
-		adapter_set_power_state(adapter,
-					powered ?
-					ADAPTER_POWER_STATE_ON :
-					ADAPTER_POWER_STATE_OFF);
+	if (adapter->power_state == ADAPTER_POWER_STATE_OFF_BLOCKED) {
+		blocked = rfkill_get_blocked(adapter->dev_id);
+
+		/* Powering on can't succeed while blocked, the rfkill
+		 * unblock event calls this function again.
+		 */
+		if (blocked > 0)
+			return 0;
+
+		if (blocked == 0)
+			adapter_set_power_state(adapter,
+						powered ?
+						ADAPTER_POWER_STATE_ON :
+						ADAPTER_POWER_STATE_OFF);
 	}
 
 	if (powered)
-- 
2.47.3

