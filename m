Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690877;
	b=pTRgfPc6vAy6DrVPf9Za1Bg9tmy16bb9KYRHRs8LHmj8HW+WTHMrQuIIj/cGl1Jzbjg0
	 lOnfFMCupOifHdjhRmQejOqYMEVqYtL0c05ggNPkUpox74ihHPpyFQSpcCZhLbxBROvfx
	 CJuvgWJV1A4O5msCwgdWxyhL2dEeox2hbzs+PMa83pS3ckAXEqmJeVhKp+lVfP0O89M/u
	 kNjvo7vMk2/tJKMaQASSQAia0SbMqRefgPU5rqUUAlk3O/sujOgfsiVGUJvfYWeFHf0K9
	 usbo+Dfda3EYE/WfzlU54a1O8NjBv5Eh3wJkN2Hr02vqn0PdDEwsffrdwZaPJCNefJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cRuGeDelLBQ3zT5yR4lgJxot3pYSuYtADZ6kC/XGsKY=;
	b=05DbdmQ4gljE9+XV5Bz5zgy/4rxnqnNTEcjqo23GWL8eSiy/+Br+CTs7IAvAEpe5Sq1A
	 DRersl8676SVm5RooZlbAI76xIzHNR4XZV19Qbg7MjO4/qeEWuFxlolXfvsmmT59qG1JT
	 HoMr2SvO79JCCxsaAAzLa4QQwYpcZICA2VWR0mw5IEz32upxxRcC5P4k5h2+QEEEhHlWQ
	 2NC6zlSuRR8jfWmCnBq4GgudZ+B3kvf50XEk41SbpSiAyLjHsPZh7JEP3kdHWJY0T8RDN
	 pEwKJyeKIZ9i4VmUZlnBRuU78STpdkdkcuxz3mDPbJT45/lN6z3eRBeB/bfrzMPux4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=F3OxpdY3;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896E606A332
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7896E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=F3OxpdY3
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so3872509c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690876; x=1794295676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRuGeDelLBQ3zT5yR4lgJxot3pYSuYtADZ6kC/XGsKY=;
        b=F3OxpdY36X/EQGVpNh2Uui1ARhWhrbIQJrMpmRiMyV1SVvFIA2hfBhHaVErO/y+p4h
         PlnfLa6iYcz0ze5Oj3VdcjG1GaApEh4TUW63zcC5+MuiCukoySOgqraPuKK/e1zqr00e
         HgCzVUZJZv/8Rj1YHsjg9FYysPkjpeOwos1hQUM8M49ob2kL8MkuJXM4M+Af6aEkIaGk
         Q8jmhkj5wYrVLsAIQXroYm1nPoG7NeKl1xRlaGkWELTCf1vYmg4LuH7/VpsLFH1w4tSw
         uSmfq8k7ZaKbw1vm0a1YsHYeYDO4yuUWBjt5CByLg0N1KpAx4l54TnQ8ddclWRuA00ol
         sWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690876; x=1794295676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRuGeDelLBQ3zT5yR4lgJxot3pYSuYtADZ6kC/XGsKY=;
        b=uyGcksjl9MqCqjE3N+Pe3lJIH/K7/Cpo2qyQ25jNO+XBCBaTex5plDRa/yv84W3iTE
         cIF79Q+zGzoMBQIVxk1p8JU6qrYAsfoqU1p7As81+arBdswnXNXOj+FYCaEdknNZ9ZTT
         +d03Dix3rzUkfZRwr72ETDtwmF+gPei7XjrZ7KbQADRH2nfxhPOyFCHAGGmfDOk2CnZA
         CcMSIeLlKbFzcupDLBsxHsbZZ4vZlgGhzE8wTHhRKU8PDRAQdu/EYntQ1e5AX9SMXJZY
         weFsQBT3g6n9aPyxptuqAu+yzA+bNBSL1ZmLEUUtt/gDivk6yc+tBo5XW9gvmesHIAZ9
         7MZw==
X-Gm-Message-State: APuU4Z/WGjIpoJuH9P8hSs6q8UZ6SqjYz4r1XdJknuWdluT9Z9N8cTxF
	6KhQkWdrBMo23/tDrGjTYanhA8Eklm1YJl1u9lSGvlSvBzLaEEzb4BrswYm57nQqiTnK2tAqw40
	K3C3aq5o=
