Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931395;
	b=W4qnVYawc7+8E6AU3HHr9QClKaQsOnskyOsw0E5oNeJdsyOCs9VTTOAEnfhhfHILgjbc
	 SRTV8M7gDK66QVtHBFg8RYCPY7lan50x1R/hgRSeWCGX7/GoLANEB7DcBwXnKX2HR44Lm
	 VISorGnlIN9DSkRHX5zyCVKy9eSMZ9Todl/CdvtoICKI9wqhlKk9L2s4nEJIdIzZkuNHu
	 FwAwoPzd9XkxMikx5WlzWz7NaHhaGzV8fcQP8Ie4YxxgJskEMRfvdxyBq6VrjezXyMIMb
	 DJGElsEfN40ZO/ydCb85eZEY06csI3A+FeIaugJL0cNvkP62mEapgSUbS+MonYx5+gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
	b=bBwtM5+48ok6hxCO5lg1WUxe3uHJosSe5S2AIONRoC+/fjnCH9JJboJpdKrtQh+tRIqO
	 cOMjlPMYaOxDqhGlT0S3ZG/+frtHp2DrwBsOf6AAjtAzWmPA02ZRyde6Zm4MnYf76DXRf
	 RWCYlU+T75vBIBdz7vKfVBGJZ/zOvuehBdhd/AxBipyCOv2jWDRGOsZakJVvQkaQGOvuV
	 bA0TWxzhQq6z5wZEgRB/tFgnX/P30Nn6e1fNNW8esab43NRuUGX46UG65f52Edxk5JLc0
	 j2HJ9X+CxVjM0nIx0abKMrnBNyijuVgvUATPbpbV6rafNshfWt74AeLiJ8x9R+gBwmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Egv8/p23";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B53606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 16:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45B53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Egv8/p23
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb609d9bf4so27855e9.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794931393; x=1795536193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=Egv8/p23DmpJ7dWGcfNe8ApL7jVxJOaob1MVWhWxate8tPI269U5Itsxlvbpwe1GNx
         isUhFOvVM7r7Qixv/QsTtqbJ56iFDyaqS6mIsiAgFBE3YJov+uHsHayiuW/Atrekm7WA
         M76ikSEj1AX0BxLapj3ah8VSPDqajVgGpDCf3mZJXd+4tbUTe1mHHm7hFzjjOIyYKJky
         qIOEw8GpAobLV5g6TVrIGF0IlgkUvArH3QE5bWE+1Uo1JczjehST55PZdfkiFXOphKH7
         MNTjK53/fTVhVeB2ZK2GpN22Xdo21Iws+IEBP05z4pwS545ybC7CjXsVcN2TXucN1eAm
         Kr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931394; x=1795536194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZCctNQK3cN5qV2Hx2SOGwUfxpcb935adt9+raA2U5A=;
        b=QzK0eFLaHN5e1AwY+/QiWVo4hFbRKLmKIRPXx1OOx9CNeZL/OvxoO13EIaE5GY3vLZ
         BnUcEO0Nt4PPdKAO69CvC7IJI0CmCu3xhL+VOPUyVOzRu3cu53+tjU05gZ5jiFQs4zfN
         SoL/TVZySUzfsNLBpAp0it0V2dPocLuDrFpxNHI1KNDbDNDjqr7i2+P/n/LWknnTrywS
         N2XrSwR5hMg0axl0tUIoCOTNxtVEpcu0yopHcjLEswU6vzA656TOWvnsT/CFJTW7CJlt
         6vojycS+C8plc200cdd76cEBBD31M12yg9xr5XQpkeJDjQgYWFAeoITCzh4KdPZDDhMc
         9Qdg==
X-Gm-Message-State: APuU4Z8P+A448iEGITB9yPzc2Oilckofb5oVmjZQHFP0L6TkpLWueGRI
	77DH/r5FGFYHi03F5wZPxM+zxQDWrFoKHRjOw2FcfWmdUMGg12EX3c0crNTiuQ==
X-Gm-Gg: AYBFou05yHocjwuo88fWiRb4crErlsselCbK09tH88y2gQrmxqWUr0LLD/xPdQ+AV21
	IHipL8OLP6SZKqn2WYuR34pRcdUtDljkrqw7VSsuklrP1lIfgwJsWn3GarBWvc6X9pwf2Joxd3Q
	JWbUeYI22a1oT+48Q2oLa5YhRkEbzIY+ZoS6QYzuG1ABCiLm6eIWmfIZkSyPlrtpBeK22VLIcc3
	V197N2nGup1KoYhAIaTrqkp/Plixff/NfjDUwqC7eSSjrDMnfswd60A+Gr7W02sAcm01sATTgw7
	HI+DQ4jBgRcf1Bet10e12+B/oSByndHASDHAjzPPNu7+qpPJM+UxNu3QsB1yC9x7fJgdI7zQ+ft
	Se0WZje3gKCixsYuWssHrnj6pnQ2N6EbGDiVODjdU5+iZKi+PJHd8I2Lz3P4hby7PpLEicSmw9b
	oj2NJoHRyRQ94V6ZgtamKv7FUTAze0iVJfiIkW881tt+j3TzKO2yZadzs6wIzBNT3yej3cgCpSZ
	xF+S+YVKLyxDHHK1mzRMwLV5Jboz5nSypzK89m1Oc8MQOcIKGlXtbGyD7ncWoNBdpCUFKydG3Wz
	VLYqfhSfEOoJEDdnDD269cTxKAe6Iqr8StOidevulZCXAPYADA==
X-Received: by 2002:a05:600c:3d96:b0:4ad:5ec2:d3b3 with SMTP id 5b1f17b1804b1-4bb55a35c14mr283586425e9.1.1794931393414;
        Tue, 17 Nov 2026 08:03:13 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a2:d500:342a:4be9:726f:4a50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7839c5c3sm75158285e9.12.2026.11.17.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:03:12 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ 1/4] monitor: Fix handle decoding of status_handle_rsp
Date: Tue, 17 Nov 2026 17:02:37 +0100
Message-ID: <20261117160240.222556-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117160240.222556-1-rolandschober1968@gmail.com>
References: <20261117160240.222556-1-rolandschober1968@gmail.com>
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

