Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5C1E89A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081262; cv=none; b=RTwcmjmfKXculQj5qrYzu0cAzIuvXAysIeIiiRTu4k05uiiDcHRF+sz+SDL/zQWE9d4HBvwyAOHwlDOWM2eZ7xEa0fnlCft8KSMYUkVj6MAuYEMhxKqapMZpM7OKjkWAZQSeZ5/zfmSivIeyqyi1J3cW1XSho1Ey9248xEPxsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081262; c=relaxed/simple;
	bh=YdhSO3QIYKxHiPHW4z302UhfJABUeFRJ4d58sXWWM6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncaMSI0s4eawBXnUFiNJYCSBcEIN4gge8FHvNNZcDHCswc0tTWIKA/oUdwQDGPKK4b6FPA6WYcu2TzZRFfg0QXGah9cV8d26ZOPoJrkvG776bm1zVuXzGhGUQ8SYIkjiGpDGFROGOBkbuWcOTasJhZ6vK/unYNExtyr3J6TFbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 938CA20012;
	Thu, 30 May 2024 15:00:58 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 3/9] l2test: Add missing error checking
Date: Thu, 30 May 2024 16:57:57 +0200
Message-ID: <20240530150057.444585-4-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

send() might fail and return a negative len, catch that to avoid
advancing the send buffer in the wrong direction and causing all sorts
of problems.

977|->			len = send(sk, buf + sent, buflen, 0);
978|
979|			sent += len;
---
 tools/l2test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 011a68c3781e..7b6c36e165da 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -975,6 +975,11 @@ static void do_send(int sk)
 			buflen = (size > omtu) ? omtu : size;
 
 			len = send(sk, buf + sent, buflen, 0);
+			if (len < 0) {
+				syslog(LOG_ERR, "Send failed: %s (%d)",
+							strerror(errno), errno);
+				exit(1);
+			}
 
 			sent += len;
 			size -= len;
-- 
2.45.1

