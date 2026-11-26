Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719611;
	b=jXrZOSMEUpr/xyUzJnhzELuogFPuxEzSwnVupxiMjkkQbiHFGjxyHBWa0p+AhneXXoEC
	 M2jKTj9wO5Ghtw+a5GOvALVM/H1tle/O5Lp/RCQRd5aWl66zYKjyIk1QLocMZHus3I0X4
	 9dgDnx8/YJGxzPMmM6qOY00A3XN7a7+vSxzJDjZ3PMcmaHgxmxG2PjsIB2klc44CoDQBH
	 iZLpEARI/NNPsiNr8JSf7BEDCvuhqcK2CIvfpyIizs0/4LhmhHCcKHTHmlah8vi3H5ibM
	 Qtk9OPJbF8xVnNks2ZHEVPb/RMW69ksq3CQQ2OpcAhnLWHiIvwdlmI6LnlZ1SFMWW2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719611;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AfU3oT4m8InMNUbGKQABQ8Ng63sjdtH6zKwdFH/dzU8=;
	b=M217aSyLYxwxL9qFTpdrequUXHuTm7cf3hn5WqRgiXb9YvztVgfmlDdRn+m6wZpn7JZ/
	 4t9ck2EQmUL9wRlz0HDp3NHL5XK73vZUmPl2Ag7pk0A8C0p7mVZPyUaAkCJqCDH2cyjje
	 2jMaXhUNMf1RGxcigYYApHieDcdd9pZPG3uQ/bIgO1zYGuwq0c+mfmaVQW+87cetpzyBr
	 E6mEBXr970R/MsmjXEE6Cj27897sSLaiV77JFePbi3kZJavPwtRVTV+8vwIYcjVU178F3
	 pV49XaYN/r+UInjmXTl8GBrJo/uPJV5bxGDuzsaZclvY43CKXIkMiFCdfh7OhJQRiNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=SpZ14eVW;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7868606A330;
	Thu, 26 Nov 2026 19:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7868606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=SpZ14eVW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1795719608; x=1795978808;
	bh=AfU3oT4m8InMNUbGKQABQ8Ng63sjdtH6zKwdFH/dzU8=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SpZ14eVWAOpNlBxeMylViwjY1jSDJEXxT07214fuG5ZvU8Vif+mQyErsDUcWKbtbw
	 P5zFnKZ9PdfD7fpGq6QIAsav2V8GOlCZ1g7X8AhQ7qRx4sb1z3vN+WDMoJ6nKvnQpl
	 v0QO1ZI95S62/T12m2cS2oY+N9fxtmMAFHjV9WQHSspS2SIbLFAz4zpBiYfbJKnPrZ
	 wyQxOn55J6kihpUQyhfruy8b4s9Bu3GkR03NTvHDtTu/BobcXOk3YOry5DceLzlA0r
	 JP0WwbZFWf0n6fOmTApi313cIY4+px8Y+/3kkj1spULxpLnLRgbJSUoGkui2Y/sOan
	 e1Dz6vSrbmvZQ==
X-Pm-Submission-Id: 4jb5TL5p7Cz2ScXb
From: Michael McAllister <me@michaelmcallister.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: brgl@kernel.org, enderaoelyther@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, markus.probst@posteo.de, mka@chromium.org,
 phone-devel@vger.kernel.org, quic_bgodavar@quicinc.com,
 shuai.zhang@oss.qualcomm.com, zhaojinming@uniontech.com,
 me@michaelmcallister.org
Date: Thu, 26 Nov 2026 18:59:41 +0000
Subject: [PATCH v4 4/4] Bluetooth: qca: Power off WCN3950
Message-ID: <179571958170.81221.16178314106519621947.wcn3950-poweroff-v4-4@michaelmcallister.org>
In-Reply-To: <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
 <hvwqozj3r7n7igxw5qogu7xxya4fkhqanb334sroj37ufzdizu@qarvtlkkulmj> <179571958163.81221.3368253997777320112.wcn3950-poweroff-v4-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Turning Bluetooth off on the Moto G10 leaves the WCN3950 regulator
votes enabled. qca_power_off() handles the other WCN39xx controllers
but omits WCN3950 from both switches.

Add it to the existing power-off pulse and regulator-disable paths.

Fixes: d5712c511cb3 ("Bluetooth: qca: add WCN3950 support")

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d341481cd..898c7a980 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2284,6 +2284,7 @@ static void qca_power_off(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2304,6 +2305,7 @@ static void qca_power_off(struct hci_uart *hu)
         }
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
-- 
2.39.5

