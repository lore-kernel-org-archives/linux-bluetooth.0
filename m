Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939719;
	b=GUkNU42M54UEmLTeDndSV+u2kT0+v5uJ4CC+l9s/PdKlhVrFztCKB1/YL1e2AGlYDt7w
	 xFsbpbowwcx1nx50RyRInDSImtXKcQxWQYcMp1Or5Lr4e14uoduMHHHiu6Ey9TdKECmVS
	 EoOM3K14Q4Mx9Pim/KSLbsQF472FNqwgm/x0YBa0hlHun6w1AYLWtMUYFHn6rIVRgpQIM
	 aPkT9/aDa9Cq7tjFb9693yto5GZm6Jrvef3KwWcN2NaG8MAq9B0vfbApYS5CyW5GyFUL1
	 qNNHRb8YAkDdLD7OIJfenKlNj3GogFrkBdeSbWusesJ6WxW2SW6FIqCfQhVExumviIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
	b=5BnZi/92HPHFyNg9oQPfLrhqTAejfBY/Ovg8TrfaOAFsPbPcD2dvWlXKkbAaIO1myru0
	 v56uis9siqmi1CS7WsVadct3B62r/IkSMZ8TQbccqOBhWkr9ngRn+JG187hhmgIYyAFjD
	 376FfjP3Q+ipPdj+8V4a7G+NcYSS4pAC3r1HfktYt1GCjMbm1D56maoKNmooVpu9QeYxJ
	 5yDXY076+ODJyeeHDKnpQdSj+CBjmqJjkJwz3U9jHNrwe6+Bu/MWkZ9wC5qpTfhYsoAc3
	 DFjV/WLeL+I2aQCHuGO9BuKxmEd3eD27Y+PzAeK1ZTAUIh2xW1cb+T9cPQcOur/mdjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Yxmu+RQB;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA95606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=Yxmu+RQB
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso486817eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794939718; x=1795544518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=Yxmu+RQBPNagg60yPmI4t9ognGU5DqAVTHkspCJlXCs6kW5I6UPVsXah9dDL00RqHg
         dJk27YAzQ0e2Ni0vrOa5eLXbfqTByihKsHbIejIwo2x3XwSP5ml+G4OsOM4Mtgv4yx+1
         +7QovPLAE5q6K3s+NBywQVbSbGLHx63FXleNOeDXAU86rDAMZGbm8FKuT1xU90k8NQkG
         XnHSJZmQsqFZBnttIqh8xjqP0JPMsvsPsRWTn9cHxiqcRrKe4tyvMA1oDM9THpVc+7P7
         PE04Yht54vF5Be2TWJALDits8MGwP7kD7IB3ZTInCyaROOtiu98RH7lanYi8u9X00piW
         OZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939718; x=1795544518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=MNOo+GGo05ujq2xHJSgbucfW2hKnMK5sbMd4fEPmrTKHwVjz5TGxBvoN/FVCY5hlUu
         nuUFcEMBGqN/WhagDtP8ofS24vg3IXzOLVROyyKVtV4YZBHCO0wJ6qjqFub6DJ/2c1tw
         toJbp+M4Kj0QCTUHQjTLyej3tvGXd8Ko7oKHBxCF2c7lUMTYKkidUC3xuYrlTasLvJe/
         WEFBoy0BMCFJ8B9m2xuNvGOsJPvt4JriCw03ROxwcK7XYTozgLz3vMZtJgP3kyLFnIkK
         YJ8jsSpwC6ERFJviRdc/7bd047Gk1u3P/WjVrjkEIzaeizEEKE0NCk26jbq1dsmRXEju
         tWgw==
X-Gm-Message-State: APuU4Z9IKpmhtLUIsNrsJPqtA1WmWQpe6fwN9jgoNzvMYw8OkXQt7rNU
	AJgUBpKiJVZKHvO3Svl4fsjZd/yMF2BfRPbva7TGPKNx9j9PkCWGospr75w3PJhBEjjtV03uWbo
	vNvNGKKU=
X-Gm-Gg: AZFdTZcQwWX7/JbJGkvdHA1Y1z8FFs0KW0rbuFggrrH3YYedBMZ8zigGAzcC64yrvxs
	RQWNggao1G+oYQEcJ9v+REWzEoebvT/qKbhj9wHLpnBYtxhpASRLIvpwK40SVQqpLiJMwGo9wbS
	banHuxR7tovvsNtoo9oAD17MWiWMvue+sIh0Kxl7U5VUYfOW+G//zyFdk6yCjwEWoGCBaYkvqWt
	7Y03K3keSissC1XbcTuS4v7EXqcUbqhAptS8vH/wblDRQoooJXWBTABhRHzEfA+pfD9CE4/wqSQ
	NExS1lvJgeG67VB8RcjL6d+na5hRL49zjF1IC59oKR/YTWLSqo9oIOxSiGVj3HYEyDUFfRCvzNM
	79V2w6wJW48SUxF3phkHtNiJ8577ubc2TXVyx4MgYhCwjFZ0jrj8ShtWHSmsDMO/yobdhK1rOVW
	lwvdnAEV5e239MNl1mD3MhGPy5Uac6UdbQgU43XR/pTU15TKtSeO5Gc7bhtkWeCD2QWLxOPRhZl
	MQ838Y7KC75Xfle4pkIMawsVdao9ISfyhZBgOUFmXgh+tKkXuSH1Rhwm2XuvArAQkxh3Uhcyfix
	rV6GPVGp2W4mH0jaoDCBpJ6xO36KAz2l0kqslSlBvZy5ZdBMkq1PmuqFggbLLA/LU45AAq8Np2r
	CB1gRa7PfcVvJp6l9o/dAxLahWpl1N7fCWMtms9J83iOVWp4mLf942oIcOr6OauPE+49sy18=
X-Received: by 2002:a05:7300:f792:b0:37f:4fda:1a85 with SMTP id 5a478bee46e88-3828016ffa9mr221066eec.16.1794939717779;
        Tue, 17 Nov 2026 10:21:57 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10503213eec.24.2026.11.17.10.21.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:21:56 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v5 1/4] org.bluez.Bearer: Add ReadRSSI method
Date: Tue, 17 Nov 2026 10:21:48 -0800
Message-ID: <20261117182151.73722-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117182151.73722-1-kevin@simpleble.org>
References: <20261117182151.73722-1-kevin@simpleble.org>
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

Add a testing method to read the RSSI of the current connection on LE
bearer, for diagnostics and production testing. It is only available
when D-Bus testing interfaces are enabled.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index 3db5237b4..803adb401 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -57,6 +57,25 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+int16 ReadRSSI() [testing]
+``````````````````````````
+
+Reads the Received Signal Strength Indicator of the current connection on LE
+bearer from the controller, in dBm, for diagnostics and production testing.
+
+Available only when D-Bus testing interfaces are enabled.
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

