Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B43EBF14
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Feb 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046658; cv=none; b=OzvHYL24xbgFZ0TkGZzc8zRK4beOTKx8L+XSqzK12GFgPpOy7S1hTvtdzbRGXXfIUNGjzQWmvonX8fo7TLh1tCO4cYA3tEHfIKLNy4vt5viK6ZwS7f6zt3F8e9GmCQ3qvjRB/D/7DNKWqh5Spp6YXd5cznbQ7yx3avREas6jMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046658; c=relaxed/simple;
	bh=vvqXzh1tlxCFt8xth7SBRWQxZkb3wz3nSAtPWQLP3Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj693HOmPLQQVERUZamvObdK6oDaPE5zrPGaeM2BFA7PqDxCGiyQPPkWg0BRNgJWvXAJL4DYV6mFRyQxPFz/nSuVe7VUXO4Jr7FzkfUM916t2W3tTM0/11TB1x86pi+8KCAAJzr7BBYt6vGEzdAsd+rrh0NPYv9Y2ThD5GXmfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGhphRVr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGhphRVr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-823c56765fdso1207393b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Feb 2026 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770046657; x=1770651457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/6qsyiS31Cxp+1gYvGwbXZitBj2fVwkgm5FbzDKM18=;
        b=JGhphRVrZ9I6/2OGp278pI0tSjzIfXUux1G5Iugs6MdZIjLTiGnbS/f3mGS7HY1VXY
         ZS89Mn34sdUiDmewDD4BOR0wq4vAphjJwLtxgxqd6iAlN8ss2O4UFUotpFtxzdhilSvH
         Rz4+fyfiyjjqwcoII2efA0OqJ9XhJYFNx8pCNlCW3warJ5B93d489NBWyN5IkdXrOye3
         WGhFu03HE360kxxhvBGV3cdzOapCii40ihXu81g/U7k0hLsjt1srFmVWTyy0jb3dWVNr
         4Wq+FrONSTAOxwTJ/CUaYCOLlB08D4GMm5IOK0jpzXtUeedSUHhewGAbcqYAQhj3FT/k
         4szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770046657; x=1770651457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/6qsyiS31Cxp+1gYvGwbXZitBj2fVwkgm5FbzDKM18=;
        b=GZpccixO5yJ7dVAhvZH1qCMk9WV86XTYklEoiVjIoLFjXMi8dpVFtJoWyRSMXhDmXM
         AycFo4sv478sCsRpH/EdaNDSiV/FLF96AHp3U5MDD25gpZxjerPgwtXOpUkNSPpVG1wX
         3UCfZk34yY1VD59BNEWyVPwAF3RW/BUMmMpXPAAUmwU/hU7R+iHRo9tlWkeR6S8YXw6e
         To8ZEzFhTUPQHf0f1Tdw1o+5UJTody/g6uT3HqtX5lXAcv28SPZOX6tMJg1d9VW4+0/3
         cbSg5KIJeojl2oDPbGNLAQkRiU9MckzOSB+xgUqa/iQ8vusFZfZYHTcH4fOQHJTpsBFc
         nN6w==
X-Gm-Message-State: AOJu0Yysaa1DaHpPRkY1vKB8s7ZiUDE5/dXF5dD7711wgtW32hvL3dDE
	uDP9Ws88pBE5BA+RlWJjy7G2G/HSoS354M+6e8iiQfX+HkekVsiBi+1WQqBkKA==
X-Gm-Gg: AZuq6aI8yQ9O2UViXexcsOMxs6sSzvL3qJJB097nbbl6MOX6cED7QHaJUoL48mh6ihN
	KrKmgfQEWqh5iVuwN6djS4kSeSkb66+wrY3DbyeMdP57PREx4QfsKCOm+5ifLEMAb62BaoRs/8T
	SaRgmKhbghoLE+1XgksF1sMvRwVIhseIZfEEZYFTCK6OsF20+HI3ZtONY2oFyyor12eqo9qe6gl
	IsMFspXAeE3xrzQKxpIknRTQ89MnqgX+y8YudYpLUk4agQ89jpwv36jlGlckjOOWvZwA5dfgoKR
	B9hdoInXKFrLulqzy/uOZ59xj7XYhINjPTbOtfIVQbU/gA3+C5ShDWY2hpbIkwCQ8+6LDhvNWFt
	X4NFgauTZEvy1/QTeEPEZbL3qwm1w2Jf/IW1HtJELj/X3RKPWbgDC2iIFh4+PX0JHCxO8kLCxlL
	T/D5l2zMGtyvxBYizWVDM=
X-Received: by 2002:a05:6a20:486:b0:35f:5896:85a4 with SMTP id adf61e73a8af0-392dffe8110mr11075921637.5.1770046656569;
        Mon, 02 Feb 2026 07:37:36 -0800 (PST)
Received: from lasan-desktop ([212.104.231.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642b0b4c07sm14740490a12.36.2026.02.02.07.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:37:36 -0800 (PST)
From: Lasan Mahaliyana <limahaliyana@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lasan Mahaliyana <limahaliyana@gmail.com>
Subject: [PATCH BlueZ] shared/att: make att channel respect LE socket security level
Date: Mon,  2 Feb 2026 21:02:15 +0530
Message-ID: <20260202153215.27593-1-limahaliyana@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prevents unwanted pairing requests instances where gatt-client tries
to read gatt characteristics that require higher security levels than
defined for the LE socket.

For example connecting to an LE L2CAP CoC socket with BT_SECURITY_LOW,
one would expect to not require pairing. But as the gatt-client starts
automatically for the initiator, if it tries to read characteristics which
require higher security levels, it fails and tries to elevate security
level. Which would prompt pairing.

Which makes it impossible to initiate a LE L2CAP CoC socket with
BT_SECURITY_LOW with some devices.
---
 src/shared/att.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 77ca4aa24..ac527fccf 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1193,6 +1193,23 @@ static uint8_t io_get_type(int fd)
 	return BT_ATT_LE;
 }
 
+static int io_get_security(int fd)
+{
+	struct bt_security sec;
+	socklen_t len;
+
+	if (!is_io_l2cap_based(fd))
+		return BT_ATT_SECURITY_LOW;
+
+	memset(&sec, 0, sizeof(sec));
+	len = sizeof(sec);
+
+	if (getsockopt(fd, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) < 0)
+		return BT_ATT_SECURITY_AUTO;
+
+	return sec.level;
+}
+
 static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 {
 	struct bt_att_chan *chan;
@@ -1219,6 +1236,10 @@ static struct bt_att_chan *bt_att_chan_new(int fd, uint8_t type)
 		chan->sec_level = BT_ATT_SECURITY_LOW;
 		/* fall through */
 	case BT_ATT_LE:
+		/* respect the current L2CAP socket security level */
+		if (chan->type == BT_ATT_LE)
+			chan->sec_level = io_get_security(fd);
+
 		chan->mtu = BT_ATT_DEFAULT_LE_MTU;
 		break;
 	default:
-- 
2.52.0

