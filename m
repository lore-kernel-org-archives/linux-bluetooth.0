Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512523;
	b=ftoiTD7lhNaM7aLC2zOD8i55ZG7AQ5vPjH+6jrX0ajq1dWEECkzwqnT1/4RmZs2xqPj2
	 d2fyEKb4uINdJPbEwsFxlNibYn4ABO9ZeMGzw1Eoq5iDLqa5ix2twl5IYYu1ANdPR5gZA
	 8uJ0cC58M7DBs4/W45OAQ+jca9Wwfq7vEmEhAqw67IBgmcaQgDmaom15faf+byuqsSMC1
	 mf6oXOa3IHU7Bg101qEPFaKPrY5n0d5QkVTWHV0bbjlqnTKE13UkVczR/GMwEwhu7LlwT
	 re7fO1syEMlaQ5gYdgmsuec1j3xHUBGumT48NNgFE/8giFZD+pk26hUtCH3mQOxz1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
	b=QlkaS+AbonUO8xTujxsERO1IAZTnAHYnD6kWT9VOvyYlyEiDrKrQrMbyc9hGHjBvcyqL
	 +m/twsO2EyKcGDZNxJMQ37vy9sxoO9KMonNbeGPUelb8fycyM79ZrKcZh2lkpi3u7QO05
	 fn9djQ/Cm0wTshKmbf5Q1OKWfAd/RCsCyzSFmdDLRvFZ4E1NaFWf0+ldMeBUF6tXeMYsS
	 ewIXDeygij/95Ux6Sg3Ra1Jbc+JkwX4HMfDSuO1QtlgHPpCjH6z3Z3piwGQrUSc6LwvaE
	 qzV270utX1xZ6PKor5HXcDHwHrcfDBE2UbL2b3L62/tfUdNCB2s7brUm9RhdtfIILdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ck5YNI0w;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD42606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 09:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD42606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=ck5YNI0w
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so3488439f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795512522; x=1796117322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=ck5YNI0wRM1ywR7v/FSe0HKh2qsSLNI/GdCdXuY81Upht6XR+whlrAj2D3fUxtaY38
         jQdlAFG7t4XIEX2E85pnpaJSw7d6bZ/+I8ByaohNFTXniVTFdGYNHfR7KrwH9xl4qDT4
         F72hdlV2si4bAqhPLLjNBmzs+CvfwLydJaPVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512522; x=1796117322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ng0JWsIQGAdG89dHvGYT0Auv5cwYct9D/A6o/8HaVwA=;
        b=fxRXgX7CmbEEwyjmUxElQN9LEB2j/t+jYSxfoWgVhW1f0Kb/uKD75NuyJGPybd8FL4
         wa9ikwnjNxViWDRi+o6a+rVK2EjkZvXFVBSSlf+Vy/tWCFgSwXn1GbbAiW2/J38fZXjz
         2afU4Otb7A05s41LPYqIy4jss5yPyplFpCx4wYpwWj/m6icsdjtzZTbC4XDz3DAfqPVy
         s8MJT2IbUzQL64s2Wf4XEDmgGMy555PsJeCCWA8dHc3nFi2DTu69VGq3wcN7dtyL7uXl
         bDr1P0aoNEbm2bKLdFiRnTLViNQvd2XkxhlnLIbSVxiqOrGOhssnt7N2xr8yl7XIA0z/
         cYEw==
X-Gm-Message-State: APuU4Z/TwX5zgJgJTkpC+pEyp/vxwef5W8f65euUimRZYB9h+3hudb79
	jTCCSFRTGawAGW6ObgJR1cSRcPmrcEOD/MharpuNfi7ud1YqFRGlCp2u1i6li69apryAtdAbC/b
	nR/pw
X-Gm-Gg: AZFdTZfLWqx8n+ZJe3+NdiqLnnhmyHmJeyB2Hrdn8aRj5njveGIF0JBY1R1MQdyRRTm
	ANKRKF7d37ak8V9/RmPZB8/UPWj2q9C3HdqaAq33PIWiF2L21OBCN34V8QWARqVgI+SBLt0wxyK
	DeSSQVMNrbQWoiL/ZHhkmf8e3XI4paRFit/+a6dhHQSyXsKlwwWbzyjmd7v1/gNZgwQhWAYF23m
	cK++KjDXMIJbuzUFpNUvCfXKpb75qJy7nqjfpI1kAMfxysB5NFjGRpW8ljDQAbzQdoU5dKshbWg
	tk0VbFntrz9j8od47XjPY5+AuS1+CW35Os+2Mb4Pix3zaADNnWfs+Ny7rByiU07ffRg9sH7TA7y
	BqEKbhUyCQkdLCTV9dpUpnwqmrfT6NOw6sztRtOqSU7K1h2ArtAJExKRw76XNQR4+m42s7eVnIA
	bhu5YaspXplF0qUUlzTiOb2I0QMLsTNYG1OgQR5faICwgY2b4R2Mff0JxVGmw+wvhKkDkHxBGul
	Bx3XnHC0A5AU8FgJXrSHD8Eyt4ZMc2wunXg/OVtz0BotVLEGYobIcA/YJnbnTmkI1jPkpJs1WNg
	9WYIPCt6T4Q5zebZAvquVw+O/jCqlLpYZi2PK5D1jt2KpUiONg==
X-Received: by 2002:a5d:5f08:0:b0:48c:4442:54e with SMTP id ffacd0b85a97d-4abb225f69cmr24908969f8f.30.1795512521894;
        Tue, 24 Nov 2026 01:28:41 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm27870362f8f.59.2026.11.24.01.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:28:41 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 02/10] avrcp: Fix listing media players up to item 0xffffffff
Date: Tue, 24 Nov 2026 10:28:25 +0100
Message-ID: <20261124092833.1191053-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
References: <20261124092833.1191053-1-simon.mikuda@streamunlimited.com>
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

GetFolderItems for the media player list stops once it has
end_item - start_item + 1 items, which overflows to 0 for a request
from 0 to 0xffffffff, so the list stops before the first player and is
answered with Range Out of Bounds. That is the request the BlueZ
controller sends, so it never learns the target's players.

To reproduce, register a media player on the target and connect AVRCP
from a BlueZ controller, whose player never gets a Name:

  btmon: AVRCP: GetFolderItems: len 0x000a
  btmon: Scope: 0x00 (Media Player List)
  btmon: StartItem: 0x00000000 (0)
  btmon: EndItem: 0xffffffff (4294967295)
  avrcp_handle_get_folder_items() scope 0x00 start_item 0x00000000
      end_item 0xffffffff
  btmon: AVRCP: GetFolderItems: len 0x0001
  btmon: Status: 0x0b (Range Out of Bounds)

Fixes: d6bb0111b569 ("audio/avrcp: Add GetFolderItems support")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 95b1d8c47..3ab7b6d7c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1997,7 +1997,7 @@ static void avrcp_handle_media_player_list(struct avrcp *session,
 		struct player_item *item;
 		uint16_t namelen;
 
-		if (rsp->num_items == (end_item - start_item) + 1)
+		if (rsp->num_items > end_item - start_item)
 			break;
 
 		folder = (void *)&pdu->params[pdu->param_len];
-- 
2.43.0

