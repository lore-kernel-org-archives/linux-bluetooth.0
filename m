Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156746;
	b=L8ztEtV/wv4VhNo2D693Bl1St3Xmv5TabvzEAQLAG9qE+ZfyDpQVshCoWgT9wvxabPwn
	 AZIuzJbawdEnx76W4yA5UYL+i0F2Yb1plijT6/3NlJAzlp4AZFRwtiVg+u/1FzY/7e+9f
	 oUCTfAE3ee85T8NgR9whubsWv3AoJmjuhe+GZVqxVOE1hFhoUNuOpWRFLLlZNFPENkifq
	 4H3H3BBxuStlSpw+vFGcBJi0TAhEspB3Rm8hbkBe5JwldEcLf9hp2WNwpw2p/JEhTlQcf
	 MMnnyZb/FhHxRWPpSkxie0GsGU4UU8bdnKfZdbQPYhe6SgVRHodLhzFglvfD12hVTTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
	b=XUZgIOJZ41MjUshQz1RZDYGTSB4d6NT1dcQ6uQzdN7ybz4R+xKyDF9SLfmlbIm0p9iwb
	 RBvPJGhAAnGmZd0eQwvKCXB7pPHdWlMKW13q16q2/DI8yn0H6cTeyVVaCJIFp/QriXuuD
	 XyLDKZI+3Umoye4lAOzO2WenQ7nId0y17l6kKYC9FS5VcyNdXkGbKqYNFFtruNtg8ezUo
	 brF2XEwQ/w9fiWKKdWywxMMrVHTjrjQQAZtGA5ujhMn30XvtS52oFeDIB3BsW8v11qrz6
	 sP65Z5uAyowt+MRMQ5cqFWIG1LU8taC9xwmECiD4A7riZXU6buw7X5BYeAh5WdtBcgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQkmEQWp;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01143606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01143606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YQkmEQWp
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso964365e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156744; x=1795761544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
        b=YQkmEQWpfojRrDHj06/Bnrv1XG39ARt+yGDptUzaREeRsZ8ar5FuDvw9yrrz5fxMHF
         fnSM1XeCv8oQ/9AaoX6vFMhmd54ccVeTLAvwoMu6ZS+XCe1XoFIv6pckwoGkzu6pNNAK
         FljBKkoSVRu1z1izqConuhd/SkCdvz6hYgVB4FmTSdUsqvnJ4MsE8aCDZ5J3AehDtRsL
         dtAIlXalttKY6YKQnHidfVzaCiJYnzq3h1NPQ0Wdi08zqDWqdHPdZpQNKZoc85sUZRxy
         Ma4Rulzu0TDFqymgQdF+UMek54WOLz44Oy5Kgm1cgrW4EJa9nWKYgQ7AIWjqUg1HApKm
         FQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156744; x=1795761544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXq6V4AmqAw6WdX3F6dIQSuYwYTqRtdpZ41EEu9f+9k=;
        b=uyvHNRpgHn/UOlOrn3A52L9zgV7yry1ldxbHCl6N9fijjeeWkU9RROheCntRFUi9iy
         Rli4Qbm7gr1V5Nvndj3MUX/TB8oAHW5FRHJx06xQXBpf9G60CgQbiT9Pg6aDIWGeL8yu
         lCQRkpXLpIHbLphPwdMg6zyNBQqM0LUmEcpmQxvMm7pXBg4qf7q0mxsoZzuVJKvCaty0
         SYVOS3eEV9/LxeP3P8qEeHJ35LKTjA5qpJTnxSz1JFQwXjV5wwnE7a939lBEfrznRWR8
         1ndKd4MaMGWzGy24yRGd+1zT585zXQery+TffyqGCBzPo2ixbQRrMj2dMSiu6SQut9Rk
         ERVA==
X-Gm-Message-State: APuU4Z8xZeecbkZK0WsVhOM0la9yh4EMhMQRusAJCaZ9V3nmPLfqpdi8
	q0ufv14jePFYi6986YtcP+DQkMGpNN0KNR0yZh4gUoTrN1F7tf4zPr5vNrW+9aYj
X-Gm-Gg: AZFdTZeNxuNhx0FgFvLPiU9Y0lSNtnKp4bxU9FkzsPqHsXYQz76wzZvL/fgyFSogy9G
	CuFUhjpTY+drZgVw9Ft4hc9v135RnYLiXtdYBxlHnIPjqJOxs/Ipa4K+VmRaqKzvHq0qBfYT1b3
	SxcnzpRhzs2e/Wl7prBJONWx447N7RK72iOsaY8mHrdu5hn332cViWXz3Kqv7lFdyLo93/3AuqB
	VOb93jTF9T5NL5uEGC1mm5oLdZbTPhZnUgCQBh23w4jGedrqM2l5oMC/kXMoa28yOCZYn6qZYe6
	R7kgbWRU36C+TLQaOnlcU+aN5Pk4Y0sqTfa252ukdcVr8E5HuE7gK/s6YPUY5Cwkk/04ot4XdK/
	3/rCANdpVNtz5pKRgu5JWV9LiLnD5LNaxdswXv4mAIxf8Qc2xRuhNA0RwveoencLyFOyFqI5l0z
	bFXb8CgKqn4fYAWThAahmcwESYyrSbmJrSnR0rID3CsQVHHILqyQPrNL6HFXTiSa+G8+cuD9f42
	aCuHTzlMxfNHfcUHdtuIRPi+6uY9B7OJoUapMHKREs4chhCZ/2Sm6aU/joN2Eh7jcgFtzeH71TZ
	QvmHr9nhHaivnvpUN1FgnMKPqSxX4J472vY=
X-Received: by 2002:a05:6000:2c05:b0:48c:698b:502c with SMTP id ffacd0b85a97d-4abaaf365d2mr3513105f8f.1.1795156744202;
        Thu, 19 Nov 2026 22:39:04 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:04 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 02/10] monitor: Fix data length of LE PA Report decoding
Date: Fri, 20 Nov 2026 07:38:48 +0100
Message-ID: <20261120063856.16585-3-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
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

The LE Periodic Advertising Report decoder passes Data_Length from the
event to the advertising data decoder without checking it against the
size of the event, so a truncated event makes it decode octets which
are not part of it, and octets beyond Data_Length are dropped silently:

> HCI Event: LE Meta Event (0x3e) plen 8
      LE Periodic Advertising Report (0x0f)
        ...
        Data length: 1
        Data[1]:
        00                                               .

Report a length which does not match the event as invalid and dump
the remaining octets instead:

        Data length: 1
        invalid data length

Fixes: 5441a5b91a08 ("monitor: Decode LE Periodic Advertising Report Event")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 4ff24092e..0e40300fd 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -13957,6 +13957,13 @@ static void le_pa_report_evt(struct timeval *tv, uint16_t index,
 
 	print_field("Data status: %s%s%s", color_on, str, COLOR_OFF);
 	print_field("Data length: %u", evt->data_len);
+
+	if (evt->data_len != size - sizeof(*evt)) {
+		print_text(COLOR_ERROR, "invalid data length");
+		packet_hexdump(evt->data, size - sizeof(*evt));
+		return;
+	}
+
 	print_eir("Data", evt->data, evt->data_len, true);
 }
 
-- 
2.47.3

