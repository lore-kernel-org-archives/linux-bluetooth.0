Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0B4190671
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171302; cv=none; b=cLvkP+6CB17FORxGwY7kICRM57uYzLG+G+i54xUe4Z9xiYd66Xw/WRmpt/dB2b0cTnRGZC7LhOR46wbvT9qNo7X9PX4XNC4ZYeP4UxAKdhosQ4v/egzXXqb3lNTRYW02FAAbzckBeYTR7M+H0PS/hdW1m8hxEgI22oQrdcT8jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171302; c=relaxed/simple;
	bh=zucuwRzPwnbALFb0QQqY6Y4SrezZ4e2Uc5ZDpNFMpy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GkQU1yC/e6rzQYA/g1O2B7fTRlNeSa3/wZJs3xQ4Y7iRpi8uvZddg+7UYR13E68hpfB/UPYftS1LxmHc7agXcuovrObLXpFCVK7ootwOHeqjJurBiXZyDYp/L9XpNs0AURvaYZAPry0A0L3uqj2RZUDou5naSdplA7bgey1K7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2IYhQjl; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2IYhQjl"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-8430557e436so1647412241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724171299; x=1724776099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4k0oyaArmrTRChexp3A7axxXJn5CFtt9suCpVQLvw0k=;
        b=c2IYhQjlpzds0pH/Qiwa0rIR5ArvelFFKTRCyFwdxPKQ5V8diWOrc33ZFKoqKEXjKT
         P2AJl2iCTK6KKJdeb6Za7c51Ylo0WMkmlzWpsfxdw6txrIcGRap2oP00ezv4pNJnnb9v
         J3gJcbOQ6oAD1Wx03dG9XG/f8swkaHnT1pMqLxY+yO8z7bkUX89/be20uBsxNeTSbluE
         r3wrBKw/VmT1Qh3S2BYtg1zh9O0t5wJ/jhIvnrQCDTWQzYxAh6wHMPYOW7TaGyPTw8Cn
         IGJ+mUm2U/YrpfQ9m2CCbcgmcx5tNBbH+TNsub8V8eqaOBMRLv7y7gqjDhGj+aGtvaJx
         K6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171299; x=1724776099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4k0oyaArmrTRChexp3A7axxXJn5CFtt9suCpVQLvw0k=;
        b=EdHQTSxatN/eMLV+HJu2kMLcVVTq8FlHzrhipkd0JWxycNCnCAtP4K/pgsHyKQQd3n
         HdfKuCqZLsW7UFVJOaJfmG6UyrzgpZaZh5GdA3g5YxI0Ltzdhis+78Vkc9AHTQh0kg3/
         LNtpMXCg3DrlIFSPZEzfDBu6bIMKA/iN+8ovRa/we0EOkKuAQx5zObzu0PnxffmTQ5gs
         RrhxYn5magO5BawXM7pctWKgLAZ6aPmRSP+E+52bxJ7YmIsGTKJHdoqHngKL9YavgCFQ
         DTvsQc9kCd58S9RZrqPuGabKkPK3m9TMSfHee7A1KJasWVbN04q/IrTXz14ZOUSPBVKZ
         kraQ==
X-Gm-Message-State: AOJu0YxqoBXc26OM7UtopiIENb5mGowoWrx585ACb+DhM5vHU0hUbcru
	jXhK/FF2+o+iwof97NV4We0IHYCmrfNgSR45JbpsQXgs98zetc7OgFBdXQ==
X-Google-Smtp-Source: AGHT+IH5baHFQd9hHD+GSXYrhrq82n/xJkWVO4n1F5isnzuoePcdUPR7Dfn/iHjJnWpYoP0P4MJrZw==
X-Received: by 2002:a05:6122:553:b0:4f6:a5ed:eb11 with SMTP id 71dfb90a1353d-4fc6c713793mr18023392e0c.8.1724171299272;
        Tue, 20 Aug 2024 09:28:19 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b901a3fsm1394845e0c.26.2024.08.20.09.28.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:28:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bluetoothctl-endpoint.1: Update documentation
Date: Tue, 20 Aug 2024 12:28:17 -0400
Message-ID: <20240820162817.179210-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates the documentation for endpoint.presets command and also add
some examples of how to enter extra capabilities/configuration and
how to setup custom presets.
---
 client/bluetoothctl-endpoint.rst | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpoint.rst