X-Gm-Gg: AYBFou212XFtIAB0IBQSyN+cOnGgKQkfKI/loJ6PwMjzkld2zgjHWlStGApT0zgLwYH
	t6OWCAsKZjB+qq9dJDxOFKe/uO4CoDRK8dqh1Q0RqE7KQcFimtIrQp0mC3ZAhuXdt3SUDJxpuFV
	KDiItUsLllYAHZzNDTK4T33l6kKSIOxFH8ZEw78FUPY9uz5GNq8zfF6P3x+pXWm6BNNK74c9IGH
	y73S5QTHj0YOJhuihloYJfiXlvExUxkmN+HeVlel3oh1XMS2w8WGg50RtEh0sH5yH6p7zFE6RI9
	PQsYFAZI74JKTEdmMNcCJ/rHC6bXQKfFGye2tebbuWqwa2piGXsz0OKwVXY3O4McjDoDm2rk884
	y3OsAJC1QfjWT72EXIMGCZ/kRrxKFkr0Wqsz9Gc12Udu5IoAt+ylFe0Lthb+Qk7CZHkt6r6+89R
	215Rv8ALUPGw2xJ/NfZMbCmbet09maMpiFiTGphen6Trq/oGnaYS/UfHQ12qv/aSPvcixDoaTPD
	QnfQa18PgNyPSj5Vmj7UEdULc+wXKHZ6r5EBFlFpPw6E0coJMUqM/cK1JNlWh3/N0zTKmzU1OS7
	6xWLBDN6KWLRAMHDeJsE0vwaIBdTPSsc6+y7GnyHUFwEjsouDNnMI7IY07mkoJPvwk1YNPpt3xD
	YF2MZDfJ9RPmtMghcpUWm6yodfZEPlWh6ooR6796hic/FCijwNlTAFsQ9MI88jDJb9pX3V5Y=
X-Received: by 2002:a05:7023:90b:b0:14c:8461:b3ef with SMTP id a92af1059eb24-1ac5e6f5132mr23605084c88.24.1793690876324;
        Mon, 02 Nov 2026 23:27:56 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:55 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/5] org.bluez.Bearer: Add connection parameter properties
Date: Mon,  2 Nov 2026 23:27:46 -0800
Message-ID: <20261103072749.50979-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
References: <20261103072749.50979-1-kevin@simpleble.org>
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

This adds Interval, Latency, SupervisionTimeout and Subrate properties
to org.bluez.Bearer.LE1 with the parameters of the current LE
connection, so applications can see the connection parameters in use,
e.g. to estimate throughput and latency, without reading HCI traffic.

Assisted-by: Claude:claude-opus-5.5
---
 doc/org.bluez.Bearer.LE.rst | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/doc/org.bluez.Bearer.LE.rst b/doc/org.bluez.Bearer.LE.rst
index 6d3df3fcf..3db5237b4 100644
--- a/doc/org.bluez.Bearer.LE.rst
+++ b/doc/org.bluez.Bearer.LE.rst
@@ -177,3 +177,41 @@ Possible values:
 	peripheral.
 
 A PropertiesChanged signal indicate changes to this status.
+
+uint32 Interval [readonly, optional]
+````````````````````````````````````
+
+Indicates the connection interval of the current connection on LE bearer, in
+microseconds. It is only present while the remote device is connected over LE
+bearer.
+
+A PropertiesChanged signal indicate changes to this status.
+
+uint16 Latency [readonly, optional]
+```````````````````````````````````
+
+Indicates the peripheral latency of the current connection on LE bearer, the
+number of consecutive connection events the peripheral may skip. When the
+connection is subrated, it counts subrated connection events. It is only present
+while the remote device is connected over LE bearer.
+
+A PropertiesChanged signal indicate changes to this status.
+
+uint16 SupervisionTimeout [readonly, optional]
+``````````````````````````````````````````````
+
+Indicates the supervision timeout of the current connection on LE bearer, in
+milliseconds. It is only present while the remote device is connected over LE
+bearer.
+
+A PropertiesChanged signal indicate changes to this status.
+
+uint16 Subrate [readonly, optional]
+```````````````````````````````````
+
+Indicates the subrate factor of the current connection on LE bearer: only one of
+every Subrate connection events is used. It is 1 when the connection is not
+subrated. It is only present while the remote device is connected over LE
+bearer.
+
+A PropertiesChanged signal indicate changes to this status.
-- 
2.54.0 (Apple Git-157)

