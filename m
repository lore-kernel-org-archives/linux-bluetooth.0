Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278982528FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501896; cv=pass; b=Std4eg/lVqt7TPLzDcaY+3IVYsfgrLIkO60yR1vgwm5ppc+qq1eW+2yVAXpKWJq99GZdO9NNOzuWNo2O5fQqdY/erVtHskrPBolvvpJ6VUTh7Vwzy+Mh2NClkPKAbLLMKj0182xShgJAeURxIILrf0tbKyzEs4fpKp1NDtRY4Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501896; c=relaxed/simple;
	bh=OTX5/5aYLBwEM3XLkP67/xpKGlmgBoSEy+KydQLvwvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rC6H8rL8b3pahTLML+88xLyPocODcOkrPMzNlG/eMk5Oa3wSguukBt6g9oa62Q6MUGEKl1VpahPmALTogx4K8iOh8AZt/ZevEbormXJF8GWSRcqCvNy9JauNa9JolIUKzlMa6/Buxy/c1RZ1IfRH9xbMOn+flCffep7Rm0Z8d2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gOUDiC5n; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gOUDiC5n"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4bgkbS3jPzzySF;
	Mon, 14 Jul 2025 17:04:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1752501893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IruzfxPB862NiWu5qkXfPCt3cpQHWszgsObPjMLUPQ=;
	b=gOUDiC5nYPH+G7jbqbJKBXY9HWC1CtP9oicStCuBdQdsNcclpw6ItoCUcHaVwBYE8qCAm+
	b5Zr3HGJTRD78IvfV1LutGak9hP9fC6VJK3QiS61M0gYDfy5tHKbW4F3ezHUUz/hXhf6Fl
	1Z2UEmlP4XCMAItAhcqx+z5SqU+a/Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1752501893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IruzfxPB862NiWu5qkXfPCt3cpQHWszgsObPjMLUPQ=;
	b=Wn+qpyggDqTv/Cs93EiyeJYpAEA2hLfxr8/suWloPpvxqB7pGikEf4UpMQv3VMjyAE//vI
	/cCd9lpfZeNWmqeZRZc22qt3E3iKw0Tp0iOX3w/1datnDru1MGjnPteWjoYDh58bpsPvFr
	6QqCxbnJoGpVibd8VPgL+Z0qGfnkloc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1752501893; a=rsa-sha256; cv=none;
	b=Vfylqirxai60TGxXq36UiN1xqHGtXpxRFw8Z0yp0F/2XvI6za2Sr8TC0/VJHpDIIx3tOXv
	ZhgtCbsn7AoRCmUiIHLBr2JqMRCtpX2suzRKJPzvrMTWPacZvevprv0S+V9Aql5fWDylDT
	8RnfR6feamtVfQpX6zSNDcWiJxBm5VA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM
Date: Mon, 14 Jul 2025 17:04:45 +0300
Message-ID: <7e400689702256a0934c4cc4bcc7ff103275ae66.1752501450.git.pav@iki.fi>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
References: <2ffec6539fe38318c713b48985aaddda9671f258.1752501450.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Socket options and CMSG identifier for ISO packet sequence numbers.
---
 lib/bluetooth.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 150679d72..4fb8ab2ec 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -253,6 +253,10 @@ enum {
 
 #define BT_ISO_BASE		20
 
+#define BT_PKT_SEQNUM		21
+
+#define BT_SCM_PKT_SEQNUM	0x05
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.50.1

