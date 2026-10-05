Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79784D596E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222755; cv=none; b=ZGDp1bZks69jZdVoR+fpwkXkQSrbecKDPoZqVA4v/m8H4Za7Wz8t+W8r2j0mKg4Q3eBAOgTys+qKnR4pRyPrD++pVAZ3OLX2WaK7s3Vaqo9c92quFaEet17ofulQvHd+nSiTLYhzDOQybu7LSNuWGgkcE+BuGivbERBKY8jX1JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222755; c=relaxed/simple;
	bh=VZ9AhH8GNxPD3BtJGBAYbVUfZQKYdMQ1AmQEDJqmp/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqQvqrTLAUvm9Ynls5CXPrDALY2fb340Nkfn3Jks3jMF+SJvabktQxhXjz48Fi0hNN1OYuxazU6IyHGOMP3aSLLEO0hEOf0shMEDK/jDzCEIm50q/bM8g26X3HQmrWZRAR5TeH+hkEkfQFh/KsUQLmYXQo+jT423Pln3fSMKStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvz5Jlid; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvz5Jlid"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-980b6159d30so418989241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222753; x=1791827553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=dvz5JlidEnTvlnQsXBNTe+grbmLvIe4l0awmoTAhe2jtem5zf8/Bakov+3k9p6RWtQ
         nXrPL5CakLTdEb02gCEyC6hQjNKCBxUOsdKXBCGfcACA22sHdFPCQLTP874UFRbmBXwo
         VmRHVnAKQdcZxvqI3tl8tnX6kxrBU0OWpc2AlujRNVebsLIiyFdV4c6KEH8HEjyxGhty
         DBpKCAcKClReprVBHkmKleeEU2otZrD3YiTYC1McNZkwr/Lu2NHzt0trq2GcYtid4zGw
         FmqQINcodMeIV3PMBHWtQ5eQ89gl3hhX3MI1ctLnXuBRmANrYfROY2XiEyl+TK2PudFY
         yMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222753; x=1791827553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=TtT+o9CgX1mBlTSKLH0hJFNSVcUAKUhb23YbsDBSFTingip4h4kly/rjIk2SXmqRAQ
         54BxmLYGTCUEZPB1NhegaXBsv/ELHuwSoCowDa+u3/BasmKaueZTQz6sAwV+/ZfP4N+1
         m9adgnyZakYO5Ii1KAzh2wcV8Z1RsEyIpcKMySoFV2EU1SK2awY/hs6GNyFuXrPVIgC3
         HIDot1FFd5yScGHP7JtpO2fms8PPghIwAOeiYP+p2tpscs/bvU7AZcUN+C8N0a1pQzJi
         qTqTGyRlKhQK2bAXBXQzKUai5BJrntMF5dCHi+pAqbNr/atFJVDRajEMe8UBMvfTe9eS
         Ir2A==
X-Gm-Message-State: AFq9FYLLx3npmoYVzOn0kA3jHTmo3hqAQ4rTBgMDXZVXg1RbROeKgbyp
	ZtHlCDP0J8WflZYXCenruL3wj8NIwYX5NIYTSU0JuVDEe++E0v+9ofl8RKqel9go
X-Gm-Gg: AYBFou0gXsY682GqoqIvEJ4LTqEUO1RmX78NEjMe7XYH2AOzSGhLvACRPXwwFbfdNFV
	SgJZCMWdVqps5utF0hFgB6FRFMV8Y+b+mldWHWg808TYEO8ZYDXqUNZlzjkK/N7WQdf42mxyuJA
	V1PYThMaUhO3zaNd6Dq8wrCgMni4+K22TzokEr22736iP5fWq1ZnRznV2h9euBbchU6HRX8Th23
	7AkRbZfLHvnMdqDMWBes4VinnUxsBU3a6J73BT+x1tjO9i52/zh7TdT4iRHmVD3/lC+VrtoAgkD
	fItO+rJdyFoJek1TlvX7jAZAcgJQT4bs14elTds+X2QRl2rX4p7B2U6mG2GNo6RDYt31c+KrJUW
	EBw4lcfUnUP23l9lNiXpEqYjKlYU/1i2mnJUTtIKgN5wVf53COBQ6V8YQVVxm70vAbx5SWu6lFK
	XsDstwbnVMmnNtCIcGppeciJFMrbahxpg+bNTSdHq5lz+cC5CGfqCMbqBMkfq7o0Q6z4FdFIiYW
	vV8FUA52nH7ch+L0wiYD+rKOcbnksAnNfKQpdKoknL75PQ3Otx0aLGr8N3K85Yb
X-Received: by 2002:a05:6102:f9f:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7c54db301c2mr1115665137.15.1791222752636;
        Mon, 05 Oct 2026 10:52:32 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54eee558bsm25655e0c.7.2026.10.05.10.52.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:52:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
Date: Mon,  5 Oct 2026 13:52:18 -0400
Message-ID: <20261005175219.3547838-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005175219.3547838-1-luiz.dentz@gmail.com>
References: <20261005175219.3547838-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When Add Advertising completes without HCI communication, e.g. when the
device is not powered or the instance is overridden by Global
Advertising, the instance is left marked as pending, so a subsequent
failure in add_adv_complete would remove it despite it having been
successfully added.

Fix this by clearing the pending state before completing the command.

Fixes: fffd38bca51c ("Bluetooth: mgmt/hci_core: multi-adv for add_advertising*()")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 106b35c88c98..93872a5fc39c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9173,6 +9173,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (!hdev_is_powered(hdev) ||
 	    adv_overridden_by_global(hdev, adv) ||
 	    !schedule_instance) {
+		/* Instance has been accepted so it shall no longer be
+		 * considered pending, otherwise a later failure in
+		 * add_adv_complete would remove it.
+		 */
+		adv->pending = false;
+
 		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
2.55.0

