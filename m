Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453181;
	b=zl7CvSBNil1n/alZlmqFzIMXwQ5118zxhl+AaCgvbdI8Sx/W/Gwq0ASDNzxJfu7ZyWiG
	 WOzvDQFo8NS9n/Su+o+DpafZkLRpk9DGAEL+PdoZHCIhCF5d05AJSZJt08ADAspG2XuQQ
	 vGQEdu/A7M1AweCwlCiUAosWmB1X9W7PHz0iNDU07FjaT/E8YZ2KY6RlRk9FSk2oz7Mh+
	 SrVI9nz68621jSqKjBc2YPe6/PmgENZXGtaiA3dzGW5jKQANEyGKfbeAaM2rh8qokAHBy
	 +KgUx8laM/I76BjgSpfOkFvf80J5ZnjVkoiZ9WGwfZWQzmat37ZgA99CeuWV3m5UPcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
	b=X2nKMa6yLqWtLtDwPC9bAjZcPn4NtcPKIXaut3hy/md0VfcdMJ5TLrNPzF8mOPpcZnFL
	 6Fxt+XdJzvLex3M6o1WQhydqyHt3uorwFWt6Pp0/02Egj1fMlqOcv7/8iHrBlVhU72fK/
	 8oAN6fadUVCKz4hd2IQkoe26/85T8yN8V+Ga65zIyhAPizYGL1wP9bMYhF9YTjxA9T+/u
	 5aX9/UU+n8Oe9tDAJMO0uZQON09CA7hjJmxNXf5EDO+qGhQK1u0/uE0dCCJeULeWKK6d2
	 c3IHA4ksPAzuWQIFv6ss7n6tb83H9tTS69sxBxX2AEXkjp+TIyxxK9EAWolIqCBm8Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Z6fjAm7c;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407A606A33C
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F407A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Z6fjAm7c
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-49465892f7bso2572304f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795453179; x=1796057979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=Z6fjAm7cFywB0fuVVR2wbrobxEEcNKiuAb0IopxzQsySkBVJo+rUgyHgm+85qZ7ajV
         MdfYFNMTDvFOgwy+mhscSdThKZBXu8GIVcbyezgkK1+UbB1ChKsNkqi0N2WVVbgKsAVU
         CZ7kQyezf+FwDMJKLvmQczUDJ978Fa5cM6n14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453179; x=1796057979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=P4jZNY/77zattd3M3btE8TPiVhoEi3D3O3QZsU3qD1bAx9IRD+mNi1TraD8uxl4ZVC
         sK/nYUC3Fm5t7X9QH0vh8Rb5vUW4Sve++/1avVYfgUPwJktxehDivjI1CVcU6hH8Jlsu
         5Smh2/bOf6XEuukzIiDFyeQnD/pxB4R1UT4X0zlMWghRgO0cEvrc+YXo4swjpqmvItUP
         uGwosqRSb1gkv6j1sK6dX5/ZBGeB1r2R1jdUzTd5dT+OhrWJ1yJgRXu5VB1kwfhA2IrQ
         meQJP6SQ/to13MtgvG9WwLh0jxc1IvfZwVev3iWMY2PgKB3NEZTBA/XjAlKPTIAPUnuX
         a4eA==
X-Gm-Message-State: APuU4Z9i7a8W89PHW/Ulm07ZB8NpiWMA48r0GpUjIWPPWi/Km593Gyik
	911KrzD5ExHsZClG5oJMJsdmX4YFX9HtkXcxGywHAWvSjOb28TaMfdIcL2kMdn/ttaQfzYE9wlq
	oqt47
X-Gm-Gg: AZFdTZdcSK1Tn/CmZpPm/rF8xVO00k7pjSCxtaR8cwi8AM8u9PLsn5iYzhh0waEKDgQ
	7W65Y6dD9mAkomAIue9bwfyLp7MTaBPgMYLtuWScWjYtrXugj7cdkemoyT5I1CZU8Ao0eTDlsIm
	++DWBFR47n/pbywjcT2UcVdn51tuU5KwE1wn15NSMjesd2vMiA+YWLNOlK2SO2+k5KUHV4cIS54
	SWBxLjJypy7QBwaDv1/dvo53et+v4XF+ct4RncIUR6Zh/esaPZlqcxGG0Sf8lkoNy2D7V56/UFF
	3sgpzlWnsSr1pfaqQq3VQrPxvhCI9kVILyDHtJ7goqYPu04b13suD/vHtCB66dk58MMz8wqjaz/
	eQsj7n9XbKv2E5ZBD9wnEngx4Y0DEq89ba2RUIIL1uoaqiruveJyXkZ8zMRmsVXUrb7bAJI6iQ3
	cDBw17cCq8bMok81vv4itxkfTX54CsW4KItMHxrbixHvKyCdix1Mh6dRWj4PrHaBDIYErmb29gg
	a4J/wPxcGdotN0IxnPeO8c8uzzghbbjcW3Hwnt9DBc5uVYEXYjU8BjB6Vgl41rRLNy4mzGFEWd4
	+3XDEHIYx/li04rgXlPXVDpYCrYGOV+XrTsbdgNaGHVtVYLy
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4bb88800134mr240974385e9.11.1795453179222;
        Mon, 23 Nov 2026 08:59:39 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm289748185e9.2.2026.11.23.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:59:39 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/8] avrcp: Fix not checking browsing PDU parameter length
Date: Mon, 23 Nov 2026 17:59:25 +0100
Message-ID: <20261123165932.470612-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
References: <20261123165932.470612-1-simon.mikuda@streamunlimited.com>
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

The parameter length of a browsing PDU is not checked against the
number of bytes received, so a handler takes the parameters missing
from a short PDU from whatever the buffer held before.

To reproduce, send to the target a GetFolderItems with a parameter
length of 10 but no parameters. It is answered from the zeroed buffer
as a request for the media players 0 to 0:

  btmon: AVRCP: GetFolderItems: len 0x000a
  handle_browsing_pdu() AVRCP Browsing PDU 0x71, len 0x000A
  avrcp_handle_get_folder_items() scope 0x00 start_item 0x00000000
      end_item 0x00000000
  btmon: AVRCP: GetFolderItems: len 0x002c
  btmon: Status: 0x04 (Success)
  btmon: NumOfItems: 0x0001 (1)
  btmon: Name: Player A

Reject a PDU whose parameter length does not match, as the control
channel does since commit e2b0f0d8d63e ("avrcp: Fix not checking if
params_len match number of received bytes").

Fixes: 731aec9cae63 ("AVRCP: Add handler for browsing PDUs")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 2f214e982..95b1d8c47 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2164,9 +2164,20 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 	const struct browsing_pdu_handler *handler;
 	struct avrcp_browsing_header *pdu = (void *) operands;
 
+	if (operand_count < AVRCP_BROWSING_HEADER_LENGTH)
+		return avrcp_browsing_general_reject(operands);
+
 	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
 						be16_to_cpu(pdu->param_len));
 
+	if (be16_to_cpu(pdu->param_len) !=
+			operand_count - AVRCP_BROWSING_HEADER_LENGTH) {
+		DBG("AVRCP Browsing PDU parameters length don't match");
+		pdu->params[0] = AVRCP_STATUS_INVALID_PARAM;
+		pdu->param_len = cpu_to_be16(1);
+		return AVRCP_BROWSING_HEADER_LENGTH + 1;
+	}
+
 	for (handler = browsing_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
 			goto done;
-- 
2.43.0

