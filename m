Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9C53359B
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981811; cv=none; b=h+HRtz74Dx92aJseTQl7A3mr58S4NqgIEobNiMXi4peAX5RiQTFwqn554T/E+Z3WQ0XaKEdclRIRx6EQlLH0tfMrKIwhvgPE7dcNZvtHgphwzofs1i3m1muVyYos/fFKMI7mfQKUHEW97YB3G5iW13FYwyM7NAzC4MIPK7Ef8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981811; c=relaxed/simple;
	bh=lUgQTdz3equyJwiQYvjAMr3TDu7jid3ZQdkL4AE9jvk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAlu34DC1qQ2WtY1gjVIevI2NXIDzdu5zErLJa8PG0E5fonRrdQOimfCbKD5nBBuVRevu6SlOL9FCpRbgYgE+Ko7jMmzpy+zUh6XS400h6J/SZpSlbPmcIctXu9DMOQIbf9/t7TUsmTojU6wtPsBzAg2AIzzxU2A+1fFrP6WNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNHvaRRH; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNHvaRRH"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a6c77d255so621364137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981808; x=1789586608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iYfL9qlWYwNmra+ri3FcuP0h76SVizTl+sTY1F9v/Ak=;
        b=qNHvaRRH/lvwyIGVwBxBq7FwkNEA5I6FK/+CbZshoLASx3V4MnJCX3TVfwWCusp24q
         ExbcodfJkSDy2G9StdXIqzo81xX5/VEoZXryrIu8HHhZjhmW2bB3dhgusgx6oOV5QU2y
         ZHcRyMjgkibjSTQuOUj8ZKRIjtZ80/4UiukLzahcctalcC7gYkDseqn4iQwjy2UeWitY
         uG05iejq1kZix8oaJ0B5ST+K636YU8SemKAzTnPQHDcNeryls6khaMntYxC8uB6wf+oB
         ljIXnqfdWANzDDGsfZeRZVZ4pZ7XDYP8b8jmwXHKOFmvWFpO8TaL5F8dZotoJ/fWZDGn
         Y5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981808; x=1789586608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iYfL9qlWYwNmra+ri3FcuP0h76SVizTl+sTY1F9v/Ak=;
        b=L5gNCqjeRyD35pKtbeVbfEyMM4Q62TxCzpeouBJ4DUCEYD81NnFwFpLBS5xOUHYBNs
         vnB4SEz0pqoTQvaJ/CiNFH3wogCM7Q6PkLVRauF3P4inoslT/twHcw7a8GlHZvv+jatX
         NMuahI0PWN4EkVFOKvmyseVs7eW5IJwJB7DRhv/ewoI1sN76RfT/ZIPsJuTBiCW/Cwhf
         QoHFxGQ7bADJNUN1pMknVArcc/1C6QFhDp8Q00c7l0Er7ouz8n/sv3kQgIug3oSkY/6n
         k4lzUIv+ZTVTZNGA5QBjVEsAsMUINmd9zVt3t+5LEdkgQY04TveqJrObXknaloRAhH2a
         c4bw==
X-Gm-Message-State: AFuF++nnEfb1S9yZSR+oOmcChudmL7fXyWy8jNH7cOX+TrIDn8RAk0KJ
	S4WmtBxZsCMpdZafoVm8DA+BrTVNOKDzl6PFUPzWbDgfwR+iBfnrDoR/DmwgObEE
X-Gm-Gg: AYBFou2xQ40hPC6iyckGetKh2/y8cVMa7Ode8apdq4zbm8Ocsjrw6I4Fn/LuzLWPRrS
	mD0HqiLQFgMObfcgQwfhPSuB3nQaJaI2AHIgfV8faSEbAZsI626TSchLKATOKNXtLWsusYlEkQU
	rS8skG2094YmgO17Clmu7rYiMflr9XywSp5Y49PrB92zZbNzPdYBOVE24hPvnSMjXem0UWcbk72
	dfQ+JJBJ634P79u69+EDva905juxsMFzbwhUt2Kg3t3Y39YejznsXxP/6icUFWjxpf+kDrqXU1u
	1R3+q9Klc9oaLqPzmnC57/4BUPBCNOimR8dtV+Sm5YjP8H5vrDbkZ22ucDXeAbKh4yS1zWZSI6q
	ZzrbCLh2IEh5hXVAH5dJ3ioTZErHgzD72Fr2zIIHVvAxvQT5oFkFhRsGq2JJH0Z2DNQtpNWVWw9
	teQp8df0PDI8TCRn1sc5uIpRu4FpoHmmTpTWrQQwCDthf2KhTUsqxxVLwjYUAYYsNd79n+qoYMU
	ir1aDY6ltdIN5ZYewHC+OcGYmHqYQ40t2+bg42rlWOA+NvVCielLySDZ3k8vySTMQ==
