Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E08255E34
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958526; cv=none; b=Js7DUHDk/flNG9d18l/wwmM1D7UIyJN6PN9pvVXE+3l3YJuLaTDIbMybBkWzWKFbrXQgI6fykpvU4ZEHOQ1yrmzIFSbNunEm+VMtyljIE1ovAVlMaqG5k3veSCArh68de+UnjUpJJwsJT/48kN3pPE2sFFhLCEmQhuBcoH58Sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958526; c=relaxed/simple;
	bh=iKbb/0VhsEjq4xSN3eH9pkLAA+Twkoab/rMPto6+VxA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2x2aGXSTcskt5RbzFM9HW4+iBQxAX0I7XB50vHjbLzyWb4waaw6KVfsAp5tLWOrbO0qmMOtdHS5CDW+1I59UwEYDU6lV0hQ7ckn1LRPMHrcvwZN4oAzdiSUcc4Oft6N6PeoMYhcfZyRR77qML5IuiEL8PXipkDuczlPdCXqEpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iiTHUCLn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iiTHUCLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751958520;
	bh=iKbb/0VhsEjq4xSN3eH9pkLAA+Twkoab/rMPto6+VxA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iiTHUCLne8u1Gge7JFgrbVRqAg4Bcb6s84A5wlhAyFUBnz6JKGUR1OPf7i58vsbeR
	 ELU/due6AE7rK1ldxpvUuD1OKmChfQ8htARWIVdnqge4tPWbP6pGshrC+BUvGKjBFP
	 4nfLdoQEQnOtP/+eRP0FmpRbL9VMXdLKKFfSilWnyZJq+ueEiXNB0Emh//ZQTUdAqB
	 mLO4dcceArA/8vfH+EeKMJakge9uIo9bOK2/dNXbLTrHaFxJVrJfBgJRFOTBqeWZq/
	 lWOLZn1j8lpdPJ2pgyE/avUK9Kp9sE35fnRb3X+u0MSDVPIyqqS8+GVTbk2KuyHIIW
	 UFuXdTRXp0PVw==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-A903-AfF7-D14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2BAB217E11EC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:08:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/5] eir: Use strtoutf8 for device names
Date: Tue,  8 Jul 2025 09:08:22 +0200
Message-ID: <20250708070822.185375-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708070822.185375-1-frederic.danis@collabora.com>
References: <20250708070822.185375-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.
---
 src/eir.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/src/eir.c b/src/eir.c
index 28b09653c..1e1f76952 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -127,19 +127,10 @@ static void eir_parse_uuid128(struct eir_data *eir, const uint8_t *data,
 static char *name2utf8(const uint8_t *name, uint8_t len)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	int i;
-
-	if (g_utf8_validate((const char *) name, len, NULL))
-		return g_strndup((char *) name, len);
 
 	memset(utf8_name, 0, sizeof(utf8_name));
 	strncpy(utf8_name, (char *) name, len);
-
-	/* Assume ASCII, and replace all non-ASCII with spaces */
-	for (i = 0; utf8_name[i] != '\0'; i++) {
-		if (!isascii(utf8_name[i]))
-			utf8_name[i] = ' ';
-	}
+	strtoutf8(utf8_name, len);
 
 	/* Remove leading and trailing whitespace characters */
 	g_strstrip(utf8_name);
-- 
2.43.0

