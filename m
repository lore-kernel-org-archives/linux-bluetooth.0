Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805EF2FB616
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345286; cv=none; b=BtcNWCSIAMyPkw56ruObdLlKvemyaDZtXiu28hxsySYguF5DOt9ak8E6UKOrIIZJDkzsyPuyjCMTBWxTu9BqNANLIqrGR9J7FNrkbN9ck6ukBzUSnLOjC7zF9M0rfER8xRGLPfrAAG8aH5yBiAETlIyHXi+mGAbjnR6VXm6KjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345286; c=relaxed/simple;
	bh=opfzhPW9GwIGipeBNvo5QFVuKN1DcbhNFhcqppwdhMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLA5leZNcNjRbdL7UXxR+AUIFheYx1vV1g2k+2uJLfHmkl+cgSidZ0PvLU4esVpNyH9ADa6A5SPOuQNAUeSS5q+NZqYUaY8Ty6dGXe8arZl6LmOznttwLn7YJj3iy8zu1ox/Sgc8N0QX1XWkRmVHPJDnrkgORggMxpaNrFL3clQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 7123B582122
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:16 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04BC141CFA
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 08:33:08 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 6/9] tools: Install avinfo tool by default
Date: Mon, 13 Oct 2025 10:32:16 +0200
Message-ID: <20251013083259.3152260-7-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013083259.3152260-1-hadess@hadess.net>
References: <20251013083259.3152260-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

It's used for checking which audio codecs are supported by a Bluetooth
audio device, which is more useful now that PulseAudio/PipeWire support
alternative codecs like LDAC or aptX).

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1699680
---
 tools/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/meson.build b/tools/meson.build
index 3e8f7ad439dd..66156ab0224b 100644
--- a/tools/meson.build
+++ b/tools/meson.build
@@ -82,7 +82,6 @@ if get_option('hid2hci').enabled()
 endif
 
 tools_names = [
-  'avinfo',
   'avtest',
   'scotest',
   'hwdb',
@@ -103,6 +102,7 @@ tools_names = [
 ]
 
 inst_tools_names = [
+  'avinfo',
   'rctest',
   'l2test',
   'l2ping',
-- 
2.51.0

