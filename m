Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08B4B2029
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217288; cv=none; b=B1i7MsYJApqElbpNCQ3de1+ENAPCQWiEQ6IgYBVwJ+UE9D2+TQUnuZ6PSKWCGagcoxwfyxQps2kFwYRVKU/NnhRuzQyepP460CssPvn3//9ENV1XKy7SyBJmegATvSGyxuU5VtKXpAZXqwFTajJw4yJH+kyGL6Me+NIVn90ic90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217288; c=relaxed/simple;
	bh=KEhQ8nhr0KH73QfD1meRDHFKuvaGmH5ibFZ2j5hQRHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+oyM29dXpmyNh3GDivxq7iMsa5Ga/u8GCVxHtYKYgy4WeDOXu/yxD9wsB1ARC4JYg/mRfVzUQ8RmDghdzVWdGaHxlt0ujdYBw2wOoToa39f4vuTaIrWv+CFpZDUz7rWEFa+esYezysaFC45WCAK0t62iVYknAC0g8uUUjr2U2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=M1CTxBxc; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="M1CTxBxc"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34c4a0868b6so1458175eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791217286; x=1791822086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqv0viyL5wvLYnYOeXWC+yb02TU6zPYIMvXisT6EQE4=;
        b=M1CTxBxcc2UZmhG63GAiormykVJhfH95YdSlQJmGdOSucVAQujkVqRoZv4WQbuzxHK
         KXpn3LC5pSQmtoc0cW3cgYFhkChSD7zgec0Wgz6e7I8Wg92b5N7yHbQy0N4exY/TrEAD
         WtQk4y+3GfoNlZV77aRHdYR1E7TuZedUjU+QjHSZZ9+nsCz5sYqn1QN5Isl1Dwfea88M
         sb7NjuZnRRhMeIFiIu4GmTNvWuzlPvxW3WbfbM0uMH9fM5QCCtFZBdd40yMRSRWjVdnS
         l9PFFyImcsgdRozqmFACpmWiIrm1n+LHDZa61r1cII2eXe+I+0076GSKkwPy9VyFiDHi
         MfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217286; x=1791822086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lqv0viyL5wvLYnYOeXWC+yb02TU6zPYIMvXisT6EQE4=;
        b=Hxyj3t34vo27ML/6KgtC9GCM07llN20gYeJjefVp+SGNvwDpCT92E/HhDWrgLNCepM
         KtXYnL3lYPhSX6+3YNkHBpC4VMzFcFzpPjZBd7mNqDkljYAiQncCML9vkoTzfR/USnIy
         vsIeNsRuLMgxcwUDoPLntk4QiyyWraEbZL7A4qWWI4f10JHdpamswtBbIZrvAYSSWSjD
         +M2SfzGQaiIdTSNMTatnYzu3mNU1ZVdSjiF3b88f3sDNP+krk11y8cnj3bndVGvSPRyA
         eLAKIFMMrM7/KQLeAXe6K31O5psgoHNUMGyXs2ZV75I6kh3pXxdL5Ibsr50HiPbJyviH
         /KnA==
X-Gm-Message-State: AFuF++nUuGLVPMZ6a+jevUNat3fqZ7z8jJxTyeXZiqR1+9Lff3bK6POF
	gxGbv9s8tAiHsbNjCvJGIgmiYh/4Bpzoo7lEAb8OE294m09TP+H/cTSz80jjIfDZL8ohFuTjokK
	cO7K6Vn8=
X-Gm-Gg: AYBFou1St4//+TZNQRjIYGq/IBsQoBlTxmoKwiORc1SARBfYQ/OvRvraSLBcxF4HXRp
	ScDnjQfeW7/oecgSF7s4uaQSnXKtaiLI6vg12XUdgnImSnRcoFnzuaFMQ1HGyyC3dVFevAf/VeE
	airia7EpKJ1di92VtQMptPar5jxH2d37vocoPMD0PfbxnJ/N6K1icHbMRunB8MTW8KHp4bafqI7
	2yZJohBz+EJ5C9THG6dwQF1R2lXEtnSw9UbQ1rQPXX5LA3vVaQGCN/Rrd2CYe4ANhAxXtk2eH6h
	K1OH2cc5GhxwHoHpWZsnojFQHld86oa5sY7mvQdTaMbnjGRKrXY4ld9Wd9v2s/IgmGduZvlbHoP
	GaDJmSti92TVyrQaMmQDhbH8ERN57wKYSUv216QfHVI8QxzjYGugASJquBHXaXW3XgOE3UiEsaz
	8phz8MRkJSHbkklXJFikdV9+oMEmqvfdEouL1L/dIXi8xDDNLPJV7amx+02IiEoINreogP2eYn/
	NX2vOZXFGXDgV7Fv6d3GItRBLdfRlL5PUHJzWWPAmBHosdTFS/x7pbUq9htq3EJXAMNL23Awbdi
	U6QtILMYuz0OHbjteQMhk4b9nHABMUHkix7aqDD9
X-Received: by 2002:a05:7300:de47:b0:350:c7e7:57a0 with SMTP id 5a478bee46e88-3514530ab4cmr85694eec.24.1791217286115;
        Mon, 05 Oct 2026 09:21:26 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713809csm15646567eec.7.2026.10.05.09.21.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 09:21:25 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/3] emulator: Fix extended scan response Event_Type
Date: Mon,  5 Oct 2026 09:21:16 -0700
Message-ID: <20261005162117.4606-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005162117.4606-1-kevin@simpleble.org>
References: <20261005162117.4606-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scan response to non-legacy scannable advertising was reported with
Event_Type 0x0000, since the scan response bit was masked instead of
set, so hosts saw it as a separate non-connectable advertisement.

Fixes: 32339501a125 ("emulator: Add 5.0 feature support")
Assisted-by: Claude:claude-opus-5.5
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 30eb183c0..e11857c3b 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5542,7 +5542,7 @@ static bool ext_adv_broadcast(void *user_data)
 			else if (ext_adv->type == 0x12)
 				report_type = 0x1a;
 			else if (!(ext_adv->type & 0x10))
-				report_type &= 0x08;
+				report_type |= 0x08;
 			else
 				continue;
 
-- 
2.54.0 (Apple Git-157)

