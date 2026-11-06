Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990038;
	b=y0vQuP2Ekrb18VWjNFM7XJ+oLycw7F/slOHsy/mAIOcw3boFwJeIqcnu9AN2qBPN/qgR
	 QhHnaPSv+Gd6q+yvDOg6tIO0NC37bVvSp7EHFOs9mmXqajdW4UtSc8O2UYH4HKZpKFvtb
	 LYL+l0LKdF0YIigSV9pX9Yr4sX+mbJszDWhTuQDp2sjahI4a8XgGQOgJL33zKDBI1rDdS
	 Ps8Bdhin/pIojn042T5257umjy3DFR1T/uR8nf5Os7g7zK/o9JDEDcJcRiGjkWvBh8g84
	 gOuMd9q8ZMpO+v18wr6igjxLcykkXQCNQzpwOWQ8SgXjtjrHlw85dcNuG+zKFpuiFRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sLPazrWSpxRZBRHl53RNiM2RntUCIEJhQILFw1iwz3Q=;
	b=et8C/slUDGPlUvbJ7drk9aedUp0keBjx5r6Jdi863JqFhgwfziM9UNuD01lSExHxDUL/
	 jxMpmDlr9JTHAKD26f7kVR+37h0Ile22E9PlHbuWT0bGLmHJbk0T+DF5kYJVvk78inYSl
	 jvZeiIBPIccNiiFLRquIRRiGnaPkWv6O8gMJ4sm4PpvlR2YCDkJk3Rf7cKS/fIwmxWSUE
	 SgJ2uZCxa9YbmQM/Hq6ukymHsXkocon6Kr8sWPOYMHBk+8W1UDRHwY/yMNYlU/oirqIx1
	 s5SUk4i9ofCj8RTv8QsAnGjiZZ+KWKOF2GnRaBTIkg/NfoKwUcLM6zpHxuP2A3GJ4VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RmCGaToJ;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31A606A331
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC31A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RmCGaToJ
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eadef147ffso744573e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990037; x=1794594837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sLPazrWSpxRZBRHl53RNiM2RntUCIEJhQILFw1iwz3Q=;
        b=RmCGaToJPqeyV6dTWpb53N84tDAlnuxz2b73x3/l0YKIeJBJw9yDe0P32xaSu+4nku
         eL/yFbpB+ujq5bx3S/BGFWo1I+EenJ0e/PZt8rWkRAsfqvrqMz9uwNpKVHuOWoBV796P
         l8oczRNHazo0tFhH202bLvvh0Uo7Nyzyin8I1WM3lYJfz6+1pZ3p8jPVhNd00SeDTBB5
         hLK8CB0WWRhmwSQ2gob6o/FJaKHPh1H2EmtifmWBu36jqTisZv67MNFLkJ/O9M0GWlzm
         q9T2gPsNYQWp/1fjPOyscj0+8OEaffhXtGeo2V8nfTHEZtrsvIsPjb/cDZvm4AgHcgul
         sn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990037; x=1794594837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=sLPazrWSpxRZBRHl53RNiM2RntUCIEJhQILFw1iwz3Q=;
        b=DJDQCG1fFs4XAcg9+WpDrZb5LeZB65IwUGPsU0AsapjlD9eq0RLqsJFmjj2u1joFnR
         uGwwQwGGRDjA6ATl/1jNRNoz5L1kxc+g6KAbHcqRFmZjusireHieJOCNz2CG4rCzHi8k
         z7HA85kn6VDea4bSrK+OV8KuKLWb/5201O/WMxkVi8vFGzpixB2zRwPW+xGV1FU3NDU+
         RgudpyzfW4xQhAN2Okc8J9dc3Y3pHAhh07uJ19E9U9/tYUzd/WZa8WzOUGRFtObNv7+4
         F2nLNZ3daDoNGwN73InWnrRJmjFMrGgT1yEqM2WSOLH/XuMv+qV5VDU7nFI2exg4oKx7
         tKGw==
