Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422C7370AE4
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921642; cv=none; b=GZfwEa1pQQwc+3KtPuT5Mi6tu3eegkZD0QuKfuSlRO16tcEr8nMQlgbavclhDgqJIRm3uFKguLWji0WZwYXb07hindyGvJiJ3RMKYOhjWmK8JjWJes0a8Z2Ew/r5yxBQ5WDIUeeBhfxWFIdv7VogR65yu+tsu9XbByBLb7lmvus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921642; c=relaxed/simple;
	bh=r4KjRljCQIs+X3/pN2QIyInpNzF3Eo7vHUcYM29lRls=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DSSB9guzSi1fF/QkW8kLP6mapF5Ceebr1ECQ+DXq9DPtlnUDSzdn80Iy/XfyoLy3C9bCRoI9q/Az2T2SZJeljEsk9Ge4RrezrF7I6LP95QwYAIeA7s9tYP0Adw4sJM8VC2YeI4AhNAZ3AmBLZGNh08gbgjK0AVi+fVCOMzhnKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SMJ+bQt1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SMJ+bQt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780921639;
	bh=r4KjRljCQIs+X3/pN2QIyInpNzF3Eo7vHUcYM29lRls=;
	h=From:To:Subject:Date:From;
	b=SMJ+bQt1+HcFI+SZqJNJffe/lAZbozar1vo80BS7LiXwkQqUFclVUuG+6GVjFFy9M
	 uXsgqcqqgy4D4xVL8qU0MS/nYUb6s89OcghTQ7pb/2cg2Ngp5U+5EXPx0kNzzSVv3q
	 RbeKLS4hkFbjCPM+Sp5maVSbNB8KOa5mxI06N0Hn1q3eWPJq1GhgfjAAHYTDp5RVAK
	 U2z46Ujpa4z1EZT3NHRzIMxMOzEJuMkaHNMiF9lCoFBJNaQUULOpRE911LzakNRA6Q
	 XBUX39zcEH3Q2rDaKlqFJaor/AnG7KFlAeJGjFVx5UhwaCWATV/JXadFBCzlbbnfJR
	 RtCLAKvuf38Eg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6EAF417E02F1
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:27:19 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix cache update on device remove
Date: Mon,  8 Jun 2026 14:27:13 +0200
Message-ID: <20260608122713.72681-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If there's no other group than the one explicitly removed the length
returned by g_key_file_to_data() will be 0 and currently nothing
will be changed in the device cache file.

If there's nothing to write, remove the device cache file.
---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index bea893301..046c8017e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5469,6 +5469,8 @@ static void device_remove_stored(struct btd_device *device)
 								gerr->message);
 			g_error_free(gerr);
 		}
+	} else {
+		unlink(filename);
 	}
 
 	g_free(data);
-- 
2.43.0