index 91409943a32d..d7865486e2a2 100644
--- a/client/bluetoothctl-endpoint.rst
+++ b/client/bluetoothctl-endpoint.rst
@@ -40,7 +40,26 @@ register
 
 Register Endpoint.
 
-:Usage: **# register <UUID> <codec> [capabilities...]**
+:Usage: **# register <UUID> <codec[:company]> [capabilities...]**
+:Example LC3 source:
+	 | **#endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
+	 | **#Auto Accept (yes/no):** y
+	 | **#Max Transports (auto/value):** a
+	 | **#Locations:** a
+	 | **#Supported Context (value):** 3
+	 | **#Context (value):** 3
+	 | **#CIG (auto/value):** a
+	 | **#CIS (auto/value):** a
+:Example LC3 since with extra capabilities:
+	 | **#endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
+	 | **#Enter Metadata (value/no):** n
+	 | **#Auto Accept (yes/no):** y
+	 | **#Max Transports (auto/value):** a
+	 | **#Locations:** a
+	 | **#Supported Context (value):** 3
+	 | **#Context (value):** 3
+	 | **#CIG (auto/value):** a
+	 | **#CIS (auto/value):** a
 
 unregister
 ----------
@@ -61,7 +80,56 @@ presets
 
 List available presets.
 
-:Usage: **# presets <UUID> [default]**
+:Usage: **# presets <endpoint>/<UUID> [codec[:company]] [preset] [codec config] [metadata]**
+:Example using endpoint:
+	  | **#presets /local/endpoint/ep0 32_1_1**
+	  | **#presets /local/endpoint/ep0**
+	  | Preset 32_1_1
+	  | Configuration.#0: len 0x02 type 0x01
+          | Configuration.Sampling Frequency: 32 Khz (0x06)
+          | Configuration.#1: len 0x02 type 0x02
+          | Configuration.Frame Duration: 7.5 ms (0x00)
+          | Configuration.#2: len 0x03 type 0x04
+          | Configuration.Frame Length: 60 (0x003c)
+:Example using UUID:
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 32_1_1**
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | ...
+	  | ***32_1_1**
+:Example setting up LC3 custom preset:
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom**
+	  | **#[Codec] Enter frequency (Khz):** 48
+	  | **#[Codec] Enter frame duration (ms):** 10
+	  | **#[Codec] Enter channel allocation:** 3
+	  | **#[Codec] Enter frame length:** 100
+	  | **#[QoS] Enter Target Latency (Low, Balance, High):** Low
+	  | **#[QoS] Enter SDU Interval (us):** 1000
+	  | **#[QoS] Enter Framing (Unframed, Framed):** Unframed
+	  | **#[QoS] Enter PHY (1M, 2M):** 2M
+	  | **#[QoS] Enter Max SDU:** 200
+	  | **#[QoS] Enter RTN:** 3
+	  | **#[QoS] Enter Max Transport Latency (ms):** 10
+	  | **#[QoS] Enter Presentation Delay (us):** 20000
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | ...
+	  | ***custom**
+:Example setting up LC3 custom preset with extra configuration:
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06 custom "0x03 0xe8 0x00 0x00 0x02 0xe9 0x00"**
+	  | **#[Codec] Enter frequency (Khz):** 48
+	  | **#[Codec] Enter frame duration (ms):** 10
+	  | **#[Codec] Enter channel allocation:** 3
+	  | **#[Codec] Enter frame length:** 100
+	  | **#[QoS] Enter Target Latency (Low, Balance, High):** Low
+	  | **#[QoS] Enter SDU Interval (us):** 1000
+	  | **#[QoS] Enter Framing (Unframed, Framed):** Unframed
+	  | **#[QoS] Enter PHY (1M, 2M):** 2M
+	  | **#[QoS] Enter Max SDU:** 200
+	  | **#[QoS] Enter RTN:** 3
+	  | **#[QoS] Enter Max Transport Latency (ms):** 10
+	  | **#[QoS] Enter Presentation Delay (us):** 20000
+	  | **#presets 00002bc9-0000-1000-8000-00805f9b34fb 0x06**
+	  | ...
+	  | ***custom**
 
 RESOURCES
 =========
-- 
2.46.0

