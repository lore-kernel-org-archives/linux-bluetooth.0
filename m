Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8129334F475
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451087; cv=pass; b=I5fqpa8654tOBUkq5aUUAMv/SFIEnWssvQqmHmVz0jAL/8MRlyx3AzpM6F9fCptDesvfMvyKX7grtsE4eKGvuHwmNlh5rCOhvdbL9rd1D7fymu1Ey9HiXKQXNbhidivWMImBGlxMnZEo/16T8KqWUGgj77DVr+fd0yJwNcKhuEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451087; c=relaxed/simple;
	bh=GD39ISEbjQ/iq+LwfmmcmI76tgKXpau5+cRsfrVKF28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMB+Tw5rJuZ4mgagfKVtNj/vrqQ6HvUtQ0m9rM03vdDhLSDwzabp3oADAOwNP2XJsIaxOwOG0sGG/QJWzcfd4SWUSD6Hfa2QtWKdET9n4t6/agN1sUg2UpDXaLdQk4ajVSXM/GiZBl3idOeg/FcHP9/zpdSnjO/PfRvD3AHrfdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rRzKv+65; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rRzKv+65"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d2V1t5rCHzyW5;
	Thu,  6 Nov 2025 19:44:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762451075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svi6BKFYKmkilnr3SAa26aHRFmp0jYCchciXiM4pr0E=;
	b=rRzKv+65t8CB07dub1xT2m3fZcnwsOj46sLyQ2aIxiM2ZsQoKHeEzhcqqUkPA2/BNzDhJj
	dM2261kclikIaAYnDKbOn3oTaDiXMqJWzKJGn5Udg7a7SzUR4U0463sZ28VNcXlgrbmDcx
	eIIMWQh9SS/k71WUYeK/02fjm3HpRp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762451075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svi6BKFYKmkilnr3SAa26aHRFmp0jYCchciXiM4pr0E=;
	b=NW+f5VVzthtqq04EhrYqRmlAhFKHhsXjIw6mZuFynrV+oNhIFjSiJYJc9cbQTC4BQN8k57
	s0Kogxyv4mCm+wHkTryHYJPEOOnG6fVBBD2IUYFRVhv/ZDxyYEyZ/r1du74p8z4NfW61fI
	H9zmGBHSL1L27uA+uIPeYq9z1lnz1sY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762451075; a=rsa-sha256; cv=none;
	b=ZV799Kp5nLg3MgpOQdwAPfs34AhbKBW2eMp9i8G4Ubp31s8iprIdShbvQvvvopbazd9NH2
	TIpnTTPlQv8gZLdyiA2x2SWME0JE+d4uMbDoD0+dBy/pMtjLbqmt7B/zNHdx+mBkKrzP6c
	pVS1ypSP7mRnem165nk3cHzUooqNOi4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] github/issue_template: Add basic issue template
Date: Thu,  6 Nov 2025 19:44:28 +0200
Message-ID: <4ae9101b9ad8a521af68b0eede9ed33e752de65a.1762450967.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add issue template that instructs to use btmon and indicate software
versions.
---
 .github/ISSUE_TEMPLATE/issue.md | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 .github/ISSUE_TEMPLATE/issue.md

diff --git a/.github/ISSUE_TEMPLATE/issue.md b/.github/ISSUE_TEMPLATE/issue.md
new file mode 100644
index 000000000..ba384e120
--- /dev/null
+++ b/.github/ISSUE_TEMPLATE/issue.md
@@ -0,0 +1,41 @@
+---
+name: New issue
+about: 'Report a bug or other problem'
+title: ''
+labels: ''
+assignees: ''
+
+---
+
+### Description
+
+<!-- A clear and concise description of what the bug is -->
+
+<!-- A clear and concise description of what you expected to happen -->
+
+<!-- Include any other relevant details -->
+
+### To reproduce
+<!-- Steps to reproduce the issue, if possible -->
+1.
+2.
+3.
+4.
+
+### Logs
+- btmon log: <!-- Bluetooth traffic dump: (usually needed)
+                  0. Power off connected device
+                  1. Run: btmon -w btmon.log
+                  2. Connect device, reproduce the issue
+                  3. Ctrl-C btmon
+                  4. Attach btmon.log to the issue -->
+- bluetoothd log: <!-- Run: journalctl -u bluetooth --boot 0 > bluetoothd.log; if relevant for issue -->
+
+<!-- Any other logs etc. relevant for the issue -->
+
+### Versions
+- BlueZ version:  <!-- Run: bluetoothctl --version -->
+- Kernel version:  <!-- Run: uname -r -->
+- Problematic device: <!-- Device model etc information, if relevant -->
+
+<!-- Any other relevant information on platform / hardware here -->
-- 
2.51.1

