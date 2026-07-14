Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7640D590;
	Tue, 14 Jul 2026 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018483; cv=pass; b=oIBJZXsEC/qDITxX20A20lHhx5joew/J1c7wLHq70kv5I696u14cxPCQHScByjqE7+BJ6a0bIbmHx1aEx+EjxNryYX1Waf4LqFTGjrl0V1wQ8Yfdy4O1wa2P0Ezhv0pSoS+i9hIsT3hblR27yLRKSdeBQJFCT7ckUbeq4Fhbp1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018483; c=relaxed/simple;
	bh=8z/edaxbP8tiYQptFXcYya3KTex0hllHGdKOA2zsgLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyvicWolmP1RrFz/j9He4/en3DurXx2jai+NJcz7MHsgLKimgA1S2DJoGApzZoYJJm9A167Z+aUdcg6+1z7qBSkDXOyeOdu1iXacTAeDzTVDYGBxoiQxA/GZQGiXtfWRErl/R7naV3+Ce2UIRfI/2/nuh9W2aVdhB5Vw1lfWlcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=XphQMjE0; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="XphQMjE0"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4gzt7T4h8Cz49Q7v;
	Tue, 14 Jul 2026 11:41:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1784018469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9RyNZnh0b6raeR9iFgM5Ho6zhrhuvNzJy1FtpQDq5g=;
	b=XphQMjE0HtpTLj1CpejJABeCxmIGEqPyTyQsqH9Vrc332s4C1tKKKWGOB9Ab/JC9iE0eXR
	Y4Uspe1hflIzOLwlXeGWJwKyJnroGEXKW4dKFL1bylbQYtKE0ICrrLCudCGpOsC89YGsE6
	rg7UxasFGgv5xSE3eGDWfjdqQSfd1iAY0SEq+EWOnpOx6W1Wet5zuuU4p5BisqDRdmCI9+
	NUlRuO9zU3WErma4L45F/SX8rNszKRq20TyW2XXzOmcRDq8Se8ChR1fA9hJP8BZdkmhYwE
	C6+0gAZOfZpiZPn6kntx0BJO407Qd9yXSIMkDxwiGVaXoIi8NW9k5q3PRIeqJw==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1784018469;
	b=TMfCFO/wXVhHkqt5oBrp6zj51L1O4iHA7o0qI9ArMCc1ICOZ6Sgj4d7Y3com3mNetv16fb
	6LT91rc5clRylQUUiosT46QESzn4aLv2sm2iGGVWq13UzPi6RmshJ1MFkG3ryoaRKlFBIP
	VJyYkR9ld4rcUqKNeLbuMEqrUi8gnbk/6cImAavoVriY5gvKGhEPNLtWKXIK9SzbZUoT94
	lmcodyFfSeXWrcv3qwISksWdSCPp9+DmT8jUIbhr8y5jARSembZOWRHkAmZHQiXnO0wzUq
	TmeZuBKVH9khgFKQW2tuzcycnu3aPZxrKA21CGYiupjTrGM6GKIQBt8qX2FTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1784018469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9RyNZnh0b6raeR9iFgM5Ho6zhrhuvNzJy1FtpQDq5g=;
	b=KGn7NSlod6g0GN21HVobRDvGIp31tz8gOWk/1BN2FpRcmyu9SMk7lwiQFdW8BgytA+d8eI
	UyEOn35bxmCBvigFY8xSmIQSiVazBlg5Ng8SPjKk3MG1MbOY4rBNh7RHZ+kwsnG/DqwzQg
	KLYLK+6qQR1PE+kkzUSE5du+7qUM3xHIbthQNLmQTVZ6rMyKyaOwdC6FCwo1WgbqaeTEiP
	BiMe4Y0+kqKL8MGePKbDwEXdDpj5vKUtbY2bAqlC68pwAzMNMF/nGKSjABNbyjrzaHBTvx
	OWvZkyG/4lPT5fhe510qscEYkcmq/9ujTIkXbw6zp3ruc6VDn2r/QPwhAYovUA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	elver@google.com,
	bvanassche@acm.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/3] Bluetooth: enable context analysis for headers
Date: Tue, 14 Jul 2026 11:40:51 +0300
Message-ID: <7f895d42129260d8074e461b3d529573c53b34d8.1784018377.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
References: <aaf5b46dd2519f7b3c7e74f9b232be2130ca30db.1784018377.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove context analysis suppression for include/net/bluetooth/*, now
that previous commits have resolved the warnings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 scripts/context-analysis-suppression.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/context-analysis-suppression.txt b/scripts/context-analysis-suppression.txt
index 1c51b6153f08..d4476d9ed10a 100644
--- a/scripts/context-analysis-suppression.txt
+++ b/scripts/context-analysis-suppression.txt
@@ -32,3 +32,4 @@ src:*include/linux/seqlock*.h=emit
 src:*include/linux/spinlock*.h=emit
 src:*include/linux/srcu*.h=emit
 src:*include/linux/ww_mutex.h=emit
+src:*include/net/bluetooth/*=emit
-- 
2.55.0

