Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A5175A80
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 22:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774562805; cv=none; b=XbjdJXLCDnFdhMxSlGwFmZoGOuC6+pbMbW2uqFy2s6Tarx0TE24Vu/MMmFRyqmJdZ8Uvpzrg/hsEjcOphofkAokPgv7TPOmYg4AQLkLo4vE0DE+LIYkYbTCCR7rg4zwJNaaXroHRZORlUANx92lQAbzmISekgQaWHhhRsD79Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774562805; c=relaxed/simple;
	bh=++USdPL+pKrL/uXpRvVE6kdH8DsXg0VWGKl/Ymz5xcc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr3m6Siby+eq2WvqljWXI7nqRVyWg+upoBwIflBamKJN4bh7CIbE1xmhunf9kN1ggf/ftGSQYgT+fWPqOBZ/gd9awc32EoSIhUiIxWUAFVDsia/E2DI88Tg9jVAeEqWix8tQAE77Q7beyHyl53KAZEMbaA6zZRGKeeSESLUKdVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmOMoTVS; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmOMoTVS"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso1577016e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774562803; x=1775167603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDtitMS5FS4rBSSfPBCX9ivE7V7wG9L9M2z4VxSF26c=;
        b=SmOMoTVS/ec08PtHsYjEfRTNFpANKaxtCNO0MaPwlCZouIZwP6rtrLI78JVojgyAsG
         GzQdRgV+6ivUmovnw5KPIib3hdQBQVVnQRterPyaEXuAEYKkqOV6cVJXws4aAziMpG+K
         7MC2BwnjmAsV1uJVey2O6IA/+MYaJ+gTQpDbWL+NZKwmao2bF91ME26rIKIGOj4R6gGA
         6krU74bSfQHy2kp1Q9phSFbynmGRZcnOXy8yVzfZj7E/W7yTOKiGO7reoZvVSsz29iK6
         ud9B9l2+/WVw7RAUviO3rairC0+Vap+HwmSPnFm6PjASL3BnofqmDfNmautbR+h1gauE
         gM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774562803; x=1775167603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDtitMS5FS4rBSSfPBCX9ivE7V7wG9L9M2z4VxSF26c=;
        b=UIWsD3rlrhumJh6EW8GxCTz4bbV1/0vWO3hamw/WoQTPCYDuqCal3agTBP/iTp6Ooz
         1E8lqJPt1AR3tLyfVvPy8Z5955LJuMx8kRpZgsxms0Uem3uoLYekSw6fQucdqH5Y+y7t
         O3sEfzMGTydtoVpwbNog6uBlavaNh3bmhHt6Wb5xPfw8YjC2RQWProJk963f3Aeu1HtZ
         cA2S/X5rWTs+ijdKQU2eipG2C6vR+yag4htDv7K/wxAGPPOmZhDSQqMknprBQoyxxRAT
         W5O0GjzXLS/4gPYpCJqXY94axBgKrmXA6c6P8tO/tVXdu03lWRkXKKlbuGedvP9AUwOV
         xRJg==
X-Gm-Message-State: AOJu0YwLZ0rEx/V9N6bncQtQTOtphduwcaygn7TUYvRKAi1dl2b1R3Qo
	rv4INEdX21FtBqOr3gbs01/YDEVmUpNi0+l7BRoi59kfY38ACWJySQledRgRN6rO
X-Gm-Gg: ATEYQzyiPnnL4QlvFVa9n/lnWKQOAX33aPyc/DvA8frnmEitOZGc/gjGHGn2s7aVXsm
	Xu/wAo9DG/X4ezmBfQqiYTqe/RbnP5T+bvll66WJB/U3oreCaI8TYIc+bexVx57XAkjzK5T2A3d
	r7tNVXiH0HWLk75Mcuq0V0iajUspPgAMOSe4mJZJXbNz6kTlChn81m5XwoGaUXqRel9Teb10gZK
	FpS5p7nnkQwu1QQrnJSB1IkzG4TQfrIp/+Gmq3AxIzpKu07V8hosrluLU+FNBGfjCJbM6pE/itA
	s6w9lHAEJ64lnCgdh55XRG9LgeQM19oAYEtVMuumYviuCDrnNakUjl1bv4uSjc+Aiblzh2t/03W
	0HIaFejHRT2f9sJRue8WCn6TFqb9gnvD052SconmjUkuT5sAUUf5xatzCZ02Eg+7t1sdA70Kjrm
	TF2xCRqYXcyrOmyf4F08RlHuxpR7HPNQwd9hOSh5iMeRpgO8qAPUfz9Th1VSQPcFsnnUHwEKKsN
	uCAYVhwAwvwUIJJkLGUpFM6N30Y
