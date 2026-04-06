Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAB330649
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474641; cv=pass; b=hL03UEWfmQywrLK755rXVFEmu7611fI2SZ9XDhZhpc6zHs+wfqDqQb8xsI+vKhMV5q/ZKLPHXtLXPNFcI1goC4dgl/gfxW++6IxaOS87QjslUXULR1+GX1trV+4TYjtXQJoeXu/n2OJSWwnYIBjS9hz4lgGNIhBVX9TV2VVyZUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474641; c=relaxed/simple;
	bh=pCFS19qBFFrokBdN6ZJaRUQZhNDUf5go1+AJjVXEkQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICD6qksJLF4GnOZ4FyUJ1unibmFR81kO++mCPcv/SJjI8xnnI0/UZg3I/+InyNTZzeB21dwmW4cDl2xkbejpzaR8Re3vvlEyFYQhtwytJ4EMICMeILXO6aTVMZOj0bRpiXNLoHFZBwbmqEAaGQeECfVBes6SeSVMQTqmQ9B7Bno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cCIXwLTy; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cCIXwLTy"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq6R241lkz104n;
	Mon, 06 Apr 2026 14:23:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775474638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VolerHN1FVtCZQV75WIXYhnTWCBXtuu/rC6mHvrkvpA=;
	b=cCIXwLTycsPueC6x8lImHwtAmfIEb5Ru/gnBUHF/1lPdz6FNt2Ec9+Q7vD5t10QMQk9kxQ
	BbC1wfYpt25KwmxnlajqZKwaBlC3fLhYUqndimr/gJepZ5TAw/UKrv+LKflELVY6tuSmr8
	eIm5gU6FwOuFTdtqUECwzPy9soXutP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775474638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VolerHN1FVtCZQV75WIXYhnTWCBXtuu/rC6mHvrkvpA=;
	b=OVWIRV4Z8g92o3T3s8VWH2gHn/GryFlL6vtsLBkaTEmqtv9kwrFPwaVDfViM4SEBUUNMXD
	rHEMkV4eiLuvpTznxYXrXGjeh0GrcjXVOXOa9PA+HXFXbBswCVt07cVSn1YPyqQwSLUOhe
	shqfRMl8JNzmPJXKZvm5I3/RoP90tk8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775474638;
	b=F9BHwmNhPXT6ji8/0mdGxBq35VVoR7XQzF92Sfvg5CyOYvC/Q7OMu9qHJKnsxW9vda+p+f
	Pv5vLt9MOrp+SqJPlqLZkxcJlX94qvgDJWAyMH9PidWxmuWNH1gxOmDEg9TqXcAi0WGDIx
	70KwFvT9NPDAeqLQJC4DOUE0j6OmbsY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] src: Remove assigned but unused variables
Date: Mon,  6 Apr 2026 14:23:53 +0300
Message-ID: <e86f3d4a9315e56ce0639463ef822d2b9546a121.1775474498.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
References: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about, or silence by void cast.

Fixes build on gcc 16.
---
 src/sdpd-request.c | 1 +
 src/shared/shell.c | 5 +----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 7c632c2aa..c78bfdffa 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -263,6 +263,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 			pSeq = sdp_list_append(pSeq, pElem);
 			numberOfElements++;
 			SDPDBG("No of elements : %d", numberOfElements);
+			(void)numberOfElements;
 
 			if (seqlen == data_size)
 				break;
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 87a8a310d..2b8d1a45c 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -179,11 +179,10 @@ static const struct bt_shell_menu *find_menu(const char *name, size_t len,
 
 static char *menu_generator(const char *text, int state)
 {
-	static unsigned int index, len;
+	static unsigned int len;
 	static struct queue_entry *entry;
 
 	if (!state) {
-		index = 0;
 		len = strlen(text);
 		entry = (void *) queue_get_entries(data.submenus);
 	}
@@ -191,8 +190,6 @@ static char *menu_generator(const char *text, int state)
 	for (; entry; entry = entry->next) {
 		struct bt_shell_menu *menu = entry->data;
 
-		index++;
-
 		if (!strncmp(menu->name, text, len)) {
 			entry = entry->next;
 			return strdup(menu->name);
-- 
2.53.0

