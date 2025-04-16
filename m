Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889720E31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744819489; cv=none; b=XGwdkUW9PmR0ckaKZQ1MOrn8SrW/Hr7cQ0w6JxnIGKk/ypSiD9SpKm7WMr5cC7LhQal1uaLvA9H4gXJY9SKxmL7fe0NlPCr5J8blYhCm8l182pDgG8x/FoG0vafdAURdSFZa+GvW9SEnuBhjsV/Sez2BXHWeLGuXamhGfrFfRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744819489; c=relaxed/simple;
	bh=Ep/VGdXyZEkyBZ8e1w235imF8eJuSSGF/xTIn+0YI+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLKGtmM2SfJrKli+bGrid2IUM5lq+O4DNCf14zEEv7zwTMviLEMfSZ7FIHQmDHtSwdwmx47W6iazmtyU5duo5oiN+Y+ptuzF84WYPPZ6k3qb0TB7DZOexwUwDJ8BX+OpQ5Fkpb8VvbONstWM/QKUpOWcNPhoChiKxXIFQ9pUr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlEACMBF; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlEACMBF"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so3848488b6e.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744819486; x=1745424286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HHkuNI7c4qBw/LbC/Lfy2J5sSnqFM4eZks/GYTvigw=;
        b=FlEACMBFexGvYGJ94zDwEApzjHxvlffsq0dP4hukes+GH9StPbVFoU2m28Mw1yaeNk
         qMLKA/INlFdiGxGVO11noehMLmSBIL/4opBsqA3L2AMjcenAspIyrQjLUN27agkC7O+b
         PpNDhEF63gVDBrUDfEV/IKORJnAQjpL+34QjyWgWT8zgPCXcU3fOBlswp3TOLzMX170/
         CFmjo53m9NgiCBUeftLUiRxms42sk4OvQ6lLkT/IPsF3kZJ4heSSEvZNT815KitFjDio
         tNTC2YW8pY75Bq6MctWB8EpXrJSdRJbes9HX6FAGI1FOUGDlIr+8ufyublVmq40FLleT
         xTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744819486; x=1745424286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HHkuNI7c4qBw/LbC/Lfy2J5sSnqFM4eZks/GYTvigw=;
        b=XIW+VZARewGT409pwxGCJrmP5rMujD8/n/0RzmVxs55hYQiwfdltBKvdyf4YvvC2lB
         OfVOaXJDgz1cN1OAm9rlCBK6ZUtfjyeqgWCvU2wV9ggVqUKle+9wZzWFMNMERcH1JuJ9
         1MbeO52bPIvhsi6UYBhc1hijLoRrjcU4Id24biIRJB/YB2Z3LgeDh21lhg3ADNjOtxht
         L05j3NKDTbGfJP1IZHVO1iuAZs0kKiW2xZ3jo/+xL0KA0I3PA5m5Nq+gmLE8sRid5Jrz
         tzLjvgL2vbvt2hsdqpjowsLhoMfbnAklxYgmsNZU0FvKgypXsC4Y3JEaWUqFZ4Vz9XCU
         Jizw==
X-Gm-Message-State: AOJu0YxOcxm6k5tXV9UIidi7FmU0Pp79pY9vXh16LM+x5EhUkBVp0d8k
	proi0Qk9e8kSvOGCkxnS663ljglJ47ucCCDLrDei8mYjhjgqfst6lmUDn3eT
X-Gm-Gg: ASbGnct7vw3Sl+BTXXdnEaHi63lLFutdUVAU+fCuIvGMFrc8INRv+6wLHUlK6SaJZ/G
	FhkKAiVl4v53kDBG7bM+OapQQTTN+iT1iQhsWp2XIFd3PuUozzztNDjIPZkF9l/w/yxe9Mq2YIo
	j4AP92zxf0lYaDYpCWA9PQSSL/AlZQhVdk4MFockNwGSWYteW1hFL+Len8syolbD5ZTjVOjcNBl
	JrZxRoThP6QZeob94nchxzqlK9B53XBpOr6Y60+JwZU7fg+rx6E9C74NxmtGM/Fb4D/7Vhiz91j
	xRl5IWsXNywrmqD7eKciUWo+l6RErbhT2CSIKzgjORhM/HhjgwLJuHINhrcVAM1u+S0D1QYx9uD
	pUS+UkCFtrA==
X-Google-Smtp-Source: AGHT+IEqKyvdXvBa90QphaLplhmVZuB8PUqsQhWWCyqe7FXJfnTf3w3Xd7dUw1kpNKPAKrB35l609g==
X-Received: by 2002:a05:6808:1509:b0:3fe:aedb:4106 with SMTP id 5614622812f47-400b01cee49mr1520431b6e.11.1744819486424;
        Wed, 16 Apr 2025 09:04:46 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98afd43sm3094029137.20.2025.04.16.09.04.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:04:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/7] btio: Add support to BT_IO_OPT_ISO_BC_SID to bt_io_get
Date: Wed, 16 Apr 2025 12:04:32 -0400
Message-ID: <20250416160433.1822263-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416160433.1822263-1-luiz.dentz@gmail.com>
References: <20250416160433.1822263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for reading BT_IO_OPT_ISO_BC_SID using bt_io_get
---
 btio/btio.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 7ea17c7754e4..14f2b700e383 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1649,6 +1649,27 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	return TRUE;
 }
 
+static bool get_bc_sid(int sock, uint8_t *sid, GError **err)
+{
+	struct {
+		struct sockaddr_iso iso;
+		struct sockaddr_iso_bc bc;
+	} addr;
+	socklen_t olen;
+
+	olen = sizeof(addr);
+	memset(&addr, 0, olen);
+	if (getpeername(sock, (void *)&addr, &olen) < 0 ||
+				olen != sizeof(addr)) {
+		ERROR_FAILED(err, "getpeername", errno);
+		return false;
+	}
+
+	*sid = addr.iso.iso_bc->bc_sid;
+
+	return true;
+}
+
 static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 {
 	BtIOOption opt = opt1;
@@ -1657,6 +1678,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	struct bt_iso_base base;
 	socklen_t len;
 	uint32_t phy;
+	uint8_t bc_sid;
 
 	len = sizeof(qos);
 	memset(&qos, 0, len);
@@ -1721,6 +1743,12 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_BASE:
 			*(va_arg(args, struct bt_iso_base *)) = base;
 			break;
+		case BT_IO_OPT_ISO_BC_SID:
+			if (!get_bc_sid(sock, &bc_sid, err))
+				return FALSE;
+
+			*(va_arg(args, uint8_t *)) = bc_sid;
+			break;
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1736,7 +1764,6 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_FLUSHABLE:
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
-		case BT_IO_OPT_ISO_BC_SID:
 		case BT_IO_OPT_ISO_BC_NUM_BIS:
 		case BT_IO_OPT_ISO_BC_BIS:
 		case BT_IO_OPT_INVALID:
-- 
2.49.0

