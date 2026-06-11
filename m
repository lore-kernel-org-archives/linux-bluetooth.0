Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27D3D1712
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198577; cv=none; b=Bjqh2hTQ9B/mTXJVFx5oa3VHsIrx3m2O0744K27l0uDYBYYFrQ6pQZJmG/Z4lJlqFAlacNFFnE2jT2gWIz8fOE29q5zDYFs/jjVcwEBXvggmnVJuX7PXiFfylyR41vfgnfQvfPkLXvUqwvyoIjtYiWA2pP4L5zEL4/Gxvv6sS/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198577; c=relaxed/simple;
	bh=RDo5LBmQlWj/Cks1GTmDGsejy4j23of7UFqZDUtEnW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdRZ0a+lhmz5ejOkt4saSWrmOo65WyGgMxAuMF0PguSXysFwd+0AfmqOugX3CwqrrJGUEe+Xby578F8tP8kBbfl2XlhcevLKDNXS1Gmn6At3axM/BUrF6Sz/34jK2LQxKRPn6vBUfFuwKUWCx0b2Tq6E4+N3fo+5Of9wDrbJLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PczR43c9; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PczR43c9"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-96395a59ff6so32967241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198569; x=1781803369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+5PZQ+O9EKebWQFeGVU0C1w+W1WS9wpVh9ZPl0zH6c=;
        b=PczR43c9MYaCMK4BpjiWSsatwGzxwVHhwYFSgfcZS6Lc6XhIe0wuBVV5QzVoSNdJ59
         y2Sl/W7djdrhYI/3cbVTgHfyFAqEkrAFMnOSHJp3wCNQ0R85fQLwm+IwzMDzVEhCVkHq
         5bFIDgZjni0/oM06O720j5QVwBKhASX57nxod6iOwO4q5oGk/CBUdiqrWSXLMixGjnOm
         y4gr9OdKbVu9aJPtAROFl69vq52JFEuxqmE4/dJXKG8oGb88sHkUlW0Ha11USN2QVbqq
         XO3u2SNdio9aJwBDzz+eEGmHiK/x0Qx6eQIiEKcvrMtp25PZGIfVvWoogaSEdG1RIEA8
         w6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198569; x=1781803369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O+5PZQ+O9EKebWQFeGVU0C1w+W1WS9wpVh9ZPl0zH6c=;
        b=pnDhoIZ9t9u4lXeMhAM+41swd5OKA0aJ7AylyVIi7vWy/EVMudkfAs70ur63at9Yp+
         EicVoEGeZwBayrrzoe/55WqwLyxWkUmllySgZlBJMlwb4+Rh4Nkql8TzeXUcERh4ZWP4
         wk5cRM8p9vZEKSAG4SP3n5tuCwI2QPZAEBv7oBtDJhZkM9/zHF2leKjzgcqASTXcbbaG
         R+IRrV20oQ9xzrV3Wa1tf50hp/rb/hTmSeV95jt7YDwyTpHFP0Uw7AO0+3OOkexAK71J
         oW/sbxuUPbflyPLry6Yj3UdZNIndhefcB2pywJUWXsR5IdRPwkOqIlDtnERf6ZZMXBD3
         66cg==
X-Gm-Message-State: AOJu0Yw5bUMtpH0+xsScL3M/po5iZTzuuFO4MO/4t+1NnUotoS0MfhNa
	3enVA9uKZakZ8G/+YX+oYa6+ghOIR2ZMVR7u2VF7bCJxYQwFziq8wlS9N4s1mnvi
X-Gm-Gg: Acq92OEay7QwtvyN9BG+OmClk93/XYkOzTcf1LE0GQ5d8Tq22ac2Qrwzuul4BYSboKc
	JkbM/Vcd5IoymrRtehTwxoY8iiE20ZxR2wUTlAt5Yps9VmJ3X0y7s6oh7ulHJawsTGWos4NsN2s
	SSYNo+DMrkpdDRHtRaFQMFYKlpxOX4Qf4Av2/fTBlv4lF76dhDgH2sAaz2YGNC3J0CPVg97ym14
	k24cCjm2hbEUx8Cob4FoqnfJ6CiySAJphUg1HP4eJjq387vUkGf5bpdciIt8CtwQjQ1Bf3ci10D
	fl1f/Xhh4HJwBhNHcbXljtkLf6ilz3h8UzIXwiL6kx2HR4liKjnF7QnI9gQ9qZOF4W+3n5+tnwY
	khOBgbNH+ASatqMh1gq5NEGKjjBoEMfFndqEsiC8oOSGR2p/IkLh4WhuRdPhKDVcNsqx3q01U6n
	0kOKMUJCHt+GjA4iU/TZB+/jSfdlE30425GUzjPbliGAONkMvjq7Lo9E6kgjL5YNiV2R5ksRszr
	3X05UJG3a/gX3/qPg==
X-Received: by 2002:a05:6102:548b:b0:632:29a5:2b27 with SMTP id ada2fe7eead31-71d5cc7fe1cmr2385788137.3.1781198569499;
        Thu, 11 Jun 2026 10:22:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71d9267bb61sm1689828137.9.2026.06.11.10.22.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:22:48 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] doc: Document Push behavior when MediaAssistant is active
Date: Thu, 11 Jun 2026 13:22:35 -0400
Message-ID: <20260611172235.92930-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611172235.92930-1-luiz.dentz@gmail.com>
References: <20260611172235.92930-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document that calling Push on an assistant already in active state uses
BASS_Modify_Source to update the existing source rather than adding a
new one.
---
 doc/org.bluez.MediaAssistant.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 45143cee8dbf..2f29a7b5c253 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -27,6 +27,10 @@ void Push(dict properties)
 
 Send stream information to the remote device.
 
+If the assistant is in the "active" state, this method uses
+BASS_Modify_Source to update the existing source on the remote device
+instead of adding a new one with BASS_Add_Source.
+
 :dict properties:
 
 Indicate stream properties that will be sent to the peer.
-- 
2.54.0

