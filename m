Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431833A5E92
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971479; cv=none; b=OOnXZv0mfKqYWs+VhQskNSZ9nZJFrtemdtCs1aAkMCm4fRWzqwrWVpjbfvNOZQRj0xsWfiii2iX6XrSS4gxPAe7P/tOpAsOmgXuiYQMul+VvaNCTn5jJnmAQE3L4/qPR4w4wFNM2Y1lncrkCxSC4gPfO8reKU5TbbpUQ6jkgSJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971479; c=relaxed/simple;
	bh=ONARsCJdSOBG3J9IrS/zMIEdrUu71tEZ6UXLKxi1+b0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOCA7ev+1fd9346E1r0oRWxNCXxgP2lasZBg6dLeNlbDph9MVg53467bOUtDWt49aO6nDDVXZOaLyjtGqplgDV2s3bRWOLtwHzo6BbyU0TFs7h8zJ/f37vgsAyeLpwFGkfsVArHX/MjWsx1SP42nn76se2ZLzU45IubLdSD73J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34ABB3EBCF
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 06/16] tools: Install avinfo tool by default
Date: Tue,  5 May 2026 10:45:12 +0200
Message-ID: <20260505085741.2497401-7-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTE1TaAIXHl+D/t+l9SZa7itxUBuNLoqjpHOpmfU0rK6iiryfmtNl4Cl2X3zg/KqvY1W7ZaJCFDDDx7D0PIfXnMMF/+UVgy/0MYHdyOzOFU6UXCEpwxM3F+asfJduKUKRYseTfyo94wbZxy2SRmcDxuNDX6/mgg6tUEfric36v+I8EKjpy7uBSy9eIID7PXBgqK61fRfhfGUORhw9QB7rHizQC8ohrYNv3coaxqvlfFN8yhnAraJxz4pThd2e/V6+mZiABC2AoYu/UHmEoVVo/9hZs4mZ2w/mVwdwnsl13HOkuvwp3oQEGbJtDvpIQhDd3Mm997Al+cBVg4kwkA/vSqphf+RpXLmdIFXTolWXFGzkm2CLxU6at5ucVJ2AHDBD6Bv2aOoz+GIGBWsiEh4SnxfzkrGI1jiG/bZEa08g+2zYTDV355ipkE8Y7nxFmFExrf+IpIZFc0GT/Nml38pj3b8Mmnx3W+2tydVxdRg9R/Rs7J9zqKAb2oAMiaKueEtC4F9zLH3VioTB6Q/hY0cTArztzOdkh7/7kJgSxeXDvXi7gL0EKQc7FaKIlvemEiCdkhInxPVz+w9D6SqmwfD0wLPH2yKUYrcUPLP4sX438/1jH7fbdYwW44hZMVuU7uFzC4ZzltsppNRyUTjzlSXIZV1JjVuDNTSg0/FvE0pitINtw

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
2.54.0

