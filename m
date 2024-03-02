Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE583FB32
	for <linux-bluetooth@vger.kernel.org>; Sat,  2 Mar 2024 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709410204; cv=pass; b=TIxY74Br7oyyU4RR1NTSO9FQFWV323aTapFC/qdfBvyOLjMeo8K9hpCTtz36g3lHbZP4FVamwn3uMpDBemcpyJ5iUOo1Dia/AnVUujhpal/okbunJwKYj3Q6LvsNyDClp8GA9EufTCSTHCnX9IG/DbIgn3CB7S8DBerFTx0mi+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709410204; c=relaxed/simple;
	bh=Cl/VKmH8Yw791OhqfZ5zc8Yvn/OJ6R2XU9oi1jsZDLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7VDM9eaasfDEavfhvEjxzVasj8P1emYJPbK12KneglMpjklTleYXwgTXkA8VQnAMErxfObvY0fGzOpOkzKLM2l2udZEfyLJ4k55lKWqqKUB5rBw2YyaIEUX2T3CHo9qyx19NajVD8VnCVjBVnaG8ohpxU9IxGTxZa4Dc516X5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fV+uweM2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fV+uweM2"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TnGK45M0Gz100r;
	Sat,  2 Mar 2024 22:10:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709410201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecV00U/d0Dc/24cvyLk1b2WsqOuuqEsP/GMGle5p4SI=;
	b=fV+uweM2WoUGRRIg7yj7Stq5bRLQ8EMrPmllDtM1+aU8S14/RcZYcIjN6zBk+mFZjAIb2m
	3mMnDLMNjgCPVsKtByWGBtl/Kqx2BsUIfFR5ZCUonVqv3d3Cdsz5Pr5p3yoJk+xzMoXrHO
	7OF2WoWo0ioF8Vwi+K0dxpPbVxufB7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709410201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecV00U/d0Dc/24cvyLk1b2WsqOuuqEsP/GMGle5p4SI=;
	b=HiX5hSTDk676Prs+M/X+TJImIBuczhWGBlFurExgxq9TZo812AQ1vWGSCuWj3l1F6HIX+d
	jN/AU/zlJwn8lxPOJYaUxocFlMmVaQvDPuTxVPv7+mv8euPBc/gmPrMA1fJLP7MLhdTjA5
	2i+zTx9NUYybh383o2Yk+iDsGd0b760=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709410201; a=rsa-sha256; cv=none;
	b=OI4sDpHNRcnweER8I/7R5R0S6LwIgrfBWzudjLnGXVGTjfqv0QOpDkrgq+vZL7vTTcwvZl
	DY8Y3ws6zncd1uOT5uQurQZxa0pD2O0LAyiLXIjxh/6TNUw9JO8wvjosxgKn1H10/loKk9
	t4KAtHPHdGAbWgANd40G6Nyf1Fnu0W8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] lib: add BT_SCM_ERROR sock_extended_err CMSG
Date: Sat,  2 Mar 2024 22:09:51 +0200
Message-ID: <af7073f4412bfad95660af68c68970216abbb567.1709409039.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709409039.git.pav@iki.fi>
References: <cover.1709409039.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new CMSG type used in new kernel TX timestamping support.
---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index ba08c70e6..90e167f16 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
-- 
2.44.0

