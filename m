Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5330FC1B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433832; cv=none; b=q3sqd4IJJ6IxhpYOLelHhJ0DoOwV0jPIENYVWpnl3+SIinRf/cYPR6wRCCuakmGqtqC6C4nb2Rc/j51MUHvJ9MTEL0FWQJD7nfU8QvRmWu4rAxIY3LnPZsXWIny88YarP8zXtDHHq3mC8TurlAAEONtNQX0NFljfrZJQwXeqj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433832; c=relaxed/simple;
	bh=m+UtyCB+3/vXPOOyqT1GFAaIvlXRwZphg2JzvUlE7XE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TnJI5kbGvwiXRwB8O2GH6sPAf4ryJ2q/pHi0F/+MsYcktRqmOvnA+48tcfKxby2oaKOtEvypdoPGnSSyWWbB6npyHKuWD7TC/sFEYnMW6xUNx2x8T5EWQN+ysbq6yUp1IxBE5A+CgdVgsqgRPRGCA0ZQ+fbss/GunBtpgeDzFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4et6Pj0; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4et6Pj0"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9638c832c48so2049061241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780433830; x=1781038630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsCSwhnPMUM8+7fBUW+SKxuUJspkuAWXQXdKrngXXyk=;
        b=N4et6Pj0e1IxRdVcT+k4fbgVRUf4yvY7aB5VKsjhikCoKlPHrfxtuIJCt6irUixgde
         4yA/tgW8Y2/u2/XqXDYMb1gP39emcfOnHCtG2e5/zjDImXlM7cnLjcmYKYhQmaOFiasT
         ZvMLoqKisZ3DAtW7JsnHcikyHtb23STwUXWz7jbuWEeNDHpNnGhSflv2XRnXfw6U1qKa
         WwSjik8eUNUyAHP2OQujzmWhtyNkbi+xooY4nUeHkkgeHctjmIKZ6SxU/qrIKduBh5QD
         QrnyRvK2OkiT25RtHe96ZZIF2rAQt/E0UU8hSR5gCilUX15S2NwMJW2FeR/UID4EVqGm
         dz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433830; x=1781038630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsCSwhnPMUM8+7fBUW+SKxuUJspkuAWXQXdKrngXXyk=;
        b=KCbID/dIHPtozjewKZU1FR0QXSugaUP4x1hIX4ZRzOVzBmhuv8kV57YuFbRzf2NNO1
         aAlxC2yij63o4wDIwMKHtI3HmIavwhX1uEgsp02sQl9Qmn9vvGvnBhi1TUdFhCaiGt5s
         KMDnbe/jitwDn96N38YLjJR/vy4Is8Fybom245jeBUWXYKbEQcA6BS4oB+elOLbhqJ3X
         2vZqOhP4rGSn8JVrGoCaSPELoUDZgyWvTYYoBM7QZf0mc9/MEN/t38CnwghPDuT4BEyU
         b1FjYTTfSLidDOD1HdQOAxTD/Qa7JH46KwwHNg3gS+SdeLxN9GSZduHKASBTc28G4Lpf
         xbSA==
X-Gm-Message-State: AOJu0YyBmDef8hLgwrgC3YLzKRZ6tNEIHI89c0r/EEMTMqixhJBGRrOr
	GXnpzE2j13PdvPF1w+5pe9qJohGnDwJpERU3659UeICzKMw9FwZ83GbilUVw5IFRZ/M=
X-Gm-Gg: Acq92OGmkP+cwi0K3gsFEwKJsyH0J3/MO7rUH9Z/wQxnMNK66vXC3ngnkPTB3I3PNN+
	2VyQhdKQ5igNA/7o56TYpl2C4p6IDRRJmnQ+83KCa0j4uBVJ8e5LIoBioXR2iT5QUI9JbHjKY2P
	g98FPI+stI3mN6oFSQn2vfJXB09EVEp2fUnXYMb18JpdDcqw+sUAF42j0sj21yg1W18lqf8MPc0
	C6/hlBCXMzpAAf8cx/DiixbZm//wDSzpNlEqAJWpJddIqBbzJpQ0uvkJXH/+e6RkcVZn5ivtZj3
	6bf6f+I4EL+oudWcVNdz9kle5gkhRNfoSZrTzVrnR21wMFbhFCuqwiRjiMgOen2guSXR7YMalI/
	YkbKF4iKUt5PqHgU5+7WD1xj/pYEZmk8mVdCKf1tjEOhN2dHNF+pV3EVtK+TBZVFCDksGQfHc6g
	ul3RBdFoxrJkkOk3z4QtCOiIA8wr9X78tuGPDNM+dFY58qRi6qtG/eLeCcvKAw0yf1s2d4g2bRz
	S8KDZ+auPgkdiyZ87RBJWun9SkW
X-Received: by 2002:a05:6102:f0d:b0:631:ab8b:c34e with SMTP id ada2fe7eead31-6ec2c4c3c04mr178716137.11.1780433829738;
        Tue, 02 Jun 2026 13:57:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb5549144csm548186137.3.2026.06.02.13.57.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:57:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Fix backward compatibility with userspace
Date: Tue,  2 Jun 2026 16:56:59 -0400
Message-ID: <20260602205659.212834-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bluetoothd has a bug with makes it send extra bytes as part of
MGMT_OP_ADD_EXT_ADV_DATA which are now being checked to be the
exact the expected length, relax this so only when the expected
length is greater than the data length to cause an error since
that would result in accessing invalid memory, otherwise just
ignore the extra bytes.

Link: https://lore.kernel.org/linux-bluetooth/20260602204749.210857-1-luiz.dentz@gmail.com/T/#u
Fixes: d3f7d17960ed ("Bluetooth: MGMT: validate Add Extended Advertising Data length")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b2..8e13af77d694 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9114,8 +9114,9 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
-	expected_len = struct_size(cp, data, cp->adv_data_len + cp->scan_rsp_len);
-	if (expected_len != data_len)
+	expected_len = struct_size(cp, data, cp->adv_data_len +
+				   cp->scan_rsp_len);
+	if (expected_len > data_len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-- 
2.54.0

