Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD92E2650
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989400; cv=none; b=AvFLXpEuEv524shRr0pnF3xNDjAhMGq5x8PJSqe97BCXQFfFIADA8fqoNzd0uj3/AG8OTd7/1eRgTeHdlaMOYXgquiSg486Xru12fcB1QHy6D4ifNOQbIWy22ME8hB8N8DuoAgHsvpw+SfLgGsZE3smUynureioOxQ0oGxdyVok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989400; c=relaxed/simple;
	bh=vfwup6qgRZkYYkTO4swivEoPg9JhneJqPcj6nikjZf4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIDhYxKoSTm5WNQYTQJObfRgjFbog44TmGEOzF0wlvuxfP3PPPn0cXzRyw23aiM1HCkSXPs9/V28XxZdXovUfWMZkBUMaJ2yPMEVyp4ex0xB/tMjvWQxcqfZf8nun9YpjcgfnOURm73HhYCBelVkesFwaTOeuRzK0LHgGtKUfYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ik1rF+/q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ik1rF+/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989395;
	bh=vfwup6qgRZkYYkTO4swivEoPg9JhneJqPcj6nikjZf4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ik1rF+/qcB0UhE2K/E/if4kG0xW8iNjeM2s4INL1rV4vRm3aeNltkElUro5kgh/LM
	 11zV5YHQs/7W0kOhuo3SVDBiS5Yneeud5yfMBtIrlN4dgGRCmI7XL/m3EAiclXmMcY
	 uG9oHi4lY7Z/wk/oAkKkG7vTHULYeJ3tSu/9EJI28x7cvcQiVT1M7Xost1xZHFtcEv
	 kBTAHrEBloNr90aXRjInBUH8AAZtDZCd0MtjKfBS/4cF/u5BQW4PhL0JsTdw/1KpzL
	 lHKXmwFB7VLhHYIIWxKeNi9zOEhslybcqwzSyGVxDKZqoPVwYwPbF828mDa4EojLoL
	 I9+OGhKrvwqpQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F3E0B17E0523
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/7] shared/ad: Use strtoutf8 for name
Date: Tue,  8 Jul 2025 17:43:06 +0200
Message-ID: <20250708154308.238963-7-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708154308.238963-1-frederic.danis@collabora.com>
References: <20250708154308.238963-1-frederic.danis@collabora.com>
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
 src/shared/ad.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/src/shared/ad.c b/src/shared/ad.c
index 3f0064dd9..6952a0dab 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -276,7 +276,6 @@ static bool ad_replace_uuid128(struct bt_ad *ad, struct iovec *iov)
 static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 {
 	char utf8_name[HCI_MAX_NAME_LENGTH + 2];
-	int i;
 
 	memset(utf8_name, 0, sizeof(utf8_name));
 	strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
@@ -284,11 +283,7 @@ static bool ad_replace_name(struct bt_ad *ad, struct iovec *iov)
 	if (strisutf8(utf8_name, iov->iov_len))
 		goto done;
 
-	/* Assume ASCII, and replace all non-ASCII with spaces */
-	for (i = 0; utf8_name[i] != '\0'; i++) {
-		if (!isascii(utf8_name[i]))
-			utf8_name[i] = ' ';
-	}
+	strtoutf8(utf8_name, iov->iov_len);
 
 	/* Remove leading and trailing whitespace characters */
 	strstrip(utf8_name);
-- 
2.43.0

