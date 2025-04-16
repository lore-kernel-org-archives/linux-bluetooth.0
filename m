Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B71990A7
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798362; cv=none; b=EidYHWAGmhIXEuQrkn1iEkQUyBpMOFWFztSrAzPomSrFrrLFIT4ArcmguBaU23oyPSnAI8wM75G6/JS8+75LUrySMNCL6+rkwtEylrTKlAqt99or3I2c7WrulNS6UnThv02zAA45gJSxWhaMPmSwUyYKOh9lpwcWPFEKaXCuHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798362; c=relaxed/simple;
	bh=UtN1WdQ4gT5NWnOIjfY89tioiePY4sw3Xn7U5tNkE+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hvIgEX5wv2kG52PG7fRxd8D4zWLoV/GMyRGV0Rd5sljkICfpv24Yy7H5OrYMDVclEFIx0ZYEKDLE2VgEEf26pF2infYnfONrdL1snarMfT3OywghA9UgjqC7NHSffmwPONByKiGm8qK1NOhSddKCHJtaHpnolGishQ64314wIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwmLbDwO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwmLbDwO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 417FCC4CEE2;
	Wed, 16 Apr 2025 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744798362;
	bh=UtN1WdQ4gT5NWnOIjfY89tioiePY4sw3Xn7U5tNkE+I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pwmLbDwOnSH9A50iiZx43Onei8sOsAb8aJADo++k/vXV364SuvMt7aR4eagLl421E
	 7l43vw6tJwq+8/mFEw8Bqc1V+r/i1owTpJQ48+LX8ncln49rN2sfgSmVyCazj8pn6A
	 XO3eTGSKm6+7aao2lnu5FNRESzAOEYcC1TuYq5/cE9b+6NFsCfqIFFTbxu5rS8V175
	 h2dGD3UdjafzkUOtpAv9rwXxfbQV08hPuD6DvVTf+Sq78X/Q8XiRZ0GM18AZXa1KUe
	 cUYWInfQ5Rp7wpPCoxMLo7M7ggctw7IrXiD/tHxjlqkajDfJmFQ+/nUcwNLT6MCHKl
	 LFYSZb5HzaNaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3A1C369BD;
	Wed, 16 Apr 2025 10:12:42 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 16 Apr 2025 18:12:34 +0800
Subject: [PATCH BlueZ bluez] bass: remove the device of BIS source when
 modify operation.
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-bass_modify-v1-1-6f4a85c2c7e4@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJGC/2cC/x3MSQqAMAxA0atI1ha0jngVEemQasCJBsUB725x+
 Rb/P8DoCRma6AGPBzGtS0AaR2BGtQwoyAaDTGSR5GkptGLu59WSu0SljEGNdZXJDEKxeXR0/rc
 W9LTjDd37fvTbIHxkAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744798359; l=965;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=WtwMgRyLk6dasgHiKyiBAQVxi48ubSbCjVHnpYA4Ysw=;
 b=y1jhPzJX0sU5nAC0OXtPgsPRFfJF+rhOxGvyBOccQ4EHU/pM26ywg9JxbcHCxNtMAtJv7bYjB
 vXtLniQndXBDh4uDks4N2mMZ/UoXta9ivFmUWii3F6DkYqLGwjsETRQ
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When the Client sends a modify operation and PA Sync is
"Do not synchronize to PA", the BIS source information
needs to be cleared.

Fixes: https://github.com/bluez/bluez/issues/1145
---
Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 profiles/audio/bass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c36f43277..4bbb1bf17 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1427,6 +1427,9 @@ static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
 
 			bt_bass_set_pa_sync(dg->src,
 				BT_BASS_NOT_SYNCHRONIZED_TO_PA);
+
+			/* Remove device of BIS source*/
+			btd_adapter_remove_device(device_get_adapter(dg->device), dg->device);
 		} else {
 			bass_update_bis_sync(dg, bcast_src);
 		}

---
base-commit: f8e7bcfdfb83a6a3becabdba1e4448bf04e32db5
change-id: 20250416-bass_modify-7accebe87323

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


