Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA327466A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787933833; cv=none; b=iKyCLTTdM2VexIlE+l6wTFn1sSS+QRpH0hb06OSvXr4oOOhfNOtQF0j+dbLhBtG3Y5qlaJ9d+Zvzm5LfLkj377OdU+V0+AiSNJXLtnR7vBYr4gwe+K4I861Nsg5cuFtgMsE+mR3De9rDAOiYgcHtJcZYAKIdhdNSWvn/Fcc04uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787933833; c=relaxed/simple;
	bh=s8vCrFexOS2KE/slAAZZzqxfqbpSWJKepHDJzpxD4o0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LC+j7msiN5bOBJngnPDN6apytODGKUlvvNhp1NdNocBV0dja10LaWHPlinBEmwYWF+TwsfQyX+1e3zgbXgFl7ApRP6iMhtZxwEeniivEEuemsvGC/deC76uAfizUtcpwSzGvhN29ElpqOpJm4VkL0NxMnDo9IpTFaHrWsXlVhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NelHgWT9; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NelHgWT9"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97bf910aa70so358146241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787933830; x=1788538630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAPi1r0cWV1jTxnu5fkIUJbNKZ9UXFm72YLmBbwsawk=;
        b=NelHgWT9HqRM4XG34zJhzTf6OsfaJtsjY5fa3zOOo/TN456ydNOEUpLD8ruc93havZ
         LujyCRKdUxyCJ65AUw+ubQzSpFWJuLY+yjlnlmH3ALgfPAe23kvw9QOoGSkXWBgavIGu
         +IisZAqMk2lt6J1rdpAXoJqzy6s6Qtz/lBwyp1I9qkqmQqvRvOxYDF6ZbWFGEIqrwEyE
         iWWAvOQn1p0fmU509Ec6CWpp1QqNN05Il3egUMu1rraUb5zWAb72JFT3aQ9fmKDA5ih+
         7aH/tJnQ7Yv1kQxHqzIOKA5zWKQX1p1mO102tMzeE9r95ULduWJkyZS9PkuNJ4lck1P1
         ACaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787933830; x=1788538630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KAPi1r0cWV1jTxnu5fkIUJbNKZ9UXFm72YLmBbwsawk=;
        b=GEsQdyb0p57j9k3XdIfaIRSKG7R+78Xa+Oqhg6f5lcoAnY9NWzqrlvF7dZqavZjlWf
         jpqXxztLHLA898scCpB/BrJf3aE4SAWY5q5AYF/4e46P41AGmbbjsCV7VXgcv5tGAcOh
         y+E2yulK7dZZRRAMtC/3ZoWCzsBhUjXqL8BK1qmcrkNkW95X9AE1VGLSEMMany88otDX
         9MX9zJBETD4BUs/sv4g1H+8VMiysXKMB9tjoc/qHEnF+eC7zZ/YByMVyN4/1UbBOziau
         8CpApfkXaNez0f361qKbQ/SYQGFrR2lj9Jb8ew9cbY7IEE/UpK2/iMfXoNM2ZB0z+Qzt
         pKSA==
X-Gm-Message-State: AFuF++kBNJOHWv3Q7Rfah1Lmk5x9gKI0Wt9kVbDShmOSGSV0bBHFGOWq
	GQm9XTBmIzXlWGeG6g3RAZBWNeKsWJvjfmYX5kpOxIkHuiUXjUzsMjfGz/uSIf4BMtI=
X-Gm-Gg: AR+sD13DXpu5TFD9k4O6RXHcpKdt99ATUkjz/sHAV7VUrAsiHPfSGDcdIEokcDLtq5e
	DKJ9MNrJhcuLqxoBpxO4SxZ1zLLHfy1BYJNExaVDuGTDJJhO1gxkV70JVjjipW4/UiHdQn+XzcC
	7TMOv+fi3WttTjOjlSWRzSQPzGYDNlGJEu7+b3dXNoGrKPWUYPVF/UZMTfQFQZMnp6y2RPuzcPN
	rWXg+mQa73/b5Gbt6Uu12aLQrC5joZoSnwrv2TTCkL2LHiXNZJQ7F5eWcIdVv+tZs2iOifqvXPT
	lcoeRiFTSqkup+7jjk7WEvP5BkLJWKD8CMwOys3jj0MNMUZErGz+yvZICQ69xlpnMRXKCtmlMdo
	y2LJLDoJd/BdXRC67QMbtDlKFMhlkZf4aK3ow3fbR4Ouneyv74VQ5pVYZEfWNxoIjdFYeUd+b0b
	8Ol4HH2MtgHECDOvgQdUgNB+/bIKQW/E5LUMUexPm36OuCybdYY9YWuhGjTEo7mbvlBYUr2RlBU
	7UY2nVCXM27tTvS4cvbOsWp5ckid8aA3ifufa7dJWd/+aS4DT650RM=