X-Received: by 2002:a05:6122:4201:b0:56a:fc35:966b with SMTP id 71dfb90a1353d-56d4a4cb511mr72459e0c.2.1774562803162;
        Thu, 26 Mar 2026 15:06:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31c3097fsm6356071e0c.7.2026.03.26.15.06.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:06:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Document bidirectional (Source+Sink) ASE flow in LE Audio
Date: Thu, 26 Mar 2026 18:06:32 -0400
Message-ID: <20260326220634.923877-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a subsection under ASCS explaining that multiple ASEs with
different directions (Source + Sink) on the same connection is the
standard bidirectional/conversational configuration.  Document the
direction indicators (Receiver Start Ready for Source ASEs only),
a typical setup sequence, and a note that this is normal behavior.

This provides LLM context so automated trace analysis does not
misinterpret bidirectional streams as an error.
---
 doc/btmon-le-audio.rst | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/doc/btmon-le-audio.rst b/doc/btmon-le-audio.rst
index db909ac38e47..50ee11879bb2 100644
--- a/doc/btmon-le-audio.rst
+++ b/doc/btmon-le-audio.rst
@@ -141,6 +141,55 @@ ASE Control Point commands:
      - Release
      - Tear down ASE (any → Releasing → Idle)
 
+Bidirectional Streams (Source + Sink)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A device may expose multiple ASEs with different directions. In the
+conversational (telephony) use case, the remote device typically has at
+least one **Sink** ASE (receives audio, e.g., speaker) and one
+**Source** ASE (sends audio, e.g., microphone). Both ASEs share the
+same CIG and often the same CIS, using the bidirectional capability of
+Connected Isochronous Streams.
+
+**Direction indicators in btmon traces:**
+
+- The ``Receiver Start Ready`` command is only sent for **Source**
+  ASEs (ASEs that send audio toward the local device). The server
+  issues this command to indicate it is ready to transmit.
+- The ``Receiver Stop Ready`` command likewise applies to Source ASEs.
+- **Sink** ASEs transition directly from Enabling to Streaming
+  without ``Receiver Start Ready``.
+
+**Typical bidirectional setup sequence** (two ASEs on one CIS)::
+
+    Config Codec  ASE ID=1 (Sink)    → Codec Configured
+    Config Codec  ASE ID=3 (Source)  → Codec Configured
+    Config QoS    ASE ID=1           → QoS Configured (CIG=X, CIS=Y)
+    Config QoS    ASE ID=3           → QoS Configured (CIG=X, CIS=Y)
+    Enable        ASE ID=1           → Enabling → Streaming (immediate)
+    Enable        ASE ID=3           → Enabling
+    CIS Established (Success)
+    Setup ISO Data Path  Input  (Host→Controller, for Sink)
+    Setup ISO Data Path  Output (Controller→Host, for Source)
+    Receiver Start Ready ASE ID=3   → Streaming
+
+Both ASEs may reach Streaming at different times. The Sink ASE can
+start receiving audio as soon as CIS is established, while the Source
+ASE waits for the ``Receiver Start Ready`` handshake.
+
+.. note::
+
+   **This is normal behavior.** Seeing one Source ASE and one Sink
+   ASE on the same connection is the standard bidirectional
+   (conversational) configuration. It is **not** an error or
+   misconfiguration. Both directions sharing a single CIS is
+   efficient and expected.
+
+**Multiple ASEs per direction** are also valid. For example, a stereo
+headset may expose two Sink ASEs (left and right channels) and one
+Source ASE (mono microphone), each with its own GATT handle for ASE
+state notifications.
+
 CIS Setup and Teardown
 ------------------------
 
-- 
2.53.0

