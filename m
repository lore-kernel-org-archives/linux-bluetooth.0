Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481448CD77
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285208; cv=none; b=cklMqDygTf3cex2s/7f++uIMhM7nlLJivY8LdLakmaRhlKWjoOy9lgfTy6ttnvHng6IJ483z0SUNp2V+GKsC6YkUuDUMRMH66G8q+iPW75yEnUHvlSGkPPgn8Wt7vkt2me+g5/uXlcO4jryIwBMfDLYuVK9UXWwKut6SFxW/y1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285208; c=relaxed/simple;
	bh=s8vCrFexOS2KE/slAAZZzqxfqbpSWJKepHDJzpxD4o0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dyANT+nf6arWynPIst7Ro2I+yHYyBR5gfR3GiIeOJ632bhJJ7MdZkxqhZElW/kQB0OW7oQMwimD/bopB/AaP5UhNtn/a0h2i9XvlsmuGn2bXZrR5u1irv1P/OC/5dUTJzGMmLWiGtQc7cL/0Ta6sAh/aT2s4zOjDmqKutb01jmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWgqfQhK; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWgqfQhK"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c65d654c23so87988e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788285206; x=1788890006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KAPi1r0cWV1jTxnu5fkIUJbNKZ9UXFm72YLmBbwsawk=;
        b=TWgqfQhKwB9Nd+EOysDgzkgLBNO/wmsLXhJ/UvndDbAPxN+bvH/5npI2mdC+TaDRcp
         VIjblIkBEBQ0mBVZPFIAVDni0ncSkWSC+UtVihbJpANzlb+5W51lmmedPh0PLbl1z1C2
         BK5EPe7ukwwxj04sDJ+iuoLSyTahQzAMAa0HAxCt19GCYsfhVAU7F73NjynuGhfJhOI2
         8DpTtkSt4zRt00bb/+NNpo6S/ABLzNl5mro39ooqoYz86Xdv2QycJtBibuP+En1Zjq5M
         OeqfENtDikp0HAezGpm8/LWQTv9M2OPOXD2+jgNSHM7x8+ryaYfJccsur0Dq5W8PiZ2F
         n7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285206; x=1788890006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KAPi1r0cWV1jTxnu5fkIUJbNKZ9UXFm72YLmBbwsawk=;
        b=GLWHeAJQCCn8WrrveFRLYhC4UXvVlk/GY1qkMpGwqZgXkhBQAYTSxCqYBDvqTG7rdv
         kfQzgNCjTrjFBstlPuua6tbmnx30jHlhsUr7xrKTz5hz8izWiJDObiSdh0/BWJdn/28R
         NHuIk/ovNkH+Ja3yfbhiBtF1lPc+k2pHnGksaur4ZAGz7AC5Kyksk0iP1g2Hu2SxPIyU
         +dZkBpPOcqy6eDhDofZBg1IssI7EAziwHdGhkJnTI7sl8hBP07zD9WigCHozeJHf7VBT
         RXZYLau4Yidv4F/AU032EfdQ0T/IdiceSpxQw5lgPnVx0ZlYB3a43XqaAa8sBC6V1EbG
         xTRg==
X-Gm-Message-State: AFuF++lY5d1NMv5KB9YbDYnuhg0OnKaXjri7qAqY/7ILggLtT1cx3pq+
	ji2OzfsOmFP6OjVqnJa0t5wJ7Byg3RZR5mOHDVkoKtpz05XsMQ8G3+/jW9w+SquE
X-Gm-Gg: AYBFou3/cYUtS2mNw3pq/mnj4m/pjp0nEefAup7omk9bUDsnY8uKgpmL7+RmdoDcZHj
	zZYvlUluO7SP6fyPsy1CfA9jgQ6N1FHbwdFb+QuISFm4iK2oR/OPMYra89v39ePJ9WNOO5IH7yT
	p77fLQd5ZgT1z55ddmGDJH/vh6Y/LbtiWbv2Wp/tYAb/yBk5tZm8kmOzPrvUE6pgiJZ7ML3l9YY
	ElsGrvcqAIpPYgFF7RefC3H5yfr+Dn9k3xFwJDmicP1izp6rfAA9H2imfM2NJzi8hKg8VgUFGlM
	SMNaM10tDZFKCB7PueRaoNg/z4veNQ3HZL+c1HMB477xRPQoVSTIAyjv802vJR08Mpud8giFN12
	c3LJfZNfFco0xERiJAdzjvNjsDA3q5R3GMwPGQaw8/k9HU+4YNtqP8E5qqzBRgINKdat9LYgV7m
	EBiK26sWUE+02yl2AXqd8SbjkqFfgEeLZvnhU0Ud/Ezxm96X885TZyTdDuWZ2YOc+yGIOJpJOyK
	zNy2zq80RT6kVkkKX7t326kA2RPHxEbnphczw/RYbB3yDOC8jii5k4=
X-Received: by 2002:a05:6122:660d:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-5c7bdea38c9mr5361628e0c.1.1788285205558;
        Tue, 01 Sep 2026 10:53:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd94646csm254265e0c.18.2026.09.01.10.53.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:53:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] avrcp: Fix out-of-bounds parsing of ListPlayerAttributes response
Date: Tue,  1 Sep 2026 13:53:11 -0400
Message-ID: <20260901175315.1348621-1-luiz.dentz@gmail.com>
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

