Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346533;
	b=e4fvKXzp/OIrrfCJUkKJ3nbdUgN67t34z0HN7ITLXaFmdNhbDE2mmBYyrILEn0jz1Ykx
	 VazNcmhqZhYysFtC7DAKd1iBWsWIs4ZuKEtjaOMAeUibHGpOJA1sdgiZIQI1xyanvNfUw
	 4hsyg/YpIgZzwKKSiYpz0Ip8Qlgg7UYFwC2mc6MxLCCyICtcPnXuyZiUn3xS/MxCpo6lR
	 Y6aFbBC21p6H+3V/nH7FXpY0QnG+0TdzjPADPJSyM1hggQmfqZrpL6TeKe3tnibccoGBX
	 syZnvI6aud26o5k6WRSyNMZcn4+orLGf9hTPFDYrZ2AL97+hjUTvOH26jzt5pA9z9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
	b=gUl0bdz/SuecWAfuyXn+dTKy5toa/zJLoHEfdoJ76getSzCexz8kLc3ASntG3WHd3SFp
	 VBCbIWgOwa5f+0lLhGXIYa9vmHICGdQjjRuP7lPkxkxZqsC6r38ullfGzeYTs+Ol3zCqY
	 ldHoKe/udedR63NU8jdsSTv4c1R/DU88hHXXkgSCdSrC9cTUU8g8UoiEdHP7ptTZWBp4d
	 xshCO2sXyzS+CDNqsnUGK2VMV9Fip6c7KWF6VRRunzE2/RVCzjwLeP7Vv+MOsfra58mN+
	 89iqZ5rsWk0cbj0deJKlQtpBAVc1mRokPq02zCBa9a4LvtGyvoIHg4iVU7WGJQzwyXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pU8f6DEb;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFF60A2603
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CFF60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pU8f6DEb
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9906034086cso611343241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346532; x=1794951332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
        b=pU8f6DEbah6/pN3Ir5pNfFenp7pm8uKq8ha7usVOFjPTczGYN0WXG1/cde6uuJGbB3
         cHRSS10s2OkM0kyUr/pevjON+p2BSyyB6Qs/UklnA/LP9bmkGdkBsjDrIFrFfpKy/cyo
         YD3DLeszoi+3mmlXBVLlMllU5gJjPKAE7RV5Csw2ztMcCH76fb3VBK/y1QES/vz8i9cT
         xtjNyBmEwcRr3vTAKHwqkIftFB8/MN1zcEkc3ybw7WSRImOr6UswQXnHwAVWGKO+gMY1
         ZsSLx09UOT3/RWZbcC14PC+syO4deG5nS6lhVRdf/UkwdSXxvnBO/b2JZrpIc6ZaxAEB
         aWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346532; x=1794951332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cRu86cbbp78Atizqq5ggRsbZJFjI2Eu7oH8XJQQzxrY=;
        b=M49YYbWYsZWsQWho3m1Y+WsILwEd9wQCHE4rpr+bFnsBtVg8PXO6z+VfzTHC3CCreA
         jPQra1rf6kZxJ626RIQWtodjmrStnoBLPaoY09BQ3b2bZOuir73aRPEmyvtAfTpK2lhv
         23pxCM/ry955d04fzdrHDJXRptfX0buKOKzW1yX6A7GdZ+hJ9xFOUqs85Nb+8K4uUbQM
         PP9MFggei0yO/qXQ1awj2oNU7eaa2BahVFRbYzQoSh1cjTBUCRd8ksYHL29m0wkxivew
         QiUEahqU0j/rIEuJwpItPpOmEPq3Aq6dwXajcDkvvl6+f0EdPKeu80KdZtBeQF8l3Wmq
         1wCg==
X-Gm-Message-State: APuU4Z8PiOAK+R+nemnT+RoipQQjNxhPlolkI9w8jpBlPnqz8AI8HkNi
	amQaqtlW3R9mKad+5IHE0YJ/nzvFoPj5GRPZzNAs32B4sIqhdLV2HdYMbArd4w==
X-Gm-Gg: AYBFou2TOROWdhNX7jMo93+A2zg+3hukETEb6KYIZCcP1ke06u7ezufyGBT7GydxyW5
	Jm39YK94C8NrSTzowJFBafanvYWySOD/QR7uQ+v+s/rcoo06OlaGEcplqIKQvrL3SeCGeKMeLPa
	NBVwS8arp5eyFc78P5PQ7TUwJqtdgV/S85jpG2pf0KiNV8zfrSFdxPVfaCWYpxHeuYVpmRsPbrv
	gl5/YlLioCNFJO3vIoVSYs/nnLc6+JJnVb771cRNE6oN3KCi++4dRTLthdM7f54LHZuw4piSYI7
	+YZAWU73E7pQOvR6wa3KqG01XSUPw5HLHXRaGG6rZu8acQMeqRW2agO3Uz4b4RfVvg/+Q6owvF8
	fOj0Gb1ajxRwBPJM17zK6uh4Ohuea856HZc++mgdsSkBpqOdenDtV3g9xmA0rV4+xX2wWy8Bj2x
	+RqzeSbKEZzSP8RgO96UaRsgK+cD6ylAf1tnQifeC43aVEQyzC44kkRuA+XcaOmO/l9J3i923BK
	4/YpPLTrugnQtqOy0rmdL1LL1k3EY47CgedcBxDHy7QCzKqGP5aW8WdS7ygu2NJTnJu7g+PVvAn
	xLN63+pnPER4D8Tqmgobk9mkN9M8C9DiSew6fIQ4czBNW3fAlSAR2M18jtH1pk5n/fcNjVvYbWP
	v6kMb5vQWqdUFdJv7Rq2uzx8xUwtYytDq3JtewJPYyEq5ZutjRCxz0x7VGl+FdCCnCuYCOgjdrK
	LgxRv8NOtnfKeQKoPw7uCmnyUd7w==
X-Received: by 2002:a05:6102:5125:b0:7cc:b246:31e2 with SMTP id ada2fe7eead31-7d4fb2c9173mr100911137.22.1794346532101;
        Tue, 10 Nov 2026 13:35:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] shared/micp: Fix reading Mute State from an empty notification
Date: Tue, 10 Nov 2026 16:35:24 -0500
Message-ID: <20261110213525.2942339-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110213525.2942339-1-luiz.dentz@gmail.com>
References: <20261110213525.2942339-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

micp_mute_state_notify copied one byte from the notification value
without checking its length, so a notification with no value made it
read past the value.

Pull the byte from the value instead and ignore the notification if it
is missing.

Fixes: 5c788b73 ("src/shared/micp.c: To implement MICP profile MICS service")
Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/micp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/micp.c b/src/shared/micp.c
index 98baff689fcc..7df8f8346f55 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -717,9 +717,16 @@ static void micp_mute_state_notify(struct bt_micp *micp, uint16_t value_handle,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
 {
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = length,
+	};
 	uint8_t mute_state;
 
-	memcpy(&mute_state, value, sizeof(mute_state));
+	if (!util_iov_pull_u8(&iov, &mute_state)) {
+		DBG(micp, "Unable to get Mute state");
+		return;
+	}
 
 	DBG(micp, "Mute state: 0x%x", mute_state);
 }
-- 
2.56.0

