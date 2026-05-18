Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2922459C5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779083532; cv=none; b=aQI37V9VFazT06Rm+04KgYmfWYi4TBJTpBHGjenJawqsSEhIOGpUnGVYWekBNuFTsFj1jwX3NeYB3AQnJ8Pjnqhm9FCqVyyVzHZudltjdEWOrtDYO/v0JqPKju8pO9hfa6KacnyeAePDm7nAAp1g+Tdj2uIZWsCjGS9uK9OCbQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779083532; c=relaxed/simple;
	bh=0XaST2SB8282P5SpQE2ggQSlVOX+Ihz5sJgUA1mooEg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XSPlky7qPRplPxt6TAfvSFzodxzsoiBEeWy79sL2WAiHSMXBe6BL2h8/Stn6j31xg0dgSTKPPrT4pst1ch5K9pTHF6okPWBI7yJo7l/8uWsj4fvYDxEQbAlkl+FGTaPlwhH2bFaVl2DcZMPzU6KpAXp4Va+2APK+AsAqHCVhkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GfcctHPR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GfcctHPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779083525;
	bh=OyM7AWnIYwTFOR3jcMVtZAgb5JjKgkvjhzzB6ME5IQI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GfcctHPRPdI2Y8pam8NIU1GuAzecEOOgElk7zjHzfuFrsauXwvFlXsIN8ecAQBPwi
	 6VRcODWUZ2ZUlf/6qrrlGQFXbjVCr7CZA/EcwCsVvSik9E/tSqkOE27Cf4D9mvMBVX
	 aV5ydwmfDJWDCf/JGjvp33sm7D+sVsIIDtBW2AQQ=
Received: from github.com (hubbernetes-node-0bbb48d.va3-iad.github.net [10.48.209.64])
	by smtp.github.com (Postfix) with ESMTPA id 6E1AA500992
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 22:52:05 -0700 (PDT)
Date: Sun, 17 May 2026 22:52:05 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096236/000000-83e927@github.com>
Subject: [bluez/bluez] 83e927: device: fix inverted NULL check in gatt_db
 clone
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1096236
  Home:   https://github.com/bluez/bluez
  Commit: 83e92707b9831b25a4de0b66f5b6cea4509c63c2
      https://github.com/bluez/bluez/commit/83e92707b9831b25a4de0b66f5b6cea4509c63c2
  Author: Zhao Dongdong <zhaodongdong@kylinos.cn>
  Date:   2026-05-18 (Mon, 18 May 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix inverted NULL check in gatt_db clone

gatt_db_clone() returns NULL on failure so the condition was inverted.
With the old check a successful clone (non-NULL) would return false and
skip swapping the device's GATT database, while a failure (NULL) would
fall through and dereference a NULL pointer a few lines below.

Fix by negating the condition: only bail out early if the clone failed;
proceed with the swap when the clone actually succeeds.

Fixes: cbe4144 ("set: Attempt to use existing set gatt-db")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
