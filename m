Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453776;
	b=CVwZxbwAwS/iePslLLvExyDopOkT8OD61Fe4MZ0CGanZYi8SqDbg2Gdj4Gng75MI5bh9
	 GOE9m9joRyiMB1vKhRKDz7zagyo78wer67J8q/ZTsNPrWmmpSlrF9Mp4w6k7l1GwNEEd2
	 +JA4wNEqa2K3h8+vy1tW9k2qWbOQfcV0SIzvgDJsOvpa1zKWWako9RD95aIZv367/hBc2
	 KV0PHX6KaiRH+dMMsykKJAcZMThihxssSN+quQiB2HVL9xy0C01f8SggZQjCmPxtOjfxH
	 l6dghER7tG1408CHBmgarplUORGPZDZ0iX5eGKGdyaxdv65ajmcPXhG/HFa4s+X8Ezg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p8WbxyOcOHSOBde3OiWG8axgKOzW4dESWWAK6iJuM+Q=;
	b=mrz8Xz05tsFIk9Mk0nXXZkZwnHD3+sDz2Une8ZphoR5yqcGkao5QmVyLiPhRpRhFno2P
	 0StDrlB6JZI13KopnrpcVyMH+wyvDjID0S8eLH/+qvYSUXGLQB+htTluZTDo8a/gtHpcN
	 L0Gmaoyd7T3xhhZbOFgkHu7bS4NyPBzOhuElXb1ORAj2+V/hB+Gfp716NlKoQsjVhDH3B
	 j5gH9BqYNMXeoAv++rfbzotT3eKtPqV6Lr2GWW2pzrU2blOiWR4CFt8yCqTC5w+/BBAyE
	 Vhq6FUQFqagG/ZFGtDkiA11nUX0YGpS69eiYsJxX/AJHJi2QycJqlo3OYdtzLeL+jWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=w9FaMr2b;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B214606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 03:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B214606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=w9FaMr2b
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37198ed3727so561596eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794453775; x=1795058575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8WbxyOcOHSOBde3OiWG8axgKOzW4dESWWAK6iJuM+Q=;
        b=w9FaMr2b2fEwpUa73tsjunJ5Az85nZA3lizHGMO17xCrZs7CPAkcdBsS3rcz/x61hP
         lHSb9zf8Ou14ZPJ/wolMAJHtgXK8yW6hJA6JBgXuPHe+2LMU1o7ziSTZYTX9wyb3f3e9
         LBdDurFwLb19mqyZ9N6p4vtjh0BsULTh9qSZX24BAVDUnMWpJaa8CVyCSwfor7gtB/57
         GlgW7P9C0TTQoW68DK5KmWHLdNl33+3at5+KOoV4HbfXY2U0eiwSJrUoy4grubPXaeLs
         oy4JjGlNLn1j8LHEM9cH/GsVCxqOYYQrcG9i7Wabiry0nNLLkKACoaiP309K4G0IJ/40
         mLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453775; x=1795058575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8WbxyOcOHSOBde3OiWG8axgKOzW4dESWWAK6iJuM+Q=;
        b=PHXOG+kR2FNIXJQEnC46eioLfNrs4AGDx9PfIZ4PySiSL3+95e6PMdFrWucpGohsjS
         XimA5u8LtF8zJ0xncvNec1LBznajaC8zEAD1EsLdNhwwQamjoouhST94qTrcAjk1C8Xf
         OvsL1LisxbWG4UB+WWdtzyiFMLuyMfCT9dWr/T+nqbVhGES0Ewu8syCoh5HDH/R2ULBH
         tkRURcp96pdlXM9Z+3dAUP2/CLLT3qOBCKUJAnTSrOVL/Xuv+kYFagjwbkXHqlz6/3J1
         ivHPVDQxw/xmqaalryWMssqioxNbhYWyKXUuSIdbdQCUR0PBY7S3elWAnbUaKjoNYHUJ
         hg5w==
X-Gm-Message-State: APuU4Z/m81BG4H77nHTGPzlXss01GS1a1VGMQ3RSVlmUQujgzCaXmklW
	OGggF+0xoPWp8zf7zjT/+6KmWw3OIpjD4j9yrdqS/dtlFDZkCHim0JYXhnr7slAWi1w1fjSDeOZ
	7cns4kjA=
X-Gm-Gg: AYBFou3Xj0pPXR/0yuVNEqoS0vrZVyYQg+Hy7bnvRBnc9Naq048ZZzaEEKhbxhVoXJn
	y9+9WSFqweN63fkZ5KG6ssS40rmH7maz2ss6WSsZtGxZOEBXamA0elzq1TveKe/f1pRnrfURJgH
	AsSEkSjoi9KmSul5rUwQgVUwyNjiIrOUjS/OvHZz/mq4p2tlSAcPmHLi/V49QyeDHPj6gDa4h7m
	WhWm7d7CnfSHWHkcprEWtIS5oOovnjl+22l9s5rogRcyifLFhmrrYnfgpTBxZFiqYs8rb1Eez/O
	BprPa/2sIZfK16L7CwL14vFcAmFRzy9qvYCajWxLTSHSLf+v5Es16yaetSP1+ap0jWuL7dWae+A
	ippjcfRMf/dikZoH14Nf0dfM8B/cujxWzdSDowBC/sE87GhC6oFxQX7uwqvMxLP5DG+se5GNWkI
	xX4VgMuhl9AyqwbMXyL7ywWXWekSsWg2ihpUTpK+Y/Pyszo/fu1HOIH5RqcOod+87Y/BiySgDuR
	ljYGMygGUMSe3neaDkhqihlCt9mf1NZJCDEUkBvq6NWoWbD2hTxcIOmQYqVg+6Q4MvKd1vvc1/1
	Le0P7BT4am2arm7e7yHhuSETVkSr/MAuAXudkuFL1Bx5c2kZr5IcmNdiIJFCIm9NoCKscED1ILH
	zFx0u3GghOe85PFlD8sApBkbaSHbnKAzBqcCr01UMrKUzrDpC5ZFRgCxCgGYRps+m7qp9WAo1
X-Received: by 2002:a05:7301:dd81:b0:36c:dd3b:a3e4 with SMTP id 5a478bee46e88-377deaeab9dmr1171768eec.3.1794453775240;
        Wed, 11 Nov 2026 19:22:55 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm21340765eec.5.2026.11.11.19.22.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 19:22:55 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [RFC PATCH BlueZ 1/4] org.bluez.Bearer: Add ReadRSSI method
Date: Wed, 11 Nov 2026 19:22:47 -0800
Message-ID: <20261112032250.37687-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112032250.37687-1-kevin@simpleble.org>
References: <20261112032250.37687-1-kevin@simpleble.org>
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

Add a method to read the RSSI of the current connection on LE bearer.
Device1.RSSI only covers inquiry and advertising, so an application
cannot follow the signal strength of a device once it is connected and
no longer advertising.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index 3db5237b4..589b54873 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -57,6 +57,23 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+int16 ReadRSSI()
+````````````````
+
+Reads the Received Signal Strength Indicator of the current connection on LE
+bearer from the controller, in dBm.
+
+The kernel caches the value for a few seconds, so calls made in quick succession
+may return the same value. Right after the connection is established, while it
+is still being set up, the method fails with org.bluez.Error.NotReady.
+
+Possible errors:
+
+:org.bluez.Error.NotConnected:
+:org.bluez.Error.NotReady:
+:org.bluez.Error.NotAvailable:
+:org.bluez.Error.Failed:
+
 Signals
 -------
 
-- 
2.54.0 (Apple Git-157)

