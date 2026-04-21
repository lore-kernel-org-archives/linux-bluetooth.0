Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42381732
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786714; cv=none; b=XDO7nEJq4mtXWDI3RZQ8TX7WmbAxyhcyQPL+uL5WgmiDF23szwRI5N+o/JFrxaluRtpIa8IEJaSmne74vhNXAWF4dYsdQHOBioz7otq44Z+DwbXVSB7poX5ACp6cIO4NcJFB2tZ3aRrTn7y1ALoo963PGj4qX3rNrIaqRHlV3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786714; c=relaxed/simple;
	bh=3lJTJnEFlH9Sc7SLYcynTaaErN6G3zQbBfbRPexrMIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EUTlg4N5RKJ3LN2mUp59TG5phPFWO+o63gTHV1AnEJjGgClRUHyvFtAgx0U0oEt1m9x/6yululemT0Sq6u+f0doBiaIB5jRaccL1ivh048YXlotw9pVLyIq/3mdTCcX/+CyJrn1aC1EilOG6W3+wpn+GSuFmNmuiYAv0tS2mJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIgEX7SJ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIgEX7SJ"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-56f8b51db2cso1377771e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786711; x=1777391511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi3Er/ggNu5KXDyN3t/wbwFCJcqDhe3zhTiXLaN5k4A=;
        b=LIgEX7SJBp9A5wDQu1UGt1gqV0ExIFz1g434Hi7ERHj1ly+sO4EYVH0G1k81oO+xyn
         cQg7jR2+8sYQ1Ni943IknxXl9U0GvG+g2NwNcQCqp+NaF5FIDaM4xEMHb8l1xfQNSFiy
         S9hEcXNiRcJdpchoUjI5N0McP1FtdhjjPViTk852VLLw+Qd8zM9xpfWLEP0134nUF4OP
         aZfsqJ/aPiroh1109tSsl1z8lRYU5YQrN1k3SdquSkVZ+55tVIajwqG2YNUW8G/cBdXP
         Yduj2Jqtc75+vjrxeATw6NTq9qzN7xEiIySxvdHs4LxLMfd//EvQoxzpV0R4zTj4IFrp
         5poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786711; x=1777391511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi3Er/ggNu5KXDyN3t/wbwFCJcqDhe3zhTiXLaN5k4A=;
        b=HCXdXclw2FXsP+9oohlwAtCpZ3QTk6q50sDA6U3/3//01WMm5PFjR2RJ6vO/nPZVGl
         t3yUJpyf32JtBYVVqXy+76JU293S0p1ZUoCwlpUEBHNycAPw1Pm1uuZuBaxh8HikkABL
         CbDnssMJFpKFwSCKyPZFEXsPcPtalTt5CDnwWmtgff2l5inYhKU0cQGSTBaw6JgFV9Tk
         8BIOzAlB2V7U9yD1gKo164baD5wUCt0vnnEYlS2hze6FZolFCFZTX36rMHEN+3IE79w5
         81FHm5NI/FCXPCH/QciUfbVYON5sB59SaLrLhtH+CSB8qOmpjJHZYdXv+PGeO51nSDTR
         cOaw==
X-Gm-Message-State: AOJu0YyLkGVj5j6NjSaH+JTlVrEugXayl2DCnhMyXaTAizFGvhgP4Mnd
	6tolWLQpd3pjP7lw5Z93D4T4LoVKIGEqMXUc8gUw+sYrICM7oJv88kIC/k1KlOdmziY=
