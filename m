Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCFC31C562
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381465; cv=pass; b=eTiW1ZJW50LpxcpWPwOEZ1AP2/HTp4pHTHsuDKVmtrTZEwm8y3n8VlEehN+53+9m1g6nCQsVV//7c1CQR3gS6cHcS5YIDsFO3stlCxF24UiVQpKRpYsTLkHj/3KBzFBoKxw9dzARbClHIQ8vsbx/7zTO/qS+v1B9x5/jrj9U8b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381465; c=relaxed/simple;
	bh=Y7Tq5rmbO6qjZlHQHLs0jPeYV0wL7xyWJuL765+2J30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AII0EO6VGqnq9TUzKbT2YbYJqeNsipa6K9P2mNw4Yq6pQak1/i8ZClDf6pg3YVlGkOP8+cDGX9hqKYt+BtzkKPCN8e4y+gyX2QlmFDy6RKsAWvdYR7YdAz0pLNKB3hD+VAR8N1986lsZFEJZ/JIBBjm9pVnjhhPlx/D2lknnd4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=hPhe7ruS; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="hPhe7ruS"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dRKlT2WLjz102m;
	Wed, 10 Dec 2025 17:44:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765381461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UG4dxgtnFSTGFacw8zRVu+GTGJcEc8DPmK0Iv8k4xo=;
	b=hPhe7ruSIWHf2/z3aySexitYJfXo1sGurZ1YD6M52B7kwFj2Wi7YMDmXQmelb7uoquLEpk
	M8v6O83OEqkY4gZIjyhZJnruiHX9m40Rw2h1Cn4FyDN8v/yhWpJdlGQYceYnOpwHGxzmfx
	Dbwxmu7V8BgPtpEx24ZUX7DE4c9ZhuQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765381461;
	b=A+i4YKtCaaxZcxRYdsIeQPcn986gDCb74xK+v0JlpHGahr2yCP4gXn8jnZIsiBQ06+aKkI
	/0aoyVEJebYTQI7fp2IJu4T0G5J3YMZkII5gBReB/QUCXfr/KcxpQA0bYM6Ha1Y9EWSCC7
	alGN99dLZdIvKt3OIWPtAGKg8Qnx+FE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765381461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UG4dxgtnFSTGFacw8zRVu+GTGJcEc8DPmK0Iv8k4xo=;
	b=o9zn4zEQ6mErmeY7X3j+yMRWzecxh/KE15eRRbsKjrTTz2mWvO1yj8+bZGqWYped1siAXV
	hDH7XDJyBf7appJjaJ/yAntwF623M5pGT9imX1fQHzQS9rJ2DBNiLZydg00XLRGfQ7Us5N
	BWpVpb5NKpo+Ruy7i12tNXO2LXN0JhA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2.. 5/7] uinput-util: fix compiler complaint about strncpy usage
Date: Wed, 10 Dec 2025 17:44:10 +0200
Message-ID: <f5052fa308321ae7840d4d885210654edd13a9b8.1765381438.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765381438.git.pav@iki.fi>
References: <cover.1765381438.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

profiles/audio/uinput-util.c: In function 'uinput_create':
profiles/audio/uinput-util.c:97:25: error: '__builtin___strncpy_chk'
    output truncated before terminating nul copying as many bytes
    from a string as its length [-Werror=stringop-truncation]
   97 |                         strncpy(dev.name + len, suffix, slen);
---
 profiles/audio/uinput-util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/uinput-util.c b/profiles/audio/uinput-util.c
index 845602c84..92af511ba 100644
--- a/profiles/audio/uinput-util.c
+++ b/profiles/audio/uinput-util.c
@@ -93,6 +93,8 @@ int uinput_create(struct btd_adapter *adapter, struct btd_device *device,
 		if (len + slen < UINPUT_MAX_NAME_SIZE - 1) {
 			strcpy(dev.name + len, suffix);
 		} else {
+			if (slen >= UINPUT_MAX_NAME_SIZE)
+				slen = UINPUT_MAX_NAME_SIZE - 1;
 			len = UINPUT_MAX_NAME_SIZE - slen - 1;
 			strncpy(dev.name + len, suffix, slen);
 			dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
-- 
2.51.1

