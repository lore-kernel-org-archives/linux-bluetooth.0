Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC01DBB2E;
	Tue,  8 Jul 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984241; cv=none; b=jDWfE7BEhyo3Fsy0lRtmCjudsKzWQlsDbO6ws8L550V7LdvGU83GVvXV9kup7lFJrfSg5b3Mc0fj+dCg1zNIAVBPkDGz6oMRtSxus81Ga4zhiPpgEDxQsADZso+L4WzQQ/CtxtS7ThN2B0W4vWoEne6Y3C3At1wL8pfypJbLP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984241; c=relaxed/simple;
	bh=XxA2SQGODxfhsVlrJsj7y3Ianx1ZtElsv48sFWrV1XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVq7tV57ejc/gBNKMM7WTf7pee1s4vAz16VrvvJ94x6tfCroEuz14FSheOPsRhTPRWqbUVt7SrtUlQpGnkxyQHZcQMcw2dTTZcaXDRF+zvIjPaB2sSosFJhPHqDAeb2qJR786F8CpgfP0qCKGlnWQOLD79h3d4kkIBADJ2GjQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMpDTl6i; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMpDTl6i"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so6024857a12.0;
        Tue, 08 Jul 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984238; x=1752589038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YAe2u5Ry38FuECjcK//c2lbSxbhj0bQal/mPso8qrP0=;
        b=ZMpDTl6ioleroz4CGpb1EgFW+rD1DiKGQPh/2mTyTIwCNHWrkUpYivZ0Nluyuh7Swo
         06t74pdjpvJhkPpIne/8j4QbUz5rRSsHDNoCoObc4RJLj65ZWj1X5Sidy3uW9fLQRCnA
         r3jynrBU1C4o7hdNugh0UJ796LYRQSASg4f26mFASSI6XV08lPgqM+sgOCQu/9R2Kmdv
         OH1lH+wdpft0sP5j1Xgs8Mz/+dqKTsygEbBSpgBFM4iueldTIXbZckesW4kSGTfFJI0y
         f1e/2maSA8ZzwT6FeDaLQ8I8wZJVmLH2fEh7LX5XlLRNuFnbYFNZbIZ1eHafyRdqnreM
         gmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984238; x=1752589038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAe2u5Ry38FuECjcK//c2lbSxbhj0bQal/mPso8qrP0=;
        b=JIzS5scnWtD+P0hrIidmdcZkGwRit9gPQbOPZTg61qoWWgY/6LXUmdko0WYAxi4ATZ
         fK032pBMhmvbkz+4WKgJx1CmVaaEDY8UJfL6Gz6tivSxHlOXAPZXLszoWZyzObJVT7Ho
         y0ztdLxnTa0+bK51hcUC5i0kkxIpmFMaH1KEaZkWUwLHkHVpR1GKC8OD1MsuDF3+w9M0
         OPEx8kJU67p4VsjMtKgBC7nQBkO6+wlQ+XIK3wflqtNoGK3ztVyXwNTgYJ2+L8kwESeY
         bwjK0PcRiPo690g3RmA/PeMtUnwarHHyajE3IBNkHmyBc9mMRDTOZ247PWktliZfqtXk
         +0UA==
X-Forwarded-Encrypted: i=1; AJvYcCUDRrqzsvdkXiKLUiTcCiCrFh+tY/FG6k6D3qLDwElkx588jwBI0sZc0cwZgdMu16iJqBYVcdmcfAAX8oc8Uxw=@vger.kernel.org, AJvYcCWFr4rhsKj9g4pdh/E3v8CLKib9EsdSvS/p3JJIs6sb487KLgHDtMOfIb9z4SfL1NL6ViATPYgzdStT5EYy@vger.kernel.org
X-Gm-Message-State: AOJu0YyCh3QbblgTPViRsxhdiqOrwQYntM8TEschiGD18xQ6O9RJLtZO
	oEzxe1UZTNuN2Oedo7BSQ/1mWo3Z45ocUMSHenI3qRH5EQp/akouDx4O
