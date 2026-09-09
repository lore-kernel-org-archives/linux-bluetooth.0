Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3015519A2
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981814; cv=none; b=gmEbqb4Z2EwCRQseMPpGCAk7HGXpHgOGQbMSM7lohA79yWVVS0zxtxIPUxnHF55Z/wkjeKDPvKfayvoFtbpiBdr6MZXtv7rp4XxOYJSrglSOYEpUgxvRTcNqTPNsqdYFyK/6wqd4ADklG8R6J5IxYCopoL+EQC4MfEFzGIHA0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981814; c=relaxed/simple;
	bh=EEaLpCYGE9W952KeSeB4JQ5rksmQvl+eJaH98k/ACZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8/4RgxG4QZUWfXDSUtikBo08SoFc4ux9lo30ikXj96kHSS3EkzmNQXQoDDRB9NygBEE8iKjmVXYDgGVzdCXhhb8EG0NayJt3M3ZSx46OJVXgItV3NYJQKDoxVE7a2OXM7eTfvnRTFKP6LG1t2jn1i/UHyDGcBvvrVz8SdI7XfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYLBR/T+; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYLBR/T+"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so1555249241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981810; x=1789586610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AI3haSUzP7F9LDkFK+x3DVq08YksjoAUEUQTUtabSdM=;
        b=jYLBR/T+brB0z5EvanGpY8/J/im8lXBoJyDBF/cz1JIXUu6JD47r3x6NLoCGI0/DY6
         QEZSr2G443H6ALjt/sRxGWK9EEeZcMWbFdgvNpU4GvezwuFbcOL83MDt2TimDqXLpr4j
         XDQ3cyzlx4pRbqqPgHGccDoN7xHGDkcOxwz/H7rDb9SP+idlFU+HVDHGpmz0Y1cGZm4f
         u0x4wCPs4Zvr2lAz4I4gEg2iV70u7BlxudrlySkdoeluCvrduume3kVy6ZNgJI+vRGis
         IZx16blR0WZTJINdliu+TkGbeHzLACmcUNDgMwxabD+nk4LMgQoHuBLfcIk16PelAmjf
         KsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981810; x=1789586610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AI3haSUzP7F9LDkFK+x3DVq08YksjoAUEUQTUtabSdM=;
        b=lWdlok5xXHw1pYIQJd4JiYKb4WgZBX/3frR91DoKJicLGfSBrmdpML1P/bGTXblbGR
         GClZKLgukv2kMMwUPckO9jzBTGXlcBYx1/2BmvNMTn1WVkICdwzbtzRGPxNWsNOwB/Tl
         dHhehxpHInekt2pTyrUiYib+iBuGBCjYqnFF0pkXwHgJKkdEhhZcwFaXxlTyv9Sh0Y/l
         PI4j8119y4ZqRcZX/3PiGCAl2HMr9/WSFJ0w53WnkYTzetaJHuPaew0o52De8uOgnLc+
         8Q9Fi5eqy+Y1DbA10Hz3iFyCAKIjcCNSJUvsaDoe+f/d0eazSD+6DUbsZDIu3BsO36gD
         zcdw==
X-Gm-Message-State: AFuF++n93tbI71/JYHM0w53+DWdDO8Zv9tVixBPvzPttF1HH1vBr4x3X
	eI8gwY0NibNrwkpTl2nvHJvGxwKeF8wbyadFT/D60pnR6vnjUaGPiySfDO2aGlob
