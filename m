Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D41AA7AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943197; cv=none; b=lLQRRh1D/vHSkOwiTnHWxkBX4ZZVpSUdCSzFIL1Ic2ZXTm2i0kOlKgmNdFc/UFl8ti0qKx5y5HaPDfd9/ARhodYmZlYpWhdo5amlys4Es4ov2uBVt6D9Mx/HDIg/uIDBWfQY7HiezCXz3RU+ypyX9Pf7C+32zwx0QWgfutQbXek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943197; c=relaxed/simple;
	bh=OTAgyHwKQAzNe9QHWBOL4pcfrn4VHbdGP753enF+jN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KAmTC/aJ0td6unbJnhIodlr3nxdwwXRSv93t+cQGggZ3sYr7mZNmXDKYA+RjL6TsvUWEN5CaPiNmsA4yk/v+5FcU8q2DIE5KrYSVHuxJudPzoVFfupteuuXq17j+0FUsjSKXgEnbbCJ9fKM5L8oU+0tDFO64ThuD66uLr2uiods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=wOQ2tS6l; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="wOQ2tS6l"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da2140769so2124237e87.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 07:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1731943192; x=1732547992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKnpzF/evUVWyiFRJwNk/oMNhYJbJ4rIzEz6848rwBI=;
        b=wOQ2tS6lUlTKyUIsSMX5CS/yzS1Thuu0OzksrRbkMB3t40YShpEsp/tEJ76o1qrtSD
         LpRFphTW5RTvPSK/4obvAgoRGliGSccpz5M9GIxFNAnF2mzsQ+yVHMQBjGazDM01OUpD
         cKiHN/g+eNaSQXmfFqoRmpe7rpo7dFrWQIYmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943192; x=1732547992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKnpzF/evUVWyiFRJwNk/oMNhYJbJ4rIzEz6848rwBI=;
        b=ZjkjsxmFZeWMM7dyQI/kX4o5VvUIKzvBAXHFvN8UiGNb11Q2Bsb/Y02ihsuc+1ZvR9
         8FjPzNuN4S+j5vuCNWyvIl3v2odgcDQQKgLWv133BYCOv1W6tK945/qBzRSd4P0zc0B7
         HmCcDnwnQ+8nvRN9ZTx1j8r+qlsy7Eqj5YC15zTpyqp70cBnXjpW5C3CWvD7cNlJJGD9
         CU4fj+BSL5MPNqUDNEUqr263LvczPRSSsw0ZdHCpPjeHD8TwE8oXG3ENYZgJ+SJOOWd5
         TjlB2I0wzbqsgfaBR7rT2PD8MEcNW4obtMmVjTyqFLmCosjg0lVSf2zhc/58GRXYh7Dn
         zUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEVYabnYCh8H8+g/JrcF42o9X8UDJX/OY3pYsDqwja93zPfcXMFpiZI3n6zi9z290y5WeV8noURIBjqnf0Ms0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1sXjVSgzgQpxao0SlPwAeiZNc5tadOwzXU6TWngsqnQ8C8Aje
	gCwfxyVN6eP8Zh9GWiiTgomutiOi714hP4tq5SXghAe1U4YOwVQb4CNCx7psoeE=
X-Google-Smtp-Source: AGHT+IGMh+VURa9zuCTt64zmS+qjwv8VHVXqaYbqFcsqZND2XPKqiN8HRYTEfD4pR+PluX1PYo3A9g==
X-Received: by 2002:a05:6512:3baa:b0:530:aa82:a50a with SMTP id 2adb3069b0e04-53dab2b41e8mr5690507e87.45.1731943192580;
        Mon, 18 Nov 2024 07:19:52 -0800 (PST)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c99eadbsm488494585a.39.2024.11.18.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:19:52 -0800 (PST)
From: =?UTF-8?q?Andr=C3=A9=20Groenewald?= <andre.groenewald@streamunlimited.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Groenewald?= <andre.groenewald@streamunlimited.com>
Subject: [PATCH] Bluetooth: hci_sync: fix LE init stage 3 failure
Date: Mon, 18 Nov 2024 16:19:47 +0100
Message-Id: <20241118151947.3323927-1-andre.groenewald@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A controller may indicate support for the extended advertising feature but
doesn't support the HCI_LE_Read_Number_of_Supported_Advertising_Sets
command, which will cause the initialization to fail.

Signed-off-by: André Groenewald <andre.groenewald@streamunlimited.com>
---
 net/bluetooth/hci_sync.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c86f4e42e69c..c07be5813113 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4416,6 +4416,15 @@ static int hci_le_read_num_support_adv_sets_sync(struct hci_dev *hdev)
 	if (!ext_adv_capable(hdev))
 		return 0;
 
+	/* Checking for extended advertising capabilities is not enough; refine
+	 * by checking if the HCI_LE_Read_Number_of_Supported_Advertising_Sets
+	 * command is supported. Since this command is part of the LE init
+	 * stage 3, the initialization will fail whenever the command is not
+	 * supported for devices that indicate extended advertising features.
+	 */
+	if (!(hdev->commands[36] & 0x80))
+		return 0;
+
 	return __hci_cmd_sync_status(hdev,
 				     HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS,
 				     0, NULL, HCI_CMD_TIMEOUT);
-- 
2.34.1

