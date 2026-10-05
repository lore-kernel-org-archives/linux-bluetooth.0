Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BD4CC28B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791230403; cv=none; b=UBAtuow/hpH1gvwB4NAQfiUEB9nNxBRHO9nff+L6jbrCD5tg/Jrfg8Iq4w/X0CCL7MGClXG1FlKG0euAeaPTDN1a4X46uz7bH2ACcAm0Yw93SmzhE2qV9wEojqgeLRAjF+kETUcCQnEnqNQhJgoo9Ofpjow5FQkOcztB7NOGIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791230403; c=relaxed/simple;
	bh=VZ9AhH8GNxPD3BtJGBAYbVUfZQKYdMQ1AmQEDJqmp/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6nexuOtZ6Y5Kh4GBqPOh92IotAYqO5MvCuPC3BJtHuhefz07FFyoy9igWQX+JTiyjtPsLbVk/DHcJY6s0fcU0egJYRlv2xZLLtWs9LQnc/iub2rhMn2fyek/zrC8MaLTzBviagHQsMwLpFAWzccsJc1QIWlAln0Aa7+Cx/dzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doeI+KYN; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doeI+KYN"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-779d18ef706so1712714137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791230400; x=1791835200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=doeI+KYNwVyOg7G8oadT2kbZr54XFOLjE9wQV4LHUPQ51iw4bHxApo+knR8rhFXykH
         6U+XFtq8wOrfLm3bSHyeW7JUEVTaFJiKijb1b4CQ5d10NKPaAFbYVRjRkVqPGhLgVKjm
         e00/a5r3CGotzWA9DRrm1LVaTZiOb2P5D4AGLcYrKkqUZ5K1N3rFYDTrIEf4ESecM9/O
         sPHr5izZNrNqTMEf6xPLUjTah2zIVgBD8vOFF8/QVkkMaaoMTgbWZxZgn2YA0EUb/2J4
         2qDjXv0Qk6yAz2sZoAb/3yZvSoTaHyj+U+3zB22r0va21qvDtrOCLx8VvmXVwLxcHzNv
         zDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791230400; x=1791835200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=kz2A9IpvPgLgXkprFlRM3SwmFtOeTxTqlaX8wp4BjNxtIIIP3EvJOfumUqoGMN6aoa
         qxNzBx65Dj8F0iR1bPZt41W/e9Oxfxzn7AVJdweCQPZD/YtPTiLyRwv5LP1XNILDloAq
         I8HiyAu0w3dACAulcDIj9AMU10S7lOsCE3VTMSeB13SWA2LqAnptlUGsHi6HsaHStENm
         R+Qk4BHFW33RSc8fGS0vG9R9W4xeKFBJdCxme13pdSyO92xS6bW3x7v4JkTbnR+VaSNF
         ftaLyIVVsgFshMlsh62nwD2lOb8nW8dM43uA8D2iNqKPi3M06LagSrypZ7oZ/sKA5PoH
         3FTw==
X-Gm-Message-State: AFq9FYIzxyK3cGOEQXjbpPOJ5id5+/HUMBsVxH9Odir7Klf0CqcKPsm0
	WcxoiTbuRzkmvZ3LWYkq9xRbuVIrqGQxCcitEiv5DAdnFQxqAe1ShNMBNF37oB+u
X-Gm-Gg: AYBFou3EUJeLvBKV+/2SrfPrfMg93hcjSJk2O5Xuu69jEEp7h4dgzFeYXZ4+54medMW
	sfe/8UDooQ3y4SRUDrP/msokua8ZY0f+9VDxWgJcai00XeXmKkzVe8GDN835UItsZ9X3vwSErht
	NwLuSTgRIfwRfgO7coQRvKPf2q/lWyAE9EIrTromgQLABDF14vTWbZH8rcSFOB3PI4ou2zoGaZa
	817phCFMyLhrV9PqbRGgyL+wo5uomJhkB0oixHeCYBf6X4TvD/pV3CAkhZlnLHdD8ey9/ImR7Uc
	/HEW3n76v1Da8zdEQVT4HWwTlETghVa+0qZpJvQfkZF7keC/UfBhh68XqCZAK85KsZ4dI3hNaIL
	WBKi5RZFE80uLDI/NH/vmWhHSehJtLBFy3BCDJthBAHMwqs1yxU0IGjq5E5LX8NWFUuWlUr6aBM
	+tkPJwcyEoL01bJDAVJJNl4wy4/w9kNoBWbuzzoT28WmxdgDpGbChWbCbsibJ8OjqsHAwsOVSQQ
	wONYEid6/vAg/gXG3csjzIX6WT2CM3/VkGo2aiLghgRsa5A0G7r3AsA2f5mbAagf7f6X723PirI
X-Received: by 2002:a05:6102:50a1:b0:7c3:2f13:d905 with SMTP id ada2fe7eead31-7c32f13da5fmr2236036137.3.1791230400506;
        Mon, 05 Oct 2026 13:00:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ffaeb6d0sm11197180137.6.2026.10.05.12.59.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:00:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
Date: Mon,  5 Oct 2026 15:59:47 -0400
Message-ID: <20261005195948.3616794-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005195948.3616794-1-luiz.dentz@gmail.com>
References: <20261005195948.3616794-1-luiz.dentz@gmail.com>
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

