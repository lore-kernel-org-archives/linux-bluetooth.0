Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA735271A94
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800905; cv=none; b=LEaqVo0g/Ydt09TDdvTYCZVh/kV5BbNB7VB+VlgGwrf2VIZE7biInk6oFxTs0BPziW34H+ZtQqQwFJNBhF9O3J6oiqBRAeSmbuGfXvg2OFfh8WORttOkdaNuS1m1JmetEKufB6QcFHXC0Yz1Mhr9jKGlUaZNwNhJuPwbncScpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800905; c=relaxed/simple;
	bh=0dLwTO/FItc8J86jULzgmGmgDjHcoRfaec8EGRmIZto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+l2pYcTUAOyLmGCWEGWA4hp2fb4R6Z1X4w3yqqhOrb1u6mJH1UNXy7WYApTL60X5K1YWRKOospuqfQLjgJ2qEiMttj3cczuVjwI6dZgpp5Q6tEulBYx0SGh8nigFiNyW93Fg6JqoDyV6G91GrlVQ19ZU64t0A+4mV36IQXojAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMD5uWN1; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMD5uWN1"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1384ebe7a10so7586716c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782800904; x=1783405704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eV+sxxoEB5gY5bMKWSs1XgHUd3+mXY3r1O8q2kqzLec=;
        b=jMD5uWN15uYtsel1C0XV7EFI8mpgWGNBZBFE5Tjvja3yIELW9dKjl9f4fWnUkHmjg5
         HNY/bbiFkRRsiqnSNx+TeE96yCDLxZfUirjEwAo18d+fG3B8cZ7OXMYCkO+w9/dMqiVY
         YeS4nRQPKNALNL1EcmpjMnZmYXlzfxitY7RfH41NSe4M1TQFgOOWQGB8fZg0wgg5eriB
         K0Icik1BeRNzWZg9VY/nuHU6y8ZUT4e8DT4K7KF9NSaxxqP/+gWiDFTW7HElbNeHmovo
         J966+E9zFa0dIIB3d+P0jUUGJtrO8aDggHBdHqmy+eVRhybYAWwxU6sWHRRiCA98Q4u2
         txog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800904; x=1783405704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV+sxxoEB5gY5bMKWSs1XgHUd3+mXY3r1O8q2kqzLec=;
        b=nTzN9YFbWNOp3K/KSr1Vpm9Cqo4rHdmyfhvQumJDaSi7Fgbl+B5Kv87vv7/H9galqk
         kp5b3gwlsl4p/kMVqwAQaslWv1gvyd2o+vx8u+zhBuc/VTM7e/kEVJq0Jp6eUzlNiKyp
         bdWI7MxM7kSLEyU27CWDgnU9SvTRfp7rseO1mjAOIHHuKNVo0EZQAbKpZ3SxvVO9oMjX
         K4GMPgS63bPJrGe54hhW/D6iI+QfHtFKTQgJTXcMw7FP28ze3whjFFuKq6zhJVkARKjs
         +hORKMNWtmi73F9SnhKP7rbEaAYIXp/j61L8gWgQd0Vt+0MNzyK7OipE34PTaGAyjyS2
         O/BQ==
X-Forwarded-Encrypted: i=1; AFNElJ9soh4IgDOg4GIaGB2dy0Z845ndysI5HHhmiwIbfPC74gw4ZzvuMhBE4C56GW1EdSlALpVtz4KHcihvjmhO34U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCx6eHdFYRNvhN1uO/DP9C0neLFxGF3vAX6jC8t9/yWQBtmSnX
	+0HIbIgqdMzKkKyOzOm/aPN7H1YAbW+GNPnL++JevihWRza05/HTlC98
X-Gm-Gg: AfdE7cnsRFDek0k/4/1M5o4u4TygvCWHWcapCIyNrhVSy9wY/cEqF2MzaRMXD+JfDi1
	iZ64VCkA5hxbf8tM6zsDWw//FZG3KOFsEQy7hzSb2pBvsM11hvWFyxAueh/nDCudvuw+SKZh4rh
	RhriAug78CwmOAsWIQPiFdZvxPCAK/JajAZCfw1J4JqZKZZ464RhVSBOcR52eIdISQJaxQj+4+6
	fwkCAFamTYJ1YWXB8NQwajRNT3b1wC4YKIqqglX/JWkvXw5F6v53OYZESG5fFXY8F0XBazsljDT
	228DKNMFS7ztDjWAj3VYr9Of58uh/6vXv3TIcjWLQRyVRjyMNgqxR5VkRKQxaAi18UZDAiOo2US
	oUNy2uioSpc28242kTjpWKlwxaOky1ljPRUvvfyJdS3pQAmhF6W41Y0LteqFmPLwIiUPBZBO9Wo
	dk63Rg1ZYD6NK3kTDxbpawE5zH5NxnVvNNCLk0qaBnOZiE4YfZhhTUK3ejig==
X-Received: by 2002:a05:7022:6707:b0:139:f599:8124 with SMTP id a92af1059eb24-13b2a147a43mr1556581c88.3.1782800903778;
        Mon, 29 Jun 2026 23:28:23 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba794csm3883398c88.10.2026.06.29.23.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:28:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] Bluetooth: bpa10x: check response length in bpa10x_setup()
Date: Mon, 29 Jun 2026 23:28:01 -0700
Message-ID: <20260630062759.2769059-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpa10x_setup() sends the vendor command 0xfc0e and passes the response
to bt_dev_info() and hci_set_fw_info() as a "%s" string starting at
skb->data + 1, without checking the length:

	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
	hci_set_fw_info(hdev, "%s", skb->data + 1);

A device that returns a one-byte response (status only) leaves
skb->data + 1 past the end of the data, and the %s walk reads adjacent
slab memory until it meets a NUL. The same happens when the payload is
not NUL-terminated within skb->len. The out-of-bounds bytes end up in
the kernel log and the firmware-info debugfs file.

Bail out if the response is too short or not NUL-terminated.

Fixes: ddd68ec8f484 ("Bluetooth: bpa10x: Read revision information in setup stage")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/bluetooth/bpa10x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index 2ae38a321c4b..07c6ed6f18ac 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -255,6 +255,12 @@ static int bpa10x_setup(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	/* Reject a short or non-terminated response before the %s reads. */
+	if (skb->len < 2 || skb->data[skb->len - 1] != '\0') {
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
 	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
 
 	hci_set_fw_info(hdev, "%s", skb->data + 1);
-- 
2.43.0