X-Gm-Message-State: APuU4Z+TpvnZwEp7Ns8/XHv5GLzfx2d9pahKUvYItlBzaGQUeCFfXkhq
	/cacrTn64cOVNXqVW0pVh/x33as2A/Za0gd1MISF9pTXdUer69Ntb2gWq04ndw==
X-Gm-Gg: AYBFou37gzDjUh8fg6tpGdmSQ1z0Ll61hYsaZ8JUtV77R9oHZm7a1OzDjdB8vAiiZzd
	QHTkOAK+7plt7xx73bLujECo1S0Guo/OVzz4Xi0MPaAvQUfYRXgA/J9ndT2un2ru8M509r5Ao0v
	pQi2NqWMMgrHKONBSbV19yjCKfd+63W/Qci6RITrG9+Ucxs77v1PKuTg5n+S4dQTZCPbnGaOgOR
	xsjsxRE575oF5NfhU3TvbTxfmDvG2il3cKJpmKP8BtsNs9tH/p97Uz9MrqExAsK3L15PjbKJ2jV
	0DzLINPqeBkOuULA8+c4+wToBu8LflAWDGKgMFORrUtNcoCEqoEcUcXTiJgy8xp1eLsNq/AbaDb
	RnMsU+Ne+Zp0iK7sxVT9zb50S23gsWnr8iYsjx9e7ktUkCNTkjlqy6MWP6QG/W6607GKYh7U6VQ
	dfOAfAa/vv0vUiFGF9nrG0yoHWjfHOkL3JdL89Uc0hAyIacgrCsk1904AT6W9zNJurEpRXKOd2n
	KJGxddAIhZ73ez3mB9FX8thttNRwQxblSWaP3ZaN7p6sscIQ+jScMoVfxuUhkfqxtohjKBqWSsk
	bY97SwgW1R8gUUtLUvPZwDbbY50VvzvIFLjHGvYxg+GQRIrtsJgCurFy0oZGtz5yucjd2tWXCXH
	Al5axLBQlx5Bv5ufEKhOntFlx7o0zAFe0K8ZuKTTzkc121jQ80NN33dkFCWI24Y5QqtiHt/x9ro
	j8b546
X-Received: by 2002:a05:6122:1d4f:b0:5eb:7686:48f5 with SMTP id 71dfb90a1353d-5ecc43af5c0mr1853657e0c.8.1793990036734;
        Fri, 06 Nov 2026 10:33:56 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:56 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/8] shared/gatt-client: Fix parsing Read Multiple Variable Length response
Date: Fri,  6 Nov 2026 13:33:48 -0500
Message-ID: <20261106183350.3155282-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106183350.3155282-1-luiz.dentz@gmail.com>
References: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

The Length Value Tuple loop never advanced past each value, and a
length exceeding the remaining data grew the remaining length instead
of truncating the value, passing data past the end of the PDU to the
callback.

Also hold a reference to the request while dispatching the values and
stop if a callback cancels it, since that would free the request.

Fixes: 6ea204dca0b2 ("shared/gatt-client: Add support for Read Multiple Variable Length")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/gatt-client.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2b6da611b9f1..4a8bdfc441d4 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2929,8 +2929,11 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		return;
 	}
 
+	/* Keep the request alive in case a callback cancels it */
+	request_ref(req);
+
 	/* Parse response */
-	while (length >= 2) {
+	while (length >= 2 && !req->removed) {
 		uint16_t len;
 
 		len = get_le16(pdu);
@@ -2942,10 +2945,15 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		 * current ATT_MTU.
 		 */
 		if (len > length)
-			length = len;
+			len = length;
 
 		op->callback(success, att_ecode, pdu, len, op->user_data);
+
+		length -= len;
+		pdu += len;
 	}
+
+	request_unref(req);
 }
 
 unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
-- 
2.56.0

