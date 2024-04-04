Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A117BA8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247694; cv=pass; b=PN6vS/23YFdOepsrc2VPCtZ+sanTQfp28nTQqdZ2qdDyf4elE1MX0kX12n9z9iVU8ru8iVD3PuDTN62XVX0xn5UvvL4kSMHWDQ7KlLPKu/qppzJcOpXK9IGaZ7NedHIWosv+/Lm5fkFAy6bAlo/2gcuYni7ShSyIVXBMF0jyRc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247694; c=relaxed/simple;
	bh=Rbylmd5Rutq4+i7hfKxure17mD3Xd1qpj1qB5aB12wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ3gUjifv/dUse8ZmtxNbuLqwBWZeQaAp3lbi68QpwLqdFnt1N60BVxuP2qbFN/RROJvFcXgAUhMV7tnJGwHWknUMcob06kFHDC54EPA2qhOmSgZVBvGBvMryec1xWvJwxHj8ueIcbeHRp/ezZ96x+sgdYzy34z7NnYlios/Wgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=OLhSFwyf; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="OLhSFwyf"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V9RhB0SfFz49Q4X;
	Thu,  4 Apr 2024 19:21:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712247690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=OLhSFwyfuM5dNboUSKJs/RPtVYQd89rG9qyhAiE6R+FHqMJrQ7d3JzszPHsuZ5fvyIhfEw
	QBZkKMlKxzBc2qwXqqy0y6yas+hOqtUvGHa+6Nvvwx/o2fww4vpUgZ/H1McpVxP0pTT1W7
	mqYfNBJC0TT1MiLZtyaNTAW15WnI68cBHTQYISr4ays5lMVXiyh4uFft76xc3yTL/HEAvn
	97sHQVdjZpEwHWbPsF22TSwzN68QK5fhKzgWgyyw8JDFNYQiL+MAumFeZ12Ht/RLfqFLk2
	bHJ2dspDIrBWRxKOJgAMFsLVtb+vLSDC7vPI5NOrekpxz4O4FMtTZ3oBwDr+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712247690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DQHBUQvSEBJ4gmBHTLJ902z3SIHMiTvD4BQrU7DmKLU=;
	b=B3L4LBMsX0h4cxaF8KmreAjjtxFOtPeT9ZxzHt2oOtzfU44Z6cEQ1EwyLWnzMT6gRQ7JkB
	XnnI3j/qVna9x+oBLlVxJSxdkh6BRZXget/7gA2qdjDDbMBBdUXoB9PCmMOrqF34njPbT0
	br9Y4yBEs+ZTL7nh2WeiBFiPHsvAY2Nv8noKhs5+y8iCnAmDmC6gadedmESuJ38blk1/1O
	C0de1H61Fl3OYPcgj2jfKDlR2kuxAY541fetBISV8sfZlvwnJZfIoass/vmxmNtUEnAzUC
	sLhe+7p5dNwOpJuMeAu3kWW2B5V7FjR7FR30PK7pigIN2C6SiOQmOf4+xAjLTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712247690; a=rsa-sha256;
	cv=none;
	b=cDXEav8ROflLrHE3xfDgsO05agVWEbFe6ZzCIYDS8FbwLiCUg69bDt06zmvBsCTa4tC/GB
	6nD2WW4CYsP5G0WNZbxhj1q0iBXq4vdzP+BSumOzMuFkh4xehFNgKdsSgv4dxdV60ui/G8
	slNgVrDjv+jXXSkbCSNEGPYDO9C/l0c4pyjkT1UvRhsUWy4Ho7KzRKP7YPuoPQh8sb0lCZ
	m2Bzc4IKomKILDhrJk8zQVhYdQBUH1NYTYDfF0RxjcNRr2WJrvMz7xCt0DvS6tMsZHI3Fc
	rrGCDqSrKTrJJPJ83dOqaMGZMi6l3f78FidqyY13+NHILk30scNF4XcR/FJ0/g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 1/7] lib: add BT_SCM_ERROR
Date: Thu,  4 Apr 2024 19:21:17 +0300
Message-ID: <231de55e44e48272c02dac8ee735af9316ec46e0.1712243675.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712243675.git.pav@iki.fi>
References: <cover.1712243675.git.pav@iki.fi>
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
index 75dc960c8..a4ed65d0b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
-- 
2.44.0

