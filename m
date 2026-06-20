Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D4237180
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983079; cv=none; b=OCIWc4swNDiE2h9Yn3sA6ADh7mSWCB8Bf2GLUxuoZ2KpYkEJTjMp/ZdJT0Osr/YS3/nrneIaTBsDd3p2aN/24RP+x9ch4mjQBJNIe1W9bd+44PNNciNnAsIniVj09wYVIGhzfyHh0GW7Z4rC/p7SdWAJA01HRFczIm88xqgB338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983079; c=relaxed/simple;
	bh=MWFJzCJUfRA+SgSfghfM5yv4qe9FbW9UxMnexSC4lI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaqDMNTdVEGgFazQd3M9PJ79bDzbVNedWuK60WZcfwz39F2YZVFIk3rxBmq1i//A0Cf51G78ZrUgEn7Lss8DxYgmYvRVIcyUdjZ4AWunfCBC76sdu8XC2q2jV0xlcycaSK6peNvn1fKp54X4hZLjG/x/V5/mc9/nAeKwnMAASYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V20jPU4h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V20jPU4h"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so16247425e9.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781983077; x=1782587877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7abULQMPvls5cp4J5wtjswkadE4eFvZTCpzeenZlV30=;
        b=V20jPU4hinKE3pozbydRhTqPqxWJvIt5QMWX7LY3rDpCx3RxLhevd1n5aoyxMDNe/f
         fs7zvDuaW0ZNO2pm1J1aICeVy8U+gncKdrh58uNjU5H7YbjTrLmOFMOlCGBKpziWFcfg
         58Kr5vcTcxWLW87ItVBB/RfrlzTB3z7CbI4OBIpB8uh2lodQhAqn1ELnm1jhI/M7sGtE
         oVe56J1qGANersCNPLOHZCSG9fbvoYeCZVnD7578KNLdMAB7pCppCytOOeGTSROvDDoG
         jj5YXbzteysxxybrWR5yWYs8lNhBLAZEx3yXFMF7vqrmUkN2mn+oxjEWZsf7hthb074r
         MQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781983077; x=1782587877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7abULQMPvls5cp4J5wtjswkadE4eFvZTCpzeenZlV30=;
        b=PoAnJQ+vAE5r9HLmAx7Jh782TwZ+7qsgg2kw7JIAHnVS88AL8ryE2FMTjzXFZiIIat
         r9ah/ph0jxmsyKNfvoN8K769KjvD2Yblu0gIP94IenHDCDA1LguZZW6ARnMDTNBO12JI
         SnHci2595nf70F026paVkvbfVJoMEGXcqJgW5D49qRlgWmPnpaebUoBpOUoX/wOOoMnf
         QCcUrccwp2i0IMfx1f/2qmWDyusdoOaD3k6o5aWLx32DvK7rthK1c0gwpMXhpEwc13wk
         IbTNPZDJHTMb3yqjY1oer7IazRMcPriTwmsLNLFqwBaYYDQWw2jRWPLf/H3vhOSqWJmv
         +q0A==
X-Gm-Message-State: AOJu0YwpljViqBrCQZH4kpuhLJ09rp61uYe8qSn9OH1o/nmsfv7ApsFu
	4XJz5OI0tOVCBzHuH62/Zh7rf131yi++LuYukQ7xlWlEgR5DWsHiFmxlq6w2gA==
X-Gm-Gg: AfdE7clWDurUyRWcIxKbaf6k40fpUDyhsWeJS1EjthSssoFyzDAUkj+c/QTFMFFe0zi
	Qp+qIN+jB8aZj+KYMbrxnJf2SaifrHvNl7N1EM41BcitRK8vVYDNRLtNjO8qx2gbdvO/797NqbF
	6yVXER0iKeI505jxKjSLn+FqsVVPpQT2HR1c2AhyLdBO39KjWzdHASRptHDnOnZgZEYTYxMIduk
	uf7dQwbmUD2/lF5FEZTpxY+Ef2lat5BDX3ozbi5ZpyfamVwk/MPP3SaOk9Wr7nN1DfHwXAKatt4
	nIZICvSLGAIkK4IqBwd03LOp/zcDWJjHWnh7y5EpH0G3pJYti7EkOxilMYzz7Jxa7YymARavTcV
	qJVzqMBwKM2TO5ZnPH5o/hJnEpnqnA55xpkXiRyN2xlvRIhBFIXGaUtC7FnDD4eH41ZqqTqHvos
	cbQhzIjjO4+ENJ4xj8S4MMhz6h6HBOGEQXd2HuPhW5eTgdP79BlCfIu+vUONdWkIeg/HxVvlEQE
	gVHymdsMPFd5hZD4A==
