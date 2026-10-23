Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795035;
	b=rOf9d9KD8j0JlRjz0nDi1mURN1B+F/iL8RBH8S7lIjDJUF+VOZA7SV9RZOYiziamvOep
	 XFtnLV/7FOxm3RJXfJ22k6T/wimPk4FxMGIjVdQbeZywtYEXXxF0wF/qHxYo8Dl6bf6dQ
	 A763y9s4GBIWspahnWxpRYQb5gRNqCH8/epqt9M3rqIQshfulFSQ0yzhMRnXW2o23Gf8O
	 4enNaTK+gPbZ4YXdoZHT+8vG1tf0NnpWmYSsaIffMvd+jitvrbsRsMGrC2RYIlQcyojB4
	 kK00piegSbyPIZYYIPNIkdYoLocbCHKEfANqEPsdKRIjoX2qdi1LeKD9Gx3qsvBfCeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v1aICwTeyhjD50UjbrNxlmplXZKwVSi9gNNMpgX0GZY=;
	b=4N9jDYxJlM0nhA/GVjEo/oVxXe1eNGkjDuRVJvWdYLCMIx/MHFuHeieKJ5RkKOyqXLCi
	 mun2s+G/bgGS2oBIKdnaU7QCgQRojxEM607tXXChTzeuM2ylY6qkGcM1PVbH/4MKb5srD
	 ec1MeLB+cSc0eHx2a8fbVE1Gh0EKCX/a7SkCtcg/FCAWgvcsgrvy2vVLbAm0c41l0Y79K
	 w6sNqf0oDk+PFybAePIp1fBLkXHJSqHDBJcDTtmN4vjz5Eu98GuRswpzoAtn51kaqanr4
	 z30FJmj9sgD1ipZXNfh6qudtgcrWkbPAItFc9NyxPsZl/JxuktRVOpjAQZ55dWqF1aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Im+mG4gR;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC8606A332
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DC8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Im+mG4gR
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so1511741c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792795034; x=1793399834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1aICwTeyhjD50UjbrNxlmplXZKwVSi9gNNMpgX0GZY=;
        b=Im+mG4gRhUub263Ve2tcrVgNa4wg/AKOxBVcOxGhHPd/APTBsgM0zYLkZbstC5jOWH
         NCN0S6+5cZKR6ci3PdK/L/7QomKUddJ31A8j4TNoaufjqBWjc6O3TFmKJgrnZgre6cCj
         yYCakSdcfJwdg16os50DGmCvSOQEwwVf9vZYOcl9JartABa7YkavDTHHoydooJh1Xcjx
         67SrQmNDYRyJJ2htK7g+i3jA1/EZn1MRu5IPlDpU9sK4xN9+c8/GGeCHMo4sqfTvqutB
         1FlUYx4tlZhrPYBgAmzF5QJEmseEHALggf0qtLW9/xptryiizZstit5hfYE+uPb8UT0J
         k3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795034; x=1793399834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1aICwTeyhjD50UjbrNxlmplXZKwVSi9gNNMpgX0GZY=;
        b=wIp2sztfGQ2V23k3DFRi9w32SDWIusDyZgbs2/TnBG7Qg/TaZW7NVQ4UsjQcAnbZNV
         54RKKogoz1ky0w2V5Cf3GZsBfdW/JtO/8IoLTwtKF7r9P3jjj7zF5yOKgamDGva++cSx
         006xBpHMVx7KiXKqtJuV4C90I4WchVSwZAFFft4U7eW4RiP6hglVGZOWUz4uMNlYYpqY
         oIZSp5gRorYReBDlytMp5kT2cpRHqlVoLiKFECzA2PzxNNrDEPvgUg1EailxR9inqm8u
         yv/Km8qStjaGBQJRvJEFSfHC3SmzyrGjzaG12F/yGm5wf8gOs2U/djbJKgkw32ozfyUF
         VqXA==
X-Gm-Message-State: AFq9FYKXMFs4M1EGo6MXkzKX0Y9m0Q2+5+3rnqdK1w4dTCvgS6wyQK1P
	t158tU/nwlrqFFhn0qpj5MmBf0PN1wKnoq0pc3O29FL/mdQzHJDe6d64Xh6DCy7DCbmTzzswf/B
	pUE0DruA=
