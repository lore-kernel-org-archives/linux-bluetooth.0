Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B652FF656
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571265; cv=none; b=MU6eKdPXof0PzjtKbKJUxvV7XEbne+KNzrGz0O0rPKqd2XvPL7O1VDSL+qdi3hJiDrn9PnUpkA0Fm3TzYaO+C22otb8VQVDW/IVCW91WQhxhgEaI4sDC+WVE/mp9i3Zu6IQJbal/oGn8clzR4zV78UvsLcJyYp0OI+D7TPh1uyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571265; c=relaxed/simple;
	bh=h4wdFPYGSI5IgxCym5OqjAQMc9s/zRmY7IaPrPtm9Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTg3IzFG/0AcBtga1ybA2Vl0DudFp3pWfJ4171/XBfR6kBkJXNtT6H2qXU04bBMOUwF6QFq7JeJuFkIjk6L6h5HZKacaQRf5PjAAXNrcXTeoblVYKSTWdgUXOquNPruPRiFiXp+FQLbjzNVXW2oHMNln79R9HVELu5v7pk50z6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QZTRw0lg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZTRw0lg"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so5556126b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763571263; x=1764176063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNHinq4/2cTHhTy5HKSefqHwCj7EyOMXN8DmFkxYCE0=;
        b=QZTRw0lgygfUcXX0/LdSoUU/gtp7hUafNRwCtcHEHVW003IsFA+A0hWlU2at2Vjdmz
         eW4QeVVZnX6r3wpStkrWnTZDQHqILy2ojKqaFYLNNQvdMYRNpb5E5iHSaMg0KANuLQAu
         aKbNXrbrIftIj+/RfO3WIjQ+vFYCKUMnCGW9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571263; x=1764176063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNHinq4/2cTHhTy5HKSefqHwCj7EyOMXN8DmFkxYCE0=;
        b=B8vC2SWP0CDIoNpGPwSTW8bJsQjbE0jATHVk9ih2WFGmZzlAXhVXi4Wc9BwMPWVM0n
         myKZ2fYYlQDjhrx1YNjVyDTff4j41t2b4Gs4+FYGU0ps05MKkx2pW1F5kpJFKxvyVaTQ
         Dfq448sTaeuTkhsB+rCOdYyYSTyCgCbbTIxHxCsWLO7qgrsZXnyAdnOhg46+v/CQQ1u6
         DoXJ/Q0J2ibreo3PND0ngwuWT3ZyT7ZwuPudwTxjtDVt7H58MKD/rxj/SvYVEIc9KtQt
         JXnTII0V8bjc25LOkfJByPllP8EBzThvN2yhw0UCDBoKIt+C/mGUcDQbFf6fpsW9wI7D
         Jpxw==
X-Forwarded-Encrypted: i=1; AJvYcCWVn7kP00tpW4gofbLJWIh2pyG9MayNQEdxE2eCWrojVX8DwDudNR2pc/vtiXCIYj7s7eX9k6vAO7ro5TMIdyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx0ifhyYR5Rhkp3M71ODT99KWeC6Ljk5lx9zdHJQB9YIfeEOAa
	NFkgLpV7sSwdNLsV1AVC9xblD+gom5cmOFMrQiHpfgYitC9tUzIU/6ykcbfiV9IWLQ==
X-Gm-Gg: ASbGnct03efc3ucD63A+dWNKuUJebLqN+/onXovyH2S+EXKWw+OSW2DnOeVijzju8RB
	Zj7vP5cdr2gRiF4aFVJCQ5kmbPH9cLaFmOijJcgUVs4bUBqF0QY+avEFXBgohCCnUphZUiT3E/9
	3Z79mZxJBW1L08nSp6JoGTCo4+wZX1s8kJiVWfikKNJaP82tFRb0jv5MxWCQYxNjJuLjUqWb7Cj
	Kdyrn02vYQOzy1HdPmAf8vsxxDjFlDZfI3qrh1i1JMig/JnFSPAeLLQeJKDNJFCAlvzI4894cUO
	eUxduclcMyoUOqU7Ik091EOIhwJGgtS6M5Au4bkqYH2mi68iKj06E9hr7JmtGEsEzgpJ+9SftCJ
	15V3FwEVOdyoa76o27s649u5b6Nv3cP4HOF7o7vj2F7UmMf16AcJq7dg0OFfUDqvOekb+i92EUm
	6AO19+oeQHX2QkuY06GXq7cJk0c5hmZNwil2PbYpQFEKnrPVgxNvTzh4HQhphkqt9Oux4hi/cQK
	Oz7o91OGQ==
X-Google-Smtp-Source: AGHT+IG6Mf8qsXvOK1ixMYCQNU/FYpCBumYnKBfjBKtdbVbifmpntuvtxBUSy93dyel1BQ7M/vgfNA==
X-Received: by 2002:a05:7022:eac7:b0:11a:a20a:4413 with SMTP id a92af1059eb24-11c93887b01mr7150c88.31.1763571262673;
        Wed, 19 Nov 2025 08:54:22 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:cf0b:c8dd:8f4c:d649])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608860fsm61967659c88.5.2025.11.19.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:54:21 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	incogcyberpunk@proton.me,
	johan.hedberg@gmail.com,
	regressions@lists.linux.dev,
	sean.wang@mediatek.com,
	Douglas Anderson <dianders@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf() NULL deref
Date: Wed, 19 Nov 2025 08:53:55 -0800
Message-ID: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
  usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)

That function can return NULL in some cases. Even when it returns
NULL, though, we still go on to call btusb_mtk_claim_iso_intf().

As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
when `btmtk_data->isopkt_intf` is NULL will cause a crash because
we'll end up passing a bad pointer to device_lock(). Prior to that
commit we'd pass the NULL pointer directly to
usb_driver_claim_interface() which would detect it and return an
error, which was handled.

Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
at the start of the function. This makes the code handle a NULL
`btmtk_data->isopkt_intf` the same way it did before the problematic
commit (just with a slight change to the error message printed).

Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info
Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_driver_claim_interface()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I have no way to test this commit myself other than to compile it. It
looks fairly straightforward, though, so I'm hopeful it will fix the
problem.

 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a722446ec73d..1466e0f1865d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2714,6 +2714,11 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	struct btmtk_data *btmtk_data = hci_get_priv(data->hdev);
 	int err;
 
+	if (!btmtk_data->isopkt_intf) {
+		bt_dev_err(data->hdev, "Can't claim NULL iso interface");
+		return;
+	}
+
 	/*
 	 * The function usb_driver_claim_interface() is documented to need
 	 * locks held if it's not called from a probe routine. The code here
-- 
2.52.0.rc1.455.g30608eb744-goog

