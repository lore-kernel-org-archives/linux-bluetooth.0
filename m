Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15A17D6
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022022; cv=none; b=i1S1kZ57EZP16bNmdYDXWSw/0AEGv1MZouT2OjV6meczNszOawDbRxRf44tOjq3axniWNjws8SVvJWAxz/+hQZfQ+oyOjSTtBdvAA8nMCfO1TGxPehmwuDV5YzMGdcYDO6f4bpTQOVUaMeb5bnFpaEjuCByfrA4HIwt9e/Z4Od0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022022; c=relaxed/simple;
	bh=fDQu0NTRcrwvoeAeLiGU2ZteYCS3HxlsIffUW0XAeIc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtbQIEOT5P+WsncSCpyuGp6u39AO4aZDbxIQSw6vmxQSacQ4vIRXkX6yhY6hzN4q00J6J/2c7f/YTqY5VlAYYjEKjO51u1fXcnSZH4LBMi6cgOweW59Mz+NF6tXJVexsoKSpwaXfg535Ckd/qm21vwbSElid5nkOv47PjqcUd6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A8833EBEA
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:34 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 04/15] tools: Install gatttool if deprecated tools are enabled
Date: Fri, 24 Apr 2026 11:11:07 +0200
Message-ID: <20260424091324.3097084-5-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF2v9NkEai7T5SMq/rc9utGxtWhOmfKeXkgZx6Q4ka33AAb/Ln46vnMm5VOKb7hbWh4MC4iKtb6jrc3PAQ4W5hGxMI45a8ue19XPdNqsqijQzg543lCLBmlvKMfXg9yE3ABdJXdkcHGi/Aavl0Oo+3arx9ETw2stYeHp2tasaWicMqy/0KgjlnpPFvwWZyyUzuaZdDVpztMIK6RC2ISJKudw6TTzGu7zRHrjVQ36WY12Q0piDsxmC0dWzFpUWwH1moDCQeXN2MLYO8g2+XEFKQlxV2iKmEkPOWd6gIXOhdbp0qsBdxXJTKxRxujTAzueCN5Ci803GVIjfulKtehG13fa7C1EY9jj1SiyPTak93RrmSCCrccExYB4BFxhYgYvpZ0tUcmKJV78q9PSgjluaMKVA3rUu20KEnJ1Na+W9axW24I0HiAc3bnnUQZsF4MGaHUIPUB9SQ+U7RCQNuWnS9anURvD0ALvElxfsVJzzbgLlNIRmRf6BCBArf9KXEjmaBHBEgpF8V2G334pV0eNVJREoij1NGmLR0n5XMNPuT1yG6+txj5h+7hW6FyQHg0F7v7JZS8b/wFKWO8mrz8ftAW5b4Q2UUMcHxvVH+xox+snWcjM30GucDRmsAJq9M2lOUPXoY8E6eHW1dHprBI6iT3MI1O5YQZjfBU7QmAjoSpAg
X-GND-State: clean
X-GND-Score: 0

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1141909
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=720486
---
 tools/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/meson.build b/tools/meson.build
index 8fc0dc1d2fb5..5f092e7e1b5c 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -204,6 +204,7 @@ if get_option('tools').allowed()
     executable('gatttool',
       sources: gatttool_sources,
       dependencies: [ libbluetooth_internal_dep, libshared_glib_dep, readline_dep ],
+      install: true
     )
     executable('hciattach',
       sources: [
-- 
2.53.0

