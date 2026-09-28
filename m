Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4E4FD296
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635125; cv=none; b=p6ka9b93Cpa9bc9N4TzFDSQgsyMqEK1oXzhKvNS8/54AYL+vCyV7gOdzIY7DcQNIo7PNEDXAIe1Ge71Z6c0LFSr/PUnvqjqiAKeiNvdWIJR9oBHIBtm3JY5e+14JotSDVRUGTPldKn+8K9j5fCx4YBtCSko/qOEmDQ3dbwis5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635125; c=relaxed/simple;
	bh=5BgCB1wdLXA+XPp1eKm0La+ZsmzYrAI7eGMWPl3ewJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7UTPDh64TqOWCXIqWGAoHNqoIZBIdtuOqPHcoiIuEw+HWAlcozjBQ9FAZnEXAfk/X+JJiuIqxeB4EYz97HNONJ/5UOrLscPlsmo/IuC7j4/gu8WRdnACfZYCUUjC4GX6VdizNbu4U4RNgHc1GPguakSvInbnkyUeiJVoi4BkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=nAB2Pl0l; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="nAB2Pl0l"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so3143864c88.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1790635123; x=1791239923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wx984YywDCF2rcoFZc8Zh3RZp3D7xEoWwZd7VcVuXDo=;
        b=nAB2Pl0lLFSkT+FDW0YiB0/rLl8vWCHp9ZvL2FXRWfGl4flnzu0BtIJX/lYG1IjAp7
         QNLCnN5j0SoWcfrs9jjwqRDnescdWmtykQi+aoe6aj+91HFJMOEe+6Ga5xLjSj7mHNfG
         55fxyf302Gvrc5xmXL/nrnDD3zZlIjOyr7ehjHW+T8KMbbJRc3SJQFPyxDagq3bi2U0a
         4ENvI+SIbxQRRDQTPGP6GwiTopNSNMS/+BQku4kYalbuHZFJ/0+LPMD9FB/TtmnWWd6c
         zm9IdtluYIt26HbQGyliXjOFuIZVh4zxJpWru02xPE3c/EPwWj5U+PcDIKS2jlWXYwPT
         PKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790635123; x=1791239923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wx984YywDCF2rcoFZc8Zh3RZp3D7xEoWwZd7VcVuXDo=;
        b=OO/uGNUKimn900PSbMP1BnSvXHTt3kMtcV2KSGZ7bfn7/5GwZxkccdN+MpWPpfGV/O
         0LbF0kZTc5J5napau63xCuei8L7Hf4X4VFGPvE62OUS6mg6q49gt2IPRxHJ80d4zi2mC
         bHh+ERDgP0nNni9E5//sziEOvmSV/9CSRwI5D+7ELCxzTBiMKobSUPC1V4bq36KcyzFW
         idaDonMxrkvVv6+wJHk8+IdWG51aw18cVXDfZTuz7KmokiqtKIpe5vrqOlY4jTa3V5ve
         JPC5/GRq4EgHXjBxcG+d+iBdVLM3XI8R/AvCbeSCXDuWIHqM8QTc89FRwY30WpnXEokc
         OKXw==
X-Gm-Message-State: AFq9FYKsgvpINT0c98Z8lnN7TkXBPkXFCwlokLcKh8919A1sfiU6y2Q+
	FNzwDlQG+kZTnyITETh5MoP0cA2V/8k+/CPN/F3H+aSaT/SI3EH1m1JGLGlvft2zx0ObTdyJA19
	B84IKg7SK3g==
X-Gm-Gg: AYBFou1grdNE80dYEOjJ425LHiE7eCTp/MimZt48if6CE16gEdy9f/86JQUUJDhv21Q
	d9s38JPlwfQkAeNQZBe1zCbUpEfkgrpVwxgQnMvFaCtMrE1LeaS5oFP1TtfFZKlOML36croppQf
	XagoiFAYdY8gJAUyjpvKJKk4ozJ24H369z4y3vXKz+17xLxb8QwgylVFpkBccdcmpDtohcTWfTp
	N3qkV5VBGu7NSNWmOWqEYvhx0sCflBU2AsQK8v1aeQUOt132t7mM2MngPrpmrG+BvkR6KTKAOO+
	dvOl1wJkd2RCEqqTiI6wWni1i6U6U7J49ticTja3JsCwnm6bMOupW6VZWUojWN7dEgKNJ2b/ATh
	vRAOyPWVFefIwpIpUJI8KVd6iUT52MKg3Z04IORGDC15+Ly9vGRa3dog+OuKOHZIx4TBRqf+HWw
	4PPJ1oHfqtsiMJKeJxNqbkk0RTkaRYXqOmTfZQGKzKKDmrmpy7Ff5yZdF6t7Q4f4ZbVo2TIARna
	wV2WQSbH2gQw63XHmeLnAkYysPzy+Xp+5ese0uvfm+IjBfjf39aSATLbYiQ3WDhn7bcOn9WFdpS
	0wR0Uz2HOIFfv56nrh2/BXFuoHBgeYphdcOW/7pE
X-Received: by 2002:a05:7301:6781:b0:341:a4ed:d910 with SMTP id 5a478bee46e88-3426fcc826cmr14024590eec.7.1790635122649;
        Mon, 28 Sep 2026 15:38:42 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm27182480eec.10.2026.09.28.15.38.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 15:38:42 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 3/3] client: Print Connectable in info
Date: Mon, 28 Sep 2026 15:38:15 -0700
Message-ID: <20260928223815.11936-4-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928223815.11936-1-kevin@simpleble.org>
References: <20260928223815.11936-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This prints the Connectable property with the likes of info command:

bluetoothctl> info <addr>
...
	Connectable: yes
---
 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 314aead..c44b81e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2026,6 +2026,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "ServiceData");
 	print_property(proxy, "RSSI");
 	print_property(proxy, "TxPower");
+	print_property(proxy, "Connectable");
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 	print_property(proxy, "Sets");
-- 
2.54.0 (Apple Git-157)

