Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472614;
	b=J2sVaynYW/ao1LTTV5d/kHuOGx29VHP1iIlN5bCnJiEbJDSdy63D3VYNg9bzODYmSZlj
	 WmZmdVlxx7ME8MPWqUUD6yWPATE8ZzTudJ8LKmIM9HOGzAsjkyHu/6n5cmIh+CC48V4ld
	 AxyXvsMRNHpWoCyNKgMhmrhP/baocSek/k/D2r7pz7pnVFsbpmZdyQyGFQYV1xyC4XTPk
	 4EeqVuSnV3dgwPQTGfE1efBDrN9aTlgdqvR1EjEZbbExv215ZHJCQUlNL7+CbsMPa+qAA
	 CcGeadULFLrB2KOlZrH8BJ1MKLBHZigm9YyNU6rug/28tmvM2M9rtzoW2sQ+/S0u9xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
	b=udRhnVWbfF5gujZDDSSzje28oT0iTs2i56qhSYKj3qf1ws2/P72aSV4zRe5CPYTP/RFz
	 +NdSS2uPuoSxrV9yVV9u8TuZemdyoitWT2HCmdr+wpvyMHwjxJuNuQXZW32cA2DQLTCZJ
	 GEVEDEakNUCw4jAEgjUQeT/hX9Tdr0j7vrY3DdrWLPV0VNuqzUjUvcgxPW23J+Qa6GmrB
	 DCi0dny6nR2/gTMRYq53Oh9Q4ZmJ8pCxZSXpz9NCGzRcVuZLraKSFvBL+qjzp5HvzUUWV
	 nMrpYIRa7FE+FN0NPuqOfbxv9yrX7vMSQSASMy8iNKvLbNi3b5nE4aQ6fHIkQYu66ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TtkOejFh;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9EC606A321
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TtkOejFh
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb8ecdcbb8so2569455e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472613; x=1796077413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
        b=TtkOejFhCs6cC/M82p0NYWMDfhXd7ntMz3p9DqBpagJPvJY4aW4YJCROO/I5sbzxVP
         pQtI0QIror4hIL6mcIOH41uGZP70VfSYUDZ+KhgwgprBaJEkYYVr8qNAv1AmB4NVtUA/
         Rdyii6E9TrJqdGneloBFj7X9XIEjvu3fBeH1A+vbMf37m9c2csl+Qre2fXEYIlq8+KKw
         +cFUoLjLwik/N2Hn8Kq74LzEoO01B8uQilIk2qAqWT2IEjHkHm2mzqWRniR3qcXvYm8K
         htPgTvNsQTRS9G2hcXtyfMDVnUW5W2vQJ907xzn5N/JKHXMXsbofsFIVP1pbXnJ+5P9H
         E5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472613; x=1796077413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEWpRNXwLO6tMVnFBy4u1Yu8LTLkEG1xyMaCgV+OMJw=;
        b=FErWjF1Z2YxDgwKVBZTZM+4j/a9iDmmwm9lBgoBj03dKzW8oMGfcCuaO/k7fyz8pDV
         5FOgjtrRYNLqHlZiPcrMaZY5JquDJTe7S70XadLdGdTIdY+kfmeFCnQ1c91le00irc9A
         wGrpq+JSneoRmLMjGwXFNe9G5usnQcp28gEahs5sOpJSFUcpcdiv6USwjGBnugFMrd9K
         g/7adPp7e7rGi4yZmIwuxADzrRcbqTAC5LJRv5fbjq/is7Qz0FR6M9J4atpMi9Y7jzyf
         DIxYJcPB24sOW05xITxiz7E5BVEbS1LBsPtCLUMKu0Ex7lnv2+UQ+10BnBm+/OqkTXLu
         I9rw==
X-Gm-Message-State: APuU4Z9sRE6B5R7hRVZdlqirXvJrYSsAV0cC/vn+2kBePmLbfBYV6l2G
	dleAQvrllX/rOqTApXk8vQnqwn8awi2izAo0awC+qmUQNZYaVvKVMlV0mr6/zQ==
X-Gm-Gg: AZFdTZd7nMMWt3VXZXUG/RKnQBc/cJ5mej2hSofpNXpSCpiJFgSakVJAZGA9bog6bH0
	QBfzHGXo1wnUVvoBqRUahgtkmYEYTUJNxwlioy3wDJnbRV8GFY849lIyr7nNZRIJ4s8CtV3DaB5
	D01tsf7+XdiDQMMyHUJ8l+PWo0ZDZuUDr7jE+9jBw1m+ht11cxfnduxg0LjZSMheILV9aAt5kHw
	AxuwSQTohIvBNss7RUYgYJKaLO18KIkyi7yvWVbpn6b0kccEkOCB7sjIR72RGIjwgBfUB39PZhL
	oRXPMiuSkA5cs4/dXp7K3xhsVwf4qTZQlg71cTiNQ1mjgnBrTAnVL51h33J5MGjMS0VVRS55o/W
	Ot2emgvxiglKpvkrP5lfCcV9wVHLa9jl5/80H/IMlFtwBXiGjR9siJzLYsybTv5HtjLlFfPYsc9
	ya0cnSg92nkOeOQyJy48TorecBnNkTf/G7IJ2uRGhjG8ybeJqwSri3vbOG6h3MldyACD+PG71Ms
	Ug/HultJLfmO88pPhX52y2fN1Z3sCFWmQKkviEU28xc06KD/+0pS+K2/vOSNuHHXgOx8k5QMCSt
	nvf33LI3vLxlKQKEbKIBirgel8pBzrKDbGdfBs0gCLA7LCEu
X-Received: by 2002:a05:6000:2f87:b0:48f:bb47:3d68 with SMTP id ffacd0b85a97d-4abaae41e22mr24239375f8f.1.1795472612510;
        Mon, 23 Nov 2026 14:23:32 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b398:6b00:c303:57b6:d70:952e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm23019015f8f.18.2026.11.23.14.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:23:32 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 1/6] monitor: Fix overflow of the name buffer in print_eir
Date: Mon, 23 Nov 2026 23:23:10 +0100
Message-ID: <20261123222315.223450-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123222315.223450-1-rolandschober1968@gmail.com>
References: <20261123222315.223450-1-rolandschober1968@gmail.com>
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

print_eir() copies the Shortened Local Name, the Complete Local Name
and the Broadcast Name into a buffer of 239 octets, which is enough for
the 240 octets of an Extended Inquiry Response. Advertising data from
other packets can have longer AD structures: an LE Periodic Advertising
Report with a Complete Local Name of 240 octets makes AddressSanitizer
report a write beyond the buffer.

Size the buffer for the largest AD structure.

Fixes: 854c945433fc ("monitor: Add full EIR parsing support")
Fixes: 99deeea86f15 ("btmon: Decode Broadcast Name")
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index eddf8706a..bce3bb819 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4418,7 +4418,7 @@ static void print_eir(const char *label, const uint8_t *eir, uint8_t eir_len,
 		uint8_t field_len = eir[0];
 		const uint8_t *data = &eir[2];
 		uint8_t data_len;
-		char name[239], label[100];
+		char name[255], label[100];
 		uint8_t flags, mask;
 
 		/* Check for the end of EIR */
-- 
2.47.3

