Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B4D39D6D9
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978537; cv=none; b=pViMKpYhTr/mqIUQqWcGf62N3sfVhYqJywA9yrnAtXGnSCeIMFzDJFyJEFQy2jZiJ7rnVsV/tRGBEY0afsyTP8seQztrcy512kAjEIcw7smrpx3GKIHTA7oH3wvzC/bsIQsW4Qthl8aYi0uprOH5dffeDgtQDjt6B1SpwfsjG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978537; c=relaxed/simple;
	bh=eXHQc3M+XObfHxATecCgTllzr3B1Qyn052kLxCTDmog=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSqoUZsjUywpvK4zCvICwiZAVwEAsuneoeBy8/SVBeFlbqvMJnq/xlE3pdkDPWutVMKGNRJhmta2vb+uA2mUu8/XjmpDj94hnmRjmc2qVik2cvHqlwtYpc6zwSSMq/jnuC+5KOOBvLa4QGo8i37XsXkHboHl2QEsUDdF/nMMEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cs6GnGud; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cs6GnGud"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c65093556aso4806975e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978534; x=1789583334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yh5Umdc7dh+unO1G5lMOsi/W9X96PnUgs3IfTsMp1K0=;
        b=cs6GnGudfUAUwlkwmvzE9KckGUjfdhn/YqzrOhaPdCiHFc1ziEKDHcjLHcakwu+I8O
         JQBuZPQjnQeTbJepoWnBxMF0dC8xlX8b9+5eU0oM6MsBFPC/WPhllnVF3XwRvQA7LRhP
         q4wqNn6CSbLDIjs/W4riqNarprhtZZxeTi3g/sA/wJfEINLH43FKbY1MlGYc1CMyNq/O
         /hUhjLOO7+2mLxLly6lXuPJE10Vg8yiilp/+c4e8Kc3RU4E6lbNehiG4nsTV6mAG8zTH
         Sc0IJoPABrMt/ODF7/IPEYIJIa4XvqFQQklqkv6S7KTeS6uR0z8gTdxiTS9h8+YScRHS
         RpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978534; x=1789583334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yh5Umdc7dh+unO1G5lMOsi/W9X96PnUgs3IfTsMp1K0=;
        b=KnUTbnUqf8Eoxd7YsPRI7TbbpXj2Sygv7PYqU0d+tLXv23FCKaJx2S3n4ltvmsoBbj
         SB4srtQjylmicpVEcsgd/UuE5T/nGMfH5dXolaCUjVSpv+WCiQUf6t5vrBvgaX6Dok1F
         1Q4n0qwB1Pw+xrHWYEDj14E3fTezFj6Mz1EcuhjZjgHFzf15afySRAUVu3zwDXIMYhY5
         06591vGjjmkNUN229UE2zYgS00WugZTi0pkdBuDv4d2ydI/14HQR0yMJ/Dsg31XZqyea
         yT3mLJY6EHQ2KyJf7iWdcxRyTg66LaF0seMSAMPzPbs9cRtiZq29/QGpegvSmHkaLDbe
         S2Zg==
X-Gm-Message-State: AFuF++ldHG0OJknbmXyGQU5E4mi6hHHP+SGD6pN9vsldzIVGlzKZ/Kvj
	dNATNAGblXxtHm9YjTaw69e/Mj3xGljpkswkzoey3KkoLRW3uT+L5L9Jg+Q7NKoM
X-Gm-Gg: AYBFou1ACKmsQpsnOlMD5/YeB4W1hjs4TjkBT3l1EyEKyXIzcnkIwgUHpwgHgSerM/c
	Gf563ONOypzTQf8M8rD8Jgg9NMzwilNhEVqy4IZWSDTDXLRHb6wBfj7Y0LZ5Yf630LRMCDx90Vu
	TlWWkpr2QAyrVEa6DFyMlIRhbVCBFYNipXWXzB6/YAFWs2kFc0MkmLgRtBYICbmb0Her1KRrGMs
	yXCmYXKdcVD9BWlsNPMTRpz5Yj7xPsnoFILc+/0PxMMnPWPFpiKAY7B3IyMCnIwStl62PzfG1Mq
	uuo34iUop/3OQh7v3Ef8eLOByk0D3wMRU1IKRPOuGK5jHfLdFCTyR5zt0v3V+3bJK/Ou7LFEZWt
	uPnuOindcHVqhV5vGpJs8Xdxf8P63NYsAG5T+Z7BKVUiV24NDPhmdeD25m/WDkzztanRBrN3NlE
	DNcXFCFW9O43rd1XneMv4yxb3wOzk2sKWTcsLxhINoWXQDxJq9ArgGDJ55CRjYBm8XZOOjpq9SE
	q9LbmGIxc+4pXlRZeCI3XRem3V7u9XHx7AiPtRIhWWxL9eUTRwHu59gQMmikv6dJQ==
X-Received: by 2002:a05:6122:d90:b0:5c8:2c83:9cb with SMTP id 71dfb90a1353d-5c82c830f80mr4113695e0c.2.1788978534221;
        Wed, 09 Sep 2026 11:28:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/10] doc/btmon: Document the deferred command references
Date: Wed,  9 Sep 2026 14:28:34 -0400
Message-ID: <20260909182840.1289776-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909182840.1289776-1-luiz.dentz@gmail.com>
References: <20260909182840.1289776-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Describe the Request field shown on events that complete a command which
was only acknowledged by a Command Status, and how those are matched.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 99d6c8ae2760..c8611ab2e9e7 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -252,6 +252,29 @@ when the request was not captured, which is normal for the first commands
 seen when attaching to a system that is already running. ``Command Status``
 events carry the same reference.
 
+Some commands are only acknowledged by a ``Command Status`` and complete
+much later through a separate event. Those events carry the reference as a
+``Request`` field instead::
+
+    < HCI Command: Create Connection (0x01|0x0005) plen 13    #12 [hci0] 3.175055
+            Address: 00:11:22:33:44:55 (CIMSYS Inc)
+    > HCI Event: Command Status (0x0f) plen 4                 #13 [hci0] 3.176055
+          Create Connection (0x01|0x0005) ncmd 1 #12 (1.000 msec)
+    > HCI Event: Connect Complete (0x03) plen 11              #27 [hci0] 6.178055
+            Request: #12 (3003.000 msec)
+            Status: Success (0x00)
+
+This is where the reference is most useful, since the delay between the
+command and its completing event is often seconds and is otherwise only
+visible by comparing timestamps by hand. Page timeouts, slow authentication
+and slow encryption setup all show up directly.
+
+Commands of this kind are matched to their event by connection handle or by
+remote address, so several may be outstanding towards different devices at
+once and still resolve correctly. A ``Command Status`` reporting an error
+means the completing event will never arrive, and the command is dropped
+rather than left to match a later unrelated event.
+
 **LE Meta Events** contain a subevent type::
 
     > HCI Event: LE Meta Event (0x3e) plen 31           #487 [hci0] 12:36:18.974201
-- 
2.55.0

