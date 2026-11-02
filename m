Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656502;
	b=G+Q3QZnw3sOuGFjdQdhUvoZrBcuUiNf9q65uQ8P/XzYWblfLU55pNmq3jV2eg0b9CTVP
	 lOAwE7Ejooi/2WI0UdtMaookzEMf16KoC3AnnaJq4Kaho3WFWPZYadHlITg/sIg25K/4l
	 aK9a2wsr6asGradM76MGdLs3d7IaNA6mbOYAIFbtgvr2fH2qBCOz2HdX3MdC8hOdngu6b
	 5WM4Evd1YnD2BSSqo+krWf+CO65LsQwYyXxuHkQUfA8j43aJz1g3ghM3kfAlHnj4pVI42
	 JMtSDDBeHD4RpcUXsIu8Qngx20QGQzACKaDiB8oh/rS3+tSZO9HXz5nYOYT2kVqXrtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O6pHjPpZY/l835OWAdG1AgRWZfTphM41zQrpHIxuEAk=;
	b=YKVloiu6X75F22iGqmMFTSZFN0CEXBcpvacZ/01RlTC8F0if7qqBKVazL8Zj6Sza0d3Q
	 HaiwvJ07s37SPK1SkdR5TXokwJZc37BTtLzDKKJfB8E8k8Cwuc64GVm3Kr/I6F3UGRE3t
	 97zWXznnIbnwRFYpY4/GrNblmdHhqTlBKsDt3Py39xb8ZQ+DJu8bz+AiHiPBACuILZLw7
	 bYB0q/PDJeIxUv+LSFIQLvSa3fl5C6EHeiBDNexQRF7CfYQqR6AxJ9k0EWQPowAIuHCiG
	 xZmUAhMVv4Ser3v4xjZgVNUvao72p01vIUGEGL3E6c20LEGnc0/zGej5cTUqde8Ftzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTuDfxRA;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63703606A32E
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63703606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nTuDfxRA
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so83796241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656501; x=1794261301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O6pHjPpZY/l835OWAdG1AgRWZfTphM41zQrpHIxuEAk=;
        b=nTuDfxRAU9Ru8pDeZFdAj1PcQLokU7V/iT331VXo3ZHteVzMVPvP0LRUNWAeAfktce
         ztNOdGmIAdqqzWqVaMLxn94XUJuFykJYjhdUn/MuGOwhyN/o5D/pFrrGVB+sExGEMgBh
         F+i/cWLBFhfN9dIcNRS5zl7dEsacRQc4N+O3B7tQIbwVu+4N2pYjGyfPN422GmWvlPHx
         gus5/gaMQo7OUV0OziKF1SLibtqRcBQb8a2QBIw0ZNDONYrPtkjZAy3Wi2BnhSe1zX3G
         WS0s2cH3VdBcQhvOYhlTKnkfIm7KadwgzGPU7zmI2h/W1VBn3aeOrgT58BVoyLGtJVTV
         TFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656501; x=1794261301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O6pHjPpZY/l835OWAdG1AgRWZfTphM41zQrpHIxuEAk=;
        b=GlnVcrquvW7KfWyaxeWDnCVIg6WMsv2IPJdRWMqN6LkoZekR9pzz+lIDL43GEn4icD
         BzVo/LXXxALnWrWtSaJItqRv+jVb/whHDG5tG1gnPmFvlbtH3ZOPECM9rMHQLZlyWlrP
         l8xz2xF9GUJMhidP0SE/DzEEsjMGKHbonvwSOTAKaWmyVrWTn0A3oT4PE+jjk87JGQc7
         JP5iRRGk1lXMHdCBcU7tnp3uMr+UG2gq/vH/IuBRh/5rtF1YhKGhSVzYqlE3oIA4vBAG
         2Vii+SahVwVYTi/gr26VcMO586iJZd70XHk8epXz0MYAXS96AlWfErcQ1wdGLz0Mgw/c
         EIMQ==
X-Gm-Message-State: APuU4Z/y5P7r57PE09XNrysDtSyoby8pXxIOyH5hTO0jJgdZqhmc0I2Q
	pPtMi0OAY/ND8MAaBaYEm1fUpaWaujCn8TZnQwrv1cyB7nzMGhFuvFaDa3gJdCTV
