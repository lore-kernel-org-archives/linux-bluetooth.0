Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C172F656A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921203; cv=none; b=Crp4McoNc/1ZJ6WL8HMt/A3LIW+XF2UAX2OgzJr59hveMl3Lv1aVsipGrKLwSykPf9BQSE81vXmstZYgAg6VGMs0KtEZE1KlCzFK7VHwfOg6eT8brwdvZmqlIzxzpZcCdDD50D+eVHLxvAWiP1c91wm25b2qpYFOaCHjlOmwbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921203; c=relaxed/simple;
	bh=opfzhPW9GwIGipeBNvo5QFVuKN1DcbhNFhcqppwdhMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urrx904Cawnbd0ntmicE9pJE7GW30sWfuafJKPqR9w6wRnBC31BhixZymKcB7XeOB56T0BGtKqM5f+h+av2KTMP7/Y80oNTOWBxEwODIZCsokzK3Q6kBfnlCyxP/j9SJPU/R6nrGpIEQV6U4ijPEKxYg/8tbTZ/Mxlm6oUOZ/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 71393582F8F
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C3A543AFC
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Oct 2025 10:41:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 06/10] tools: Install avinfo tool by default
Date: Wed,  8 Oct 2025 12:40:21 +0200
Message-ID: <20251008104132.2206963-7-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008104132.2206963-1-hadess@hadess.net>
References: <20251008104132.2206963-1-hadess@hadess.net>
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

