Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EF39EF12
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333816; cv=none; b=bkupk698JnHtdsW9WQN0QZ05epdhpikklhTHpyxfofRtnniY04EBRBCcv+ux0JPlQrvGtTGsLHRHwBk1oI3NMeBArriueXhjGfn/GDKXiSRKIbifLoU0iJhdJuUhjU0IIfZ0HwsyIKMt7jGT3gmMFkzwj/MSiToC1yczgQXJwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333816; c=relaxed/simple;
	bh=B/j3kxFlOZ7pbXOMKR0IInpB+9lYbeababtWFm0pZWA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WUygVdLr/RaGz9otjTilJFj2mPsdqzGkcfqbiJ+n/FSw/lvkLI6WvWPdGXD6Vehlq0FK6pBb665Z2g/A+SafMQVufyV98qQXYG+XJqk5RuLcH7CNa3INQk/N9lOAy+33JkWlyUEk4uBnZi7CYRJ/Y+lg5T+/4xiNl4q1UZpMgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8D703EC02
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 10:03:31 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] doc: Add missing btmon-cs doc to btmon.rst
Date: Thu, 16 Apr 2026 12:03:17 +0200
Message-ID: <20260416100323.3848182-1-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTGhjJ/R2rB92h/ExDMa1NfQUCI8Tdq57jGAZy/bfKCL4SHxSO5IfI9KwsNxgX2kyf7TeMIEeBQUsf9TzAY+xva0Y+sMu7UUsywpWTyOcU1pmt9jK7R9X1Xf2U2F0id4k0w2d0IlVin9+XG1U2I7JBLZpCWUvoLm00HgcoPO3b2uGr5OcnQOFwmjMjvR9XQr7fgc/hyfEn4tbK4ZmmKtAyfp+MZw6RyrRcMzbS+oN70cwzbpMevWDtrOYWl0We/jj1C6kw5jUiUs1SCvXly0SfovM4wHzIoi8rebOOlsl0A1uMQi2WWoAUzcLwKnlXn60w6RNlyzhUXgoasU4asX2KvrSyz8sbdpdj85y/DqhTQgeoWWeYSLg90++2mTUgBxqL3xKfet2L6dRZam7ysH2AVzhlBkZfK/1ZBeerXyzJg7KMZEMjB0vlji7LVOVVb6HbxrXsbAIPtiYHFQt+TtWnx+bkqU1If0YMXLuVT0E6gLx+eJhBqI39ReDACuvg1QvRJZLkONxgmLK9NcaBg/h4oflstZIubpegueBEezoTAPbwsrwsaO1h47zHHp+Dm1L+3V8SyHcLUQmywP2a4MU4idlTQ2FKbORIuhlzTFSJuy1WwZO1//QT5N7WJqGI2I5JmflQQweLPATNS7TGXdDRGQQGQXedmdB9yy+TEs2g/fww
X-GND-State: clean
X-GND-Score: 0

---
 Makefile.am   | 2 ++
 doc/btmon.rst | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 1f0b52ded8fa..76c4ab5d4f4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -542,6 +542,8 @@ EXTRA_DIST += doc/btmon-advertising.rst
 
 EXTRA_DIST += doc/btmon-le-audio.rst
 
+EXTRA_DIST += doc/btmon-cs.rst
+
 EXTRA_DIST += doc/btmon-l2cap.rst
 
 EXTRA_DIST += doc/btmon-smp.rst
diff --git a/doc/btmon.rst b/doc/btmon.rst
index cd08ed3d5424..f701454e598e 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -767,6 +767,8 @@ PROTOCOL FLOWS
 
 .. include:: btmon-le-audio.rst
 
+.. include:: btmon-cs.rst
+
 .. include:: btmon-classic-audio.rst
 
 .. include:: btmon-advertising.rst
-- 
2.53.0

