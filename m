Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8E1C5486
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Mar 2025 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740810214; cv=none; b=evnui8mDHyNvhp6pr+QHxfs9R2jmlvMZGhIMLX2USChMXw0U5kExhyNT/2smqMfacv0GVZcUJRaMhvoeHMLNGTR+yNBILHoAPx0p0QqlU1VfzfpwuUX04YFHKqagHCCM1eZw3O/67S1cyih2RweojP+dADm7SoLU5XCCoIH2rE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740810214; c=relaxed/simple;
	bh=IPAqH7O9Ym6PzkOq6+w+MUTqZYBnht/xmlA41TSmi48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uscZMu4viL24+oKKpcIoqj7I1CNeVThnKLk04HDBzg5CW7YnK6V72u8g7NMnwn7SKj7HKIXbEzUizxL+QvgCfNMAqAVXR65mhjsS4UngfB9/8LVHG3n5nbZVDpuJp5rO5fN70Fq8JGFMx7KgL3xvy/mx078RVTLDWDL4voACyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApHx0Rgc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApHx0Rgc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feae68f835so3786917a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 22:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740810212; x=1741415012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa+TzR/uaIKft7GqGPo8hnK/co0kcosgc6iNYdJhEAg=;
        b=ApHx0Rgcetnn5Qn8BmvIsyJCEcVPqCd25H9d3Uafg1O0DkL6KOzzBZtud6eMFS2G0D
         GxBYOpyxV0RUIEt6DTPfXaqhmVSe7i4qONQ5spYuYnvC8/90we43TV0zo/QRcPqUOIVZ
         1ZvMg0OgpLWrEVQuIC7Ryc9MZ6LHWAc/rYPXLMoLQr+5OEXtqqJ8c6dL3eTKUGHz+H4f
         JlKDwANjn1qzHQY8OcOga/dYBIqSZkI3qr0uIacniHT083UKrxOnyKQao2PfJrYM+E1x
         xWdW+spD94soSO0UM7BHR39FmvfmWbp5fLvwr0UqTFaZX1dFkfjGMCKxkafXPKB7iykz
         CAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740810212; x=1741415012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa+TzR/uaIKft7GqGPo8hnK/co0kcosgc6iNYdJhEAg=;
        b=TpPB8KgOtk9Ag6sJ293HRee+wEglyC3y8qU3Ifv3aAYZz9IXOc6rUsviBRBmtqswmq
         chTMyfWjK5nLtdL6+7C/fdQIkwNwZgPfZctf9BJRxGixrfgM5Xgu+wz9R7T0Txfx/KVC
         AJFqwntIerJwHSoQKr9Si9+Zu5AVf+Sd6hhSB56deRmzGDbWyEcDC4AyPfpSJeywLmdM
         9M2iRKBjr6p/1kyJPG11o4c3bhFdPMUGQM96m7mwlwV/uYZcoU7xK76nYfOS8j+J6FtR
         LqtZ5fymUqxbJMy0WvbSe+rpjHDsYzF3cN7CO45dEvmBR46b+igB+LWWE26CMyG+BJ3e
         p+9A==
X-Gm-Message-State: AOJu0YyhBSqhQsBE82F0gMgmqXVmqHV0ejFColUsedzgF59TxHGmr392
	Vx4j2t8UVeA0+YBFL4UWfYt1b7rGrR27SN4x7kTEZFBhA1+VA8wpd/J8ZtMB
X-Gm-Gg: ASbGncttjl3VWfuXAheP6ibU5WkEiStKORJdaRXcW2zh0WzJYkkoCaa7j3eXKJ/3kjS
	nOodoe1vwTpkpqMd+rGBJoBa/0e5a2zDZ/ae3DGHxGFbdSHp1kZoelNeU+NUh2TuOxNKyDKZFNY
	C7NLB6EuNN6wxXj6TOoQ2HBaOPn3ahWt7EB0G0/0JleGGreBGhMNAhQZT+PXg3fibfbSGpSTQKA
	rf+a/0IroAQOORsHYQT7/F6RO8EoPw2sSpOsEQAJiRD1mjtsVUNLLrcxUGTW/e/Gv0VE4Oh9Nt5
	mbj5ZGkl0dJiEFGRlc0h7/1BEv/uK315qEBPNK8DkSQrHDXESUvE6p6oScIgelheg6gtNiuOMlC
	LCHAzF6GplJyCN8RnyJUTsTFOZcee9g==
X-Google-Smtp-Source: AGHT+IEvNGdsU0MQN59ozUCIroTkN5d63x2VoiqaJmBNxdBwHsQTBZXucmzmz0p9PYbJ1fjiPLJXzg==
X-Received: by 2002:a17:90b:1d46:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2febabf19bemr8741243a91.22.1740810211857;
        Fri, 28 Feb 2025 22:23:31 -0800 (PST)
Received: from localhost.localdomain (168-228-202-55.static.sumicity.net.br. [168.228.202.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f121sm7014625a91.47.2025.02.28.22.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 22:23:31 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [PATCH V4 4/4] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Sat,  1 Mar 2025 03:23:01 -0300
Message-ID: <20250301062301.18029-5-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
References: <20250301062301.18029-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set HCI_READ_VOICE_SETTING and HCI_READ_PAGE_SCAN_TYPE as broken.

Once the min/max length of the commands began to be asserted, these fake 
controllers can no longer be initialized because they return a smaller 
report for these commands.

This affects various fake controllers reusing the 0A12:0001 VID/PID.

Fixes: c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to handle Command Complete")
Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8149e53fd0a7..903361456acf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2436,6 +2436,8 @@ static int btusb_setup_csr(struct hci_dev *hdev)
 		set_bit(HCI_QUIRK_BROKEN_ERR_DATA_REPORTING, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks);
 		set_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_VOICE_SETTING, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE, &hdev->quirks);
 
 		/* Clear the reset quirk since this is not an actual
 		 * early Bluetooth 1.1 device from CSR.
-- 
2.48.1

