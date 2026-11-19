Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076199;
	b=4Ixm8Y4IF0z0FyrjO20pDyyOYvC3jiGMtsZ2KgvHPRHufxUEla/9aL8SXPMcGs+wt8Gt
	 tC36s+2jb9jMcTHFVVbLzhobz16L7BK0biJcor0DL2VBSTOBTUKmIjp+XDfEELAZdnw5p
	 a3W6Ic0a7i/Jq86Zouhx0VqHxQ2z4CkC/HnCTlM/VEDiWQLw9/oYLUUQdDgZJiGF1c/Gc
	 OFxgZ2gM6KSUrIBYl8XE1Piqsb5k9MqrCz3G/ve4ikbgXAxTnAJe6+Gpy1pEWDkKuBYGS
	 +20qWR1hh9WZChMIGwWyziIOf1BjelW+5b8PJi2j79kGc9d3i/8da1KA4+nYc+5PS1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
	b=ftooOkXvLDMfg43XhpwyPiqdqcwgajTllH4+IRsw864Ri7SppMRLf/RG0Ic29J7dS6eY
	 LgHs++E182g9GZk3aaNCQurxKMp8RhevTbnht3AazKEwePSNE/c/tKOcKmHGvmp0S4nkT
	 BcTto3uxXRr9P3hb1XxEt24ZbMHtHIxqzVeprukUGWHSucYNkKri+KzN/QdAoE5Fevyu9
	 W0zjUQazehJ//9J4HwqLEjEdk/02JovP6ZykY3S/DMpio9lZUH3nX3xgQdzE6+NsE0+it
	 F0ftUP2bIVNGGvtsB+JKzQhpci4oWJQK83YvI8cg14XbDKdBoL8uQLnAz2C8a2musOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2PVQbbT;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0A606A801
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98B0A606A801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t2PVQbbT
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b87ffdc5easo163608a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076197; x=1795680997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=t2PVQbbTmkigem34ibXBplQFTz0iJomo24BOFK2WTmafbA9BNGcBI4vmaMbm47bpb9
         n8EhGI+NB7a9GoiokPfbEdWudao4EYWAwG95fPzsndN6gZ+asgGShLJ1wJcYJThfg6NP
         THM8YdbNUAp6pSlVIxrmguhaTtyyLM3J8kT4seMbRVDjzUaNgNefPCwL2h0mcW6CVMz3
         zr0ddLknPAvciFxqrEtHiJgJN1gJG4cooZeKl+pNRyI61lar3HYZAQz4QAjFaan0dV1F
         dfz/8MqJxI74EB8A0j+Aic0FjaYbyEWVB6VqGLhgnryikD/RGDyUzvuySzK6umnTikQ5
         Ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076197; x=1795680997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=Zb3HqQcL9tnQF1G5Q/0Wwkk03Os+fqt72WcQTYrpTckhAZCqFVA++2fA54Lu8LsCim
         V0CekME015+/NGjtcRqMEQPyHyVjpj0Mj4s5LjkSUE5mZupVa9k4F7n0ogb4xKSnesCK
         ce48YyLpfo6u3/nhaaKiHvANrW7gVxXH5HpINNdZShnWTAd1QTU5HZcpnWPlbZNJr6Sg
         QJCxjkc1QMlC08F2s9LVnt5ttQSlm+AvW8WN/qReycs3vbYIQcK9sQ4o7dlDpicZWCuU
         Qc7KuCba1dzTTTWM4JHIDwcICcmWTZGRQqRi4OrNGb8M1hcw428DeXXw2P08MzYolYdj
         /vlg==
X-Gm-Message-State: APuU4Z/hjjRoYCl2ZY0m2ykqManBws0Vk0rtp9q/3LAzDKxOM88O5+wO
	RnNf9Vhsz5X571bWA6YsaQZBAwap7JnHKpUdocBwTFO5rr5DG6ZHQYa3dowvgshf
X-Gm-Gg: AYBFou3HOE8DIzlWnnBViVRI/6aye+wIrljSGdp7xdmleV+gjMOgZZhg15t7YI8PFPb
	MDwI+TWUTUK3S0JqUq/pXvBfATBEbWv1QPlPFsrCqGUHCewqx8KReC+ITUnFSof6bQcXRZ0cie2
	xB3D0nHMrA5mR8TaCy6K8aBpQ6rqCVK8bl/hBjn2Y5bTzobPUqZ4liEojLqV5L9WIVqeblcIFy8
	hHFfB2LDVk9klBvRxOVMfkfaE3mWCWsigda5nqTh5lsCADxfzQQDm93MU/7aduL39Arv29LF5e7
	XrMul0CDnSbyv3Sw65IYgTkIUlrLVwic+1QcE6LrtrrAK8Psc7+5scc/PMptHXFsksfN5yQXvT4
	Ppqf6KME0tuNDhhWAQ1NO9bsxEkGM85djlbR8QURkJplo9C4ib3krgLdi2UMjQF54fKc2MXpJ7/
	1n3lidBOAADkNFu6tvjYTiFZxWz42x1iV2D/HNhOt+dTisCVmNcDMzdl/eBF8z7HpUMHFlvqwzq
	gvE9eo3BwIXyHQDBrWS2qKL7/yxD4zsX0szMFwPRNYHDMNdFRa8ckjqI/lSz2CYCA1v81v5KunT
	9xRldKj+sDbVogb7YLWaUlsSNJxFi06EM9c=
X-Received: by 2002:aa7:c613:0:b0:6b4:602d:f1f2 with SMTP id 4fb4d7f45d1cf-6b887e4190dmr4398922a12.3.1795076196196;
        Thu, 19 Nov 2026 00:16:36 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:35 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 1/9] monitor: Fix handle decoding of status_handle_rsp
Date: Thu, 19 Nov 2026 09:16:13 +0100
Message-ID: <20261119081621.112623-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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

