Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77797405C48
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013820; cv=pass; b=PBRBxX98thuJlVJm/tH2RB12ED2EQ68v6dQRyd5MvhvpDGYdkajhLFmaCdJ6WTzigDGS/DjsGi+yvazv6hryoYlT1q5RGyre1RP11gqDloQDvPigQUeBEUf+hfK0lXCnpzL3v9zVJ/gwA+kIUJk5izoQbKcq0AsuIWqkc0mgQFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013820; c=relaxed/simple;
	bh=V1ZLXKInfJTF//i2Ch4OAg5QrFtKsshzYaToQ/OB+RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fd3TOHaEi91+FmHTwsvC68RmeLCGN32ZgyJVwBqq2yd0zj93db7jaMXW4xfB/oWfD2IEVkgCazSdAowLXY9U5reFmz3rd3nf3RMrY1fgoYqduSua2QFsydMtjlOzHCYCXnt2Jc3St+QivHQeG2h1rmuvsiIFdPgZPi84Wt3sXbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GsHe5UzN; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GsHe5UzN"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gJHJ92nyjzyTf;
	Sun, 17 May 2026 13:30:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1779013817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlG1g3Z9Eo65G+/xdQudbO9ShHCvwh6Vf74xU+HeDRA=;
	b=GsHe5UzNhfKe6MPOshmgZTt8q3nBFOBkBeDIOtXdTS/a5bUihpcVWtQLXeK0cjAqCQz2Us
	r3fyDhLstym10JvQfO66ZDug3yhMdq59NBbB4XLQeMy6V1KGSpWB1sTZiZo2SUU7q3QkQI
	/tBeRPBjcDK2IAzvZm4mg9LKMCnOG/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1779013817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NlG1g3Z9Eo65G+/xdQudbO9ShHCvwh6Vf74xU+HeDRA=;
	b=W5odLtEAHmoIKFEhKrrQASxqSt5ezDAiKXEL7A9O9Gv5OkhzgbfcqjDhp9c0IuLPaCGdyv
	Wfj/Y2wDNubjLoLsnhTIwSIWugAFg4Ry4qi/jbT0BKwwem0XzvwplfB0qTA55ztkuMdklf
	AwcJFCcKASMwz2G8IFFDP+aKMrIeVtc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1779013817;
	b=GuUlAiG41EBrSUBBG2tH9Z/tEmyw5hWaiWdtS+KTHBF2w3aD2gvx3JzsVb++bqfrnvuqhb
	VrAzInvECj+nCxMDqnWJ2bwBFJepsLxfihHWKYynOG+20J6XGYXm6bdDvYYDVWcQmiAkVN
	OwHlUbMfXGl+geROXkWSoXTEyGxcK/k=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] main.conf: fix unintentionally set value
Date: Sun, 17 May 2026 13:30:10 +0300
Message-ID: <9f8f586b241d6ea2bc602eff7941972232210907.1779013529.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
References: <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 31e4fb1498f ("monitor: Add decoding support for HIDS 1.1 flags
and attributes") unintentionally set a non-default value in main.conf.

Restore the value back.
---
 src/main.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.conf b/src/main.conf
index 39584e225..5846ef92d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -289,7 +289,7 @@
 # Export claimed services by plugins
 # Possible values: no, read-only, read-write
 # Default: read-only
-ExportClaimedServices = read-write
+#ExportClaimedServices = read-only
 
 # Security level:
 # Sets security level of ATT channel, setting security anything other than
-- 
2.54.0