X-Gm-Gg: ASbGncsaK6yzUNX3HdyvJh3Zx/7eAJnLOjTU/05APmSWTYxDplQIRK3tthZKa2lKKhO
	5rrMUa8JmB2cfDBzH+5S1eOmuEroV0G+HoyMq+z0H7prtZzhBLnP/bBHEuOdVUxUVgwAuwMRAu+
	qjNT2uaYl2tbGJ4otZXcFg794kEujEOkIzefS4Rh/sE2NxkcUKHbjnQTDO8Aj7mPlSBmP9cFipW
	Tab0uAh6tTveoTrOfWs6HEqbTno74z6IEo8lc3+9yF7vSiYaDJoDYXqvWSZGCj0d4W2ItSAq5OD
	LB4uQIrg6FnSuvxon5R02eFKzrm2wNhp2cTgZPOCRbp9tLQgnyhy8sX2rkEeBPwAPbFWSzc4tin
	2
X-Google-Smtp-Source: AGHT+IEKgFjK0svm+YInGP+RsM98sKNu7m+gNG2WMQOwlcmxj3AAtdKKcAIJ3pqCIjJNYAxZVCPxzQ==
X-Received: by 2002:a05:6402:5191:b0:60b:9f77:e514 with SMTP id 4fb4d7f45d1cf-60fd6510ce0mr13951067a12.10.1751984237659;
        Tue, 08 Jul 2025 07:17:17 -0700 (PDT)
Received: from yavin ([2001:b07:6474:515f:faac:65ff:fe6a:e677])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb8c6c97sm7266600a12.74.2025.07.08.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:17:17 -0700 (PDT)
From: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: fix connectable extended advertising when using static random address
Date: Tue,  8 Jul 2025 16:14:12 +0200
Message-ID: <20250708141617.3691-2-alex.gasbarroni@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the connectable flag used by the setup of an extended
advertising instance drives whether we require privacy when trying to pass
a random address to the advertising parameters (Own Address).
If privacy is not required, then it automatically falls back to using the
controller's public address. This can cause problems when using controllers
that do not have a public address set, but instead use a static random
address.

e.g. Assume a BLE controller that does not have a public address set.
The controller upon powering is set with a random static address by default
by the kernel.

	< HCI Command: LE Set Random Address (0x08|0x0005) plen 6
        	Address: E4:AF:26:D8:3E:3A (Static)
	> HCI Event: Command Complete (0x0e) plen 4
	      LE Set Random Address (0x08|0x0005) ncmd 1
	        Status: Success (0x00)

Setting non-connectable extended advertisement parameters in bluetoothctl
mgmt

	add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g 1

correctly sets Own address type as Random

	< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
	plen 25
		...
	    Own address type: Random (0x01)

Setting connectable extended advertisement parameters in bluetoothctl mgmt

	add-ext-adv-params -r 0x801 -x 0x802 -P 2M -g -c 1

mistakenly sets Own address type to Public (which causes to use Public
Address 00:00:00:00:00:00)

	< HCI Command: LE Set Extended Advertising Parameters (0x08|0x0036)
	plen 25
		...
	    Own address type: Public (0x00)

This causes either the controller to emit an Invalid Parameters error or to
mishandle the advertising.

This patch makes sure that we use the already set static random address
when requesting a connectable extended advertising when we don't require
privacy and our public address is not set (00:00:00:00:00:00).

Signed-off-by: Alessandro Gasbarroni <alex.gasbarroni@gmail.com>
---
 net/bluetooth/hci_sync.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 77b3691f3423..012a9e9a4f9b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6815,8 +6815,19 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 		return 0;
 	}
 
-	/* No privacy so use a public address. */
-	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+	/* No privacy
+	 *
+	 * Even though no privacy is requested, we have to use the assigned random static address
+	 * if we don't have a public address.
+	 */
+	if (bacmp(&hdev->bdaddr, BDADDR_ANY) == 0 && bacmp(&hdev->static_addr, BDADDR_ANY) != 0) {
+		/* Re-use the static address if one is set */
+		bacpy(rand_addr, &hdev->static_addr);
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+	} else {
+		/* Use a public address. */
+		*own_addr_type = ADDR_LE_DEV_PUBLIC;
+	}
 
 	return 0;
 }
-- 
2.50.0

