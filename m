Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15940B6C7
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261566; cv=none; b=hG3LTNppZSfpdFvKKYNVF0I+eRXgTFPBuJqCQrHtqXKinDc60bv+sLyRVEOKI0r54DeR2CnmOogAx5+gLi4k2bKeBzv7vr1C8oY+9KfidzFa3FCQjSp/S2IG8Cad+FcsCMs+U9nd3fERj1tBRAkAvIFUSgTfXtye8ixqZ7c3/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261566; c=relaxed/simple;
	bh=LplV3crLjJFyz1CKIX58/3G5oyVUNzkN7/tKutv6ISY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYftVC2/zT/egQBgXHUhIdT8njT1NyTrQ13ZmKF3sNvyLLrVk7fkpuHwtNggH5xLYctaFEBGV3e0L9KjmC+Wy2HRAaMi73SDdEE5RoLj/dCUIRyZAbrO+E6f/uK1RuLTwgJwkOiJbqzCpepPWCthoVKD3Oi5HtfTB4JHKL7qy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SagMxUA7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SagMxUA7"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393ba0616aaso24491211fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261561; x=1778866361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKiWj7c3WOUi3B7MNwmGjdVqB1Ve1n7R+SIRjPXohtk=;
        b=SagMxUA7DK+tK3LCVK2O37xqlwyhcfZciQbXK6LT/efDfzuVN92NUthqKYR51g5am/
         k6npWXBITfrRzZTwnqCwnIV8niBV5lO7SYXXD2Gw9PeWWrmpYtzy7ZCajReHLIhzyA5K
         Fa6nQEnkUCXjpE5zf4sXHhBHGCgiROsnL2QKqESIHpTEDsOixoRlH62lhF4wcDXvK1kO
         lmsyr+tMUTwQOp3FryKYClaLMMfQyDCQIeZuUcfdblYhqUJnIXq1XFdgIrpXmWmdLiwt
         hESFk2okLYHoNJt90JfZKNoy/c4UQuP9C8OEmeMPCRiuKwT9EzIvLRmIP6CuMdtSqM5Q
         j0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261561; x=1778866361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKiWj7c3WOUi3B7MNwmGjdVqB1Ve1n7R+SIRjPXohtk=;
        b=q3scNkvWe2H6uXTZSlokGkUI8HgFvE9yNeOzfeCoaS1Cb9zBzQUYtnhm5bAuvr2FQK
         djnEqWe3oAtI9CHz6XCFzQuZswnj2dC8s3oxR0AFha1dwXo3gEnrlD8XYzDzBFhSRQsf
         GLjD9yBXeOCNLvKpaU4rpUn9cFZAjBf2PTRoI+yjloYeNYE/PG8u2TgSX2mRYjGV2ffg
         utWuJx/JcaqDCta99sYB7sOwwlXbVg+VV2OYhoEm1zs3UAxCfU9LoKtFrvV9g6kqVVmM
         +cJlFqFuoa4/xRm4MNQ+mjPv9YDcpJGaTSjahWItZ+a4vIkk7jwKFUiQ2DSWmF3mHKxV
         zqpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uKp9UKD/E+JMpK8Jp/HKLFQ4Mp7N3o0uWpUAPo1/yQc+yhqP0Y+7BbxXQpNWuntG4xgeB2KiARWMCxzYOLyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEvSDd82ceMMruD67AzHl3WP38tnOFqnFJhWJE3hQavaZnMGF
	pXyb1f6CN0qBkS0+hUKXZXBveKj/PaEaNhw08nbAXxMbn2S6e8C/4TcC
X-Gm-Gg: Acq92OFeL3MGV5m5oPsV0l+WPBUGiSZv7e3c5IVHtmH0RzBt6tl33shB46joIQBTUNh
	UxtElpfo0J//96/uYEbGUYl3qaMsoJlekuHaStzehVBzTN8weudQgvXWeNwtUqvE9fIyLECvbx2
	a1qSewjm1cgfNLETzXlryIdEIWUssXHaSi77+sOVD6G54/S1fRhdzaf/oAcJphZ3jnz0+vhNS0o
	BByOag7HRRweXjn0GwMEcIyhCKTvZEJ132OGXtgOZujQLwEIqeMI57SZj8c4Am41zyVuL5nv7g4
	4GiicWi1eFFH2aSNJEzNN0cev0lrB+Y7nIocT5O2Vd5rkwNI/uP2OzoTJB4SfJq8A29X2v6gYXw
	5MMI1jzpFq1pHga64L3AaS5C+D9PHJzAbvWAZgXIJYt9N+GwKdSNv+4EiaObwiKdcwhrQRS1h3P
	iUoybUAPWtEMVKFqdwh8Ih+IyN3pF1vOAmyiWkmdZLKCJ1
X-Received: by 2002:a2e:98d0:0:b0:38e:90b9:ce98 with SMTP id 38308e7fff4ca-393c40cbb63mr38714761fa.6.1778261560643;
        Fri, 08 May 2026 10:32:40 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f6144071sm6162291fa.32.2026.05.08.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:32:39 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Bluetooth: btmtk: handle FUNC_CTRL events without status field
Date: Fri,  8 May 2026 22:31:21 +0500
Message-ID: <20260508173121.27526-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A WMT FUNC_CTRL response shorter than struct btmtk_hci_wmt_evt_funcc
(9 bytes; WMT header plus a 2-byte big-endian status) makes
btmtk_usb_hci_wmt_sync() fail with -EINVAL.  This regresses Bluetooth
initialization on MediaTek MT7922 (e.g. USB id 0489:e0e2; reproduced
with firmware 0x008a008a, build 20260224103448): the FUNC_CTRL response
from the controller is 7 bytes long and the second skb_pull_data() in
the FUNC_CTRL case returns NULL, aborting setup:

  Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
  Bluetooth: hci0: Failed to send wmt func ctrl (-22)

Reverting the offending commit on top of v7.1-rc2 restores Bluetooth
on the affected hardware.

The pre-existing code dereferenced wmt_evt_funcc->status out of the
SKB tailroom in this case -- the original out-of-bounds read that the
offending commit correctly closes.  The byte pair read OOB almost
never matched 0x404 (ON_DONE) or 0x420 (ON_PROGRESS), so the else
branch ran and the caller observed BTMTK_WMT_ON_UNDONE.  That value
lets btmtk_usb_setup() proceed: for func_query it means "not yet
enabled, issue enable", and for the enable command it means "treat
as not done", both of which keep setup advancing rather than aborting
it.

Preserve that effective behaviour explicitly: when the status field
is absent, set status to BTMTK_WMT_ON_UNDONE instead of failing.
The OOB read remains closed, since skb_pull_data() still validates
the length before any further access.

Fixes: 634a4408c061 ("Bluetooth: btmtk: validate WMT event SKB length before struct access")
Cc: stable@vger.kernel.org
Cc: Tristan Madani <tristan@talencesecurity.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> # MT7922 (0489:e0e2)
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/bluetooth/btmtk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index f70c1b0f8990..fb4875760164 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -719,8 +719,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	case BTMTK_WMT_FUNC_CTRL:
 		if (!skb_pull_data(data->evt_skb,
 				   sizeof(wmt_evt_funcc->status))) {
-			err = -EINVAL;
-			goto err_free_skb;
+			bt_dev_dbg(hdev,
+				   "FUNC_CTRL event without status, assuming UNDONE");
+			status = BTMTK_WMT_ON_UNDONE;
+			break;
 		}
 
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
-- 
2.54.0