X-Received: by 2002:a05:6102:8095:b0:783:f3bf:f9aa with SMTP id ada2fe7eead31-78f757d562emr3069352137.8.1788981803578;
        Wed, 09 Sep 2026 12:23:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/12] client: rename media endpoint scripts to include the codec
Date: Wed,  9 Sep 2026 15:23:02 -0400
Message-ID: <20260909192308.1306567-7-luiz.dentz@gmail.com>
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

Name the scripts registering a media endpoint
<profile>-<role>-<codec>[-<preset>].bt, so it is clear what they set
up without having to read them.

Assisted-by: opencode:claude-opus-5
---
 client/scripts/{a2dp-sink.bt => a2dp-sink-sbc.bt}     | 0
 client/scripts/{a2dp-source.bt => a2dp-source-sbc.bt} | 0
 doc/functional-a2dp.rst                               | 6 +++---
 test/functional/test_a2dp.py                          | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename client/scripts/{a2dp-sink.bt => a2dp-sink-sbc.bt} (100%)
 rename client/scripts/{a2dp-source.bt => a2dp-source-sbc.bt} (100%)

diff --git a/client/scripts/a2dp-sink.bt b/client/scripts/a2dp-sink-sbc.bt
similarity index 100%
rename from client/scripts/a2dp-sink.bt
rename to client/scripts/a2dp-sink-sbc.bt
diff --git a/client/scripts/a2dp-source.bt b/client/scripts/a2dp-source-sbc.bt
similarity index 100%
rename from client/scripts/a2dp-source.bt
rename to client/scripts/a2dp-source-sbc.bt
diff --git a/doc/functional-a2dp.rst b/doc/functional-a2dp.rst
index 779bcdcc0ff8..03b18a7201c2 100644
--- a/doc/functional-a2dp.rst
+++ b/doc/functional-a2dp.rst
@@ -20,7 +20,7 @@ Two hosts, connected over BR/EDR:
 	| host0                  |     BR/EDR      | host1                  |
 	| central                | --------------> | peripheral             |
 	| bluetoothctl           |                 | bluetoothctl           |
-	| a2dp-source.bt         |   AVDTP (SBC)   | a2dp-sink.bt           |
+	| a2dp-source-sbc.bt     |   AVDTP (SBC)   | a2dp-sink-sbc.bt       |
 	| A2DP Source endpoint   | ==============> | A2DP Sink endpoint     |
 	+------------------------+                 +------------------------+
 
@@ -28,12 +28,12 @@ Two hosts, connected over BR/EDR:
 
 Both hosts start `bluetoothctl` with an endpoint registration script:
 
-``client/scripts/a2dp-source.bt`` on host0
+``client/scripts/a2dp-source-sbc.bt`` on host0
 	Registers a local A2DP Source endpoint
 	(``0000110a-0000-1000-8000-00805f9b34fb``) with SBC. host0 is the
 	central, i.e. the device sending audio.
 
-``client/scripts/a2dp-sink.bt`` on host1
+``client/scripts/a2dp-sink-sbc.bt`` on host1
 	Registers a local A2DP Sink endpoint
 	(``0000110b-0000-1000-8000-00805f9b34fb``) with SBC. host1 is the
 	peripheral, i.e. the device receiving audio.
diff --git a/test/functional/test_a2dp.py b/test/functional/test_a2dp.py
index f176e4296439..1ab712cd0da1 100644
--- a/test/functional/test_a2dp.py
+++ b/test/functional/test_a2dp.py
@@ -93,8 +93,8 @@ def a2dp_hosts(hosts):
     """
     host0, host1 = hosts
 
-    source = start_bluetoothctl(host0, "a2dp-source.bt")
-    sink = start_bluetoothctl(host1, "a2dp-sink.bt")
+    source = start_bluetoothctl(host0, "a2dp-source-sbc.bt")
+    sink = start_bluetoothctl(host1, "a2dp-sink-sbc.bt")
 
     pair(host0, source, host1, sink)
 
-- 
2.55.0

