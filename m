Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0A3BCD0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303376; cv=none; b=N8wnhH1xiKa52e6Uu/sit84yf0gnDqaeYCC2QUN4eGxHGbJ4JDbsET5S8QHyXUrin4cnbnB2Cwur7EYe+A750r3Q7BLq5F4Gbvp0uVetK4vMcRUne4p6lme/4Ntk6fr0QrjNLgNjMaBdVYynC7NNE8X/AxD4jyuhKw7C1ZHVMHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303376; c=relaxed/simple;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iObTU1CCjkKsf3UK7I0S0rGA1s4PoaMMqFr6uSeFir18xaEe+Od3aoBAOmNeBg7c7XjwsAoWlIFFzegKRol7ZdyR+/oLe+xAVA+re/Ane/05sS+WoMbO/p9qMIzCxfBPC1iRhsfN1hsUsw7T4Yv1toozoBkBlci+O7INX0nlHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y8xS6c3M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y8xS6c3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787303354;
	bh=F5rq0CqaD/lPPYF5BYi4zNLM+xq81c0JB5CkpKteoIw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Y8xS6c3MEwvhLjDMux0l3WfoCo1o5ZRx+heH7oWzk6zK6tzgyuzRaEVUP233yGHyH
	 UN5x3nhI082M4jQB8NGabOxA3PCOq69IdvTNQwMkygJ+idOMCEHWcXVkGRoDKmXlej
	 kBqSQs3Rf8Z3qARkbdB4HHtaUkAylpRhxpZ78Ms9Pcs1tQjrE+t2hXh9vLGLk3/oF6
	 SJ885kZW+golblXRiKPMh8vDDZ9durKsjhoWS+wuMVQgQeHfXDoA9I2QuYgj3PmXKW
	 KHL+gFNlZ6JSXusQNixVvZcF458kMKYnjyJCqeN8pkMyAu9tedn/8QrHw91sAhKaik
	 h+AtyIUVk7wPg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84BA217E0FC9
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:09:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/6] client: Display SecurityLevel in device info
Date: Fri, 21 Aug 2026 11:09:08 +0200
Message-ID: <20260821090908.1546451-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821090908.1546451-1-frederic.danis@collabora.com>
References: <20260821090908.1546451-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 069e20485..0531c9de1 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1918,6 +1918,8 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "WakeAllowed");
 	print_property(proxy, "LegacyPairing");
 	print_property(proxy, "CablePairing");
+	print_property(proxy, "SecurityLevel");
+	print_property(proxy, "EncryptionType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.43.0

