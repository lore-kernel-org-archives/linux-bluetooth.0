Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA63F54C4
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969294; cv=none; b=sPCLqUPD4cbDZd+mObdC0S0npaolYy8pRgnNEEcQHzmRf0L2zfakOamrnlVGFvXw4i+Egu7JIbUFf5okvs7kTDB7qeejGGNxFTlPmHPXgHQACLLnkWwtUAnaZAVTUZkvaVLL7RFg3O3LJa0AEVoEdpg7ioBFmsPbXjS4Yq1QF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969294; c=relaxed/simple;
	bh=sPwh16ArToN7yWaj/C2s8OWHs5NY7YmUEbTjfNJ3SEs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Scl6BTIT8vXXE19T8jZf86URGGRG3vF8g0gRzrnv+OKNg8goMkHQQQC0vWI+tLaqWz6j18XAkJ84raesstdCPMWd7/ZnUiyJlCo9I4XYL6unNIlbAk+8WnuKEbabO/bEfO55KCbWrMJsaa1EyS6f18o/3oI0bvHdYy0Nmnx/6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ+bac9Y; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ+bac9Y"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98a903b7e1dso1105681241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969288; x=1791574088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C0dQjwfHJ2yPjGmlvr16Pp57wjMPmq05vrYmYo0BUmU=;
        b=HQ+bac9YezGcTRH5p6ogtnYMZjMBE7duDVrSjjCLRtjUrGZ+YTlQD4oWk6kqQhypU6
         1/6AVXyTtrq00m89maVid66sd1QHNQ2qqWzxOhqVgoUaKnIyX7E98Y2tJtEbvD/Uhf7M
         XzH1eSC9DRAs51rsaZjC4kMQ0qYGBRhLxBmdw7liBmwAunhhcK3bOE0zMM0srWBvQIUm
         Rjw2I04+nV8giduBuSDtRE0pA/HmwmC/L8djVrpxE97D/J1USeTzgixtI2GdNHvaHQww
         JyKBRDmKzhV+iBxJgw/1ar8n7ii/w3zTKj1hlvp1kgYsEvoaBnwPDYi6fQad3YfitxOw
         w6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969288; x=1791574088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C0dQjwfHJ2yPjGmlvr16Pp57wjMPmq05vrYmYo0BUmU=;
        b=eA3QDE50nU6Cto8SdV9B1tNDJJ/ANsmPWSnEvJ+RKiEcr8WvrkIm95w0cMa1DLP9Ab
         vcjW5EEp9Whh8u//rGl+td9FF9ZjzeUe5V8PE9OnPuc7u4BxlO9R7fIMMBrp12N8boCC
         TJv6uXY5y6GqBYEEysTkBHLVTc+qbNJpTUeFYfEY5g+6EawckOeDrwujwsZnKUJOYmji
         eCMv03FAurMlYlO3OR6qz9jWddXXjx/eP0nN2cAGoUZFV2XxM0ll1Q9Dh1dHl638Evlm
         OKu+X21hB2uBOz+fMCUaudk+FWIc2hwO5OfkfFN83yrW/nplPa7hXeYuG9UlJR3rLsTQ
         ok8w==
X-Gm-Message-State: AFq9FYLk2CKIfJNI72qyQX46Hej83R/4vKx4cmGSCVbeCIGERVqvoRkJ
	TmrcjLfv98jJRHWcbc5xe3zcqq99aFBqJgAX3po/KHgFhj/ToEvYUc6SIszJY+vC
X-Gm-Gg: AYBFou3CU3tqJTAtB2EpY4N+KtZoBoDwUeouuz+SgawG8WPOgyisuVqXLqWPsWcfJqp
	lk5uKR0lY2GRY2t2Gm1XM2+4dqWTp8tOLcKbxuK1jtkIdg9yVVSz4/gW4h1/lDOUsyzr6Cgv6Pv
	9DFXLFOVmU8N3eISAFi0C0J+duK8xnbnCH8ZalM0hCED4BUfbdwY/MdICxdkPgDzYst0gZAOA6c
	km6J+T0IB7E5HxXwxIB8mjBHJmBgWbwZSueTX+eaRLzDSNWZDQhLLlWuNDXPznR2JMnmaTM9K2b
	zNJILw9Ae8Ql6yac5e0o4zCMTIfeSjiY7FiAbDqdbkk8noMHAh/hYK6EK+Ol3EvqaBtNtIiFKC5
	4I1gAfvXEPIzIWn6RNheXzETkxmHnXQd5/9kMjdClUiYF7vt38UEO9wEaYzUB0SMOpNfiz6Bvpp
	/bjFXeMBSoL1VBFqNJYHEIVLage5Ncwsu/cbq0wXK/OPj8by/e52ymDbir4rioUFXNYi2clKUaj
	hcZinFxmbDX4h5GsBXrxsx8IQy9xqA5V8RPy46oPn3v+7XBWcCdBqISWPBbO4lSsu2+ZK+e+L8=
X-Received: by 2002:a05:6102:5802:b0:7b4:6720:f954 with SMTP id ada2fe7eead31-7bf8355674fmr1940109137.11.1790969288057;
        Fri, 02 Oct 2026 12:28:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 3/7] monitor/analyze: Fix the size of SCO packets
Date: Fri,  2 Oct 2026 15:27:55 -0400
Message-ID: <20261002192759.3071262-3-luiz.dentz@gmail.com>
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

The SCO header is one octet shorter than the ACL one used to strip it, so
the packets were accounted one octet short.

Fixes: dce3971d227d ("monitor/analyze: Fix not calculating latency for ISO/SCO packets")
Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/analyze.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 168efdb4b882..b132643154f2 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -1392,7 +1392,7 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
-	const struct bt_hci_acl_hdr *hdr = data;
+	const struct bt_hci_sco_hdr *hdr = data;
 	struct hci_dev *dev;
 	struct hci_conn *conn;
 
-- 
2.55.0

