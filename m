Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162983D966A;
	Sun, 16 Aug 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786873663; cv=pass; b=Wa8gWHvdcYiWjNOlvZIWD4KbESZqFUmT6Q62pKWdV63WhBvikl7fnkaRJI4dq0djzyg+nzp1y1yUTwE+u92e6HoOrC4qrSnII6cF9gmecaQYYSefT78eAc8UjiUeo1comtW+CaPMIATcL/HMtpXg8c79CAD4CQQVTarCO22gY2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786873663; c=relaxed/simple;
	bh=IMBEqojgtSGGfWQ1YY5F4aDFG5jNzpe1yUwnd83batQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADi7elL77P/lYPYUHwsgDENHccCY+RgQARPXbj+efaumNMPwlmJsq3sdYG+KYuRAvz5PgKpwo2l0cwDkc6dVebVuFg94uIMbMthD2jS4kDcXA2UhRh2jFGb991+eDc5BK7G2CjycVAybmKZMGgXkc05xA4kgI49TrUOJ0OwwuAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=RN0yJT41; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="RN0yJT41"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::de01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hNB2t63K2zyvS;
	Sun, 16 Aug 2026 12:47:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1786873656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1jzoDhFHsiTovmnJvEXc3cuqy67His4RWmvtvi9XpA=;
	b=RN0yJT41X7qRq6Fu1KNj2ULRNW59X2mF8FQqnXx1kETxLHRbmX4iJUm6CRtkocTl6urYVh
	k+VyMOCHR0nE1wks+9NSuAkQIGAt5Hupa7/Tp5wP3v+97c5rRltnQFay1GHoHA/QlqB4zo
	bpxEV7GIx5ov3d1B1ksimmwxPg+8AXw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1786873656;
	b=A+MFhi9P0uFcO4vaWnWQ7xz4qeRcgQDCPxWVKCYHC08w7CzSlOR3XJwNAp2rCCe78x1fX1
	VElZ4oQgV6nMBP6Wgn5DWFTNu3nOyN64YhAn/CDmUzqpWDRRh4Ty5cXex+WeTbqjDWz0Yg
	y5k0qLvkF3PrvGy7BIpiM6NinwcBsIo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1786873656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O1jzoDhFHsiTovmnJvEXc3cuqy67His4RWmvtvi9XpA=;
	b=Ludp5NdxSd4BSuUyI/KmiqpFoDVC6KeT1xlvUqEZ4Of4iD/GiEOENMumkdowAdQcO0wFno
	AK8gffNgspJuWS6LJh+2qGOnfFmJpcG5eklIQ0nXCFUnM2gbdXA+ge8sop0U6RvQ/J67PA
	W5fIyCB9nwTt0/A2/9Fh0N9qslxOUF0=
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
Subject: [PATCH RESEND v2 3/3] Bluetooth: enable context analysis for headers
Date: Sun, 16 Aug 2026 12:47:05 +0300
Message-ID: <91a565de2025cd2dff9b94bf6b79ab0dbf79a50c.1786871620.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
References: <35f8d2856ef35e1c6314101ee60b16af39d88e78.1786871620.git.pav@iki.fi>
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
    resend:
    - no changes
    
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

