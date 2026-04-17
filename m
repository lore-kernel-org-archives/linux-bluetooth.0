Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D69391E46
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425390; cv=none; b=Gv8yp708104XiSFWnLj8AI6Fj4SsLLv5AtipeXAsczcmpeoyJ0BCD31IYiu6dLJPz71nDiC6He0SGLZGSTIltZVtfdDOhr7ywcKb3P8nttLxTg9EfIPXE5QjqC8ylz/k+Yd7f7Tr2YDn6N1GisqozGrbXHA+NOQcrfWBnZdrGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425390; c=relaxed/simple;
	bh=945W8owtOl27lJ/2AANH8/X7UDPMlJNhyUS3IIuZI7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9WUacW/qimpX/YTwtgeDIviI+1aBNT8i5P0BsqQjVlaBhgciyHRd3Kt2jhIcijdejG7WMXZ9KN8CdG0eA3hG5kyiV79lVu3geXGGKWPiQVuPxvcWuwYl/1ecdaSMwD3O4KuJaDO/J1QS5CuGwdpkH7wbVvt3asXCLkZ8BUys7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=M6E7xI/g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="M6E7xI/g"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43eada6d900so537947f8f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776425385; x=1777030185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1tE+Q87KUMVVBwKNVYd/5/CC/4XRNK/FMVwgztA76o=;
        b=M6E7xI/gQLBLpZQmDU7fPum9O8hNPglwBr+jYLjy3+DfAKBgptIbwDtctA1y30a8Uu
         blkEjS7pjVfJfksfAsKZC4bCxetaYfSCGXaYPaJS9DL1p4jlztdyCByor3XFT4WqqW4J
         U5n9vjjyp7g/43hA4F8s3XlOs5PUbk2ylp1Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425385; x=1777030185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1tE+Q87KUMVVBwKNVYd/5/CC/4XRNK/FMVwgztA76o=;
        b=OMfyLGkKo6lhJ2tLHrkEPemm2pEFNSgeDFluglCCxfg/hDdP4/Z+Fep7HL+oYM2dPP
         cECOFG2BFLI0frL1AiSzKOR17+LgeDHv5pJgxLk3lFDVVoeOvd5xdgBe+yDPBrGTr2wO
         OFw0W7R9av7ZmP4ld1rdGDpHnBLrCzxq+YQMQsqYe1DvRPgrPpKUN+GBIRFkj9J2EsYE
         QblvUiE0blX9BxRXllmv5tZaGlrez6bEfbHGKa723dY4GwmLVFmdn2hVe9t93ZtIcALM
         0SW9qP6gNl3LGuEsX/enrLnbztTgJbK2etfsbYqaPbEIhuqlqMgly4nuwuHx2cs/0k8a
         Fmzg==
X-Gm-Message-State: AOJu0YwOa3upfbm07rUX/V7zxCFv06QqbqGx+KMvDD3hzP1zMP6UwLHp
	jPMzVDbOZH5NKqX14f/4xu5IbQ+I8OrUc6FaeE08DI0Wq4dvccI21K8LBd+P/VIMl8gPAHgBjXi
	d7K9Fgg==
X-Gm-Gg: AeBDietJeFn90G8FfRo9oQjdI2qP1fh3Vj1swb97iazzzeumSZhp/Lyu/E1kxzZ9CB7
	9bRH7MhUGGndj2jfgIe+ogGB0lxKQxyWCM+1+uY6DlHM/wctMIspde1TuTx5+cXhK+6sVokPb5q
	iIuzcHeL+QA1I3QZbHnYb68Inz9QTwwM2iUeWL9naiG8HmO53HZEbMn3NRBbU6SQZvX8UHubBAM
	QnPBrN4fLzwF2+RcvrO3Z/rIcoQN64IuOgHVDc+Vssvz7WWggO19vkH7nl4jwCQ0EwlPCte0q7X
	uctuGtHHp/YEHek810o1kvulaZ7hRjc5TJ9XX8imjfYOV4Vis6IVeLZIDcGyHMcTd0oUqrmOAn0
	6l3Yliea/lAirGV7BxwRc6kAKTUUAyEezPig0pE1HxAdgQt0eGktv+cGm2R24JtqcfBVtnyE/xU
	dxuVsUBimUdvDp3pvG8xeYjRqHybSOYADoNkp9tU//TUhr2+8gCvrv/FxUf64QF028ZJx4ukfYq
	VeiABWW42S54/gq
X-Received: by 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id ffacd0b85a97d-43fe3e144b5mr3917780f8f.41.1776425385602;
        Fri, 17 Apr 2026 04:29:45 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3765865f8f.27.2026.04.17.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:29:45 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/4] shared/bap: run callback after setting the broadcast metadata
Date: Fri, 17 Apr 2026 13:29:12 +0200
Message-ID: <20260417112914.3752605-3-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
References: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this callback, dbus property setting will stall.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8da626fe3..78ba22259 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2526,6 +2526,9 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(data, 1);
 
+	if (func)
+		func(stream, BT_ASCS_RSP_SUCCESS, 0x00, user_data);
+
 	return 1;
 }
 
-- 
2.43.0

