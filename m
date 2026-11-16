Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813388;
	b=0jk50TIcu8o7MIFMdJ214iLRVpwtZxEuqViE6795kuMJp2zzBE0xpSBatCEBfPTDHDWv
	 osKmzEndwj9kn3ixAKVnRZGZX9zn15CIA2k/+p6sV/hehqxRd20+yfhHM5FXR6gqa/kcm
	 7zRkhF+Ma98s6uB9G+2FFrDjFG+8Ws/itWVEWTKyCqHgCf1Xlq8IJ5h6ZwvC6W8YSKNRm
	 /pi4wpMb0d2jC5Nuk0OBigS6bjNON2jr+b1ogu+5j18/hqQpbHLlnjSf69YjeNFJGDO/f
	 qzJOMNBLqPjuqeD/Z1MrXF6lIuf8qhFm5kHVhYh83SP18MjtuJfKXcMgN7gQmLFQy7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
	b=YwwOJ8mvBpXThd7VoOhzPD3mKvT9vrg/r4eFAfll7NalH+OnVGdM1fzi1wIrb47vgFxe
	 xtorbLplfmmKD4xFOv8Ilifne/NZrmb5uHAUKxy+vvO3vzN17uliNn3Z+inb2E4fuFdUU
	 WSHRs2XU3TFGbY8oHzcvVa4jWevSRE3YIhN3JdfvzaZal6JZybD4pm9EBXjdwyVFINDpM
	 YS/pvgz+SVMNaE0//3IYAR5/c8AHHqhC3YPTEF2qR8CbJP9p6KoyYSj+OqC+iL+Ntz6R6
	 bdmYWeJZaG0476qtVt8+r5hgwC7V5rvunWlXzKghCsm5+Plt3nDbddwfnBJpFNMGXiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=H5PvSM0g;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551AC606A331
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 551AC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=H5PvSM0g
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b3acec6677so4216112c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794813387; x=1795418187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=H5PvSM0gt8MfsU2d3vxOv/oskBzH1Xhn3LIYAwn2ZkUv9590Dk9GNhgxz0Dp7KwGRv
         HRwQsVSgS/tT3PuDMqPMtgoCuNDs+YkY0oY1i2CcTrzfG5sdlfKuMSXqDcHUuVgfzVRc
         W33h5qvsNj05mWzr89JPVh/sQ8AhuIuEK71a2YtFA3xKBsopj9331prBFxMO3+5DusIx
         ElLR6VT4olRA7s+QIOSR6w8HCoVMAUpjVFOsV0UiYVAspxidAZqIjc5m5CLB8feM2Yol
         L0zMEuGCDz2BvZwhbeL3yjXHauvgTppIukj44LlZdoRefOd1ra6JLtosTQR2Pmepj8Es
         kf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813387; x=1795418187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv3Z2W4kuPmcTI91pdO/2Gi5/UuEkGZSmgSM8GZaGkY=;
        b=AKaq1m0INbT2mCjUF6NsgYu7S9NNsYrfp3fM1VY1eJjhl7Nbt8jr6VnIOqdbFZWE5h
         R8aDAicFaKqUZEqX90C40UFL0/tL1eoZMSRG9luhKvnyzR1hRGaisdnNlHvd/Xaobzt6
         hMfbotaa/6hO3Jem52ojT9AI4Luegq3vu6ikTkBiwBTuJJyWZP/N8ptvsZLAXNZr/asj
         zFXHRU4+n04OlW97MGiYjZ9VbAttjUCZrPJYXcbvmf/j0SCIMP/STLEkSJRTcv/mUpsS
         vR5FrNiKCODvzR9FpA4E2VDIGQeyVro8jcuXZ4uVD5Gg4+bqKMMaM64nmIbw297M9wfQ
         fBHA==
X-Gm-Message-State: APuU4Z84rmVvE5eM9MFjGqEbO0vm5be7lJzwkH787lbyisRmNi0bp0ir
	YqWTLHG4QQYmYSIzcbS9WS3GjVywjdMVJV0hxLaJjaaIorCvoNrBPy/9BcNR6W6S9iSaMQ2mFD3
	aoMyyM10=
X-Gm-Gg: AYBFou3lTpv3h2zma11ZCUa4qlItwa90+fkS/5akPACXDFWce9FMBUgAuueECS5v5l+
	KxLOSHaNTut/jAGoJF9QuBWD0LytiGfgM9OTVXxTqY7t6k4+TKexTnBgOHhEmJQCZpWfTTm3piH
	It++Hj/EcbggYt8c3vzg60OW4xMEAl+3YX1w9zj1HMkFYl33ACVznoHMDvIujwQvt3P7sColZY1
	xwz/hiZsmnIzQVn4FuFOQom9lhTSLCTW4NpQ8LMLp8jFXOd9l5+GMgM69hAokbtXWvuKF8K+RBT
	3M7PuT1By2yLGXsw6Vh6iAKpseDRkja8qePDgJyFYc+A9OyaG0YfcIOAYjSd+rOtSM+AvPHCerG
	IpvN5cBjOwOfb0QoCB9DS06J1NzRPTYzuG3D0Fa/JURzqhfMl40xZKFgsR7H3p15NB264vPEjxN
	FQhPHiTF7Xzn2VupryGTyEkVQXh7jawINAuHfQVTLK3mBgvn8t1z9I8qcN1Nw05+foFdAsyPg72
	39mqmNUJ8qFfGoMw7+bCfT2R9B2xD8K2H+xdZW81qqI3xSU7GVIBW+IO5u2o2+gBOWG8Kpt4at6
	nweiSBgseps4r0pXyk2xGICr2wFFgekhEyKDKIIFb31LLGXxOQU0UzzHfmzPPenTl7pnkrVWTv8
	UjEL0exxRnN+pSMol7ngOlmgXYII2MLwTcsRq5q5TpDepUVjzyD8dHcRsnIw/olSoiU+Q17I=
X-Received: by 2002:a05:7022:3a87:b0:1b3:afa2:2d7e with SMTP id a92af1059eb24-1b503055284mr10132828c88.1.1794813387363;
        Sun, 15 Nov 2026 23:16:27 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm40571430c88.9.2026.11.15.23.16.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:16:26 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v4 1/4] org.bluez.Bearer: Add ReadRSSI method
Date: Sun, 15 Nov 2026 23:16:18 -0800
Message-ID: <20261116071622.35355-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116071622.35355-1-kevin@simpleble.org>
References: <20261116071622.35355-1-kevin@simpleble.org>
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

