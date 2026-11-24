Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522754;
	b=bO+diTpwlMUNjl/T9jGFMBUMgsjUMemVtwAl5zQD9urbzMc0uuE9CTuAOcofCvBs6TOS
	 3SDkX2dCdBEx9VTn/nnOTDo0bUPVtt8rr7NZlcqJORHiXGG5Hzd0/csRPFALSdQOWHNL9
	 A5UtjKHdUYzcELYIX/ugmC5F2I7zECEl/kp7/6MKQ7UmpzAaF+LkynYQs2+ORaXoJKTVs
	 ethoJI51oZvcSR06xvdWfSDTt0XREyZHX49dqTANdAaXvi4GpwoqaKmxIdEJR91uKdMZR
	 l0RySsSSzacWvo2yA6C3M6fp2gMwXe/1hk3FkCWFlBAUuNUQXrp+3Y0b9V7smkanh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
	b=ah6BhVg9pszbuEZDp35asH0nfkxViKPowunLG7546M6nMYYEUgewJ6VOKizLq+xdn4ER
	 jVrGsbs4njJo/sPVeRtf5Tb8CSpQ3JCL2wJDuFi3NkbJXl38AMwFzo3esBJiczD25NyDS
	 XcA5caOUD78kCVgs/Tf9CKKbZjdgz5KJM69dkIQICje4KrjKVNQDeqemqbkkfChN1ljz0
	 a17zilBd52XRaFH8+MXYzirup6b3tCs7xTaGqZWnx8D6QjfNqksTnLY97GQLUfQvT7t+a
	 B4u13Ws29YeQom/b9JUciuyaZJtL+jywkFdLI9EMf0Xoz35fIwwoRJUhASuOeHALxng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HelYAGig;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06E606A338
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE06E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=HelYAGig
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso32739275e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522752; x=1796127552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=HelYAGigRdFQE/mpKc0hlnmzGjTdGBcIxXksks+4nvEVN9cZ0xKDzeY+B8KhW4Zv+5
         Gu5/0mgYFyW79h2+2859kJnN6sJzC+H7kyFEr29vXXcWBU6qtGgkg+zLivHPONaF2GrF
         OhpgFr1CiKKiWyIWTR7AdWftdyTEM6mA/jpTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522752; x=1796127552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnadnBrf9KhjiDVaAi+tm44lxXvlPk5YiBx9cQB8Cz8=;
        b=tv9vJ7P10Fks0iBLyGWVbXk/8SJ1LlKhjF35wjrju0LjHLPnEcWeiP+bbThswekp7E
         ZQ1cvMg6mGCBLSuwCL7BYXCv9GB2j1FBrOIZ+E0d1KiNfYk0XGCFIRx6GgFYcdohZqNY
         xDQfBlKNRJ0yyBVOHJa/zQ/lJbGaJ6GfdJiRdnF90WidJtUTLHoPaTFusbQNN0jRIDHg
         tykEJsqfjZ2fafyQ0nj8VibRn57nGjsz4+P6bb5NYYdm/xqdNAS/f8I0/cXJicA+hvfE
         uUf0pxuly/f6bkUjwNMGLsDXqVcZ74qeF9UgfwRBnMpxMNk16zeSM0nRr7SSuhuIz1in
         HGDw==
X-Gm-Message-State: APuU4Z/A2cBmLyjrJufUKJazuo1WHjtrBS3fyx44FINEa1gktLNzmnVY
	5kLWJ12RReRpTVurisL1G72nLBxaUMtgNhlkI6nm6OCtJIIOZJFEMnXrVvj7KCklG+tdfR5sWLw
	9d+uI
X-Gm-Gg: AZFdTZdWQgT6VAAEyNrq4GOn7rsLSgWJQ3Z2UQ7Pu1EVHnkuOqq1xrMDcIWZPZpoIW+
	zXGQPaJSpzcRIMU7wRJfmJGoLRgpflFggu/dG54Qzo6yZIwc5RuD2Yioj7i5fxuWvlzuxzuENYi
	bJO0HWDddBgzIxUKHjhu22BHqiI4URFuEou1O/0GNln6h63wxuyssaRsmqr8TxekQOE1JeUq37T
	McBcLn5atz5UU9vxrDQtt0hCIqGI16MetPSRIBA8K3XKQd6ZhYiLBq77JIZ3qsHCxvRNqifROMf
	woyZJvwvqtUiodcRfo2LrDEmVh4e6dGIPUliedrZzUvNNVYl4s6W41YWm16R1Z+i8sPcSSr22no
	RbVwQ9DnkDfhvW4KXe6kd733FEOfdAW81mmfA7ghw6DkMrL4kVy22qnoGknzUthG39K2D/LY/hm
	Na9Ir/bW+lwiYo7/TNDc3QOjbY4+/FE6fLmq9fXuGXedbd+2D1igt7qBT2MPN4BgJxoZuSrDM+g
	jpQfjFpgjusmEOgeshtQYjL8DTne1imjkaXQKELt8HnWqYYH0jPjS8YQspNLtcd1Fe3tV/3aTKs
	5EWPY28VnswTSz/YGR2ArWIdqkMLh9YvnF1c4U9x7ynWIxthPw==
X-Received: by 2002:a05:600c:848d:b0:4ac:86c9:b09c with SMTP id 5b1f17b1804b1-4bb88811da9mr304516965e9.13.1795522751939;
        Tue, 24 Nov 2026 04:19:11 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 04/10] avrcp: Fix byte order of TRACK_CHANGED identifier
Date: Tue, 24 Nov 2026 13:18:58 +0100
Message-ID: <20261124121904.3267700-5-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
References: <20261124121904.3267700-1-simon.mikuda@streamunlimited.com>
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

The Identifier of TRACK_CHANGED, in the interim and the changed
response, was copied in host byte order. The identifiers sent so far, 0
and UINT64_MAX, read the same in either byte order, but any other one,
such as the UID of an item of a browsable player, is swapped on a
little endian host, and the controller then asks for an item that does
not exist.

To reproduce, with a target that reports the UID of the current track,
as "avrcp: Add browsing support in the target role" later in this
series does, change the track to the item of UID 2:

  btmon: EventID: 0x02 (EVENT_TRACK_CHANGED)
  btmon: Identifier: 0x 200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x000c
  btmon: UID: 0x0200000000000000 (144115188075855872)
  btmon: AVRCP: GetItemAttributes: len 0x0001
  btmon: Status: 0x09 (Does Not Exist)

Fixes: 9ab125a8ec20 ("AVRCP: Use track's UID in event notification")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index aff1c381a..fbd212511 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -791,7 +791,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_TRACK_CHANGED:
 		size = 9;
-		memcpy(&pdu->params[1], data, sizeof(uint64_t));
+		put_be64(*(const uint64_t *) data, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
@@ -1629,7 +1629,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	case AVRCP_EVENT_TRACK_CHANGED:
 		len = 9;
 		uid = player_get_uid(player);
-		memcpy(&pdu->params[1], &uid, sizeof(uint64_t));
+		put_be64(uid, &pdu->params[1]);
 
 		break;
 	case AVRCP_EVENT_TRACK_REACHED_END:
-- 
2.43.0

