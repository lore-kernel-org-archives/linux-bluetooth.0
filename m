Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB093976A9
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434038; cv=none; b=ZKoYNyOAhuTA26nNOtyAr+q/a+JGh4M9OA9emtZjS65XE4tOBbgD7XTvd8BD3qfKatMwMZ8H2HRI4asopf8d5oCBiEGMlM2sYt3j7ApVwJRUY6v7GrnOuioOVY1jXkwhoIrQlgb2VyxWc4KLcyoSV287hyQABWLRvKE2nx/gd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434038; c=relaxed/simple;
	bh=RDo5LBmQlWj/Cks1GTmDGsejy4j23of7UFqZDUtEnW8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3cjNV93DODMcNeYZFszbIJbwaNWEOBbbuQP/LzvRGRAikDCkUOmu7Q2eNanRsoWrZzGNZRYJ6Z0boLIf3nVpc2d7S40A496hZIkbF2HLSlPfrwaLptfgAwt2kiGEpEzvN7FJbRoeQNL/5VL0HtfNLJ+hGwNoi6XqnQdXtVK5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwQTvXu9; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwQTvXu9"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6cf48482ddeso1204547137.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434036; x=1781038836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+5PZQ+O9EKebWQFeGVU0C1w+W1WS9wpVh9ZPl0zH6c=;
        b=KwQTvXu9Whmueqx3Ox/LnKHONH0DbejXpqZWeVyE9pwbtNutXZT82GHBQFnMD7Dk+q
         UZs7MKeEuTybfoEBF+G+nwr+DC6VeeabCFAiq3LQFwBjET8WmYvax9kCR9LLoG2s5LxH
         ClzRI/icmBCHelM9ra+Kw2U4Ls7texDw+CW4x22M8xbDgk6+GAIXY8/FpeeqY7e3Vxpf
         /g3vpIFjX5DXbNsaLjmLPjk7iwZyarSYSp8P9+unoSjnS6e8mglK6wXTAAeyCSqFH66j
         8Zc7LxucytGohm6hFBUMT7qW26wTZEGoTvuTJ+T6OA8jDDS5K2VMYPBhlD3HrmkFr09s
         T7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434036; x=1781038836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O+5PZQ+O9EKebWQFeGVU0C1w+W1WS9wpVh9ZPl0zH6c=;
        b=etb9NlyW/B7SmmFVx37tZ2n0feBtQqrh9y/IvfRWKfBV4OhzjiWJvRE7rPjKOdKl36
         k3ejj3RQg4fCfsk2k0tGxLcH3GfRdNB9jwVApvqhOKEqWD+4qQL7wXEQk9cSQIIibvry
         BuCvjRU8Rv4JEPsGrol9/CPjtOE2H5+5YKEk5UrzXNg6z6ztKCwlSxXbvzKtWVO+pCi0
         2dKvfwCMrC1WsdBEpAi6ivLiN3DYaEEQhKRLXaSiMrNXeRVx84vHBksSil1geUMpItVB
         ZGOvYCa4jI/ErMkW2iKt52tYu3bKrsMq4y7koZvJ5XepvhsIIn2JRljWn/Bu0jRI9MW+
         Oc5w==
X-Gm-Message-State: AOJu0YxmpeHyZ1ZB2t87bZ1mPkpjsKmdaZnMW64H6cJ59pxGfxA+KwJx
	/I8WtDa9DqvPPReXMkvpzPMzXijtNIYNtlJwZD7F6YoGs5lV204ziwirP2hQqNkJys8=
X-Gm-Gg: Acq92OGKcr53u1Qffw0hjmSyiP1NpuB3Ot5y5xLyzCek7dqBfB0Neg7rUwDLvCbYpar
	crSkH7dvdjzFDO7iF6sGcQArn/Oxn+fUCege7oY463sxM/mdYaEKUsVt1xL6DbT4q13RHaonpa9
	4iySb0g3MbE/D+4Q/0mOmLwLX5hH3SLS/MRVvrmSbk2uPq5fp8BnVf1MpU1AVgPSrpvoXSyWAb3
	+cmF6xhpTX1Le5mcBae2Jzji/Ylj2qkflWbiJvgTx6eZBK7j4uwKegnYSwTZ3axSaz+m90QDRhM
	Vg2kQDJtn+qXXORuY8VtDFKRtnF/eGSpcddTde2PCZQjBYPE4pYeKvcUoO5Sm+JaZOR7qo6nQya
	PhP5H6CelHEqUv968HU1r6ed7ZYxctevNgBoC8VABtAc4sheNORNb9eV7hcAn/gM8hhzyAl8rWE
	Miuru9O71Laf3rDFoHfSnAuVoYXFST7qaRFcBpAHI9hmlkOrX8TrO40zG1BpaRwS2U7BIlDzWax
	78QU0uc68yHjBN191gjb3k8l7wS
X-Received: by 2002:a05:6102:3046:b0:6d1:c650:2f91 with SMTP id ada2fe7eead31-6ec4d5186femr200375137.31.1780434035580;
        Tue, 02 Jun 2026 14:00:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb6668702fsm496943137.10.2026.06.02.14.00.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:00:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] doc: Document Push behavior when MediaAssistant is active
Date: Tue,  2 Jun 2026 17:00:22 -0400
Message-ID: <20260602210022.213562-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602210022.213562-1-luiz.dentz@gmail.com>
References: <20260602210022.213562-1-luiz.dentz@gmail.com>
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

