Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711EC2FFDCC
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028416; cv=none; b=htnbgzAAoZk+FFQnP6I4rYL7s5Afq1D4i0P147+e1Rk9XOB45QKERakTNF0HvfBd2/R7XmA74bw0U1zcvG1lCOgsNNnPM87Ba5WTDGs5sHMFrwY2rOwn/GLD5NWrAhID+imnoYUu/qGH5hSGIfVK4CTbpuh+qD2eIyaBITRIrX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028416; c=relaxed/simple;
	bh=v0bOi9xX2qwRuV5ph8bQeR05YEI1n25fILqj5TVAUSY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CsNxVNgXh3OoprbPAqvXgiPV+c5S/WV8AZ/KNg6lFyvU+zy2cktiGC8YIBI5qRmFkz0kN16BP947fmYWpt6J8rn9TlzrFvviKid2gpRNVJ6gpeNeK/e+xwmYKMEQq54smWV57fmuq6yQqxv9CSUfPutfY213wYimDXPWvNnqfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuGS9+nZ; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuGS9+nZ"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4fc1a5e600aso2098479137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755028413; x=1755633213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=JuGS9+nZLz00zLAsa7h0wZdoJNKSU9b1KbMa6r20FMi6Ui2e9DiuoEvblkxNkuwigN
         HSJh/BpVDDfFVisFhyQXZiQdczx9FASjjzO8Vt5La5xAtarKDd0TTD3NJ9rgVIcI3fCC
         BuXmJBOJfN6LyLc1ZVj5EoLQOe4wIVJyYltxSRSeKQ5ECWDuNSszaRDnzm8y6rFptR+v
         6GZyu0jRTPF22NguB0sZMeiIr3ZWkk73e/AA/WBAToY+5ECLRUdCRBhsiZCNHLxn92fJ
         vF+aM24wcf3bgPgVlN9RjapF64IyzUnB01HzO+/zwvwIHvOkny2qLVJFUEkx0QAnbypA
         fOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028413; x=1755633213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FdSl0Ehd7Wqv/wH7ISLEtXFGnt5ZXFAuG1oTTTgxGM=;
        b=ASVAqtZiXj0DPVxKH6+xci+V+prRtB3BTAsgEySU6SrqdTaOWX0NTbFKuedlt/01jd
         HnBgDuCTJVRK+44yzPFceA8GqMtbtns85i/EL0TsvafjYvuGvpyUXS+qtsJAdFGQINuB
         1BLJrsFsi5YyPTDCDxBMYORTqKMF5gACmlI29rUEQcas7MIHEJ3XOypvvxNRaBnpvOzL
         FqlZ7thb7py2ga5CngwQ95Mt0scOoXje8XIgw02fCqWNtW6bxCwvNl/eISsvh6wJeTmc
         Wenkase3sgJZmCJqTQRb1PUdeNi99NJbwUh+erFF1vfdUmpw8KyEWb727H0Fk4LlaFwL
         i0/g==
X-Gm-Message-State: AOJu0YxGkNMiMtEhJU4CSZlowxAhe581OjB1qrXR1B8/NeM65ClfRvzf
	PSPytzkmeR+zpxXrHrzHADNXqjH7qOqrx+L2EDgpatV0slpJx3iZfLir/TVH5L+D
X-Gm-Gg: ASbGncs0yGJUT/JG9dVi2w47v7NsDREgztjNlUB8Kx0kK4ocaju4gEopDWYF/0eMVIR
	MCnZqsHreCBsX1KmLpZXIp4ABbqqplCYy8NFyo8uTpavY8QknYMhJNRg4a5pXNX4l78P/32hL/T
	z5GoAG3UAL6keiMqhgjxbkSiub9us/AKQPEspBRgiHcDSA8SAPXb45JvBNCBCxxWDZGFWD0yJEA
	DPCiWZoBZFMzuGI7WJptrimjZclYnca05ObiGJ69sgIkgQl3LdeiNDsZFQygcVBx7Nb/XzxmOSh
	q/16Rk4BPWssAwgBOYd8RPtyE18qZPuubbecm0t1eUaLYin2JSo5MQMr6+4rKRJBOMdqKibiStM
	aQBK4u6aj6nIygxYxje/ICafM5aGvWSmbC7ZzKuvi7Ddy/3WXEOkFyksYoHBsv4CG
X-Google-Smtp-Source: AGHT+IE6FXtWNyqKpzPNj8gYSAq0H3uViqLrB2852+Rvt9e3Satx2Cch/AcSGv6g+7r3n1Q0diG3xg==
X-Received: by 2002:a05:6102:4414:b0:505:ff14:8e0 with SMTP id ada2fe7eead31-50e4eee5945mr150369137.11.1755028413516;
        Tue, 12 Aug 2025 12:53:33 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-507a216a07fsm1799784137.3.2025.08.12.12.53.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:53:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: ISO: Don't initiate CIS connections if there are no buffers
Date: Tue, 12 Aug 2025 15:53:21 -0400
Message-ID: <20250812195323.1522605-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the controller has no buffers left return -ENOBUFF to indicate that
iso_cnt might be out of sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5ce823ca3aaf..dff3fc4917d6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
 		goto unlock;
 	}
 
+	/* Check if there are available buffers for output/TX. */
+	if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK) &&
+	    (hdev->iso_pkts && !hdev->iso_cnt)) {
+		err = -ENOBUFS;
+		goto unlock;
+	}
+
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
-- 
2.50.1

