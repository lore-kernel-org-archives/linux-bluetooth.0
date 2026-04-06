Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F8328243
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474641; cv=pass; b=KHBWJFsQ3HC0aRU5r1NQ46b9moj5osEUsUN+U2rJL1eVdtKfdG3zjVs9qpWIQnrfblnMPzrweK7dMeOUZkIw1q8Pi17zGBU6ozAIBhEYImDUUF6/3g46SiWuQbuz4cJPESc72VJW23aubRblcR1lvcv2TgfABCGUoUdP9AEt9E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474641; c=relaxed/simple;
	bh=qXGj9TDNjJ6J2dz0V6S1onpo8e3AtZIAHSAQ7dNaJaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYV4Tg0L7p/UYXZLPIy4XxLReRBmHA32URP1i559myzuCgsq6UbdN5StO37C7mQw7WNGzxd5EDw6DQc3r0T2ZGUVYbb0FT0ligF9MmOpm4pqibbwljr738GF3Mv4jzKwN259vmvMzj9reu3GlKNm09rKSCgsMp1CR0EZNyf6KbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iRcTpKls; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iRcTpKls"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq6R20b36zyxH;
	Mon, 06 Apr 2026 14:23:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775474638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJs2jJ930iEXNqjFR1+F/6tmPpEIjKlnVsxIbww1Ytc=;
	b=iRcTpKlsNP22dht3fRZ7AKXcldNSB+dGXCu+YoenNKxx1/nwNhYjElG1CpYPhaVXRdd4iB
	OfRVLGXizLzftnpmEI6gRBbJwhvTV63mSp9wx+6NfWxY16DB0/c6FFFpr+Lv+sseM+Vmo4
	gieFDHUwyFdThbNxX4GQxUA0GDZ1ygA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775474638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJs2jJ930iEXNqjFR1+F/6tmPpEIjKlnVsxIbww1Ytc=;
	b=NXUO6niGVOCcu6tPqCNiaG1UqSYxfa5fZpl384hIEPEBWAz5WosP2XbQKhcUsp/T55DwlZ
	0SCB5unfryFPxG70JaDYv61SP8vB29/beG65cTQBhr+xL92TQ/MdEVo7x1d/ixvNdPF9rs
	i4pVjcLFt3hWT/D9mks9dxk9QU9PVdQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775474638;
	b=rXT2kvHux9Iwv1aUDbR+zmKX74gAWWggwJNQGFOcHtzvNG3Fa2xj4jkDG0xPY08gD9xtio
	x7NPVL4yCjQKSMhYk9Hrn04UEoLjPNat7oWAgMbq1fvAHjEWt/QANiJ7phgj4WfFMiAqWX
	zcUSCtrvyWNNSTNdrFoZtr1vmylGtAY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] monitor: Remove assigned but unused variables
Date: Mon,  6 Apr 2026 14:23:52 +0300
Message-ID: <1c9f9af5556b9482239d080a8d10d0df9f6fa460.1775474498.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
References: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.
---
 monitor/avctp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 874e217a7..6309275f6 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -803,7 +803,6 @@ static bool avrcp_get_capabilities(struct avctp_frame *avctp_frame,
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t cap, count;
-	int i;
 
 	if (!l2cap_frame_get_u8(frame, &cap))
 		return false;
@@ -835,7 +834,7 @@ static bool avrcp_get_capabilities(struct avctp_frame *avctp_frame,
 		}
 		break;
 	case 0x3:
-		for (i = 0; count > 0; count--, i++) {
+		for (; count > 0; count--) {
 			uint8_t event;
 
 			if (!l2cap_frame_get_u8(frame, &event))
@@ -858,7 +857,6 @@ static bool avrcp_list_player_attributes(struct avctp_frame *avctp_frame,
 {
 	struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
 	uint8_t num;
-	int i;
 
 	if (len == 0)
 		return true;
@@ -868,7 +866,7 @@ static bool avrcp_list_player_attributes(struct avctp_frame *avctp_frame,
 
 	print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
 
-	for (i = 0; num > 0; num--, i++) {
+	for (; num > 0; num--) {
 		uint8_t attr;
 
 		if (!l2cap_frame_get_u8(frame, &attr))
-- 
2.53.0

