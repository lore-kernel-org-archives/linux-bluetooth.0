Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925623CF51
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911089; cv=none; b=Rccum6753fqfr8+AT3W7YrIbmTlLMviB9xtrM9QHNh5ePrdwPFwMBQhk0lo4Y0cKrjkvMFBbYFeoTbPhQMwX6Bhi+y0COzCzVxAoiJA0b1PBR6I5ayZ3PvoJNYiNh9SIEKzdXwzJfB8jaXJmzxztF/6jUGspmxatU0KTk889KW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911089; c=relaxed/simple;
	bh=Pmf5qRBAY1GX0Iz3zETdKHJA7ADI2jumk7QcEy7eZ6U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KqItxMDzT4ULbhHDwAGc+rMEt8kUYqfX9IfGIq0VdurYBBkbXMim/74R+4vCbLxcrans0siWf3rduJfqERj1j3i/WPjVYB+DQtmjRZf3WOxfTy+f6p2YHwzrzslnVh8UaLrmobpZOH7LC6MkwyxeHpvQZRP/NUajJQ7uHvVZ7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXnz/8Qi; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXnz/8Qi"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-846ca104682so808241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725911086; x=1726515886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWR25QdGDmkOHfEyQz727qFXs/Fk4VaD8IwJ/1Zo19w=;
        b=BXnz/8QiqaCdxa9poW1Aozn9OmZV7thgtBEUx3/GIdqT96N2exnCye5mMsb/G7sS13
         uACHdpGtA/4mJQKN8IppQ8EZj5anYckw1Hl6Ahg+uV10dD8aL6CU7QUS0+AL6zuMb4T3
         DVpFaAGioztFmOr/PxGOKZ3JIGFUy9pIfhK7rBextRTIj5wdExGaUn4PAAWIeTRuhyc7
         LYatWyuUpeOo35i6bZGAxKFDo6e/2bcAZTN2AssWBOvDkk800K0Qm1C68vE0S3mBRU3O
         XLYt3r8fco0NRv+duysetT3Nkhs6DwBzv+03s/alBs27dLk/OK5xfLyu/1YmDqtHJQle
         z19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725911086; x=1726515886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWR25QdGDmkOHfEyQz727qFXs/Fk4VaD8IwJ/1Zo19w=;
        b=gXTNNU59awhee7Dn0LnGOwj26jVU8bPcMt2LNbv5d/hd5a8eiwnxwTW0YJaFCURrl7
         RTY67DREs2JEho6tWKDFOPM7tKaNBAvMJfrcoM/uQLtZ4MXksf+J4lD6bt56pNCmENqa
         SOCcJWDI29jlqomS1OeLgxiqUFcvRsVIaXwqc5qek5/61f9a7fbmlu8vkUkaKQFT+Y5A
         /B6SeuhbE7+o30L4N1D0fRkWoFjkggPrkKoVvMpFDoAdl+50X6TOEuUiqPBK9O8zxK8u
         3NX29MV55IsFDQzlIyhF3J/zdyoMdIXR64ZKJ+z5t7Pc2UGn1gmI3nWCbJMNhlxAkXUZ
         Xl2A==
X-Gm-Message-State: AOJu0YzlK31WBeUMjXJN0iSfwqNm0ea3huWTXRLtXwZzGf85VRbnRzlC
	wYV/TVpRbB6eH3owJADlJVODq4gpjnMrXNzXKIVeQ8RNMHWQLxg1VNy+4w==
X-Google-Smtp-Source: AGHT+IGLBfJrDCL9e0J2g0wB4ASt779UruPZzzJ2EBEHrrPN8T5GUZK02YLXezlfDU/7fJw2zP7SUw==
X-Received: by 2002:a05:6102:26d4:b0:493:e582:70ce with SMTP id ada2fe7eead31-49beccf9791mr6950731137.10.1725911085640;
        Mon, 09 Sep 2024 12:44:45 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-49c16ce78aasm27243137.18.2024.09.09.12.44.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:44:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND v1] Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL
Date: Mon,  9 Sep 2024 15:44:43 -0400
Message-ID: <20240909194443.2387703-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This ignores errors from HCI_OP_REMOTE_NAME_REQ_CANCEL since it
shouldn't interfere with the stopping of discovery and in certain
conditions it seems to be failing.

Link: https://github.com/bluez/bluez/issues/575
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5533e6f561b3..40ccdef168d7 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5380,7 +5380,10 @@ int hci_stop_discovery_sync(struct hci_dev *hdev)
 		if (!e)
 			return 0;
 
-		return hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
+		/* Ignore cancel errors since it should interfere with stopping
+		 * of the discovery.
+		 */
+		hci_remote_name_cancel_sync(hdev, &e->data.bdaddr);
 	}
 
 	return 0;
-- 
2.46.0

