Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19239A7F6;
	Sun, 12 Jul 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783860184; cv=pass; b=Or8pb8d9RoQOVArDAtigZAgQmDreTYI4puCSZYsEjQiCJwTsHcmUIVjNxvQvuCJhcWgiZ9ed5yoT4886DX+H61QyvE65A5Ik2hqHEIMm6vIlD5qfNy80IYrHQVVOsqmtfG5o4uQbu9Vn9hiuO7xm0rpDKfIC3yutMIF9rCrQtRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783860184; c=relaxed/simple;
	bh=dAd5tTm06RX/+PCttrns/4DY9vOEIcmNawJVE5qlIFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4KpumAq65F86WAK+9YKGhqa7D/OS2oDUYp0ft2oxITmsXtZd55YZB0QxBIwv+0AMHPQEQsFyHu8UhphmAEIHejlLrjfKliDo/hMzA9hUaQvJE/yCy66i0gHN70O7JujpAuxDMb5TipRRMPaw/h4r7uOSAM9r/M7bYkSR2lECgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=FH9hwjzF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FH9hwjzF"
Received: from monolith.lan (unknown [185.65.133.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gylbK6lWKz10Y9;
	Sun, 12 Jul 2026 15:42:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783860175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48S2c86lboq4vEeROkXpXGdmfPL0XsQyKsCp6yHBJIA=;
	b=FH9hwjzFnUT9VMyupMkaB7sNntxl43dbEms7vQqKQGrpCVdOcmZCqUbZMhjDv4tQUDzQUQ
	Aw3cfjFof8sS87O9Mx9AZEl8Jf12N/ZSfFZ7vFyL9KOf/Vca8U5Cn++fdfFR0ToYTgsgpI
	MKw6uNqe8ZWQQh+5dGmfTKPDaUJElqc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783860175;
	b=I0oTVO6ovnG3GvKEuEAEOkyAvJGJH89Bp2F8SjsUuPtKYhq0wti5CSSPmmchC0jNozJHiC
	C4kmoZwWf52pXlOLQqO+EQmX9gkhO+KA1wxDoIPqaoqK8kfGT/LVIydSiVmi85bDlkCimk
	/GAMCdTYM2CLanNHiWQotNtNDNzzcds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783860175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48S2c86lboq4vEeROkXpXGdmfPL0XsQyKsCp6yHBJIA=;
	b=faV7r7pDQrNAruTyqyR4XFTu3eNm3tiIdkCfk9XGzoZCEQh/IA1PexOZ+zZEhqgCz2gYmW
	eERhmYYf9j1Vd6X6z9hz+NszSjB4YPPd6cTSuepIu1a4pyp0qRGVRaynuS8+4cPkhUMI9p
	ejUzLdvOEGdK/3gu/SxAA9X2hr5sgN4=
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
Subject: [PATCH 2/2] Bluetooth: enable context analysis for headers
Date: Sun, 12 Jul 2026 15:42:46 +0300
Message-ID: <ec3a235a79254560e4acd4f71ed7ca95c8763f77.1783860121.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
References: <9a718ecfbeb46077d8100dcb687e1ab6073986f6.1783860121.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove context analysis suppression for include/net/bluetooth/*, now
that previous commits have resolved the warnings.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
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

