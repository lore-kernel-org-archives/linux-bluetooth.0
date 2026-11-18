Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017558;
	b=puJu9Ky7+Vsd+lAo5ugQ7/v4DQXzEFgkwRzH7Ype7YPDVhZp0pTPI0QIUN4d6nl4rsW2
	 BGX03YpadwE2031PouTVqGRU8jSvVYk37+UP4UNIDXr+dEHzlxkWb3A+02+U/5NdnRtUs
	 rZwvZyk7IXuc88+x01zVQb1GQJPs+WxukFIkPJDYkagCLl+Mxswgcw2wYeM7g8e6vAa94
	 2fYCyM0xlERfXuDkJppL97uaAR1OMtMnw0WnuUHDwBacLYnJqASwa+vTufXmvnUgeWhe+
	 strBDsoO68G+VarAugqLxVuau/cFwbfoGWAC/r1X7k4nUd4YcoHUEUEOG8BLbc3J8oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
	b=ugsxwmySKRTp0vWx4qldwStPs2YHTdXs+ojCbHvXEEdxIIHjV16Yf0Gsk4e9V8k0IqGo
	 qCyO7KMZHeDpquiAWNv6sJURVxuOFmsPJK6r7zT+dHo7hLo11Z1TqqRID47RS5bxHBDo5
	 KWFumxqpu0WiNBEZ7R0k8m/6mNmQh5uHOnOWeOAwa3YZ5ZuRvxxbftpyBUpkzm1RoCf6u
	 s9M02UM6feNTAP0sZoXTOaRiPYyinOWWfKl7tECo1bEllHHvTeRwIM84iinVEaZsWrFOl
	 lEpOSVZC7SmaEHN2tq4cD8sRp8JKKMlBq20HjkC6yqzEeC8X5ZOE91zs9PqWNKuHJ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDmXXz+W;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2C606A334
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 15:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC2C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDmXXz+W
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso755651e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795017557; x=1795622357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=iDmXXz+WE5J/tljwQjF+rlz+h1/El1Eo2lj8ocsUG4h9a2mOFyAkD2vw2Tn0W7O/Dd
         CaSG2vhl/q0/20IiMdyKAqoVsakZ15BeKXNxrqEIXpFD0Ht9yx+hADpGcRP30eCdvhIk
         o4Jgx9Zc64yAMf9+VqeVP2QgazUmdnUJQZhyfeYUDZiisj+yoiIIWLbF4VMmnZa/HbBP
         pBC+nufs/asvz9bb75nnz3PvpuIQnUB210/IRmZTTgSjs9h6KkCrihMmsitXiB0p458X
         hyv3JtVnCVxAywdBQ2P8QyI88N+dh0Cxmjth2Q8kqfm8bXwPohI1sXdTzmc5ctelh1+P
         XtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017557; x=1795622357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xKgb9ZS2KNfuSDJtqHp4Vi833hjt+EUPqL7Hov729wk=;
        b=kKqCJN3FjfkOavpIdQmt0EmlKlhn55ZZ8RUdSy3aS8NEbA7bsHjfRl+V/zovJzWsQ1
         9Ao/COBaxAllD+zgFfhDEI5OU7RwQ+0xEWPpVhqX0lddwLJFTMdCa0aOkiRqjt1cUf/8
         WbXLx+MAV+kwC7o2z00MqxO3kKC7sgnEUbMXTgheM7ZcfHszJpXpwTQLXe1GZeNyqJvm
         mcFT2w6ECVKLPzi4lvZrfk+cNVR1nMhrV3XpdzZ1EyBEPW5eds8BpyodEBHeLkhv0um0
         ykhNZU91pYJp4MM3Zf89QNf9SEEp2QSJspHNskkTnqcV75xu/Rqhm3UMYgXhtifkSWhc
         xzBw==
X-Gm-Message-State: APuU4Z/c07cDAGeGQl0Bb+VRXSaWX4YpTsOaS0Jk3s1AZ2ACh1dUMo7T
	8QpLM538RoUo4E7lHXCvIsw5cry9NbqFU6xY3kPWsPDtO0Z88Jsjbr5z9JON9oP4
X-Gm-Gg: AYBFou05AZCzb5BInEQWJQON9Ez1HLWzPIqBeJwi0IRVgFTcp5bUvivL5fYcEHkAdre
	vuuzajwqu5d08P2tANAO3eZEiz7MUZc6rSSpc1Y4TyO+Ruv1uOMVcDN0tUv1vQ+B6fbIwexHeCz
	Z2BV/2uJTh5z8OLSGrB+OHss5lU8gn82CMn/HN82ep2CefIvVTNKQrezzICcN4GChjrrMWEXxea
	TVp4ePpTNzPvxdUvUoXFX4Qx//IHNT28GKJV+f9tM3pg7MBUFE9bdqJgyWfpfM5kiykCe+W5pYZ
	R5XCrnt5SSpXd8txwspUFgw3kHVMqO+SPOIJIp1D3HqCa2uvRLR0dnDgwb4U2sjf2LwnjsYjP/p
	u+NgDLiRdJ0YVeflrNS5dxBsKRi1qNQvTiLI8LeLnaSgjpSeAA3/dvE6Jc3WeYwzYx5vxOzQCzH
	5m+qMmaWOZ7FuTktXg32+dbNAoF1eY1lqG8q2wmPnQ0O3JS/CwYsONZj+Qvm9I7Z5B67bV7mylt
	GoOTM5DpE36c3uRK9FPhrRAJ886IlG89f6W1T0P+QtSvlCv0zznwv1lZL+bzf4ig2dFAiOAhwLy
	S6WEgy3ZaCde3LgN34VyhXGa7nafNukKsJpF8nWzW5LfVRUm7f1O2ik7VZquoyvYC9xpDKzqzKK
	z/TO/2MV4wkyJoXdJoMWucDN9Ss2zHD3zei96hWfXV3kTA1DhWymY28E7RdY5+uHGeNFDiEZAw+
	UZcXw=
X-Received: by 2002:a05:6123:148:b0:5ea:ea07:b119 with SMTP id 71dfb90a1353d-5ee6470cc09mr1866880e0c.16.1795017557481;
        Wed, 18 Nov 2026 07:59:17 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64e4dfe3sm1919266e0c.5.2026.11.18.07.59.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:59:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 01/17] Bluetooth: mgmt: Fix read_index_list() buffer overflow
Date: Wed, 18 Nov 2026 10:58:58 -0500
Message-ID: <20261118155914.178050-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118155914.178050-1-luiz.dentz@gmail.com>
References: <20261118155914.178050-1-luiz.dentz@gmail.com>
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

The first pass counts only configured controllers, but HCI_UNCONFIGURED
can change before the second pass, which may then write more entries than
were allocated. Size the buffer from the total number of controllers as
read_unconf_index_list() already does.

Reported-by: sashiko.dev (linux-7841362e-9b8f-465f-aa22-e99c315231e2)
Fixes: 73d1df2a7a10 ("Bluetooth: Add support for Read Unconfigured Index List command")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6ed3bf6f1738..fc0be4ca033f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -444,10 +444,8 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 	read_lock(&hci_dev_list_lock);
 
 	count = 0;
-	list_for_each_entry(d, &hci_dev_list, list) {
-		if (!hci_dev_test_flag(d, HCI_UNCONFIGURED))
-			count++;
-	}
+	list_for_each_entry(d, &hci_dev_list, list)
+		count++;
 
 	rp_len = sizeof(*rp) + (2 * count);
 	rp = kmalloc(rp_len, GFP_ATOMIC);
-- 
2.56.0