X-Received: by 2002:a05:600c:5285:b0:492:4640:cf59 with SMTP id 5b1f17b1804b1-4924640cf67mr102536285e9.36.1781983076679;
        Sat, 20 Jun 2026 12:17:56 -0700 (PDT)
Received: from morpheus01.lan (93-38-64-42.ip69.fastwebnet.it. [93.38.64.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924923c862sm77000665e9.7.2026.06.20.12.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 12:17:56 -0700 (PDT)
From: Geraldo Netto <geraldonetto@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Geraldo Netto <geraldonetto@gmail.com>
Subject: [PATCH BlueZ 2/2] audio: reduce a2dp parser complexity
Date: Sat, 20 Jun 2026 21:17:35 +0200
Message-ID: <20260620191735.2675946-3-geraldonetto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620191735.2675946-1-geraldonetto@gmail.com>
References: <20260620191735.2675946-1-geraldonetto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 profiles/audio/a2dp-helpers.c | 55 +++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/a2dp-helpers.c b/profiles/audio/a2dp-helpers.c
index 035236df6..09dc6db91 100644
--- a/profiles/audio/a2dp-helpers.c
+++ b/profiles/audio/a2dp-helpers.c
@@ -74,6 +74,46 @@ static bool parse_caps(const char *value, uint8_t *caps, size_t caps_len,
 	return true;
 }
 
+static bool has_delay_field(const char *value)
+{
+	return value[0] != '\0' && value[1] != '\0' &&
+			g_ascii_isxdigit(value[0]) &&
+			g_ascii_isxdigit(value[1]) &&
+			value[2] == ':';
+}
+
+static bool parse_endpoint_header(const char **value, uint8_t *type,
+							uint8_t *codec)
+{
+	if (!parse_hex_byte(value, type) || !parse_colon(value))
+		return false;
+
+	if (!parse_hex_byte(value, codec) || !parse_colon(value))
+		return false;
+
+	return true;
+}
+
+static bool parse_delay_field(const char **value, uint8_t *delay)
+{
+	*delay = 0;
+
+	if (!has_delay_field(*value))
+		return true;
+
+	parse_hex_byte(value, delay);
+	parse_colon(value);
+
+	return *delay <= 1;
+}
+
+static bool valid_endpoint_args(const char *value,
+				const uint8_t *type, const uint8_t *codec,
+				const bool *delay_reporting, const size_t *size)
+{
+	return value && type && codec && delay_reporting && size;
+}
+
 bool a2dp_parse_capabilities_array(DBusMessageIter *value,
 					uint8_t **caps, int *size)
 {
@@ -106,27 +146,18 @@ bool a2dp_parse_persisted_endpoint(const char *value, uint8_t *type,
 	const char *pos;
 	uint8_t delay = 0;
 
-	if (!value || !type || !codec || !delay_reporting || !size)
+	if (!valid_endpoint_args(value, type, codec, delay_reporting, size))
 		return false;
 
 	*size = 0;
 
 	pos = value;
-	if (!parse_hex_byte(&pos, type) || !parse_colon(&pos))
+	if (!parse_endpoint_header(&pos, type, codec))
 		return false;
 
-	if (!parse_hex_byte(&pos, codec) || !parse_colon(&pos))
+	if (!parse_delay_field(&pos, &delay))
 		return false;
 
-	if (pos[0] != '\0' && pos[1] != '\0' &&
-			g_ascii_isxdigit(pos[0]) && g_ascii_isxdigit(pos[1]) &&
-			pos[2] == ':') {
-		parse_hex_byte(&pos, &delay);
-		parse_colon(&pos);
-		if (delay > 1)
-			return false;
-	}
-
 	if (!parse_caps(pos, caps, caps_len, size))
 		return false;
 
-- 
2.43.0

