Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535617;
	b=XLyDeJnCXs4qtrnPsUOKmdVVylqsNmdXkT/HBK4/LbT23vs0IBUp3BB06FssOb9QWiV8
	 8nd0rToeXKBqikf9Swk9m7puEKz02mOL+m9zdNwGCOkZL3nMwgIhqF0d9SLZcgYfi37sB
	 pLQMoAzgorM83v8KfM4phUtWyLYlXCRRd7vY7YDeEIIsWcdpIFde/C3hCLQSudQKyF/PA
	 NoQvpgahr75ikLOZ+MmgHy2+o6ystpRaYIjfENw7i/pJ3cIGQUazfnkxh7SupL1JkWrEQ
	 bSRceJBAWzUMiibKmpxNqvjjmWOIEz6I3BZ6Eg+AEptx2VoL76cw8++S+a8PQUeWsNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535617;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=kEhiF7v7kF6PPFbqABN5mRAjubXqXOwvJdaHJMR8Aik=;
	b=cVz4PbC1m3OuxhPo33pNdgiwdiSElfN72VV5t4b07alIBKjbEmsfqpvyw8U9A9Kj1P1G
	 DpGsW57DA+Bz8T7yqcpdwuBxoKAisOs5fzfZMm+GO/CUAwx6j1fFJduX0NAM3fcBmXoh9
	 3uGLJmAOoHM67eBf868xpdUYp4zwZCS02MOKjJAMwspEMZZGyXtKTl5HaZxJH7FMrwsEm
	 MxkC+GvpfE6LIrwbADEoRtNbnrIt2WA9RtgogREcYtImzAV6/nSVugeeyYu5aVFZyujFh
	 sXfijQaSOptHRaJuxmZ1TgZnnotIZIveNbmUAmi+oNfEOrFJWxoWHPThM2xmiwj5ZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1D606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53B1D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CE053F5A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 07/14] build: Only build profiles if the daemon is built
Date: Tue, 24 Nov 2026 16:50:38 +0100
Message-ID: <20261124155319.1752879-8-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFZJheZtnjKFg+gPK/6ccinNkO+hbr8RqiaIWGIFcH7KO+mUcB4qXezxu/62Excvf60epLI2YfpKIX9TOStZL7rRZ6Q6/viK+b51OU3YIBsCYxzvCGwd7mW7TW9Fh7+kv/hKyZ9UG4KMC3NnVOG2MSc4djIpsjUFDZ12PvyaobtKFjrUWl7JSpxSM2SK/uGPmqHPf+jycozv+KTOo2OETyyx9BAEI2s8dGYujMtKxAihPpG3IdOBSNhF+cWsW6+jUat5D2zPwzZu5E3kIDrpvAa/30ivyjX66xYLhJ99GajNLJ6GoRLKMczShKpD26eM6LMwZ6Mg0ly4p4oDvncjdwcw
X-GND-State: clean

---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index cbd337f2ab32..d8ded120bb7d 100644
--- a/meson.build
+++ b/meson.build
@@ -273,7 +273,9 @@ subdir('lib')
 subdir('gdbus')
 subdir('btio')
 subdir('plugins')
-subdir('profiles')
+if get_option('daemon').enabled()
+  subdir('profiles')
+endif
 subdir('src')
 subdir('client')
 if get_option('monitor').allowed()
-- 
2.56.0

