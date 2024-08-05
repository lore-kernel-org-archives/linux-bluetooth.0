Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD067D40D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866926; cv=none; b=mOnhL8S7y9e0KJ5qMC+E+JO8+yedlwtfateg8ZtDQ8Uw3RSA5DWWFXa2gclneI7sF2FBYaC//v7AKalpxzZteOYtlL8ms3JA+NyY/dMIugtK/bRdBQWsPX/qiRtIunQifYjR+5J4a7YaPHA1Za5K/6Ir1k4X2AF9VcboV12M1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866926; c=relaxed/simple;
	bh=BdTQ8LZ6jZWoM+L9qDs8wG+nWa8UVCk+Cx+c7JD4cA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Up3gDZPv2yU1OWj3qAUPtA9bWe53ulQNoLqkxU1aJcPq90uqa0GIdi57j0hX7cP+UWK5t9ghBMsDANrGKIucvg1LYso/0nTvWx6RW4epmO2KtYVI9Q2FuhwYHzCFG8SGmfcP5T9xCg0BEKLkRk9Jtsbz+Ml4BHPpckmAiUcjojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0653920005;
	Mon,  5 Aug 2024 14:08:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 2/8] tools/isotest: Ensure ret doesn't overflow
Date: Mon,  5 Aug 2024 16:06:40 +0200
Message-ID: <20240805140840.1606239-3-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140840.1606239-1-hadess@hadess.net>
References: <20240805140840.1606239-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def20] [important]
bluez-5.77/tools/isotest.c:778:2: tainted_data_argument: The check "ret < count" contains the tainted expression "ret" which causes "count" to be considered tainted.
bluez-5.77/tools/isotest.c:779:3: overflow: The expression "count - ret" is deemed overflowed because at least one of its arguments has overflowed.
bluez-5.77/tools/isotest.c:779:3: overflow_sink: "count - ret", which might have underflowed, is passed to "read(fd, buf + ret, count - ret)". [Note: The source code implementation of the function has been overridden by a builtin model.]
777|
778|	while (ret < count) {
779|->		len = read(fd, buf + ret, count - ret);
780|		if (len < 0)
781|			return -errno;
---
 tools/isotest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/isotest.c b/tools/isotest.c
index 2cac0e49cc39..0805faa66e47 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -779,6 +779,8 @@ static int read_stream(int fd, ssize_t count)
 		len = read(fd, buf + ret, count - ret);
 		if (len < 0)
 			return -errno;
+		if (len > SSIZE_MAX - ret)
+			return -EOVERFLOW;
 
 		ret += len;
 		usleep(1000);
-- 
2.45.2

