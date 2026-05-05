Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5523A1A3B
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971480; cv=none; b=Js7llgFbimTYMEIwbFb8F8hASP1Xbhi72u5TzGQHyk+Q6rNVVJRYiX53faa6PtUEJYn0ZBnakU/+IiBAGFWj558VUkqPzXsJlVvu6y3wQOauyaS7zbCO3hmPQ0APgy3bFS4pHmeKr78RQmePakKHpDQeeuPzD4h+RQmx7rG1bVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971480; c=relaxed/simple;
	bh=zRymKxd+CCFv5VDTRyALcbPmQp7uX6rxuIUTs0k4IYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQkbuy80HQIxbyqYjdENt0UxhMYlHc3/52w7OxRAVrjaKeLcF8rChjN4mWhavOsVT3o1IgugHPws9/huuOeoi27Gm0NDQwG0KhmFKDVFzQWsSSaDvkV35kRo4dwKq6Ap8MCKSmMFmTd0CsjdvKPFr1j4nlyii1OOpxh9AUqKNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0E4E3EBCC
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:50 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 04/16] build: Separate systemd and libsystemd dependencies
Date: Tue,  5 May 2026 10:45:10 +0200
Message-ID: <20260505085741.2497401-5-hadess@hadess.net>
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
X-GND-Cause: dmFkZTF7m1kdtbVHsZr2LXd0j4SaLCDeEFbauGG+fBV8q/Lb0JtuMjsr5muOTSEAf7igQM0Bnw8BHYljvnxFnsAmHOLly4+52VorB9b4KAmDSVF4GGxfoa10KOzkkk0FZ/iH7EudoHjCU3lQOFMf08hNxPB0Om5CXgN/JaXrD8vR0QFR6vK+BgL2HzcSZsu+faoyhdo4a67AVWTy2kRkYaFGckVGbBf8TVfzXT8T3W71rhL99sA17fK9wNykeLee1lk/s3PuiKITlPDUhdt/XRmi48jSPOFu1u+d/gMtvWUS3SjNATRBgl/nHvW2jk6XZ5zgKwUZHQGjWGUUgyPiGRUQZieqHDXzyPs03QKr8QhHT+FduumNjwitO3CPfJ+9Sxd48NgZ9AAeNvEdxe1m4mQUiNwXZyWZlA0tAxPTLRboM71KalaEg75bWSrp3K+kLYfGLYiLjaUNJZVUaGokL2GxjTacZvc4q9sA4hUhQVdYsmtniPBH16S9rCdbY6VpI4+RQbRHKdp2zuVqR4u3e5pZDZmIkjXjp6gAyZ6FYjA/jidcNfrdVxVxYInv/t8wER5I6kGDtO64nEjiJbbZ49j4hw0wZQUYWLFz9KMm3z3Gg98LMJbzlwwOqJTQby3eZuaaIDmdRgXV0grojbs7utqDJeS+OYi32PeRg9E3InjkPwEPIQ

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 15508a868636..915dd32a37c6 100644
--- a/meson.build
+++ b/meson.build
@@ -144,7 +144,8 @@ readline_dep = dependency('readline',
   required: get_option('client').enabled() or
     get_option('mesh').enabled())
 systemd_dep = dependency('systemd', required: get_option('systemd'))
-libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
+libsystemd_dep = dependency('libsystemd',
+  required: get_option('obex').enabled() and get_option('logind').enabled())
 
 ell_args = {
   'version': '>= 0.39',
diff --git a/meson_options.txt b/meson_options.txt
index 4a0c726c2098..54cfdbb0d7c1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,7 +6,8 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
-option('systemd', type: 'feature', value: 'enabled', description: 'Enable systemd integration')
+option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
+option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support in tools')
 option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
-- 
2.54.0

