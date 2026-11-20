Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156746;
	b=5LqPfUue1uvnpr0usySbZAOZh6lqW/5nb5a03icgZYYEgWC0TUM/3OeU4aX5I9n+pNk8
	 oUE3Ib6Ar5YHzcwEpYSi28YzaoyICQncuit8cpxnL1leqCJO/3wtAvKx+xDkXP0oGzLSr
	 EEKZtP5dkbbn2aPGPnZF5nBdT/5HzXKs94Ci5sA1N4KBfKrauwtbjwGC2qpXnKE/cDRdq
	 vGX8CphqXTGfxz3SOyVYeScfQKCpNMO8RcXiNyNouG+2LT4GmUMaJvpcaSOk0G+V95tWV
	 aiJu6bLxqX4V88XifsK7iCiJ4I5YuW0lK9ApUb2WHIkA+lDx51F7hOIlumiC4E/XV7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
	b=pzrLl8D8UkE+Y4CBBGCAJgtVfBf6iC18TK7vS4fmXZ78TMy2Xhwcdu3ovd886RHMkzxu
	 TAbh1NkUbu0ZO6VtwvhfZbFSxfOa+rzSiswZuyFl1q4xvkPxIvfJ9CFgGAEWikxsyHCOq
	 1jaT4cIpqyErO5FEXwgolHrH3Eh5RqEykE2iXPFafUQ58sFHZhrJ3uu0IGFdxXKJQgImW
	 yCgdg2AXlS/OXAmRtq1VBiyDZ9ipCkzKv1r/rxZW+chk9A6plU7DULOU0Ecwl3SkOzbwc
	 BxhSYJj3Fmhk5ALT4cnpJ+85Iqph+TMbGtH9F6OqYHCbNHayFtqtFFXZfy6nc353bWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=audvQMQM;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDE606A334
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDDE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=audvQMQM
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4af52002471so702555e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156744; x=1795761544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=audvQMQMsNYI5uWJluja6CndZ4AWTa9CnPnt79FKRjisKtxS3uYdOUtk6ONxtu8lqp
         LyqNE2ZFcXHYs3UIpIPclhVRdBkdL1r4CCxfRz3zINkmXAGw13HgvRJuy6ZXcDsh/ZDU
         w5p6aIqVw9QSiQP6Kt9B2YnFKDhv1PbzaVDxuxtXZiw3x2TlVDDFgQmAA0j3rvQkzb6A
         n0cCeiIAcYRy1iGsKjSkxOVpkWvx/DNXPosedbk54+fh5cUeh1kJ3rAw4NpA58v23zxV
         Lk6hyaHdku6BR8KN/3hwtQ5sjp33l9N4gNCiMOW2JbGdROniVkH6aqGsYxYwVRR8yoxj
         BLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156744; x=1795761544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=yn4rqS/vG6FZW0RpMXL9l5Kg2Y5FJFIVnvOaJlCGJQEf9lrt5LfT5iSlRBCeMWBbK4
         V4RurRNAyHGNGcbUUsG/sn7Sm+EROEjDd0osZ2Dh00aTIlJdSttVsi8yxyStMqrdMscD
         qEZ/Ql6WUWTiNiWmJwn57JazhAJxgnEIq2HAh8twYv/OreQA095ade3BNX6eC/YM2au2
         xmhP54BCsCDsNduOyKt3rT8qqYgcOjKqxkJShWPR7mHn3RddIfZP93myviSgRO+xDaCU
         JfBdkIY+huPDPhpmcoS5Q/J9J1cO/+1GnXLa7NjFZhQTzNi6VUqGVQ3/uonLTtdfCIDj
         6k7A==
X-Gm-Message-State: APuU4Z/xtVM4ojrfdk6aDO+HwN5TPgxdsqTj6wtUaVnWP3e0LqKrlfqy
	x5zyGRI5byjO5p7SDhk0qjKI/9jUeefpLIh2yZ/uzlOsFSq04wBHmlQ79ZxKuPhE
X-Gm-Gg: AZFdTZc4FnXAmaEc+BZmtuRwthjsEOEPeNc4EIoytlmHFzrtbjOt23CbvNkuZ4Q5DqW
	6wNIJg7xe5FMjRPmZHj6b3Dz4H6xb1vfTvlDFzsLXRYb9Rksnp7277BNjTMRynA7lJBrfE3duXB
	Hoor8m5Yy72a3gs4UOitFizSvYw0tCydHxg5zGS2FH5t5XTm0fXWfKsuDecDr0KMmLIJcxOoEp3
	ADDfFyzzvKd6u11ql8LuHiePwONu+dC1rAI0sSIVUwBoBnEpae/ots6djKFqP792D7pw+M/UQIA
	W0Eldq4L+lQIKYH9sADr6kseLLmjIwKzbxw1WyhM1fJH446o/g5B6wvpTbteyCIXVgIlzpZIKHL
	nzXScHg6W7PmryZYXRS2cnk5/1gFcLfRBom6vS1kS0KN8tfZlmgPjKzwmLdkYzyDjWd8O/NNcv0
	pAp+V2ae6iJzUZ+Q9WeybMmx6yqPkaTEShTEY9bW/i1JBjuBzkiXqgLYBLO1YCtAKQtu0T9rM2t
	aURUNQdQghYOE2fvycBJQYwuq8Bwvuoe9sJyMSQQyhEwVPISsN4tgK+Ycmc2vIhFBFtmIc1WCXp
	VC3BI0lF5WeLq60IRklIM/1kOec9saTJGuBj
X-Received: by 2002:a05:6000:22c1:b0:48d:f1b3:7e82 with SMTP id ffacd0b85a97d-4aba531f89cmr4459247f8f.0.1795156743843;
        Thu, 19 Nov 2026 22:39:03 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:03 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 01/10] monitor: Fix handle decoding of status_handle_rsp
Date: Fri, 20 Nov 2026 07:38:47 +0100
Message-ID: <20261120063856.16585-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

status_handle_rsp() decodes the return parameters of commands which
return a Status followed by a Connection_Handle, but it only reads the
first octet of the two octets of the handle, so any handle above 255 is
printed wrong.

With LE Periodic Advertising Set Info Transfer returning handle 3585:

> HCI Event: Command Complete (0x0e) plen 6
      LE Periodic Advertising Set Info Transfer (0x08|0x005b) ncmd 1
        Status: Unknown Connection Identifier (0x02)
        Connection handle: 1

Read the handle as a 16-bit value:

        Connection handle: 3585

Fixes: b73d4bb9e3c9 ("monitor: Decode LE Periodic Advertising Sync Transfer command")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index eddf8706a..4ff24092e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4976,7 +4976,7 @@ static void status_handle_rsp(uint16_t index, const void *data, uint8_t size)
 	uint8_t status = *((const uint8_t *) data);
 
 	print_status(status);
-	print_field("Connection handle: %d", get_u8(data + 1));
+	print_field("Connection handle: %d", get_le16(data + 1));
 }
 
 static void status_bdaddr_rsp(uint16_t index, const void *data, uint8_t size)
-- 
2.47.3

