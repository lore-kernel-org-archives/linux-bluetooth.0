Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507277;
	b=YffUr1HiZG/qrlukdSIHsqGKuXywTjmyFQmFxb+rhNVQq3mQM6hdqBEOIEtIOhzTVIov
	 86h/A+LFPomVRu7OIn58Jr51UOkq7vVG77GQk8AJcMcgQLcbNwxIL6tsP9UM1ZhYSSnHW
	 ThPD9u/yQTcnF/doJKrcuncye7z+XVZR2sEs1XzA2E0/4nPiepd0Sj9uz+4uUASrTgAxr
	 IJschLyRnaIdbq/riJaAdDgP1i3LgXN+cCA9xYNRTf+OLTDntgQgB9C7mRkQgNDYcQmRS
	 oOVeWaJu1sjX3navvSF88yc+8pTQyCWhMKAKVKwjM+uAFOOgk9pO3CYryiZ/vdul8SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
	b=UqXwhxOiDItul+1BkXB8jLnjCYam1uI6n0kjDHAewJWP9TUaOcYyOPdw6dK2Ccbc/QyT
	 uxO2Dr30vB482KGds1C/d2LfJtlSnkBZeX0fnRR1sSOhfh8N4V1cisrt1srY7msO6QXjP
	 ifOp2IbNjHcqVdLyeJIA9dKvsq7Uol7Qm0RRnVBi4A9iNU/26Z1VY3se5T70H9JNy6Fmv
	 ppOFQABofD+uy5qNFQf/rReSKV/ibgNaJEydPRyDy7DCaz6sJMeP4hIz2BkdAexlaevkz
	 lfpnQDty8yTFtdfOXj29qniIoQZkvN8eBqhp+Hq/+uVliRQ3XTYlIhv3vr/aPHG8z+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doA7S2bX;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09E606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D09E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doA7S2bX
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98fea7e52b7so82190241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507276; x=1795112076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=doA7S2bXecApk3nbXkaokBJirdaW3uLkyTxVU8ZEioW5BUcjwyLUC9IlprlWDZFQeb
         xxHphk5lrsPn9kb8byL88HFCvZPduHg1R+WLmDG0Qx3ELaGF8XOI1lQRgPjhRaebeTy/
         /5mlWLZvfi0EKcY0dDdeVHbOqgpkajKRSnGBXY3DZS71cIFgrlmRz8yYB1LPXKmgyTTF
         apyKo9toU2Kx27BVH9wGOI2wB2WfddfH8tu6iZpHAG+X1Ptaz433ji6n67n34Kr9VAbT
         EWoqbr8xdU2jSP7NGDpsfSDiB2nvD3+4ghOSFW8CvT0r+C6obSyjaQ2nXqZ9feMT6qax
         mIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507276; x=1795112076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8UWQwwIPzi1eSYvirGUpwcO4+98p/xAucINZYWnrkug=;
        b=BzHCBqLuYRMAngVjgKTVu2eXfpM8WxYZEq+yhDNL+jvhpKpWOmI7yUW8ZOs8ZU8PK4
         Quc4PzxZ5Uo0xJKB0pJr6XRUNT/7nlLJvGeldA8ZE+AWWFoFB+59YoM1y31x0sklTit7
         NWPOcKnieTwYhsCy26rOBuxjZxHLXHjdb/TJWMqTEqdkyKMoJVTsWkk9viRoAdu7TOWY
         dHcaMrNTr+b1y5u/s7bgygRCRPLD+JhvGyBed9C/QcrXgeaLkcFofNlYyn8xkTwWUMVW
         z1r5nNmLKnR+iEW3oWTU8uM3GIS5U7CsZhrNAUS31kt0hN9gn2F72Yme3HRnCrq0o63Z
         fUog==
X-Gm-Message-State: APuU4Z9FbVcKt0oOsEbNYKJ7uh+Ih1uIVeYtmjuISEfaQt9J+2woYk4t
	6Nsg+BGZYeES2XyhCF9VT9BiOXdpIaNqHAcN2EVG1Zco/jfWzsrRW6/nv6Kn+g==
X-Gm-Gg: AYBFou24+pw84q6cNlbzN4VkwNUDBU2ZKJJKLWd+K+0wK6TzTYLm/EGv9aT/WgH6srx
	Fk4tMjPpLFyMlm7kmWB/D41ZffRENFwfl7NThBF4rVucJbFeG1uirveS5kzhWJhU0wn3mxDNY/+
	5kA7nSVWb2IzkbD6b06spoCmAYTYf/3CMQgQ7N/Ry0adxQ9rQySWU8iYwJbD92QbKa6zEPtwVuL
	ARDOE7UZT+V40NnT90lfyR3NVHS2SDi368/4PiaWM44v1CevmXal/sstNfyDCscETNySYrootjw
	TeP6CNJMpx1U3p5Omp5LgSd+MMCk6xVyzOI99teQeopU6eJx2+AeeJZnquKhVeiYm8EPeqrnSus
	oQFiuSdl4eJJ+af5XgUV4oXzYivppIKn5VgB3q9ZjsvAVm6dpyqlvIZi6QePB343qnlvAlmCaOa
	jhd2fhG1ovmyOkdNOS0V7gV/M0VnSRd4fUIN2Y6zuy9k1NxBRXx7BTlaO1CGXhhmghlT+EzWmmB
	9k7PAoz972esq8JZfWNPqymKGoDTvEr84njrPRe1Z7G+J5FwPEV2zB1Le94QU3KfwzAeoibiKBj
	VYKmBJ/hwSLrUdXHHwavZG74Q6BkOZP6dTDAW6ekAZJCCjsb6J4UZxMpsY0JmffC/o0xuzf2FPg
	DxrSlOlEYWNRGmub15QhugTTVVUJBAStpz77kJBDLNKq0fYmQLfZ+KtoyxPLhTeQfmGs9vycGKZ
	eWTno=
X-Received: by 2002:a05:6102:4447:b0:7cc:2c52:47aa with SMTP id ada2fe7eead31-7d64d12d2c4mr37595137.0.1794507276119;
        Thu, 12 Nov 2026 10:14:36 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/6] shared/bap: Update the remote PAC when reusing an ASE
Date: Thu, 12 Nov 2026 13:14:27 -0500
Message-ID: <1c41577456acc2457f3c5177d9380eda950649f0.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

An ASE kept by a stream, e.g. one the server cached after its release,
may be reused for another remote PAC, which replaced the local PAC but
left the stream pointing to the previous remote one. Update it as well,
so that it matches the PAC the ASE is now configured for.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e45d12144acb..4fd4055565f7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6975,6 +6975,7 @@ static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
 		 */
 		bap_stream_clear_cfm(stream);
 		stream->lpac = lpac;
+		stream->rpac = rpac;
 		util_iov_free(stream->cc, 1);
 		stream->cc = util_iov_dup(data, 1);
 		stream->need_reconfig = true;
-- 
2.56.0