X-Gm-Gg: AYBFou2+sp/FGq8as8AggHDiC5nsmFCirytomu2d0AE7SyXUdaCndLEpvPb1rAILq21
	TomuTQoISZG11aDl6tVrEZUJ/WytzE6P8JG/amWrz1fOB6i4R20YEEB/7Dw7FBiliimJ7caM+Vq
	s83GtPV+/WKEjQxnkBd3AFEh7uT9z2HZThAHHOddycRI2TC/naJunrqO0yXrtpY8f/dtkIvmeNa
	Lwnf+nbSS/jWJkU1mauv+BPkP4HdPVop/U9Zla8mqgQTdX3uELD2hVXAXH7C0RxTWnxCHyBvoTR
	eNPrLipSaLU2ZoffZtJ3OVCxYTA5793k9RRzTwYFVvKm0BXsEyFpxQtCHj11n8b0MhtutPpArQL
	EJ9NYgytw/EKBBF5pYDfbgocfTGf9FmPDnOGSHlVC2JKzNFrYIBUIPWhZMp12F1PF+Ndewbn/g4
	VpdzeEtXmBY1gOflKSWRqDk4M/Sv+3YGN5T9zMFYOJFSz1vQHVohCCx7LXIl2B6MeCaU3D9Vj4V
	Wq0vtiL48RtQWIeKVptCCrvC3Tct7uM6fsbawkdnog74dbevD2mbzOq7BXB66xCWWkh4JnQ6mDy
	ZwQnCFjS45UYfvYbkynjZYqA6AUJ0rVEXSbYFxV4MBcfgmamPSeYmZZ9yxeeYlqB7QlEmQRLD48
	CQC32GahHjRr/jfeS8HOqSg==
X-Received: by 2002:a05:7022:7f06:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1992afd1fb5mr618166c88.5.1792795034150;
        Fri, 23 Oct 2026 15:37:14 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm1327484eec.14.2026.10.23.15.37.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 15:37:13 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 3/3] test: functional: run bearer tests without experimental
Date: Fri, 23 Oct 2026 15:37:08 -0700
Message-ID: <20261023223708.76232-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023223708.76232-1-kevin@simpleble.org>
References: <20261023223708.76232-1-kevin@simpleble.org>
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

The bearer interfaces are no longer experimental, so run bluetoothd
without Experimental in the bearer tests.

Assisted-by: Claude:claude-opus-5.5
---
 doc/functional-bearer.rst      | 7 +++----
 test/functional/test_bearer.py | 8 +++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/doc/functional-bearer.rst b/doc/functional-bearer.rst
index 79fed9db3..de69b489b 100644
--- a/doc/functional-bearer.rst
+++ b/doc/functional-bearer.rst
@@ -13,10 +13,9 @@ used here, and **test-functional(1)** for how to run the suite.
 SETUP
 =====
 
-Two hosts, both running **bluetoothd(8)** with ``Experimental = true``,
-as the bearer interfaces are experimental, and with the MIDI plugin
-disabled (``-P midi``), as the MIDI profile would ask to pair as soon as
-it finds the MIDI service the other host exports:
+Two hosts, both running **bluetoothd(8)** with the MIDI plugin disabled
+(``-P midi``), as the MIDI profile would ask to pair as soon as it finds
+the MIDI service the other host exports:
 
 .. code-block::
 
diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 9d2f3346d..69eed15c4 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -34,9 +34,7 @@ DEVICE_INTERFACE = "org.bluez.Device1"
 LE_INTERFACE = "org.bluez.Bearer.LE1"
 BREDR_INTERFACE = "org.bluez.Bearer.BREDR1"
 
-# The bearer interfaces are experimental
-CONF = "[General]\nExperimental = true\n"
-LE_CONF = CONF + "ControllerMode = le\n"
+LE_CONF = "[General]\nControllerMode = le\n"
 
 # bluetoothd only creates device objects for advertisers that are
 # discoverable, which a broadcaster is not
@@ -170,8 +168,8 @@ le_config = host_config(
 )
 
 bredr_config = host_config(
-    [Bluetoothd(conf=CONF, args=ARGS), Agent(), Bearers()],
-    [Bluetoothd(conf=CONF, args=ARGS), Agent(), Bearers()],
+    [Bluetoothd(args=ARGS), Agent(), Bearers()],
+    [Bluetoothd(args=ARGS), Agent(), Bearers()],
 )
 
 
-- 
2.54.0 (Apple Git-157)

