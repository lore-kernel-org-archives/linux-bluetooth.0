Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546887;
	b=XGxkMgl1f3WgRQZk4TqMRrBNqOQBV4FpWVF1Uf/PWw9Xb0O4CWycLTpRkF1ypYVJ1QOo
	 8naDHXdqB0tj7RgpgJwFE6e9b3xnr5dKi9QP+AdASRrc9rdU1JOtFT/Eel2Eb6X67SWoL
	 6hQxIsLzLT4iBS3kSjyKotZwF4LBoVxyrcitXWCsHLDlkPSPRsTmueLgRunCjb1436+c2
	 mZN45FnhRoDn2kzBG7F/fKjHiHAipRZ9YMzCZkFoH5qKYo59eNmtBAwuH43yy/PWon5ZA
	 EP+/UfcbJS1gkCoJgkyOYzDjlEFrQScMolGO97QuPZcg7Tu/jviVgH5ViyUUipFP6aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
	b=QiJVK+pC2+yo1lh+ni2GLjd6leQ2VSq+PE5nvb1uvKLb3pLuQDq33DWm/KzZeHQ9WniX
	 pE/hmm3dc6WF9dryP0+H1LrqZ63CB5Z3dlRMcUa9+gVJ9MwQuEiLTB7bWGBh5W6QqpYv+
	 C4/oQPZw9rK0i7Nl5kfKCXA+VMAtZG4HcTDvlsFz7AgWlrfU/G55ytwKOuTSSU9puZGpN
	 UK1dL523k5p7+4wkn/9HF4vymuchjWKY2OCgeUDWvOjUJWvm1yy0g8ES3l+fOjESV4QHR
	 QRB/6fQngO4+osTMOboForohyH9Pe+qtc/AYS/KjxPq90PofDJSpT2uk/VGb3XhYGpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=k6rT+n7R;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07917606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07917606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=k6rT+n7R
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36dbde64409so943710eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794546886; x=1795151686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=k6rT+n7R5TvV0xatutU4Jbk+GnJV1JH8W40xpKyEONSLMwmLZeTcrUUFHUeJDW/eC6
         1S7ZV+VRwDTXg6wDX+uEzINqapUxCiDMf3UqHWwrFzxw5hiY3HrmKgd+d9C3a8UK7Dfr
         zCwadCidYjcp8tgcPkwMgTptftUnWg3CJuZ1zbEMP41mABnSRKbd2946/kt6eok5wzXB
         xGYpPad2EzfwVYcuNSan8Jde1MZ9Lg6TbE7Jj/d7nQgewmzSK4tqXvzXdX4mKbnMP5Gd
         tRxMykQO2pAh8kWDb6rlH6P1K2Ev99Lx7wWDFE6oiHCHOtRZ8J5ozH/1ps06TMkfcHNk
         SUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546886; x=1795151686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=1MgDbMIXAN5OxoXqQI9ZqXzhjr2Q9YcJe4B+mAcch0ZNLBXWRb1s/UhLy41PFhAARw
         tUcc4Dy9PgSUWdezyfofS1/LEGoFB+45WiGlM6NKqz2k7fkP+BZIXAIHGMYkiaYlgTJB
         0nUGxQCcRfrHLOwBht/Y1NJCF1ewHCp0nTQYbAENa3Tk7TUllrf0OGUntztfJ3DV0zZO
         NY5YxEvi2DxdxvYc+Zk4YpRwjKqejxRuxlodNXK2Yt2zltia4sept1cyYa6zsm68e3Z9
         sst0/cS9PdPg9NXtTYcTCYtHTIsas9T1zCKcejnpBtU2cY3RK+VP3N74Nu6fUoqu1NL4
         cEGg==
X-Gm-Message-State: APuU4Z+Xs6uiO4P8j9trqph+Zyww7zVVeJ0dPRXExaxa6iz9V8/6sqUO
	mJ7HUL0E2v3voZ6jlNeb2YMZfM7Mg88BNRFOJH+6ueIHypCX9HyD4OgaJAIWpViOuDsx9nYL4qJ
	ROlIfxuQ=
X-Gm-Gg: AYBFou2A0+hjLTzekSWBfjLKvd28dCtF76c/eZ8siFitLusCwmlpywdbIEFn4RpQCCh
	y4J8Xqu0YU2SzHJ8e6JlwRzOaIZ5rDybzYhSSC06G8K7NrY9ctK8SgDfAM6jigu8nOCk1ivyeJD
	vTDnbHlg1uHoKk94hv8mIBDS3a0lebGUF4Zx+3/iz51+s8dN2S/PVHwhq2d+ef0/LRZGRKkAr5c
	awyHxOQlLULAkbCFiO+5yZG3IvWudeX8L+6pz18PJ/6l4bMUdVhvLYYoTxhEwfxiUxa1tF1mT8j
	b0UU7oqUXiW3apGRtv7g1xTdBHRAPXcxZjOBCKYPLeAGLmZ8d2RMEuDB5OyUgN5bW0xa0tQx2tY
	8WyRcEFI5akMrUViBZQLrHL4JMWI05EoSfEafI8ZPEIsTpqzsxXZtEFsjD3rEMYpz2KTNOjiluJ
	ViNhIwB+3PmNU+Omh4TJepeqo5TO9UG00+XvR8mq80QkpTyjwWzjV3hG3bVvLxNMZFbG2zgiL5q
	WnPEnQ9ZL+pknC8XUINuBB2VU+zroI6h5hmw1VitIVUSGx98DIZmcmOKUi7Ug/IcaBk0pcnxGlG
	RGKSdIsmDv7kbGgLZzjERflyAwZL+gU7chOvdMEdUHbdKbLJxZb6XJvpTNoPji1y/mA38FRnX1m
	F+Wj2aNyCtLUbphiuuR2tT8wfpgYQ6K7szdPpF9wkB7IAxxzSPp31dDLyHozHJlQRLQLB3O0=
X-Received: by 2002:a05:693c:8806:10b0:370:121a:b2f with SMTP id 5a478bee46e88-37965f9dce1mr1254778eec.11.1794546886098;
        Thu, 12 Nov 2026 21:14:46 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3597550eec.14.2026.11.12.21.14.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 21:14:45 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 1/4] org.bluez.Bearer: Add ReadRSSI method
Date: Thu, 12 Nov 2026 21:14:35 -0800
Message-ID: <20261113051438.75230-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113051438.75230-1-kevin@simpleble.org>
References: <20261113051438.75230-1-kevin@simpleble.org>
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

Add a testing method to read the RSSI of the current connection on LE
bearer, for diagnostics and production testing. It is only available
when D-Bus testing interfaces are enabled.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index 3db5237b4..803adb401 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -57,6 +57,25 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+int16 ReadRSSI() [testing]
+``````````````````````````
+
+Reads the Received Signal Strength Indicator of the current connection on LE
+bearer from the controller, in dBm, for diagnostics and production testing.
+
+Available only when D-Bus testing interfaces are enabled.
+
+The kernel caches the value for a few seconds, so calls made in quick succession
+may return the same value. Right after the connection is established, while it
+is still being set up, the method fails with org.bluez.Error.NotReady.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.NotAvailable:
+:org.bluez.Error.Failed:
+
 Signals
 -------
 
-- 
2.54.0 (Apple Git-157)

