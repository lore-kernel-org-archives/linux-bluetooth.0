Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5A1B21BF
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740430499; cv=none; b=ndXPuGLyO+ASy8ujuaUhP0U35mP0OOacMPrDNjw8/8up33AQdCCRZz3Sqrv30SlerZneRVy1xBhFI1BPHk6meW0ZktayYTx6lLAI8hOGDySIDY5/HCpsd99S87Or23lc2w/f9CpDhkpKGs6CglTMRuT26qPUsdfm/eThHvF4Ucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740430499; c=relaxed/simple;
	bh=IyJUsihjzORhHZrToHi8PRSrgqKHFCmLMbmzgENuod8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF2zwpl5kg5l6s42BXZxfAwtBWRqR0o/xNO00ObDh9heIgsWv4n1G02c7vqSrXnGUDB+SecKswfIqlwH0/9AOGSu2C7WovRR5NGjwkgo/iE3pFwSx0rDDF0ERQoqPmHDkJR6jVisPwaQ+vfTIYgVQrN6oWwGqJApfwnyclOeG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKGhPqHI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKGhPqHI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22101839807so105827155ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740430497; x=1741035297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K080OKxRPxGBqN01VOJesZf2LZMU6YNuvzKFNRMFtBE=;
        b=iKGhPqHIghRjgeA9tQW/Pxr6hrw9fV3dMScnvA0uGdANKTgSdqUEL2H9Me1u+iflE4
         cOjXsP8pVOl4eKLd3iiYX9jDNFGbH6Mi57wePaxEyocdCWJkUogfmy1Wvv7BNy3k9E3W
         S86yYGRrBTSv/kG7w4S9MGlMekhgtnNpG59Vlt9xCHppVQ2wVspUfOf2lQ02fqQuQFBG
         DxCzPM1T4ikbh/Ds7zuHmHlTtyFJBodu74cN9UQt/HGGJlsO47cmYQ6HdPyKmd1nEMwX
         /UcdOlxyPV4aFUrw11BeQdVb0jo+fPdfpdIxl4q2FwNvoCXbXTuhURpLUQyStjCQSG4z
         h9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740430497; x=1741035297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K080OKxRPxGBqN01VOJesZf2LZMU6YNuvzKFNRMFtBE=;
        b=buEpzAeBHH0Ze5IcYoiXUJaxc4OFOJtPony8yzNpTRcT0YFfdndBpgiVpiXQqvJ7q5
         WUJN8JFPdiYfovsLn+YNmFDfj6QC3k8BHBOfzVHyM81mNgR9dxqoNceu2a+FpfdR3Ewv
         gsLvXRuFEeIKSupxX0P/1dLOgsp5VJF1kWF24iI5poQsSRqntnXJsx+Om2zLXYjuAeTq
         EHNWKmnx0SsryGjwlc6QylfeJ9yZrTi/ScpD43/8lJSPTjkpti51aV9uACIKZXG2LpaM
         zRlqtzlKiicQz8ek6sg2jkMqjwp/u3f2pctpikjwr07ONT29UueN7RmShG1pkVXnkZ6b
         lYZg==
X-Gm-Message-State: AOJu0YzS5HQdZx+j3cD9pGYjfOx4TFcxKK71KxCrhe+yHJ9vO5xqdx9c
	lpm7lBmmrABdpCoiw8+409b0axNn1ZRH/7/IUptHM+798rE5DZdzbb4qZXHD
X-Gm-Gg: ASbGncuEXdxX4MJtmu9hG+8SXHmQ0RS9MH3pBqUXU2rv6XE57phcPjmEdd61L9e5WOm
	jYRCsrdfIO5lc9wExlQew9so+rYZlCwa5ftqXIbR5Ru9+WtF28sOS6D3r+3ZmW57uYnEeyqyDHB
	7/2EN7EJDUC9O36k6+5d18DIwxOGZr2W5gyevegHnej3uJk530OxU5t9biFxadChH3jvjyGAXjj
	rXgg5igC6+kuU6Xc8+jk1oIDeic3zaTWPfnhGQ1yX5uUXlkso5aeJbWfMad3Of147AbhNvpIsAl
	MicSvM0l8sauXZ3GYbLL7Fa5vmh8LQ4Tk4EMUhBc+NmSTaJ32RgPyEJavCxq4iI70JkT8rTm7dC
	KwdQmre8mmOI=
X-Google-Smtp-Source: AGHT+IHjS6TViwBPHk+9To9I1epmA01ol8O6Qp76AdTXf7CQUpy9Rqp2ewgUgpBhC/cnE7T/NLY/6A==
X-Received: by 2002:a17:902:f681:b0:220:c4f0:4ed9 with SMTP id d9443c01a7336-2219fff358amr232860855ad.45.1740430497116;
        Mon, 24 Feb 2025 12:54:57 -0800 (PST)
Received: from localhost.localdomain (168-228-202-11.static.sumicity.net.br. [168.228.202.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a01fdeasm471715ad.87.2025.02.24.12.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:54:56 -0800 (PST)
From: Pedro Nishiyama <nishiyama.pedro@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Pedro Nishiyama <nishiyama.pedro@gmail.com>
Subject: [V3 2/2] Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers
Date: Mon, 24 Feb 2025 17:54:39 -0300
Message-ID: <20250224205439.18672-3-nishiyama.pedro@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
References: <20250224205439.18672-1-nishiyama.pedro@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set HCI_READ_VOICE_SETTING and HCI_READ_PAGE_SCAN_TYPE as broken.

Once the min/max length of the commands began to be asserted, these fake controllers
cannot be initialized because they return a smaller report than expected.
This affects fake controllers reusing the 0A12:0001 VID/PID.

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

