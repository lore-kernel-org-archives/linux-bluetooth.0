Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615F5226AF
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867469; cv=none; b=aV/WJfycVzdlQJNbRPaVMtN3w5KqFAJk/FWdD3y7U8uRDk4+v0Y63uMJW6zFQPh9soUh5Hox+U7gteJzp1hDNWLbQbLaWmqZJElY+qB5YcRzj4vpxQtPqbk7mgYPkLpJOEOf1YzxeTIDMM1VrGQvzLxYGI4DwSaG8LEJvBiOPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867469; c=relaxed/simple;
	bh=k1wE0W8dKSWNSu6ac5gadV7jpUC0tWLUhhkStxgEhns=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgBEg31+u64O48OBw6TERBdRjUyr3nyLx6FYZnzlVLWb7hulNw2osDCyrC7U8TUzDPgsqb+fbH1fuJyFhpJwvITKhmMExWdErVsZdwFBDHjpuhkWvHXA+fnGDXA38KSQeyIiiWp7AGnn/r/1RrU6+mSJ4VGIgC7IwsLoXPreMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsxsxe3G; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsxsxe3G"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso6704112d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790867467; x=1791472267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZqQTJMgBdAWcjz7o4JIzsKklU1HAWUKH3Ka2NOU1xH0=;
        b=bsxsxe3G9PqCE904O1jw6FxQ8qUVMEFsUy8u4L1VUXGRszAeNt1Dl0qnObJwqdQlWn
         veXiZHAozZai9QiriYye9KRmaFar7E6Z4wb3mPC9PI53ZuhoYYtdjPy7/sK0d0a3AhpC
         idqHQpf4pZ97CtwczvBtdeSz7ESanCqxzOmX/RjuBbk5W0x1Vs4uBhE2Sa2q20dBVkP8
         /dSP/emOBmAwiExyxqvT1vCVG4H58z7ghGEqRpOxEUKcujkM8rVX6zvNJvKPMmkl7Gn8
         jyn2wfdGYe3Gokfz9g+0C/6GX48Iynn0Kfsa2ZVpJyLol2lcr5esxbaANqkU+8TX582o
         5QtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790867467; x=1791472267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZqQTJMgBdAWcjz7o4JIzsKklU1HAWUKH3Ka2NOU1xH0=;
        b=F5XRu7kII2kCJmkR3nVghvujyKOC5gfjkZeyx1dZjM+QjUGC8uJGykclPzzwTsHA6I
         V06Beu7UJXGLa6DjpUVs7nLuP06n8gTYWbHmkjtXv31YGjz5kvaacN6Ajq12J66hLqmn
         PIEg0OxmSc3Vx0w+UyyjWMb8/RQ0kwF896e/9qhuYYn/03PMpllKrJJ4YwQHTERzOuiM
         NYJCy4EMkT2f4qPSH5mcs78+0GObcWc9NS6rFKZUjMwnSkTHKJ36SNcIZmZo4s14KNju
         BFaP4zhavqwEx1th8REutzsn8QKH1AtyBxBkadmVrLcAYV3ArL9+XHTZwCOATwsl64o9
         52Pg==
X-Gm-Message-State: AFq9FYLPaRViZ05mLlp+eWgSPambll9qgu3ZLKcioR91M1pP0d0cZ7kd
	+uLlYjjJ/GxI9icUbNB4UO7QGLAyUCv5o0M5mOznOveQsgc8AmCyIiRemSqi2C0gnXHhTw==
X-Gm-Gg: AYBFou0kcWZhCG7n15nEcV+S6ynk5r3Vwf/NUlAdsj5xvyOrbrxAE35s/YTOaZUExeJ
	XKQtlDS3Lg3bLb6/xgPD3v2quWWyARs58NxH0InEqNf31m+fxTR8ELa6pawHFlhnFrvnY4oEuLA
	qsvxc9IokYDaoHXMSLVZQIFXJgZyyqjz0Kq+ZGZYUmyrqeIH7DGYyzF13M1KkiTD+BfA/WHQbnA
	sL+BE4s3REe8n54vzEvZCk1exNnlWa0hiAi5Zf7djlF0lz1OYnwPahViT8q3zUBBdA87uf8coYP
	BgxWaY+M+XCDphsUd5i4y07TF7unfdlGkNvL3ryoFzrU3Q6WIikaMCWMZ9jsQeLMla8MykJ53+7
	yRJFelOrbzgeJFJlt9yipLfWC8qqVB6MeCqDd49crCpU2/AXSBVQFrFp5C60wxGGGVacwYKzm/y
	zFWuS5tJYp8Nyv+fCl1L9KoUwEY8NeOsaR8tWUnB2Bqm4oGpnaKRKF6jj6hobiXZbohPmWRNloX
	lswiNlWWQur52WW85IV+P4opKgYEXpO+IVqEpZaXPA7/Qgjc7sXZjSbUGBt0NXR/JulwNoZFkrZ
X-Received: by 2002:a05:690e:1187:b0:676:961f:78a8 with SMTP id 956f58d0204a3-676961f828emr1078980d50.17.1790867466510;
        Thu, 01 Oct 2026 08:11:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-676917cee9asm1171933d50.3.2026.10.01.08.11.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:11:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] Add AGENTS.md symlink to doc/coding-assistants.rst
Date: Thu,  1 Oct 2026 11:10:54 -0400
Message-ID: <20261001151054.2422165-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001151054.2422165-1-luiz.dentz@gmail.com>
References: <20261001151054.2422165-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Let AI coding assistants that look for AGENTS.md load the guidelines
automatically.

Assisted-by: OpenCode:claude-opus-5.5
---
 AGENTS.md | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 120000
index 000000000000..f219acfe818d
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1 @@
+doc/coding-assistants.rst
\ No newline at end of file
-- 
2.55.0