X-Gm-Gg: AYBFou26G9HbNClfKePzstmrMlpp1dy9g4DcPyBO1ewZ+lK4OjR33m51RK2eKxhWrEj
	Ta6GWv3WqCJi2xTxVPUI8WloFJTFGt3Jo6OZBZpCZFcwqTEAJJ6riDqf8/IQm9v5yDvrm3QZ9xf
	qR9bf3BCAssax/59JLB8T0uKqioZllNDR6WUp762uxfx+l7/er7z5IfwYXDSW0FCwPVx2dRFlJG
	KM2VmUjb7dl0TCouOj41aMJmRI8z7XJNtzKouIHQnL6STDz5zKU7od5cPffwQrC/JkWUUiKDcKu
	lUvjyLHyfJYjMRK27CClSmvZU2AwZjZu09h2GHw9FUssp9c5prvbeV0uzSQvvLbPI7dDWHVLdL3
	F1HXr4FRBCXsBEMMfkrxlLF8p2vnuk4W1G3dXlK7EoGvNYZ2J162qOz8BUmj2ygnID2VMhKQQHh
	sG6APZ07YQFAP1BuacXjErI3G5gpScwBzfHOBWVrhowd0o5wJCNHBe0LB7SiEqy1ZmomFRSIg5I
	2sxczU5W5QAMpzOwj4lHYdbE2eYh6Y+qRjekus0ZmHtPOI92JrbaIGZ/BEx5rvGzdVqidE/epvZ
	Q/0XENMq6i3AJhUxdmcgyS044JlDd6zCQXm/sSe1Ov2fUzI7nGCmhPMMKI7WPNX9kUzDpImNqwJ
	lby8wTePLm3IKdymKzJQ9JY644TK+TAQDQV4IOVp22dwim+k4Mbr8XSLX96bqbSHj8CT2wlpvfC
	PGDq8=
X-Received: by 2002:a05:6102:5106:b0:7c1:e804:3c91 with SMTP id ada2fe7eead31-7d072c398bdmr2629661137.8.1793656501262;
        Mon, 02 Nov 2026 13:55:01 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] client/scripts: Add bap-duplex-lc3.bt
Date: Mon,  2 Nov 2026 16:54:52 -0500
Message-ID: <20261102215457.2553416-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
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

Register a PAC Sink and a PAC Source endpoint with LC3, both for Front
Left only, so a single CIS carries both directions, e.g. for a voice
call to a headset with a microphone, and describe how to enable and
disable each direction on its own.

Assisted-by: Claude:claude-opus-5-5
---
 client/scripts/bap-duplex-lc3.bt | 53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 client/scripts/bap-duplex-lc3.bt

diff --git a/client/scripts/bap-duplex-lc3.bt b/client/scripts/bap-duplex-lc3.bt
new file mode 100644
index 000000000000..af82658b5df3
--- /dev/null
+++ b/client/scripts/bap-duplex-lc3.bt
@@ -0,0 +1,53 @@
+power on
+#
+#
+# Register a PAC Sink and a PAC Source endpoint with LC3, both for Front
+# Left only, e.g. a headset with a microphone in a voice call. Run on
+# both sides: the device that pairs is the initiator.
+#
+endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left
+1
+# Supported Context: same as the contexts bluetoothctl registers with
+0x0fff
+# Context
+0x0fff
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left
+1
+# Supported Context: same as the contexts bluetoothctl registers with
+0x000f
+# Context
+0x000f
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+#
+#
+# With a single location, the stream of each direction uses the same
+# CIS, so the two transports are linked.
+#
+# To enable each direction on its own, as a phone may do in a voice
+# call, run bluetoothd with Testing = true on the initiator and, after
+# pairing, desynchronize the transports and acquire them one at a time:
+#
+# transport.desync /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_sink0/fd0 on
+# transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_source0/fd1
+# transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_sink0/fd0
+#
+# bluetoothctl on the acceptor acquires each transport once it is
+# pending, i.e. once its ASE is enabled, and transport.release on the
+# initiator disables the ASE of a transport alone.
-- 
2.56.0