X-Received: by 2002:a05:6102:3f0e:b0:784:d83f:2a59 with SMTP id ada2fe7eead31-78599267a90mr2326919137.9.1787933830190;
        Fri, 28 Aug 2026 09:17:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-785f532aa2fsm1431750137.2.2026.08.28.09.17.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 09:17:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
Date: Fri, 28 Aug 2026 12:17:00 -0400
Message-ID: <20260828161702.519421-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bastien Nocera <hadess@hadess.net>

In profiles/audio/avrcp.c, avrcp_list_player_attributes_rsp() parsed the
response using hand-computed offsets into the operands buffer, without
accounting for the fact that operand_count spans the 7 byte AVRCP header
as well as the parameters:

- attrs is a 4 byte array which could be written out-of-bounds if a
  length greater than 4 was declared in the first parameter byte.

- The attribute bytes were read with a bound derived from operand_count,
  so a truncated response could be read past its end. As the receive
  buffer is reused across packets, those stale bytes could be echoed
  back to the peer in the following GetCurrentPlayerValue request.

- params_len was compared against count, which was only ever 0 at that
  point, so the length of the PDU was in practice never validated.

Parse the response through a struct iovec using the util_iov_pull_*
helpers instead, so that the header and each subsequent field are bounds
checked as they are consumed and the remaining length is tracked for us.
This lets params_len be validated against the actual number of parameter
bytes received. The attribute count is still clamped to
AVRCP_ATTRIBUTE_LAST, which is what bounds the write into attrs.

Reported-by: @ax-nnlabs
Closes: https://github.com/bluez/bluez/security/advisories/GHSA-m2vx-pw5f-rc8v
---
 profiles/audio/avrcp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 3271b84782e8..906f93424872 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2395,31 +2395,49 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 					uint8_t transaction, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
+	struct iovec iov = { operands, operand_count };
 	uint8_t attrs[AVRCP_ATTRIBUTE_LAST];
 	struct avrcp *session = user_data;
-	struct avrcp_header *pdu = (void *) operands;
+	struct avrcp_header *pdu;
 	uint8_t len, count = 0;
 	int i;
 
 	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
 
-	len = pdu->params[0];
+	pdu = util_iov_pull_mem(&iov, sizeof(*pdu));
+	if (!pdu) {
+		error("Invalid AVRCP header");
+		return FALSE;
+	}
 
-	if (be16_to_cpu(pdu->params_len) < count) {
+	if (be16_to_cpu(pdu->params_len) != iov.iov_len) {
 		error("Invalid parameters");
 		return FALSE;
 	}
 
-	for (i = 0; len > 0; len--, i++) {
+	if (!util_iov_pull_u8(&iov, &len))
+		return FALSE;
+
+	len = MIN(len, AVRCP_ATTRIBUTE_LAST);
+
+	for (i = 0; i < len; i++) {
+		uint8_t attr;
+
+		if (!util_iov_pull_u8(&iov, &attr))
+			break;
+
 		/* Don't query invalid attributes */
-		if (pdu->params[i + 1] == AVRCP_ATTRIBUTE_ILLEGAL ||
-				pdu->params[i + 1] > AVRCP_ATTRIBUTE_LAST)
+		if (attr == AVRCP_ATTRIBUTE_ILLEGAL ||
+					attr > AVRCP_ATTRIBUTE_LAST)
 			continue;
 
-		attrs[count++] = pdu->params[i + 1];
+		attrs[count++] = attr;
 	}
 
+	if (!count)
+		return FALSE;
+
 	avrcp_get_current_player_value(session, attrs, count);
 
 	return FALSE;
-- 
2.54.0

