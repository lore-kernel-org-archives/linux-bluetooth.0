Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAAA52F88
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487780; cv=none; b=crB7pX2ai6HbfW63tXEh26I/chknp8aIjj/KywP3KumRe2vx6loYK55YBtFbRjT7sJC4rTIq9Hfz5yyjvlJfmQ1DZlDlAUkofvUD4ZmpVt+fBA7JricRgo7kisRS+91f+hh3lg23M60YWODWFxu4iWKKFCjv4fhMn2CUbfh5AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487780; c=relaxed/simple;
	bh=YtAnzlTa5u+eqXBVetJBBem7mVeV0aQfU2ghA+pxHOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eD0HBNzkooaHA2DSuTW+CmQlHtxJB2b5TWoiRDcnUl8nKmXqMMo2WQXB9Zr0wn2uCdYAna9ETN1TPwDECpBFszzqZql8r6b24DrhlV6u8XqiDqasOytHESAv0/7btFEd0R3Lvt7itur3XMGNN7oZCd/2OVf0MRZ9cPVzfIy1uW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lnTO+xVW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lnTO+xVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768487774;
	bh=YtAnzlTa5u+eqXBVetJBBem7mVeV0aQfU2ghA+pxHOw=;
	h=From:To:Subject:Date:From;
	b=lnTO+xVW1DD/wnNk5GU95jcX4z6niwcR+1j4uHjRA6glC4/YyKlKuuM1iEnrXI+8J
	 3ycTyD9EpgxBrNQwNZ2XDfMjZPU7jVPUEXqaEYzYPFLShsv40PiTemf1aBW5D8fjX9
	 gka2Vb0GCNlQZak0zMSKl18SUpb6OryFQU7t+0sYrg8qFyRFruwUSRMBWunHXoSSiN
	 gEb3hwOYpTPW3tSaP7lARXU6WkMHDyEY3vY/EHkvtL2Ey29+/9pq1rAeX52xTlfRdY
	 Y9Rhr/CPuG0fpyC8TD84bjDtLyMzBGqkEoj6Bwzlr2PvtjFqOi7l3koxfzWd4Q1z+R
	 lRAnjlUJDdIRQ==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-6f33-5C0F-0153-9768.rev.sfr.net [IPv6:2a02:8428:af44:1001:6f33:5c0f:153:9768])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31EF917E10F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:36:14 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/btpclient: Fix discovery filter setup
Date: Thu, 15 Jan 2026 15:36:09 +0100
Message-ID: <20260115143609.12559-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fix transport mode test to use 'auto' only when both BREDR and LE are
set.

Add an empty filter to discover all devices.

This allows to pass GAP/BROB/OBSV/BV-01-C and GAP/BROB/OBSV/BV-02-C
tests with auto-pts.
---
 tools/btpclient.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index a140253d9..5b531bfbd 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1340,15 +1340,17 @@ static void set_discovery_filter_setup(struct l_dbus_message *message,
 	builder = l_dbus_message_builder_new(message);
 
 	l_dbus_message_builder_enter_array(builder, "{sv}");
-	l_dbus_message_builder_enter_dict(builder, "sv");
 
 	/* Be in observer mode or in general mode (default in Bluez) */
 	if (flags & BTP_GAP_DISCOVERY_FLAG_OBSERVATION) {
+		l_dbus_message_builder_enter_dict(builder, "sv");
 		l_dbus_message_builder_append_basic(builder, 's', "Transport");
 		l_dbus_message_builder_enter_variant(builder, "s");
 
-		if (flags & (BTP_GAP_DISCOVERY_FLAG_LE |
-						BTP_GAP_DISCOVERY_FLAG_BREDR))
+		if ((flags & (BTP_GAP_DISCOVERY_FLAG_LE |
+					BTP_GAP_DISCOVERY_FLAG_BREDR)) ==
+				(BTP_GAP_DISCOVERY_FLAG_LE |
+					BTP_GAP_DISCOVERY_FLAG_BREDR))
 			l_dbus_message_builder_append_basic(builder, 's',
 									"auto");
 		else if (flags & BTP_GAP_DISCOVERY_FLAG_LE)
@@ -1358,9 +1360,17 @@ static void set_discovery_filter_setup(struct l_dbus_message *message,
 								"bredr");
 
 		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+
+		/* Add empty pattern to discover all devices */
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's', "Pattern");
+		l_dbus_message_builder_enter_variant(builder, "s");
+		l_dbus_message_builder_append_basic(builder, 's', "");
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
 	}
 
-	l_dbus_message_builder_leave_dict(builder);
 	l_dbus_message_builder_leave_array(builder);
 
 	/* TODO add passive, limited discovery */
-- 
2.43.0

