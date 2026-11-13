Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546888;
	b=0lM8rZIj/mNtPhC7CnVfh3tO28pK7eeXWQNgBpg8lWUAEe1hU6YoS+yuYBqQkT9+KvhY
	 95hSzS4ZBS6ehUWj1ojqZJhMCwEhlObYLEJPUBDLAfA1mwqgd4e8ZYU9GnPnSIlCPHwBv
	 LF1ReEnxnOWpIOsT9DWBt5ddym6yIoE5E/9STSkpEyTO4vulYfswVAlgEf5R7ynly91T/
	 LSFH21e1a1MAjjVO7opR5yaZ/8JJrCW5lV2dlFLRa0izlbrFOSppHDFfRCCVETV++mmgb
	 8rJ4g8iaD8ZtvN8qFhstwzGGnf/mSxv1PxDq+xbcxRr81w8FhEN412vp8iQi55x7Nbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
	b=unEq8NBnmxtEeAriTrlCgtHZGy40vo2GQGn3y6ZaJuKGMFrTXQPlbh9vEAWboZS5HhjP
	 F5y1EkscUpnzeK+2QHN1F5E8UA2RpYa4RSpte5oW8KVvh6JS96USISm4yi/V25hT5iha5
	 xI0g18BFOoMU40BRheeTABnZEjRqBAGCj8aiIZbQFGqTLIKYI4b0eDLEH9oKEuQEwPn5l
	 Du4/koih4vk0ij32uh6i0r72WyQzZJ55dbRQB15K1A/FsH3x0SldLm2x0SgDtuZBhMM6R
	 z9OH6Evr5ob2gN8nuWH4XpCfLA1GY/xP0kHQKCDqMYJd0quPJHUX0R5epcbzPS3J//g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=U5MyK4nc;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F38606A335
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F38606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=U5MyK4nc
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso265601eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794546887; x=1795151687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
        b=U5MyK4nc5EH9ceY8DCXoFJQ5MzhIf7cKgZPvgmIeivbR9pEx3OKpUOsT+si0buegfM
         c2vshcRdEuPqMyRzIzhFzaDenuFNfIH2it4CwqoYD762/aKSkjA2kRCpTtwoGBPUMpVl
         cfIKEBgc4qUUAUG9TBOvvLDtP6Iir3CU5GWxs1nYgwFf90mhjT0KuR8lLm3YFya6kFt1
         p6gxy/Y1enKnoujk+JRBqUfWOadhjbuBOGMoY21Uwo/bEfpc0Pp9TrC7nFsvttTDSyxQ
         S2oHLaKbt/FZ8FOSl4ohOdCAJ3MX4/zvUjuS7MTGgRFneiXTD1SaJtj9AIxL61xmyzm/
         jasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546887; x=1795151687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Y+odWRgHh4z07I4UYRqxV/HlFuN3r1WhkMbWBsNBrA=;
        b=23ZGpKYDzIKwSQYnxDcxd+A/ahpHo6vrszOXJFlSl6x/uxjlGZGL/j1dvHI9wvLtjp
         I76vFJDx9ZLoK6NZsMLZHpD533Vx1ohvInkfnjCCCGvWSLqQ/qJUzvQnXoJ88Q38WQM5
         JPSgGhBGmfSEyVL9Bte9TjM3Y/NeqQZWhUS+AAzeBf7UbVWVGiKkGigHiOmhT16MrpOG
         lx4ObpvFDmhbR6Lo+miF4rUGcmBcR9D1nKT90RZN26jwc2ltgMnQ8y/Oew0PQ9D4AQy6
         4n06W9NcE5Ha3pqFdeiAZd+tYnwldofD1nHS/YK1xb9aLA/lQ+J1kkDvtDjr+MsLVYjS
         fMGQ==
X-Gm-Message-State: APuU4Z/D9y/wUeizW/ZnH4E+kcWE3KXcZw4PQ9p2qKS7BNAo3FhfHoO6
	uSb4emBvVRKEtg2lPmQflxqf5jYlAqZVpjNgGw7gvjqGy3gqOFQL3UQuYi6un43LN68uo9fZMO8
	SKocxzTI=
