Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B253ABD91
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981805; cv=none; b=sia+lEjbpfntz9f5YE3zlTNCQY7wenUMwgEzyW+DovRtZnLiOP9T09EhNUQfQJnESNCnKJk3TUBReyxTM2DwNLPN6PvD8xpWyKgpMnrEjGLkJxdujJhv+xEsO2vkXenuG/wwU3BMPx5Tx9MF1K44xNyXAGhOGwMpQJdmHoNmiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981805; c=relaxed/simple;
	bh=jVd7n2q2ksKcOwlxZ5sDXQqcUTIy++d6bxyTZjbJKPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtqUOJ3hKNuUhL31XWiIVyOQIsS+LhgD6L8LlaB6Sra8uyKT/1i91CSxrdeFPlKfT8iW+Yd7ClTkeSUEuOrlkPnP7zhP4TuhDNw9/MYjQdXhTOZRBROfkKtAIc2nKh2zNa9rDc3sRqe1aoT4HOU+JhnmLYOp54Ur8rciYzcnReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBY5VWIy; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBY5VWIy"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-78a220b5778so166617137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981802; x=1789586602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HSpfSA+t568DJzIHrugZ+AFn3nfaiD4uCWene8f3GlI=;
        b=QBY5VWIyhckUZbjQfxEme1DDoBbs630AgW3HdCogTpP4VRcW3xL4gBQZb1VfB1vm7w
         9fCyLHfrnfn7qerjyTDrJJ/1MrJk0XKmZQdINwN5WsNPlR2h+b2UNEqNPgmb41/jZCwA
         T0Ya/V4xMu7/iVdL+8x9N718cH5VPIIog9sStVJnO9ag9Ah2ITfF9qdmJmomjvw+psB+
         P9KzP1z4O49QJfGHk99H6XmVEGY2rxLvsLw4tfsOVcrcNxjH6tNIsVAw2wTDatrcRLdR
         Juw1+hMsAOWHGXlm17YPaqG32mpm/UFU7wqiJ8ILLyD+XZKjucCBzhLePfJqx8iZEFZx
         Oiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981802; x=1789586602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HSpfSA+t568DJzIHrugZ+AFn3nfaiD4uCWene8f3GlI=;
        b=WVvgTTfngkfdDYBdRLcoFsphQDwXAzosYrGnnVzeAjy9e68i6WVvqGKWBu63Wmh3m9
         oFNIcw8S2DDbTDN9Gv1JP921i5saYE6kLaT4RxT19LEx8EAcyVQsen+PA6st7LQ1Ql76
         U6+qF5uZqa1FRSgqx1WOnCqhj76x8+CUVvyIzE87OHE9KU6FHp3hOGkp3tk1y8as0TmB
         3zhkvTgo7Q8r+ct/WLy3S87EvUur2jsAUu8AFflW7rh3bL053kZFEqRnQwmsVlcxg2+/
         SoJem5PkmNwYOs6SwClE1EuER29j+0/GxT3g9Ux1xiPrwWQyXX/EwbDRTrroy0zza3nW
         TbVA==
X-Gm-Message-State: AFuF++mRms1S8mjtpvYbLCaDJMVgJ1XEX5OqmnvHU17qLyEziXoYTqR1
	WW9ph0vFcHesxYQyZ7TDrmuID82ykQhyy/kmXLdUs6EFZcDbrzId71WKzVMjTlqO
X-Gm-Gg: AYBFou3f1LmeiribxihknAs4sQwD/+lHpVV0mv+eqQ21V2dw+IlvhD0x8b++PfLRLx9
	+sF2s1zrjRI6AZN9vMreCpMmdXQ19opH41xcNQfU+kcgu8LqO27e0WnwgML9ScDql4BIm5yQNX3
	HW/vPD+vTS/W0bmM30kAfZtJ3MFtHAFDPsLsAKrQGnd0cLokLV+CjqgxPJrE4+Gvbdx3bQ2uuFx
	R+RyctEMf6+KaMYcG5Up5Fa8xLEAWRK5Q6un4hel0SfluuS+stwiQJUHRAGT+LBkZWbjhA7p8rU
	u+M9zim6OL638PBvjNAx8luW1CpOzwHjCtqhHabw2KWocxt0IbyqlYgpZoE4BWDIhQS4gPVaAzH
	dsmwXBLYit001HahyAQytBpj9oa9mnK+LUHfGuegVy4D+LmaZqjDIKAYNfOiAYJL66ywY2SExhT
	3efZQ+egv8W0J7EIR8j2cFIjVLP8kqUWlY3iViLqqOV2QUhJgnR4zkH5hbbFLlQ5lxxW8+FcBMr
	1ND4j5XbSnbJEWpsCh7SIQFS64GNerGnFtgP+mrs/PG5bCHu6YHm2AteNZ/7RtEQQ==
X-Received: by 2002:a67:fa18:0:b0:785:6b42:b7b0 with SMTP id ada2fe7eead31-790d83f30bcmr265332137.4.1788981801811;
        Wed, 09 Sep 2026 12:23:21 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/12] client: add A2DP endpoint registration scripts
Date: Wed,  9 Sep 2026 15:23:00 -0400
Message-ID: <20260909192308.1306567-5-luiz.dentz@gmail.com>
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

Add scripts registering an A2DP Source and an A2DP Sink endpoint with
SBC, so a peer can be set up with a single command:

  bluetoothctl --init-script client/scripts/a2dp-source.bt

Assisted-by: opencode:claude-opus-5
---
 client/scripts/a2dp-sink.bt   | 19 +++++++++++++++++++
 client/scripts/a2dp-source.bt | 24 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 client/scripts/a2dp-sink.bt
 create mode 100644 client/scripts/a2dp-source.bt

diff --git a/client/scripts/a2dp-sink.bt b/client/scripts/a2dp-sink.bt
new file mode 100644
index 000000000000..3c7c040bdb5d
--- /dev/null
+++ b/client/scripts/a2dp-sink.bt
@@ -0,0 +1,19 @@
+power on
+#
+#
+# Register an A2DP Sink endpoint with SBC, to act as the device
+# receiving audio, e.g. a speaker.
+#
+endpoint.register 0000110b-0000-1000-8000-00805f9b34fb 0x00
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+#
+#
+# The endpoint has to be registered before pairing, so the SDP record
+# is in place when the peer resolves the services.
+#
+# A transport is created once the peer configures the stream, and it is
+# the peer, as the A2DP Source, that acquires it to start the stream.
+#
diff --git a/client/scripts/a2dp-source.bt b/client/scripts/a2dp-source.bt
new file mode 100644
index 000000000000..8f582e9f2faa
--- /dev/null
+++ b/client/scripts/a2dp-source.bt
@@ -0,0 +1,24 @@
+power on
+#
+#
+# Register an A2DP Source endpoint with SBC, to act as the device
+# sending audio, e.g. a phone.
+#
+endpoint.register 0000110a-0000-1000-8000-00805f9b34fb 0x00
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+#
+#
+# The endpoint has to be registered before pairing, so the SDP record
+# is in place when the peer resolves the services, otherwise connecting
+# fails with org.bluez.Error.BREDR.ProfileUnavailable.
+#
+# Once connected, the stream is configured and a transport is created:
+#
+# [NEW] Transport /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/sep1/fd0
+#
+# Acquire it to start the stream:
+#
+# transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/sep1/fd0
-- 
2.55.0

