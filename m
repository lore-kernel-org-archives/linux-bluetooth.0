Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E1248886
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 01:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983334; cv=none; b=gTVNb+yjeS40F5NdBgwQn03xI06O7/IF1SnA1CQKy39fi859R6YZ7M19YXvdB3hTWr8KhLZfcVPWhv3tD2p0EaIofkS+jXuMkKs/Q/hNsEe5OJFTiPxBnXvCSZhKR2tGlFCp3Ld80RiuzDXY8aVMblhQ+EQ4ZaWSTIo5HYRAx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983334; c=relaxed/simple;
	bh=Dr6jiJ0/0ZDoHpCn0Eg2KG1YN9YQtA78FZ9OQzhjLgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqL1MWowioisxltA10a5frinnxZrgSYwB1pG0xMnDSqRk1lp51+LK3xycy/nauP1TI/AU8a8z3o9/un/UInRCWnU74aGTyr1CP22MOXoE8dFgq61NA+QfP8MTbGE3kCVaepXRyRvKEGed3Hl2gxi8XspREU5TDKi7L/bpeMK97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYGYI2rS; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYGYI2rS"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2aadc18f230so37858275ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 17:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771983333; x=1772588133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcNeG4HbGt8Ti8QMipeo88D6Pkf72Tg2k7nLs0vDwLI=;
        b=bYGYI2rSpF+mUrAfM8OLK4jaxITYAc3dtVQZiUMiUrUWwVaD8+cKIBD5ya7lHO9HsK
         orDHtFfo2KhJ628HTaqArcaPAjP7dtgl7PYU5gMF+LdNJZc4ATqv0aR8CuTATktb5lFM
         d76AriURGzmJrauhMs0iKQSq4bpO8acF/AfPWeR1K8wfoEKGHLh5zZOdMJuT8mE1U/Cr
         vADR1Yq+5O4Qag0tufgTnNMbJF7iB5FQmcgo9tEqaufHEJnf1kDqEsvDs/lTnoc6YkyG
         2TvLsRVNr3YkPPLO0p9C9K8ikEn3fMo9X4vGTX4eK1qtgugclfFNwui+hvNbSzp6Tk0x
         fMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983333; x=1772588133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcNeG4HbGt8Ti8QMipeo88D6Pkf72Tg2k7nLs0vDwLI=;
        b=ICLZ9Lukck7PyckbaSpyFUJbm/FWN9I58B+SAigtTwxfAJ2WDg1aTYemw1ZvTHZRYe
         HlF08z0MUSN+xY1oTyuhRAK6KbbhwBlY+BbfA1w9TBMBQfvCLVWhdNN1xzCuwALOTdXg
         y9J3fiAJON4EH/uY979HL3zWqEY9wZ37KmLWG1vbRo4XGERJGk+5wTeGzF7ECTa0on6I
         oQ5z6bQo2RjJFmYNOQDmgVbUSb/h20mlwRsp1DWxXQRkNTotn3ko2KhT+w9Iybapf3JL
         +MhHHFd2bTxqKuWVY9FMdBPR4cJyTkVaLWroisO0HZuTqTs+J2ZcucbchVRIqZAmM8ao
         S9zQ==
X-Gm-Message-State: AOJu0YxfeJAKA7EG3gDo6LSB6rAKU6IHQlTAr+dPOkQj6ZkAGYjg8wSI
	eBtOaz/aQvR4QzmXqUfdN8lx7XT5GlglErzBzml2MGIQ3BwM2KqHs4Hb
X-Gm-Gg: ATEYQzyxSs2g0WUlveQERgve/bFxhj4VfbPu79sUemzG3Q9xI7gngE4RGmELbFOA6wR
	yqmIMZtceK4Gy0T8W5g2Rd/NTuEq7R8V649oTYQXxS6g2aZyA4p4/Uo8qwNXLxVe507at15jEhQ
	VRGnyTyBA4nI5bORP9GVTkuX/In5LDtLXQeRF8QilkgDpVMSCc+hCfnW6b7TBHZ9FldePPsitj3
	R8RFx/204XBZ69ph6fT4XyQpWtPlWFb3iyAezARsbDDcJONyLCvQxDFvsuFX+844xYH5G7nkpYF
	PYEv5eSQGMSES8epfKbClj+O1poz62gZcCoP9kK5UEssJvdng/o+/mG/Y2RKudwiWRCISBGWF/D
	1Us47XZaCUJeT80csbBAMMpFmm8CmsKwp7Eivks9HHEDKplgIW6Gocz/RKvlgBFLHO4f73rquJO
	GtOqyKJO+6s59pPb/JgsQc91/UmvCmWE/936lM6j9LCiWGWTS/qbokEHI6d2wDmUzZ4RMj4g==
X-Received: by 2002:a17:902:e885:b0:2ad:b957:e7ff with SMTP id d9443c01a7336-2add14401b4mr7368625ad.45.1771983332853;
        Tue, 24 Feb 2026 17:35:32 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adae6c6674sm38942655ad.73.2026.02.24.17.35.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 17:35:32 -0800 (PST)
From: Eric-Terminal <ericterminal@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericterminal@gmail.com
Subject: [PATCH] Bluetooth: HIDP: reject oversized report descriptor
Date: Wed, 25 Feb 2026 09:35:27 +0800
Message-ID: <20260225013527.17605-1-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=ericterminal@gmail.com; h=from:subject; bh=HG3CwtVu3za+J5tr8QIO4bwZ09cObu2x+PgSRj5Xuho=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWTOC+y6Me/lp7+Mh36bz2U9/fJp87tzua5Xyz4ZHIxkM LznkTSjq6OUhUGMi0FWTJHl7v99c3O9bs25zn04F2YOKxPIEAYuTgGYiKcqw//qvDMTCt2nbsri fXQ6816g8imjnLUuDAEzrsUlSzt/e7GCkWHRnP9XV3ntKZE7c+Rw2Qv+fUvSOXZMe3ep/GItwy6 ++A5+AA==
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit

From: Yufan Chen <ericterminal@gmail.com>

hidp_setup_hid() duplicates the report descriptor from userspace
based on req->rd_size. hidp_session_dev_init() only checked
rd_size > 0, so oversized values were accepted and propagated
to memdup_user().

Reject values larger than HID_MAX_DESCRIPTOR_SIZE and return
-EINVAL before entering the HID setup path.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 net/bluetooth/hidp/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 6fe815241..ce68b3c27 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -815,6 +815,9 @@ static int hidp_session_dev_init(struct hidp_session *session,
 {
 	int ret;
 
+	if (req->rd_size > HID_MAX_DESCRIPTOR_SIZE)
+		return -EINVAL;
+
 	if (req->rd_size > 0) {
 		ret = hidp_setup_hid(session, req);
 		if (ret && ret != -ENODEV)
-- 
2.53.0

