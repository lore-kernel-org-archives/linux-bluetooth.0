Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4335339BFF1
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788978539; cv=none; b=isoWj/e88NFuItP19M6ugiF7NwEh1i30UCSSpc8yW2CWHlXcxKufW+mYdZgIipuo1qKKeILH1e60NcPcecaJOBj1lHHD9rIanZvLhTGqiKvr4/8AV3l4pHZ46uxVwQ8V0g/igeHbviMohiIjjlvmPdd3m17+Fgv1nIjTdUFbRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788978539; c=relaxed/simple;
	bh=Cgrt9c54gXlzSJ/92mj8J+mQTsSloyeQxZv0DNkzLoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIn6e4bmCXZJGEL1JT9kFDssfV19Z3vhtsMuJ3VehiRuhRECNmvENRsr0+TiA3a227LVy8u1yngEKlZt9eU5FjBdLZS4I+snE7qUWxTZvHOeSGf/m9nebXdxAp5gNtjXjV2rXpiV+HNKd7oglpw5+iAjlLH7GQUGXzSI902ECEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nT7vK52c; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT7vK52c"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292faso560290e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788978536; x=1789583336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0+HXy0qpq2hqos5bScnG0cOJqu0xQZjjhKMhoKY/fns=;
        b=nT7vK52c1EwKgLBMmLiwK2VkmvSKvC7NWNuhxPTNiWDEqt2XotXWf1R/oNZT/Z8qGD
         oyOquCNkrT7w8DutsUJORNFhJN0Ae6Ia4fER69o/AHzivd1kR2x2gzNnWetvmdXakmND
         q5Iyhm84GlOlE+ERbiMTT2pfqD16jfVFmmUVei+ZJtvqc0Pix505Ceq8K7jBPnk8wEEC
         33OahknRoBmurOgrUdzU1CSl436JB7Uxzc4K3ZNJOOqVIiU1DBUCjPl5H+msACaWquuN
         gKabZMv3kGuBslXrN9zzzo2UTnS0sHFX6XfeejlGrIogym91qtsN9dwaAcUHqVk4MF08
         3PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978536; x=1789583336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0+HXy0qpq2hqos5bScnG0cOJqu0xQZjjhKMhoKY/fns=;
        b=eY8R5wHQAkEZBeb1NcKKK5lKCRPE3Ede4K85NU0UL/DCZG7+5IVySG9MHS/ademukL
         YZ5FjP+qSajpaCoHMV/aH4VUjaGK9L188M8qqO9ePOG9rpbcKbsE2cEvck+ZdJV5mU/q
         it9creYGWt6ZJ/lnf0UjBpZTnnznaY67Al1S9fQR3iVI7FXXOAWxcqOrya9Ir+Ze6QxZ
         M8lMqunsoxpDr/1AFFEHkSwt4tL0VsSE0ov+/IviOZWPpT/t5eNSYCtNerh2YhrkJG77
         GY4e1Rrpgw3IaCs64GaoedeuPdGtOH2QcghzbUIJ1l2MVY7UJ7BELbc4RXXHkbj2cj0j
         zZfQ==
X-Gm-Message-State: AFuF++k+1ZXrriz5JWVzartbaNftE2KLAZ55/o71x+/BwpHg1OiymXWS
	MjQmLCKiQfC6lUuRNWIovc2MVsE6UbvKcRAqjj/6mXhuBgShdQazVhpiXowTBAIh
X-Gm-Gg: AYBFou14GeHmpXiHnr8aNPot/Kr65asQyp5mDepcLwvkys2uvLniph7Poy1oL0GjWhl
	JWKvAXdGEXWZ7lKJM7PqFsTMXxC4u0DlRfEgTdAzE6sRTm6olxSu/i5SpZFqAoCEg/bDVT+m5D7
	7MeU8fIDJow48KKKiG+UcaLh5hV4b1+kaTRemxcsrfD++x5BitYkT2W/tWKZfpPVyF8m8Ix+Zvf
	0Ua8iMTga5REBNrcro4N3w4saIJwmtf50deXwAiG4zs/mRZ6zQp5qvScyaBvjqqhonvUHN5Kjlr
	Aig3pogjaB4MeqG65nUM0aN+SQ/u0qRyjofhVUcZgfERYkbGyJY/+wyXyfycsbvAtRcZwZ1+hgH
	91rA4JpQLZ8k874Pg2DLGVgflzocTQQbUvajgJz3UADINqhnTZmN7VOVDGudRTEwGYEtWxrsQ6O
	Yf+BHDXAIBb3NnvgqIHWVECKYG5k+4yjm8UmVKPN8A6Z6u3dsTWw1Q/luJz6hWH5I8Iw5xdefbK
	UBbmb8D+GbIr/89Z8ye8vokYLhoK/uyZZ5qvaPzrtwpwj+OoaSLoO1G7DOkqN54Iw==
X-Received: by 2002:a05:6122:d26:b0:5c5:731b:11d2 with SMTP id 71dfb90a1353d-5c82883a91emr4393656e0c.8.1788978535896;
        Wed, 09 Sep 2026 11:28:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c81c506f31sm5399388e0c.11.2026.09.09.11.28.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:28:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/10] doc/btmon: Document the command latency statistics
Date: Wed,  9 Sep 2026 14:28:36 -0400
Message-ID: <20260909182840.1289776-7-luiz.dentz@gmail.com>
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

Describe what the command latency measures, why deferred commands are
only measured up to their acknowledgement, and how to read the count of
commands without a response.

The model drafted the text, which the author reviewed against the actual
output.

Assisted-by: opencode:claude-opus-5
---
 doc/btmon.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index c8611ab2e9e7..80c8a8947caf 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -591,6 +591,9 @@ Analyze mode reports, for each controller found in the trace:
   events, ACL, SCO, ISO, vendor diagnostics, system notes, user
   logs, control messages).
 
+- **Command latency**: How long the controller took to acknowledge
+  commands, and how many commands were never answered at all.
+
 - **Per-connection statistics**: For each connection handle found:
 
   - Connection type (BR-ACL, LE-ACL, BR-SCO, BR-ESCO, LE-ISO)
@@ -627,6 +630,30 @@ interference, retransmissions or controller buffer stalls. Comparing the
 maximum against ``average + deviation`` shows whether the worst case is
 representative or a one-off outlier.
 
+Command Latency
+---------------
+
+Command latency is reported per controller::
+
+   Command latency: 0-215 msec (~55 msec +/- 70 msec)
+   Commands without response: 3
+
+This measures the interval between an HCI command and the ``Command
+Complete`` or ``Command Status`` that acknowledges it, so it describes the
+responsiveness of the controller itself.
+
+Commands that are only acknowledged by a ``Command Status`` and complete
+much later through a separate event are measured up to the acknowledgement
+only. A ``Create Connection`` that takes three seconds to reach its
+``Connect Complete`` is waiting on the remote device rather than on the
+controller, and including it would swamp both the average and the
+deviation.
+
+``Commands without response`` counts commands that were never acknowledged
+at all before the end of the trace. A non-zero value usually means the
+capture simply ended with commands in flight, but a persistently high count
+points at firmware dropping commands.
+
 Packet Loss
 -----------
 
-- 
2.55.0

