Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522752;
	b=ruDkkw/xL/Uz+sqvxFbAwRZLj1+K7FPM/08oDIL9NjG1cwzRClZFT2AXoMi9V+zkvgfa
	 MVXdYzU9WB3lFXcj8PF3ulaX6m40SZYp4t/L0eoiVO/mzXKYfJbfVWpXXeUFR7Ar4Lanm
	 DlR+HZwAg7SL10hjSgDKPcgvWE/M2N3m+L8llxpU9xnS5Zipsdd4dNOYXHlzagu1ZC0M3
	 oc7SpCTcCq4rwte0I2Q7HTL9N6z1oDeJ6DjmCAbQc9CZSUJpSnvZlqRZUyjakcbBqRGHO
	 6twon6K6me9z1pZTwCojhpQA+bl3u5fNg+2mdvV+UxLM+8SSnORHyjzsGys7ePfCEPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
	b=MBk+igf1GXMXmejgE/7tFopHracLHCcyyVNc9AI5F4bujdQvJzF3CtQJHP9BJwQNX3Am
	 qJbSD7wadXfgrcw1PHANNgI7qaOKFoapCK4qrol22bETuL5MlmkydzwbZJ9hpzImOIzI0
	 pkrYNTFeJ/Zcow8ngww4lvzS6z6jSXVfBaX/m8P89XkzDHF/4jHHysBtAOC8IaAq6beDI
	 uzRQCHn4ZvGM72QB3zkNpjPeRT7y9T2HHrtm+Myr62Cws5O2WTr2WXTffrf+AOIo4WT8o
	 9ri6MReNu2Fg54BI7lg9tYa/5mGUq90MT9GdWFFKdQbfLPfJxyVTYkK/5KAj2e6/wxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=E9S8wrVm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35546606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35546606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=E9S8wrVm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so46184435e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 04:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795522750; x=1796127550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=E9S8wrVm/eHuSAYezurFFXtbJNVu6Mb5pTgLU5hDk0CPaoUCB2bvcCpS/4R2FXHDua
         hkz67HlqbRx/hvYxh2VfyKUHWAagPGZg2U8K4/4NzCmsRWI/x/RjqlebPE2z7iVxNx9o
         wnxfARM8Zuaa7iY1x8pcHVba1GXjzq1l/ygfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522750; x=1796127550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=E23U8xTxS2nQh2jXTMbzjdOeaDnZE3tfgUl8XGMtC9K21kDlq8bgOFvbGz8HqK2iMn
         WjdJgZbqrcVI9xgn4+KISCOgd5X/86XBYVCmOpDeDDLukDPCrLnoiMv0JIUrJIBVsB0h
         Yf96zTmGDgnaKreD/kEN0qodxcmrIc73DbmObzKSpc5OgDLY8/jC4S2VURRfBzKr/QBG
         17PKVkfDLAtDjmq8jmAPXPt+zU6HtJIfxOokzmQ+uNto7JPdlgy+BESEBs10Ibi5iGVr
         7i6OgCuReeELay7QiRfn6meQip2yLguATa6fdJvagIgwCgjaNaPlyPnWR4Lte6IsPhps
         9ZXw==
X-Gm-Message-State: APuU4Z9K13MDAujHCaGevpV9KziQinnsvwFksPxK1VfgtmPm1OfGbjV2
	bK07JLE+kLTRKmANKypCxM0tKObJxIAvqMM3oLCeZaCjQUQ5B4M3UgxMgj5tqHC1IKgoPuMSa2w
	OjnV/
X-Gm-Gg: AZFdTZeIEq+F+soO7snyTCfbZ7bszovOv6batkraEiVCeKevKIvAF5UjKe0EM8dY7Qo
	crPCTn1XVnPxPC3xEysVsE3HT3mHiVhYDQzDQecMUYjhqYhttbdWDxcx71vJyk36aeMUbUl2qxu
	YvYalhU1GXm6Gh8NspZVsjOH8QFDQcVLlnTrnMlfE7l3Ema1oXObX2MyYG2nOGGh7FkX721EcUj
	svU7RVqUzMVRLsBKl2o5BNlVTtMBZ/sIQ7Gv7j8HXOGIVs7/cL1R6Q5ZZPWqgFJfV9ZFPYqRftN
	b0saXRg2W3BZmDWXSWaXIGqiAjS90iV8563RvciqTwzzZ0uGlUGC2KJAuuPsC+GcrRLWbJa77iA
	v621PGEJn32IjMZXJ9RFMo4KAh4KIDaZpPIjz+LNsp2GRNJjW53F/EQXBvbANx0gE1LwTy2wIiH
	C/kCb6mBzBPXbcb0l+Go2oSoCuVeTJNDFcTDVGfH/A1Yw7vLkreQ8JR6EpzVmmPNU9i1gxCt5Yc
	7dMe7vxUgzA4C7BVPW/aoVzJqELhtdmy3gGE61yxjp0JjCzWnntejtkByrchmjV9Yg1vw6KVXKC
	cYIJlukZszvTNRwgBS59MDCtF0LcCK5DRW4C6xJYk0A06U9eNmY=
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4bb88938a62mr297429795e9.28.1795522750478;
        Tue, 24 Nov 2026 04:19:10 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm391427775e9.8.2026.11.24.04.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:19:10 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v4 01/10] avrcp: Fix not checking browsing PDU parameter length
Date: Tue, 24 Nov 2026 13:18:55 +0100
Message-ID: <20261124121904.3267700-2-simon.mikuda@streamunlimited.com>
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

