Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795345058;
	b=iuXjYSf/Wb9WB7GbfTOHqx89WwA8IHcUIgS18nd9Y3Vb2Gbj117q2n4vaj4fFPJlzhss
	 hFnFvDvLVBNFWYq3T3nkfBcyrVO4KwOlccHXizbG5m04KSjlpIJWkYnCLwh4Z0PJzWQ+c
	 CFIOmOUbR37Zd3mcux/9LpciqUxceFbK6A52zIr2Lgg82aQwTYs7kHjyNIAJ5wue72wE6
	 FBjW5Ic7Y38+1C5urCXUk+Qecg2TdCofek0d8RhMpH/WWOY5Zb7MzHgMfmVnU5Fgc7su3
	 HcV8LROscAjgF24zUVp0fjuCJfjY4CVAvJN/apVcz8gW1V4DPFgVlkcy91hafAa57rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795345058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
	b=c9XSXvunPBoDn2algfWDYWVROIFYk9sCR71jAbHM5uhVNGXEf263tqUyK6hTxPE2pHMz
	 OxomHI57FGdlMPINhwmHeU4NB98ErU5MptFA7i4DzZblnPnUcCYQctjcCJ7jgLAEuXOOQ
	 8/50ZBE4JzjRA+CO5SRkRJDzLoBpA6FgU77Xkj/YYD3P107zv6WOXm2NgWMGpmTQt6fhV
	 kJR9lggtGP4pCPxZ2yPtH1EO05WXB7jwP3tpk/4thYgfniJwjlrRPUz6tIh4p9CSxLADz
	 oe+mJd9Jb5EAIivvNPF2Kr8nlykA20MwCfdGtcH/6cY14At3rKP9qCRg3Cmez+Cp0jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=J6J1gyu+;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB742606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB742606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=J6J1gyu+
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so21260005e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795345056; x=1795949856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=J6J1gyu+s571xVQa59DFzxOU5Gj85WgyFoPfhVTCbJgBEL21OME0WzpltE4H/veAcD
         TwIyUrPNSdOONNzOqjNO8TSucALmmohGJggS2dG1lte+XUotFw/rsdx+gecKSMdPMV/q
         CPye2VjVIf3SEby6TmbPZNO6mEu/Os1VWWhlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795345056; x=1795949856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GdLkTAZ2O3Ycy9Z1AyjkdYR4Zo8R86EDt88adU0Aaq0=;
        b=pbDy5IUIc0Qms9uYA6os0yGnrcq32zppt1G0iUCIdPMOYal3qc7+qLkghLexKQg7XU
         Y2xaYp8h3fR0yropzKUIzDkdWhr7N5jzPMIdaCnHcwuyBI/F3K1I/oSnDAJutfqJO3Sw
         RffQ0raTOQ0N3H5xvA+RZHteZzjThHlPuTf6I/XCo40U6SOF77Ho7qA5C/lFHTqP1/nN
         d6VQ47TrtPX/29tp7X0uI2b9bF37uPefGbOLf8JU8r1Rvenhf6T9/Tl21sjKKm01laru
         c1eoG5mLredJUR5+Wnj0AwkqzUouPQogzhOaEJ3NyYnBWR1+rdeHsCdX3PEe+lvG8Wjw
         dQWA==
X-Gm-Message-State: APuU4Z9dgx/ik75n9fjAb1EOwY4tYTLUp8MrqLhvO6OkZTPSJE4fgIIg
	+AcBPVvFN5usCZiACZKIuLP+2oIFkg4wx+7u2S0Q9Xy4mBN2yfvpFnaSRSXkJM4mec5M553cikm
	doNPU
X-Gm-Gg: AZFdTZd4shI/EJAl6m7K/gHMCyIGLS2PWSYEuYRJZLnKTdf1pbMqJv13lJqiFD8KsKF
	dJS3JnW2qaEGdGGm68sPT+VXYxkl9Qt06RuJE9bDQ6JwV8McMtEq9tWhUPJNDMztr70X1yriib/
	5sW+Wr9CNLFxOtw2pHJqPbUWiJFzdBGk602sBWAme39sAZbyAptzyLWyE0xuEsGGUly5kKWiDx3
	vW6lq1i079b/JH5SdVshnYVw1ds7Nc8a3dAQVrzcl+TsOKIrtwpzV1Q9qDBI2w3vbh2cnB7TA5r
	aPMmSGPAC/paSTUp160CmYIuqZOetDCvLeOJi95vJJ1trnMgXx2LIkgEH1sPiStIwCgRbw2Ko5e
	zOLCS+CzWQa/v7hoShfgwnVB7hI9f2nSkeXsZAbpc0HjrkA1PL0Id46X/qius/oXb7PIER6Ke5i
	dcxFSjcskly/yY6i6BWCEcdHmdCM607AMR65Dpch0UyQ7mmZD4fzFZgjgJc+Te/yBQX6vkNzsHN
	CM+SdeT4pw9Oz3ra98vixorbO7Vgs8eTXP4lRgGEMbT+6bzBzMfDk1fd4DeabCzn2b99kpZljlM
	UdEKRIkvbWmXQ3Lkn+NYyxw2IzXHatbO6qOI7TYZivDJc7GUcyRcEY7QXeHpTfv5UCzFWgE=
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id 5b1f17b1804b1-4bb88817772mr183458245e9.23.1795345056319;
        Sun, 22 Nov 2026 02:57:36 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399e2esm300138965e9.7.2026.11.22.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:57:36 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/8] avrcp: Fix not checking browsing PDU parameter length
Date: Sun, 22 Nov 2026 11:57:24 +0100
Message-ID: <20261122105731.799090-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
References: <20261122105731.799090-1-simon.mikuda@streamunlimited.com>
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

