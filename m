Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA68238D49
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811022; cv=none; b=tPjV2q6G68J55H6OIZgihELquiNWJ7tQXZhZuhDbePGpk9D5mvtu9zuM9ZNj6iVZ6byVMb7gcXBDZnqEZXB35VndJXzscn3SCLZ0pOcQYUhaC5iJ3Jrp9htlAYLxMPpm/iHuvOWajWzjeOqEViDm77Qd3k2iauAafRbRa6etGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811022; c=relaxed/simple;
	bh=+KXFtXqhvYIhR82VtnL5OxIjhrLiUQ1f5VZDH3mr7W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ce6HaXpO5GWwd/Ct2sX5tGjinRj50I2+1HNrSry0Rt9APE9XqMa6mkAvZlFzjlS1v4wZ1o5s4uJdxfakD33kZWUQb/KySRLhlN048EfNVSi85ZxnFFQ4NtgKP+IVmAYxqSuUDDBBiiPnVxDczn2+ZzmVaGr+BJsa3HlQa4ymBeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBB92VRC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ochang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBB92VRC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4227538a47so2657453a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754811020; x=1755415820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=43mrkfiW1WrBVgY5qgioZ3gQLj8nBBoAFhqS3GdgwyI=;
        b=FBB92VRCr30NCmB95apeeifCvLnxXVbXlEWkqw2Xp5dyYFo0O0akZlfRrav4DzJXlw
         mlO3NeXJt+wHwiqTbgf9+Ze5olptj65HVQfV8Q9akmVX3tTnUGY0Ajhh3oqQvVxhlcHr
         2bzC70RVbzvAA4lY+ulwUy6VLf6vaSaKp4+79pCNHLRqSjqBe0sNsL2ZkgtUdT/iV9fl
         Rfc+q3Bn5mj/y0h2SiCsIbakVVm0sYNcLndYpT6I2li8vzlARTrcnBbQcEsL6LAey9Ux
         FnGA22yNzYeNMbWAlDEBE7W4+EwhaQHq6Y2AaAtQk3OSVUoxkhtQbp8TQ24PIjUUHGgY
         8vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754811020; x=1755415820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43mrkfiW1WrBVgY5qgioZ3gQLj8nBBoAFhqS3GdgwyI=;
        b=A4fsnc88EmYzbM/VFMNFcc8wh5615GqZBzsjfHNlmYQVrm3wK3WTs+8JLuUWjOYlO7
         vGq2oA4PqKXtcK4eqUco9M7LVlb+/s38tIdMWqb5aiEwXA5mXDLccz9ZEfMT+rstjLLf
         GNhPokmvMMQsYgvB11EUh28aJqP0tdUbuRAmv2SyWh8pCggTfxUJdL6yrBqBNOOdVOdv
         C4KbeyHLu5T7sCGPPlbY3n5ofJSqSVXvKrJO1TLoaBtacKJZsx58ZO6wQCAoSTokM8Sd
         53HXhgx2Lu1UOleiXxJnzk3nXcmk1wbxRPLm7GyouWxh90UHmQH8RSfW/FyRQ+StH+6L
         FA8A==
X-Gm-Message-State: AOJu0YxlqJdBH+r2bk8bLqrVSuD9yNZr/ZojbSFZTXdCSDbIRHKkrX/b
	lO6G+k6amyPQNRYXPAT+7eCRGbkjQk4WM5ouKh4O3pqDI8jn90mHIo1lCq2cU23MzEps0hUB59T
	32SWJLLT8Aib72q9pz7M++82taHoHguv5KA8akXhSuFaSd//dNcswb88ZzPQDOnC1Y1s0eMYF/c
	2l7MrU4FbYudZRIcQZw16KBbnswIx7QtAp5V5I2UWJ9o8/fHsr
X-Google-Smtp-Source: AGHT+IGpBxfqPuT3eywX70qP7E94h8xWdZWV2usaNPxN5RuH3fVUQ3Mmw7Ys+q25/dSgvUw6lPCNQ4Bkddc=
X-Received: from plhl15.prod.google.com ([2002:a17:903:120f:b0:240:670f:ad71])
 (user=ochang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2341:b0:240:6766:ac01
 with SMTP id d9443c01a7336-242c1fdbcdfmr138606585ad.2.1754811019870; Sun, 10
 Aug 2025 00:30:19 -0700 (PDT)
Date: Sun, 10 Aug 2025 07:30:09 +0000
In-Reply-To: <20250810073008.1824799-2-ochang@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810073008.1824799-2-ochang@google.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250810073008.1824799-3-ochang@google.com>
Subject: [PATCH BlueZ 1/1] Fix buffer overflow in sdp_xml_parse_uuid128
From: Oliver Chang <ochang@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: oss-fuzz-bugs@google.com, Oliver Chang <ochang@google.com>
Content-Type: text/plain; charset="UTF-8"

This was found by OSS-Fuzz.

This can be reproduced by running this input:
`<uuid value="111111111111111111111111111111111111">`
against the harness in
https://github.com/google/oss-fuzz/blob/master/projects/bluez/fuzz_xml.c
which just calls `sdp_xml_parse_record`.

`sdp_xml_parse_uuid` checks that the length of the string is 36 (32
digits + 4 '-' characters) prior to calling `sdp_xml_parse_uuid128`.

There's no check preventing this data from being 36 digits (with no
"-"), which leads to a buffer overflow in sdp_xml_parse_uuid128.

https://issues.oss-fuzz.com/issues/42534847
https://oss-fuzz.com/testcase-detail/5070205940531200
---
 src/sdp-xml.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 5efa62ab8..2fa8f28a0 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -125,10 +125,16 @@ static sdp_data_t *sdp_xml_parse_uuid128(const char *data)
 		buf[0] = data[i];
 		buf[1] = data[i + 1];
 
+		if (j >= sizeof(val.data))
+			return NULL;
+
 		val.data[j++] = strtoul(buf, 0, 16);
 		i += 2;
 	}
 
+	if (j != sizeof(val.data))
+		return NULL;
+
 	return sdp_data_alloc(SDP_UUID128, &val);
 }
 
-- 
2.50.1.703.g449372360f-goog

