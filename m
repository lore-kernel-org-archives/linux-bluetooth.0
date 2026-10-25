Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792912579;
	b=4OoA9pXdUC5sZi09n7qi0R1mcr5Z5FD0JTBs5Xx/u5e1spXNEZfY03XlQofbFzLjfzDh
	 tPyqZ3+v1wJ1viBOeuQcCffX0ONiNbyfaEE4byk/bwoOSkmOVWDTuVRFiO7b91lxvG68t
	 PaPmVoo1USHHd5F7+L0Ku8cXVNxNeDklEW7IAb2aeuRlz9LKNu2vhnBEiO5Vc7vFQMEfy
	 sRTw7yRQkXS4+nO2E079cYwIBebK8ZWdfQ+S+W1WI+IBcrUEcEdT84lIhlWX2cktRoeBO
	 z2H9DxUZbAqTZYI/gbmQa3X0rD8oVm9HhR7759OBMaS3zVAoQ1fHAN3Is0fXqE9zMaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912579;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=LZmi/8D69OZunmPkZZpWC28kiqEgHbLAk/mMp7+jBWM=;
	b=uk3X4R7yDE1GVS0AMTj9HhlbFG7UJN+UWrpSXDsnbhiKpq+PIQr7fvBQcay/oePh8GgS
	 XG4jUdtGuDTCl8/9KfkXZXhPiush7W8mkDbXZ7P3fQxGE19/wZWx8XYtcMbAEP26vN/uN
	 FkZ8g+o/P6ivg4FG3aDDUGKkq8veFXaebFhrjBquWowCcD87B6KrXLF9R/xkfSFKgfoEJ
	 woxbSk6QxugEzl73aTumrGvJbCGCZIev8P3m62znFu98hJkykWSVhAS9YzDnT/l131Pr1
	 +Ow6ArgmKsh4ph51EXnu9ThI2OFgp9iJmdD4PsYqlxEF3WncpiOplKCIt1qrMMGBzcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sadiqpk.org;
	spf=pass smtp.mailfrom=sadiqpk.org;
	dkim=pass header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=t1Py6SZK;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E8606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2026 07:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A62E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sadiqpk.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sadiqpk.org header.i=@sadiqpk.org header.a=rsa-sha256 header.s=MBO0001 header.b=t1Py6SZK
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jC7Mt0H99zMlGd;
	Sun, 25 Oct 2026 08:16:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sadiqpk.org; s=MBO0001;
	t=1792912570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZmi/8D69OZunmPkZZpWC28kiqEgHbLAk/mMp7+jBWM=;
	b=t1Py6SZK/OLvcfbh23+g80JLLMcsn0FrUepLF4aUrP3WUqZQld0xuxOZiwS4HKvVG9jg6G
	FQSvG2k774kXqyqoJAOtKDxo7bf5Mcsd4G8/D1lgMhup/CmNEG0ydcFcCNPp+d/MFHNl+J
	oMRUAd4kCaCFLrrkbwB8udcTriKoc4HiLpasXlHom4225yCtSmCu3mOWJ5Qio/kTUQIQl7
	olkl48YYyfVS4n0wBGUKDmJqijXAJGTCSGio/0xJ73qmthDQS4j2uhMrabHJQ6XEr7A/rZ
	Zv6CHGrDv5G4hRgiOhYMHdd9XdowoX9ifx+lo2yQ9G0VpRfvkgXvGjiuIdofbg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of sadiq@sadiqpk.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=sadiq@sadiqpk.org
From: Mohammed Sadiq <sadiq@sadiqpk.org>
To: linux-bluetooth@vger.kernel.org
Cc: Mohammed Sadiq <sadiq@sadiqpk.org>
Subject: [PATCH BlueZ] doc: Improve obex MessageAccess Filter Types doc
Date: Sun, 25 Oct 2026 12:45:32 +0530
Message-ID: <20261025071533.2567150-1-sadiq@sadiqpk.org>
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
X-Rspamd-Queue-Id: 4jC7Mt0H99zMlGd

---
 doc/org.bluez.obex.MessageAccess.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/org.bluez.obex.MessageAccess.rst b/doc/org.bluez.obex.MessageAccess.rst
index 7d784fc62..047b7d24a 100644
--- a/doc/org.bluez.obex.MessageAccess.rst
+++ b/doc/org.bluez.obex.MessageAccess.rst
@@ -115,7 +115,7 @@ uint16 MaxCount (default 1024):
 
 :array{string} Types:
 
-	Filter messages by type.
+	Filter out messages by type. The specified types shall be excluded.
 
 	Possible values:
 
-- 
2.47.3