X-Gm-Gg: AYBFou3YLJUpxZDyoDzrZv8/fCxgzyeNwq4Sa32r+2epNduZfyR9aqmB9h5ity7ZDkS
	7SIK5BKmThXAKoQmWRyClM9i6t8i/Kuruk4jY6xKJIdtXfe6h2v2dOOJWA0aOQeDM6+tv/LtGC3
	s1BUaH7iHktrFie5MYf9HDtSGVqF2wMiaaMcF6pWWUqAI+lwAUthdwHxuvVaNQIEPAButLs981/
	WgKX/Cqy4PaLViOYuxQqvHIpHaAwMr2fu2hWyNPN5y9b7XFuLkm/VGNPLqrDO7Qu7k+lyriskv9
	VQxTZL2LAXGmsD7LjEy2pd6CFbNJOtTpaRxegAzV0BGueARbzpBlJklo4xp5aOvhOrA2t1je3b4
	elyIY4cdcd9U+1juZSai/XFqbUKX6wfZ7DV0OmRRg2sRy4lEon7G2w6o//LbtLcZnmhzpJtuiIX
	yyVopG8RgAaww0LTXHtCR6Udj9dnsuj5p7/CkEhytcjFNHYiKTMn4AJnOzIc/7CEblMZGUSa4zl
	TQv3NpNRrEo64/TWBvD/9q0YbSWvw78mfRdzFgP/2d69RSWbd/VvC5sLVoNs07XAA==
X-Received: by 2002:a05:6102:943:b0:77a:d089:3dd8 with SMTP id ada2fe7eead31-78a4aa5a199mr14320486137.12.1788981804612;
        Wed, 09 Sep 2026 12:23:24 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/12] client: add BAP endpoint registration scripts
Date: Wed,  9 Sep 2026 15:23:03 -0400
Message-ID: <20260909192308.1306567-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add scripts registering a local PAC Source and a local PAC Sink
endpoint with LC3, to set up the two sides of a BAP unicast stream:

  bluetoothctl --init-script client/scripts/bap-source-lc3.bt

The locations and contexts match the ones bluetoothctl uses when
registering the endpoints itself, so that the metadata of a stream is
not rejected.

Assisted-by: opencode:claude-opus-5
---
 client/scripts/bap-sink-lc3.bt   | 32 ++++++++++++++++++++++++++++++
 client/scripts/bap-source-lc3.bt | 34 ++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 client/scripts/bap-sink-lc3.bt
 create mode 100644 client/scripts/bap-source-lc3.bt

diff --git a/client/scripts/bap-sink-lc3.bt b/client/scripts/bap-sink-lc3.bt
new file mode 100644
index 000000000000..4c3cdc51e785
--- /dev/null
+++ b/client/scripts/bap-sink-lc3.bt
@@ -0,0 +1,32 @@
+power on
+#
+#
+# Register a PAC Sink endpoint with LC3, to act as the acceptor
+# receiving audio, e.g. a headset.
+#
+endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left and Front Right
+3
+# Supported Context: same as the contexts bluetoothctl registers with
+0x0fff
+# Context
+0x0fff
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+#
+#
+# With narrower Supported Contexts the Enable is rejected with Invalid
+# Metadata, as the metadata of a stream carries the Unspecified
+# context.
+#
+# Advertise and wait for the initiator to connect and configure the
+# streams. The transports do not have to be acquired for the CIS to be
+# established, as bluetoothd sets up the ISO listener on its own:
+#
+# advertise on
diff --git a/client/scripts/bap-source-lc3.bt b/client/scripts/bap-source-lc3.bt
new file mode 100644
index 000000000000..8bd03044af6c
--- /dev/null
+++ b/client/scripts/bap-source-lc3.bt
@@ -0,0 +1,34 @@
+power on
+#
+#
+# Register a PAC Source endpoint with LC3, to act as the initiator
+# sending audio, e.g. a phone.
+#
+endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left and Front Right
+3
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
+# After pairing, configure a remote PAC Sink endpoint with a preset:
+#
+# endpoint.config /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_sink0 \
+#	/local/endpoint/ep0 16_2_1
+#
+# A stream is created per audio location, each with its own CIS in the
+# same CIG, and all of the transports have to be acquired, as the CIS
+# are only created once every CIS of the CIG is ready:
+#
+# transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_sink0/fd0 \
+#	/org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/pac_sink0/fd1
-- 
2.55.0

