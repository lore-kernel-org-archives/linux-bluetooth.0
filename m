Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB943C3450
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602337; cv=none; b=IUvRgPoomsH+WKG8QF22Y034gFUr4KvcxvNBu+lCt0JzbOs+7UT2ZUBCXu5qgUDOoOeDPaqSFYzwpqA5sPdAvTQ4MwQ0Y/dfLmTu85pEP25d3o1Vny+WTaJJPMi+McR3k/OAgsXhFpTx0OM7W3mdjhuC+IgKvcIe8fK5BJS0Fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602337; c=relaxed/simple;
	bh=xjWEaUZXs60yw+pKZM/bthVcL/B98QbcDhoLy//HNHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geuXp4kozD56bvcvP/XHnYtTyxuRSRZecwkA3TYG6KmzmmUxoCV4zLn2Kdho10gk4ylgaVTtmuxaUtf+HatWlK+uI4T4wQqWBpFYpodwa9HrP9QldVi1flBl7BruvQIPKM/VkCqnllNOE097VGjVoQkUTZIkNvzmRGZjWC4VrRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtcRAaDs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtcRAaDs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a17ce1dc00so398685e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 20:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602334; x=1792207134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EHxmkEUl5nl8/tcPAtdDPD5IXGMGzpWCjxYf2/fRiK8=;
        b=DtcRAaDsbVvjE1D+sXqwIofUaHmyeN83msOfeETcPFL9hav82tyR8SaxtIDyTgmS9g
         0S4UP/iKQV+NSOZXJlwM5gX9Nj0kxdyhNFBJ+KlGfqeMgOR7WN0UVEg3xUCFiMHEwNex
         yjjmFkgM5MUC40i3RqVoXbjrS+WyvMfw9usjAQ6VuLW1ytWCAwY0KMhKFwdZkl5clp8e
         z3HrJS6ain+CLBVaIXHC5FQrUNYtdcup7q58sVnPS61XOeRL782FdFg21CONt2SGa7Yg
         cO3rZvnncsrWpZUtdUjzK8VQFCrtCrXofUNK1LG79WbQ+jRbHvFmRYqOUzOmk41j5X+X
         A3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602334; x=1792207134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EHxmkEUl5nl8/tcPAtdDPD5IXGMGzpWCjxYf2/fRiK8=;
        b=Ws7feud28CSXI9B5SdEdSZu/X1ztpLPZuw61Du82uJNXntTS+4k1nVXRf+88neCRAO
         ILlZ/Rfh9AC5cTcR1KJkQCbZYIxEQm9KHsfFrEj3WeY7ygPRihpQvzpTUJz8y2nizzhq
         ZTM7bdvDWJ4atzraKGwHfGVJ7Ao471/06SPcM0NhphltOTmIee0zIl8GzN6oFMBZLpr3
         FsEsf5vSYPoi0n69ZdBic5c4cE9KffL3s3umz7Ll4D5mtwd3JdcsHE8NTkxpYwYSxUOa
         k2PiaC9mWm3Slbiyj19WyHCzo3P7Z8iFiEK5LiwFYNjUKQnxAV3wVxqYZstXw4SF2agI
         o0kg==
X-Gm-Message-State: AFq9FYKjpsL6/DROSsCIz8xPBKYvjgdufx/fu23kTaa03PW1t4Pgdtfs
	5E+KxQYnatEESd9i70gj1I2+ipRBXzfpDmd/gajuebeynHbRjZIk3ysA7gK/7UpMNyU=
X-Gm-Gg: AYBFou2GUvPmFVMgBojrOH0TqvtPTPcrtNzeM8in/dDKvGfN5x6r3jqO2X5pZH5EPPT
	n0uRkPe4F2y3bRjHLtobICr2t/OTBMiHRP75+zS7ESNXZnvImNprcS2Ph+n3UwHPU8LSY9JgHPo
	WTTfyYRF88ArSnP2NENyYdyMYsimDgG/MlTeXeLq5okD1dU+IOj6Ejq8OpXi1AO3H9AKmOY54bt
	o7RXVQ7wM5d/VYF7BsziLRp8wCTYJUaMXl/eLuKILTaassImdJRFF4MzcUukKZOCQGyCddreWFd
	VzWzhzCqZAjYr3/+GqEy+SKN0Dr0LuTZXylIqsx0xBE5Pr4SiWD1Kys5ZSHeiRXPoJP7yRJ/RZ4
	YXLIQ35ucN/9WQAPeOBcAIXsaTD1x1LX7+pcjA9oXjdDmo5fM0vBF2/u8UVCcJm9ocqR/wc8nzL
	qo5mfv/Sq2JpTYlR0MHXJtX7xkeAPVZhNlmPb+Ef4YIqHIwJbDMW9u89wnJr7N8mMpFT4FuYo+T
	kTtVG6h6FsgMMJNCskSfE10PHdA3HdICVn8nNspufGn7MB4SQ+btcE=
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr71282855e9.1.1791602333516;
        Fri, 09 Oct 2026 20:18:53 -0700 (PDT)
Received: from localhost.localdomain ([194.36.104.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm110270805e9.10.2026.10.09.20.18.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:53 -0700 (PDT)
From: Iaroslav Voitovych <yaroslav.voytovych@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] emulator: Add btdev_send_event
Date: Sat, 10 Oct 2026 05:18:49 +0200
Message-ID: <20261010031852.2842893-2-yaroslav.voytovych@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
References: <20261010031852.2842893-1-yaroslav.voytovych@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a tester to send an arbitrary event from the emulated controller,
for instance from a command hook, so that the order of events around a
command can be chosen by the test.
---
 emulator/btdev.c | 11 +++++++++++
 emulator/btdev.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e00f78288..fa326e72f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -9158,3 +9158,14 @@ int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode)
 		return -ENOTSUP;
 	}
 }
+
+int btdev_send_event(struct btdev *btdev, uint8_t event, const void *data,
+								uint8_t len)
+{
+	if (!btdev)
+		return -EINVAL;
+
+	send_event(btdev, event, data, len);
+
+	return 0;
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 145f7edaa..aa04ca611 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -112,3 +112,6 @@ bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 int btdev_set_msft_opcode(struct btdev *btdev, uint16_t opcode);
 int btdev_set_aosp_capable(struct btdev *btdev, bool enable);
 int btdev_set_emu_opcode(struct btdev *btdev, uint16_t opcode);
+
+int btdev_send_event(struct btdev *btdev, uint8_t event, const void *data,
+								uint8_t len);
-- 
2.43.0

