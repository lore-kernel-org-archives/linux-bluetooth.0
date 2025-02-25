Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5E1F95C
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474275; cv=none; b=aQUCzcQS7hQxD0PBw4oV0/aMVhMraPG2HH85auDEaR0kZuGUCQ+mNyDObIR/8MVc/iBpbUfEk1wiJ/KDsML85SwKCwJjB8Hs8aUgFzLQsLSYGSzWlvK2L+FFf8lEXR8nOBEQh9iTQTkTemN1/HSwp0227GmyHwdRTJZzRukfDjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474275; c=relaxed/simple;
	bh=OyScD5QfSaM9fF2+ZH9zBO0jqqy/YkxiMFgk80wyDqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LTzRn3W4GBlOacs9+ZKkQGTWvzfP3dkL3Yd8jEs3q4NMXPhvkvh4W7OtGleXaxpc4bWHszgC94z/Mnv1lOe8HhR4AaMK1+oq1M6yKmOno0h6h6roaw9CzCnY3zHEpPWMbJ9Duc7G1D/LjjsXh+290+Moq0qIDvtQHd+HBK8mE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTC7xCaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTC7xCaz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37BEFC4CEDD;
	Tue, 25 Feb 2025 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474274;
	bh=OyScD5QfSaM9fF2+ZH9zBO0jqqy/YkxiMFgk80wyDqU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BTC7xCaz9eVEai33kih9KXQKVJWeC/Mhxy+FEyZD1IKPjwcMkJyIBJIoBnGllIEgf
	 9BlD69Ng40ZzfHRkQZ3eNXSTtzM1U/SbhCalKzamFdir2KLekni0PGt+82i3TGdU1k
	 7zf3sYourIym2MSx4ohcjgyGQHzQea4w1F5Lkqjy77Jp4kLGLvrp1jJd9NtAJ8OsUC
	 jw3OegTZhIvxpzL5M6AGaC5TX370K3c92MpB//Cnmmhz6pdjTOCamI0WhIXRDtxX3r
	 RpfKjY7F8jJ6FsrGpG/HuRTS3C/q6MDDy2RoJOcZxLf6RUguaXnJbhzvRCeoSeRB1/
	 MWP5VnqbAtT6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B8C021B2;
	Tue, 25 Feb 2025 09:04:34 +0000 (UTC)
From: "ye.he via B4 Relay" <devnull+ye.he.amlogic.com@kernel.org>
Date: Tue, 25 Feb 2025 17:04:07 +0800
Subject: [PATCH bluez] adapter: Prepend the new added device to the adapter
 devices list
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIaHvWcC/x3MQQqDMBBG4avIrB2IY5TiVcRFav62AzaRBEUq3
 t3Q5bd476SMpMg0VCcl7Jo1hoKmrmj+uPAGqy8mMdIZkY4XuM1r5BD5C6+O+9Zaac2jh7NUsjX
 hpcd/OdJz2fCj6bpu5WJMnGkAAAA=
X-Change-ID: 20250225-leaudio-no-media-634423086ea4
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: "ye.he" <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740474272; l=1144;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=LiGBECn3b0Rk/VUHLXhxHMcVkP8VTGA2MyBmfyfM1r0=;
 b=ZlRx8DI8XcFeJtepjZzxZcknAdYqlWYb2doFr922Erxr6lH23dmsY/LWa+RjQtpeq8HmeU8Sh
 Fc5Dbs+9oUuDBiNZYB3PEXnQI2Xywt+qksll71d6CMmWqfE3JtqP+6V
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: "ye.he" <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: "ye.he" <ye.he@amlogic.com>

When the DUT is paired with a mobile phone using RPA multiple times,
multiple device contexts with the same bdaddr will be cached.
When we query the device context through bdaddr, we always get the
context at the head of adapter->devices, but its status is inactive.

https://github.com/bluez/bluez/issues/1095

Signed-off-by: ye.he <ye.he@amlogic.com>
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2bb94cf1673e85710abf1e619fdeee9c9fa0f087..d675f0b1575a21bc345cbdb003411cf188fdd314 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5243,7 +5243,7 @@ void device_resolved_drivers(struct btd_adapter *adapter,
 static void adapter_add_device(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
-	adapter->devices = g_slist_append(adapter->devices, device);
+	adapter->devices = g_slist_prepend(adapter->devices, device);
 	device_added_drivers(adapter, device);
 }
 

---
base-commit: 0845b8f6ef2ac004b1c953cf4fe4ca3458cd8e36
change-id: 20250225-leaudio-no-media-634423086ea4

Best regards,
-- 
ye.he <ye.he@amlogic.com>


