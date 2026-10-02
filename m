Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE43F58E8
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969294; cv=none; b=Z7d+AudvtvCng8XzMOFsVCrdjQcSQDQxFyPx/gDxXozEXc6caSN1IfZWKhuy77yI54WJ5eN6aawVN9rXt/VPBH6B02imL1nN/wHLpvLsSa2boxgfcsJM9K/f9ygFRmW9jlbq0i5pR/Pl6dxOomgo3NjFlyPZ12cpR5mhXBijrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969294; c=relaxed/simple;
	bh=ae7cJiNZgRG1DHBuCP1zMJxTY+xSSV4Dx2OazlU5nJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUeW28+oTPn/cNAWbZ7T7qXHG8jl9Z9BLfLq7Unpm9OHhXfTno5j78H9z+0nPn48CTeo+gcKlrpDL9ztgLI/l91ct2bfdSvJIYc9O6CfZZqUjWa5Qex7MpUbdTTOM5nyCRjgXRhKwj6ndikX4v0KVLaMiMMUTO8CiFckMlaQ8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrRQeGmQ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrRQeGmQ"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7b1e67fcd84so1456274137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969289; x=1791574089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mx9QnZ/PTwrpIGhCvH0dEg0eIiKxZDNJxJAWMjEVIkI=;
        b=RrRQeGmQ1LL/eAuTx60wYwIUuFegmPEeeUPeQj3Lq2TCZLFlCgRvibGdH8vQBEXKbG
         ooLcVAE2nsvzvbJX9L6oFT3XWXmiIDOSdA8Zd7dlXqurTUFK69oLhYdyDZAN3IXGqpHs
         +SzEVegYc2yCA8BNfSgZBhZQXBWh/619UHhzZXvQCGAJUAl7lzYH+o0wjMAevB5V2mAE
         DlL7cSfQd9N7TydI5/0hPXMw0CeSXczAYJ6WC14XAn7YaEfHLHxWq7yVhgUmVAv3JrEu
         j5EDi37OUwbY8Wpksu9Hf0olF7brwWjY5DDTakB/0ZdxIrNM7Gg2VschkGckpxp7LmO2
         t5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969289; x=1791574089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mx9QnZ/PTwrpIGhCvH0dEg0eIiKxZDNJxJAWMjEVIkI=;
        b=JhDzCmom5BrCD5cFOAv/LskH/A0WFdlz4XlhUZILX5tj1XjOHsq1MOgpSxKj1MdzLG
         S9CR+eNSE/AgcJCK3sHLlirSQFosYavoROc5zN6nNOo+tombaYDlgNa2Rf/HOXae1EWo
         oZatZhTgPIxrbl5D4lRjFtJSMMDtMr6Okk7uYxddgH/go+EzZnTKrPw56FfHnl9P6hth
         ccxkq7PPAXN/52UWHHeL2edYBHMf7W4ioFbC5pTmjlhNBRLcgNfkUOxF/vmSnGRXQs2a
         eJDWTnJCWmBemie9Xrj+ombL0W4KW9+QEzofsxP74BDBjW4/EsqxOQgxBwJhpXKnYeTq
         4RrQ==
X-Gm-Message-State: AFq9FYJ2EA65FQqfc6oMpPag2FZHP6MgtzFLkJE3o82CEHgdof248dpH
	6SYJ2Pckv0pt3ReqGfDW+zRiwqHV77ggvIawiI6b/MHX0SQkZ1G8PF5Vyq/t3FGJ
X-Gm-Gg: AYBFou0RuPWUzGKxRfS7BZzdUZQdeQoXyhAIUBaENW+7vTFHVVmafTVUp7YTie7Hbxm
	uIqpKEksJLoodGii4UYJQWQxULHoeI1shjpuGWbvG8Gd9+HqpHXgs7DZ3oh3yeC6I0QMfpX2QdS
	FJrcGeROocXl+vGmNkXpnt/s1+XHUR6Awa6XTYIbgnXi0ft9Eyhh0rAZFWqFKip5hlBfw2+pZNi
	mK3uVU6wyNpYQn2diVfPQEAl0LVTlTyWLj4mcTPuoH3If23BHf9wQax0LU8tZERWOEnsD27FVpE
	sDiB1q35tPCVM2Kj5WwTEcvCNjaSM6nNw5s3VLMqZ0Yr46NbTfDnpLnNwUccLVdsZ0g4u4GAo3Y
	3n75Pesm86JNYhVcOdQDKoRUCgGGuP7uC03s1iWuZN6WVWNKa7/ivE9UUszXcAIkhuATm6D//z9
	4SfiB7zwiN4uSkzVHGgS04/XDz5QLyriYipA2wpzaCIK+A5+1kIPnXWhSwjPZ8LN0Zxlcpx0tfE
	YyAZIFY98M79FVM8EAaBpe3ODdhtv3qbpzqBCQOzHi0Ih59Z75x+2qtmKZ22gwXuXheS3cbqBU=
X-Received: by 2002:a05:6102:8603:10b0:784:a925:3f0c with SMTP id ada2fe7eead31-7bf7df582c6mr1407070137.0.1790969289173;
        Fri, 02 Oct 2026 12:28:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 4/7] monitor/analyze: Fix the type of synchronous connections
Date: Fri,  2 Oct 2026 15:27:56 -0400
Message-ID: <20261002192759.3071262-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Link_Type of the Synchronous Connection Complete event was used as
the connection type, so an eSCO connection was tracked as SCO and a SCO
one as of any type.

Fixes: 1f6e606c8504 ("monitor: Add connection tracking for SCO/ISO with -a/--analyze")
Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/analyze.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index b132643154f2..c5bf88216408 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -1063,7 +1063,9 @@ static void evt_sync_conn_complete(struct hci_dev *dev, struct timeval *tv,
 	if (evt->status)
 		return;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle), evt->link_type);
+	conn = conn_lookup_type(dev, le16_to_cpu(evt->handle),
+				evt->link_type ? BTMON_CONN_ESCO :
+				BTMON_CONN_SCO);
 	if (!conn)
 		return;
 
-- 
2.55.0

