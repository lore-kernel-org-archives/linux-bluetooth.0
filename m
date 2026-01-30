Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250932FE58C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801978; cv=none; b=DHk9nbGcCSEsXJ9Vnm9px5FNZyki6UieZLWhtZKId7R7zbdaOwOpZ6RNGybQnO8YXXYf2WNsQfaKhXKSfUhuT0NmpJXjwzt/NCdQtUWzArYPSQoB69umT4tuD4y6lEG1xLDnx+d+UN+qBBxHcBRHKd7cI0P9WuJE0v6BzadoLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801978; c=relaxed/simple;
	bh=LYISWL86KL7Uk58GnxnrXddW+FoKabNbRJo1hjFBJbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzfOgvfm00uiA6+nWgj4XsgWthMKE9DP39ggEnqehNWQA3MdeatjL/NY8d6IZPTZK1jt1X60YF44VJHT8+wVp5gt79lbskc5ptnTZmKFLrVN7rGRnxETpB8wiUvt38+33bQJ9g1/J78bsQ5EiUc9ZzI0sGCx7Do4guDaVsRxrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6SaFHhZ; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6SaFHhZ"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5664848545fso892425e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801976; x=1770406776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQMn5YZxiOBfyGwvRG6Hb50a2WarYYSuu9UHaiS+tEc=;
        b=T6SaFHhZDSh0KIaY9DYglE7ycRtVTK0ZH0QKpIQa7xMYFrgggwEpIiQoSe6GJsnE67
         C6rMjsH9UezYAImCev01Oob72tA2cth29quP+ep31BvFbcDunA5D9oicCZb0SwY5il7m
         NecsY+nKzfsLduPf19ciLXs2DuoMdWm8oREggeRqAkyZC4gZ4WBri75k+rmgfLI448od
         6wEAHpDdsbtt+owQcQXYb7ewwfHeojfNxuI55NTmTWKdA84goopVmdsQg4uS6gH+Kphq
         YRcHqACVm2nen/Yqg6WxB+pDJGVp+IMa4/giM8gGwVKJOpmmMHcQUZcxAePmz6GhZu+l
         OVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801976; x=1770406776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQMn5YZxiOBfyGwvRG6Hb50a2WarYYSuu9UHaiS+tEc=;
        b=PWGHWUGui7rdpJKGiZ5H/viQpZeInurdT80PGoTatakSe8kMAm3VclbV8egjrpCRfN
         FaBFOE9V9PeinDvHy7NzbmCBTZ3T2cT6zR8FxXxvOTUiXqTXQ5mYEg+oUYQ6ykq6JTIX
         qIFOuA5xsD9SkuUDQfJdIxVZfed2oFGnFz8WtxgoBSdPClxvA0ISYNWUpNkBrzNhGP2b
         DpYizUfmrpQSXyLO3kLzmtRkOp5gC/Kxi5bWLjAYQqhUMzIWOY0PSTWah61LgcmgHSN8
         sDz54PA/G9qKAms7yHTtMod7mb+R4QQBUR5IfGwsdMPqDpk08ubqpqHWqADznOCzCklj
         iLGw==
X-Gm-Message-State: AOJu0YzRWMj/P/Eub7aSAsx6BVRO7aKeQ+0NyUdrmwC3xuWbEHRzhMUE
	GMa0JjvAJK3VgjdBC7QXrtWwYuqdjvIZbRuk4pB67ep7imijMFMVf3wIiY2eE8bv
X-Gm-Gg: AZuq6aIcq1LN6SGLuLptk0FVKadSAfiUvglFGtexjwirPYl2VaiX4Di4g0wxWppIHix
	oCbbG6pqjwhcVTg3wxvt0Faj9Ud85H+LqzocsToWuOWdb4Gmqysw9LrAc2VbPS4JyKRuek/4I3a
	O00/WZ4pjcDJwsBfc77qTR/mSj6GpR7WFQs3xaCfjcHYk8AesbnLNeTRprwVM2rFoGSJO/Ncjs2
	mVqW42rD8jCPyFZeG1n0QeEbuKCCTpUs02MR82VyMPHHL7v6NdIXXTOQrWbVhs4x9ApnLLpHuj5
	8pR2LIqKpWXFWkhc0+6IQwspC02LS8UcPLHPes/THylbIviFnW/ODQECZXzgC4ArPi1tvbeE9Hw
	TsOHcW9NWc6UAYidq3D8AP6bsMbWn+n3xNfVT96Ayw1LsgnWTVQkw37Rdme6c8nnWZJbVLDpwhL
	sANSl8lGcOnoDarsqJyWekFm6QNSGHPLCTjhSuCn1QqOGwbNXxBj7Ry11ztJL15NSan+J4dm2cs
	26rEQ==
X-Received: by 2002:a05:6122:c21b:b0:563:71e1:c878 with SMTP id 71dfb90a1353d-566a00db838mr851715e0c.13.1769801975820;
        Fri, 30 Jan 2026 11:39:35 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/35] doc/bluetoothctl-assistant: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:47 -0500
Message-ID: <20260130193921.1273263-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-assistant.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/doc/bluetoothctl-assistant.rst b/doc/bluetoothctl-assistant.rst
index 33fbcbc764cf..ff22e2a82291 100644
--- a/doc/bluetoothctl-assistant.rst
+++ b/doc/bluetoothctl-assistant.rst
@@ -18,6 +18,9 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [assistant.commands]
 
+This submenu manages BAP Broadcast Assistants using the
+**org.bluez.MediaAssistant(5)** interface.
+
 Assistant Commands
 ==================
 
@@ -27,6 +30,8 @@ list
 List available assistants.
 
 :Usage: **> list**
+:Example Display all available BAP Broadcast Assistants:
+	| **> list**
 
 show
 ----
@@ -34,6 +39,12 @@ show
 Show assistant information.
 
 :Usage: **> show [assistant]**
+:Uses: **org.bluez.MediaAssistant(5)** properties
+:[assistant]: BAP Broadcast Assistant path (optional, shows current if omitted)
+:Example Show information for currently selected assistant:
+	| **> show**
+:Example Show specific BAP Broadcast Assistant information:
+	| **> show /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
 
 push
 ----
@@ -66,9 +77,16 @@ Code, a zero filled array will be sent to the peer. Otherwise,
 the string entered by the user will be sent as an array of bytes.
 
 :Usage: **> push <assistant>**
-:Example: | **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
-          | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
-          | **[Assistant] Enter Broadcast Code (auto/value): Borne House**
+:Uses: **org.bluez.MediaAssistant(5)** method **Push**
+:<assistant>: BAP Broadcast Assistant path to send stream information to
+:Example Push stream info with automatic metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): auto**
+	| **[Assistant] Enter Broadcast Code (auto/value): auto**
+:Example Push stream info with custom metadata and broadcast code:
+	| **> push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+	| **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
+	| **[Assistant] Enter Broadcast Code (auto/value): Borne House**
 
 RESOURCES
 =========
-- 
2.52.0