X-Gm-Gg: AYBFou1K9f9RElQTU+4TMCVYD4NBYMixWdss7F0BmOwhz/dvD/P+37TMOqh0Nngjk5t
	pJiD5o1L1c6CHW4AgIsjR7bfCLoATYNbUOj7ImbuNvzkmz4IrDzrcS8vSYLEaZC7DD2Nb20YgV5
	Nnl75WFu2zsTraHhUsIaDLoqz0g1Iwk7wgWf6drhFKXRhpBFgSEQVg6DDLA3LiyQg8BPTClxO7V
	YKNhVADoAVfeir0czAlSG+FSoAvYscE9mjimIzYhDjAJnsiUyQaiwD51sMZfFBih2VequTsvE5S
	k1uQDIHWNNtb+BISQk5uc74VFV6JcrAacH6HFysobPyTfLA1MlNE7tILbWKfoJO+ykesIPqM0XV
	SbJjN1uODqN/afUSpoQYaJd1AvavPjSJYXnaIw36KYEvtJ0LTnul4qzcAnR1tt9o7WZ97IVeSt9
	4ga5HWXzroj4WAwMgEl9V8d7sbVWGVxl6wKocjbw/1OW+Ei21hS6/N+PLGOYKzDwQNSzXFHlsdl
	pVifY19O/vr2l+QTrHw80lmZaWAfU4tVw4B3bhBBtKnN0McD8NNANDXCDAQBNiOTWcMInzvRmbO
	0QLobu9U8U2WyjekJqLzXpu+oqdZ37X0Ojio9G11yv9JFcRv6RV1XF8uwLTCY9TmAt3Rz87cHN0
	By/q7oCDICKISnq4q2rpPs8NIkV07dJEEVSAaOyTqtigSKKfjit7Q3BcvqItU92NOfPj+79s=
X-Received: by 2002:a05:693c:3e0a:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-37966192e10mr1235905eec.19.1794546887216;
        Thu, 12 Nov 2026 21:14:47 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3597550eec.14.2026.11.12.21.14.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 21:14:46 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 2/4] adapter: Add btd_adapter_get_conn_info
Date: Thu, 12 Nov 2026 21:14:36 -0800
Message-ID: <20261113051438.75230-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113051438.75230-1-kevin@simpleble.org>
References: <20261113051438.75230-1-kevin@simpleble.org>
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

Add a function to send Get Connection Information for a connection, and
one to cancel a pending mgmt request.

Assisted-by: Claude:claude-opus-5.5
---
 src/adapter.c | 22 ++++++++++++++++++++++
 src/adapter.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ea438375c..fa55bd87c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11628,3 +11628,25 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 				adapter->dev_id, sizeof(pkt.cp) + length,
 				&pkt, callback, user_data, destroy);
 }
+
+unsigned int btd_adapter_get_conn_info(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					btd_adapter_reply_event_t callback,
+					void *user_data)
+{
+	struct mgmt_cp_get_conn_info cp;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, bdaddr);
+	cp.addr.type = bdaddr_type;
+
+	return mgmt_send(adapter->mgmt, MGMT_OP_GET_CONN_INFO,
+				adapter->dev_id, sizeof(cp), &cp,
+				callback, user_data, NULL);
+}
+
+void btd_adapter_cancel_request(struct btd_adapter *adapter, unsigned int id)
+{
+	mgmt_cancel(adapter->mgmt, id);
+}
diff --git a/src/adapter.h b/src/adapter.h
index 583168f4b..3c777afe1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -328,3 +328,10 @@ unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
 					void *user_data,
 					btd_adapter_destroy_func_t destroy,
 					uint8_t timeout);
+
+unsigned int btd_adapter_get_conn_info(struct btd_adapter *adapter,
+					const bdaddr_t *bdaddr,
+					uint8_t bdaddr_type,
+					btd_adapter_reply_event_t callback,
+					void *user_data);
+void btd_adapter_cancel_request(struct btd_adapter *adapter, unsigned int id);
-- 
2.54.0 (Apple Git-157)

