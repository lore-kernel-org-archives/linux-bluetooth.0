Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20738422E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022022; cv=none; b=uHshbddxmxXu0LyLiDFdZxWwrPM+P3w5J/7chnthtbjDMzPjoeflU4XQtqVZJkEnkjFWWYK9HWYjXiO3lO+D2bmrK7hfBP0rEsj+wEfycAbQw6Xo4TydrEo2DfRcEE/A4osD1lESmuG//pQw64I442YTu1TjyvnmP0NS/on1fvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022022; c=relaxed/simple;
	bh=XZZTgMUeB8WIRsW9Y3UYVaejcaeh2/CU3D8g26poMZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/8q63KwrrEc4pUSX6pHSB9ky9a8uJVE456IndhKNzEAp63/sBORJr/aK2+Jm9aJrvdtjfZOlae/mInDaDgcTFKji9ibMtkb1+ewp+QPI45En59ifH9CKihnDhixW1f/nVgAzePQJmfDjohPuhdRh9a2fG8RLseyRBKrB/cmtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 702A13EBEB
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 05/15] tools: Install avinfo tool by default
Date: Fri, 24 Apr 2026 11:11:08 +0200
Message-ID: <20260424091324.3097084-6-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFMlvzLZS57T3ivUDR7WJjUzCleTMezFcr8ZxBSlwLmTyU1Ja2I5Git12NXz7/yxa0WLCQC67dLdT8LfJi7qLUFP7KgLtBjX2b6J3d0OB7oE09ZwGT6K7RGmAcv1SFLW62y1/ziNvBJy1+YAZdkF0ShdU8Owj2vg6qTL9jC4tqhfZ8G9zrImFItTb+m79rDSmL30H+aLGmrHi/+OSBMUqQkDRdKayBsS1EWkeBI8yUqaXGPtsWDCA9+UvtXWtbXhnnLCr5Nn8Z66HBwomTJThjPSMDu+o+O/P+y5LiDloJxkALPTAACjqMyUK/Q2iCggOE+Td3a0xOjpOU/P5CUIIbnB35KGzNXMbUR7L3Wia5NBVwTuEPblQUfinJtROKltarTOTAeZjL8CdqmYrQJ83SleJZe4iAPKE1nv0peTkFP8i/PdBu7XeOEpU44PtoMgBd5TE+sRKAy0uVu6+SaGpJR9zaygS5YG530r/ou8NftxIh+lUMqqhYXLrl9CmgercBGwHU6LLs8IfXMZMnmXoZxWlXGbNm/ch7x2FdJbGnaspkdzUR9CbFV+VarLLjzethNI0I0gFihJqis7h2lhuEYDSXacEmKGNtMmmMIAGW0+m+E6bFgpiQIFUtztt/AHfcmIgFdK0ryLRpmaUQ8GIZR3hBJ3Ijn3+8Wr69LuUTTew
X-GND-State: clean
X-GND-Score: 0

It's used for checking which audio codecs are supported by a Bluetooth
audio device, which is more useful now that PulseAudio/PipeWire support
alternative codecs like LDAC or aptX).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1699680
---
 tools/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/meson.build b/tools/meson.build
index 5f092e7e1b5c..1c2595a31f77 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -61,7 +61,6 @@ if udevlib_hid2hci_dep.found()
 endif
 
 tools_names = [
-  'avinfo',
   'avtest',
   'scotest',
   'hwdb',
@@ -82,6 +81,7 @@ tools_names = [
 ]
 
 inst_tools_names = [
+  'avinfo',
   'rctest',
   'l2test',
   'l2ping',
-- 
2.53.0

