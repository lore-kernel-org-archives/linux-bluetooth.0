Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072441;
	b=eA4ArU4KX5WIeIek4VIib37ARG12UH/1l+shuW4w1a2QJ288tY88yW7dccAW1WQIP73R
	 qw2bjN9UhpxVOoVsLBLTyvMLZyzW3w7Alps5HYGiW0TrU2hN3ysdhVRm7P267C/y4pqlh
	 iGeitBUQnMDQnSkQBBKKS8msbJa7Ztbg67WeMvz+/bkQMTbd7Cf1arNyQsfT9WffjZ5l3
	 t+XLb/eI6Rc2FfwcKfPIFst5o54GfiDa0FLH/0iThQjkP5kYRv5S8pteVhi3Irn//OdxO
	 5En7+Tx7DQejja5UocMLGlp77/Tv7PTnupgrUTxqtl/GB5iZRfAfAvoDuYXxzh7UNMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MNnpBEDTbwc3p59eYQh0IhUrbFt7av9B3+LIG1StQvk=;
	b=s1vC+gPtwROqfz7foHwGOZRr3p85TMEethZc1utXB6g4gXVaGrydeJTitHj++1eFUT5t
	 hYvvTnrTC3TwExttEqTePrpjWAWdA2+WUNrVOzuQhuEDDSFJTWusLucU1IJ0Q8BD3b/Z0
	 T1xJY3qi9QBX3hjo3x5H44WUPeegANgRnR8p11zKn403SRHd8e1kk517njRu/3PJIs72i
	 e5xyZCpNIXtnb5/jAVo2wmvntIZH7Kk3tNAp62nWTZ8lVhMiSTxg1CZ2q+eTW8JaCRhIW
	 4UWBJaAuiNBF6vpkA+mwxuz4Lj9gqW293720BcWzbPfc46FUgCUHj9zz07UdDVLKrTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPakR8O8;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A0606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20A0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cPakR8O8
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so1505255e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072439; x=1795677239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNnpBEDTbwc3p59eYQh0IhUrbFt7av9B3+LIG1StQvk=;
        b=cPakR8O8VnA4AUzSp5XKn3zBYkh8CLswR1/4oQOQwczaF5q5ULwuUHPOcPj2hF+c06
         LsGUhL7EyY4SmMIK6kXVKFDYwNOORvhG7QMvTaCbZW/x+XveQIVFA04riUJwAUx7H+R2
         L/C0Yk2WXcGIH9iJDqycTXLTintaV8ItCTBGPb6QePy1Oqou1fxnj0Nvv/2LTKNErEFi
         FCj1Ph+gyCwmPvWL4YZSLgWBnSj59yh3iuxub12xzkFUsgbEFAnjAAbFDBvQPIyRHt43
         5Q8Y/KLRGJfzjXor4kCcX79ODXf1ctkxxf/RPidsYTxH5hSz7zfliFNqq7GXHzorNHAL
         +RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072439; x=1795677239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNnpBEDTbwc3p59eYQh0IhUrbFt7av9B3+LIG1StQvk=;
        b=QQGwsbziSyNUbsYHusGGEOiu4YqIkPdlqvRxw8sNXwNi9WM+phTBgalQ/5uQS1VU3E
         DpPaZDd3TGcZzDg3MbTubjbOG0Tt7aM+8AONI2I89Q3kaRk161VZ0BbY3XMioStCBUpJ
         Y7LW+iXCIMbyJl3LNQ9JMeUJZr/ygK1ArOmpIahdDByAULvAS7wQ5b/gUv6WAvS3TLEh
         DIj3SkPd92HtJbK++ykA1igRTrzCxgbn/0aj/eRZeXkn2vqqmX0JrH/EENRwggcCJ7Lt
         84CAYEC6WmjxOnFBwIVXnaBJqZrblIK3mrDGYxRjxWU/lhAVhLY/ePHxvr1otmEKaWql
         AnKQ==
X-Gm-Message-State: APuU4Z8W5hQaJNIKhqxVjSwVCmne9nmca7vgX6YEH6BDcfC5hXUxAyfy
	GhA3zEc4gUh1dJunhKPA97eAnRIU1eiOBAcvIRLZEmQj2n5ECjiCXr3802AcVs2r
X-Gm-Gg: AYBFou20rf1RbGmgVpmrhdRwDpxcCG8pKuHEM6DYnDeXx3Qwz9Fk/7vr14+gb5AspIs
	FwhlhyZK1gBBPf61YnX47j69N0HLVW+zNXFOzHNhykgEhSRD5cH5lEz28XK8It2i56v/VLWQIMQ
	U/d/6p8p0910Dfpbaq7GwIB8eRUQuFBcKoR9PR+6pv4lX7vL/OS9/JXixIB6iPjhBPx+xbm/SX7
	CnPPj7rehGS4uGFhvNgIgyC0ADky+g6OTAIsUUheC5/n8vt/GrbSFu4ItKS0eZYTurfO2vwo/Yh
	4luc53T31Q/rTo6f5CTsFygQSyFjl7a/uOTC09LYgJlKqrFjv+TmuztyS1YJWqDOLxfOLl3PTts
	cCgqke0T9h73wWyerALJPZURF6BafgRYsLIcRU1FBoU5mbZ5gmPfkpPhWyXrVN7Fc37dRtT3ZpZ
	AIsOlc25LuTu+7fu3PfJrBLgCf1eN10c71PS+nkJ0Fkesxom8tKqnjn/yR+Vi6G0q6smDnG5wUL
	YqGiWZN1cTU/JSYhhudmrMpzhjmZJp8YgNL9XKExfalSjKC+vdP0lM06Mrh9ewgaZoEVjjD5wxo
	hvGWzMduzFdIF29PWnrq6xqc6sf9pSQQBo6/
X-Received: by 2002:a05:600c:4e92:b0:4bb:7ae0:30bf with SMTP id 5b1f17b1804b1-4bb7da147cfmr86266085e9.2.1795072439163;
        Wed, 18 Nov 2026 23:13:59 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:13:58 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 2/6] monitor: Fix data length of LE PA Report decoding
Date: Thu, 19 Nov 2026 08:13:28 +0100
Message-ID: <20261119071332.32424-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119071332.32424-1-rolandschober1968@gmail.com>
References: <20261119071332.32424-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Report decoder passes Data_Length from the
event to the advertising data decoder without checking it against the
size of the event, so a truncated event makes it decode octets which
are not part of it:

> HCI Event: LE Meta Event (0x3e) plen 8
      LE Periodic Advertising Report (0x0f)
        ...
        Data length: 1
        Data[1]:
        00                                               .

Report the length as invalid and dump the remaining octets instead:

        Data length: 1
        invalid data length

Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4ff24092e..0adc0144a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13957,6 +13957,13 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
 	print_field("Data length: %u", evt->data_len);
+
+	if (evt->data_len > size - sizeof(*evt)) {
+		print_text(COLOR_ERROR, "invalid data length");
+		packet_hexdump(evt->data, size - sizeof(*evt));
+		return;
+	}
+
 	print_eir("Data", evt->data, evt->data_len, true);
 }
 
-- 
2.47.3