X-Gm-Gg: AeBDieudtnKHb00OzTOlIEeiNpl1bLBfPXChT7lKknPIHY8+5drljFLmPwxkXKo5gL8
	lfSSdera6vieRU9CITLHjW67BxpQedzVf4X8r9kLifxdz/XcP8v7sValKq0EF5Gfgjwyf67HoKO
	ASHj2irLccC+vBi/uVtbPO+531BBiFRx625Tv0lAENFmxlfIDke+GLGbyZOCzljZhZ/JCTgoTzS
	RUKFdWia2ryHIQX2wGi0+AFWzHSO0OXohjmWJiuVYKxnVYVxIC9W0fA7KJb5fYxoKWpkiHG6jI3
	uinIJss9TD3aOg0hS/bdfWITuXTU9viwf92NqvHEcm1jDjp9xzJ2VEH6yYqHiK4gluac0ZwR/q+
	PBNV7lNPxU7fjwVbjpDWrnSIC1k8VxEKES46Cb2qQw8/afXrGHiKEoWMh+7LiTFxxrbcjxA7yhd
	XJ2P9Zu2vYunqXu+dxcpFvSNS7g/UqAvj9AL9qVcIL3dSHsSSPQrxwnh6LwM07NcV1FInSBHiP2
	gIQQUBska0sc8yUp9R7esOO+QRW
X-Received: by 2002:a05:6122:e191:b0:56f:a3e2:66a4 with SMTP id 71dfb90a1353d-56fa582b8dcmr8732727e0c.1.1776786711082;
        Tue, 21 Apr 2026 08:51:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890bc746bsm6551779241.8.2026.04.21.08.51.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:51:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] doc: Add AI coding assistants guidelines
Date: Tue, 21 Apr 2026 11:51:41 -0400
Message-ID: <20260421155141.1863559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add doc/coding-assistants.rst with guidance for AI tools contributing to
BlueZ, covering licensing compatibility, human responsibility, and the
Assisted-by attribution format. Reference the new document from the README.

Based on similar documentation from the Linux kernel:
  78d979db6cef ("docs: add AI Coding Assistants documentation")
---
 README                    |  7 ++++++
 doc/coding-assistants.rst | 47 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 doc/coding-assistants.rst

diff --git a/README b/README
index 74221a29ca91..1da987087355 100644
--- a/README
+++ b/README
@@ -284,6 +284,13 @@ For a working system, certain configuration options need to be enabled:
 		The plugin is built into bluetoothd therefore it does not need
 		to be package separately.
 
+AI Coding Assistants
+====================
+
+For guidance on using AI tools when contributing to BlueZ, see:
+	doc/coding-assistants.rst
+
+
 Information
 ===========
 
diff --git a/doc/coding-assistants.rst b/doc/coding-assistants.rst
new file mode 100644
index 000000000000..3a643527fd65
--- /dev/null
+++ b/doc/coding-assistants.rst
@@ -0,0 +1,47 @@
+AI Coding Assistants
+++++++++++++++++++++
+
+This document provides guidance for AI tools and developers using AI
+assistance when contributing to BlueZ.
+
+AI tools helping with BlueZ development should follow the standard
+development process:
+
+* doc/coding-style.rst
+* doc/maintainer-guidelines.rst
+
+Licensing and Legal Requirements
+================================
+
+All contributed code must be compatible with the license of the
+respective file. The daemon is licensed under GPL-2.0, while other
+parts of the project may use different licenses such as LGPL.
+Use appropriate SPDX license identifiers.
+
+The human submitter is responsible for:
+
+* Reviewing all AI-generated code
+* Ensuring compliance with licensing requirements
+* Taking full responsibility for the contribution
+
+Attribution
+===========
+
+When AI tools contribute to development, proper attribution helps track
+the evolving role of AI in the development process. Contributions should
+include an Assisted-by tag in the following format::
+
+  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
+
+Where:
+
+* ``AGENT_NAME`` is the name of the AI tool or framework
+* ``MODEL_VERSION`` is the specific model version used
+* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
+  (e.g., coccinelle, sparse, smatch, clang-tidy)
+
+Basic development tools (git, gcc, make, editors) should not be listed.
+
+Example::
+
+  Assisted-by: Claude:claude-3-opus coccinelle sparse
-- 
2.53.0

