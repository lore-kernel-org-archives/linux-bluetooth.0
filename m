Received: from relay0.mail.gandi.net (relay0.mail.gandi.net [217.70.178.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782D42D8785
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006176; cv=none; b=RPYlsD5grchoxqWgDTtXecuFf99exSDIdVH7sUUERZleTFuB3xEjWBNrB519UHS3ksWemEHNkufYKxPoaXi7QgC7IiNena7ObYtNOmWGor+D36viLZ3Q24wyKMGNgvUS0FhDXO00kQFdyZHA4Aa/SpQr5dNKMkuGrId2zwyNmVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006176; c=relaxed/simple;
	bh=opfzhPW9GwIGipeBNvo5QFVuKN1DcbhNFhcqppwdhMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNY88b8XXhZHthp0rEV0TjMqa2Srp87xxEM+Hm6+sMVzTMzcdehEWMBE6A7RQIqdWsqcnP6e3r4bpKwc2UnivWP4sxIBsxvHe/rovw98CvBEz+UzE6BAPgOxLpMb2SA9QLZPJ1LLx4/JMgfXHjU0xmJ2zcgyrasTqimKCC+9Lt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F9EB434D0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 10:36:05 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 06/10] tools: Install avinfo tool by default
Date: Thu,  9 Oct 2025 12:33:29 +0200
Message-ID: <20251009103554.2417973-7-hadess@hadess.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009103554.2417973-1-hadess@hadess.net>
References: <20251009103554.2417973-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

