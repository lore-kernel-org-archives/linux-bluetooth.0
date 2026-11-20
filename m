Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795132839;
	b=eEUSJQ5U+PcY8yPlEQx5lI5Z/YXsfUfL++Q0irgD+H/zed0hSamUh6YjYUoW/VOlCiFl
	 luicD4Vt1OpPVD9qoxWwtWjPI8JlPFJ9atNJIXmUDDxfAPjJD0X6/tLiijReJFh+hGlxn
	 9RK8QsU1V/059xTml9n/TD5MQm0/CQaC7MoW46ps4f7UZhrdarOdKGbqy/sJ8xIdL5Gv4
	 keV53AayrADv8bf1thVR83DI7od5yWSCGSeU4cnDKZYrWpeK3aQuRgkNEYLSfK4WlvT3x
	 fbjblk8IblHFHa+ThCoM41MWJ9NspKb9pTEtoU/JxnJ1ZVkWZ2/0JsI1BlKT6WFgpUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=W0tYFLt0oaiF6q11oWKCW83MLcJTweo76XkXJ7GXpyk=;
	b=z9Fqj9WWfenJaPQNxsIusyAdAz8iwIUJg4+thlKSH0Ebdsy3/dWBlIcvFU3ZEQ4zjJmf
	 IYYQv6yJWnVvCp5/yyYmRIeFDhgvpTak3xppVog+YC3oc5XF1zrce+DWWarMbDvYR0E3A
	 EsVnTfCllvPLfb/c/t/uM0VpBoHeWxiaSwnkIVXMX1ZRmE7QDXu5z+57E8gj1i3s9tJcV
	 UvMvYz82+h7LUfR0riqvhw8q9l1DEWPZ4zMfyjkklib5+S4KOc0ggRuK3OBBkI1p6dJ2K
	 jjG+JgWt8ouwIHbwmw/AvTiOyL+w+yUZZpAaV6rHl70OXcB1bCpl+cf4zsID/EVl/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEP4saMI;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D25606A32A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 00:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D25606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vEP4saMI
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso962043b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 16:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795132838; x=1795737638; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W0tYFLt0oaiF6q11oWKCW83MLcJTweo76XkXJ7GXpyk=;
        b=vEP4saMIMlhm2Hrd4ua9iOR5vMhlhYSCDbJBrM/iiL+8WyvffEG1qbbak7HcnbhNFw
         Oqz+O1qXCwrHhZsuImxxoyaonTTICqujTRvjuoAIdhmxi/vEAzTUCBW6VOFFTULiRlmS
         Pn/aax4Na4nZC0F83Tftjot6Dl/TNO83O1Wq844bxzA9y/t+RsY9/6jv6A+mI9FHX1WM
         xcz0CwEj6QyAaHvDYnllwvGn2zYOza9XCXplAgutsNFZbcaUjPVuIFgNxNLRK6F1X9Y9
         32umilSNJfPQsl6IYZ5E0Pq6Y5op1/9MpMZWtahEuwXp/T/NB4N2PC5zWiaAReihOpym
         eYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132838; x=1795737638;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W0tYFLt0oaiF6q11oWKCW83MLcJTweo76XkXJ7GXpyk=;
        b=sIENf9pI89SIy9LrdRgl0JcOe5Ye78ZWsa74NPXtnO36xAVgPR28idjmooZOCdrLYo
         I4d/d3xXenSSTGJETVJYkse2qMQ/tOdTGY2Iee5Ae/1mxswwCyaX14Yvtq3/qeHwTDrs
         mZDXFeSobtG0rMwcwpDvDj8fzU9/lhce9sdLe4Uiowfh2+M5Xy1bDDZvFtQEtNrLSWiD
         UvjLRIgUaqnaEFTk0IfkcfTXITIBDYWVtWWHpHNd2SkOHojcBRyp6ghmm3KtdkBYdvI0
         BDGt230aNY6WhI8xnz8PGPfljZZfVTQo63HmuxcHJYdmDSPlLEOtImsPh4EEGiytCXYG
         hQtA==
X-Gm-Message-State: APuU4Z+NbwwICJ6x/zfUi5KKWuXO7hpnMBq+RkqoUEKlRs/q8C3HNT2+
	SykI8jGyK8RRqZciia1JZJoVR1S5BhCqgPXbMQPLMt3tyHtEtTHWhAfnULB4bQ==
X-Gm-Gg: AYBFou2nhv4oyyVhNvrwOkq0pzHmS4cJv+xnbt4NMpx1y/K9CaAB1M6uJBdIVDnX/iE
	3zUcmKU/xuFx8uyecqQSUqzcHz275nmTY0CW/GjsCuV81oUqJWSyJNih3/gPXdC6v+IYDJKH93f
	a05zw+mnzCPCuIwVUhyVL1nmNz/ChwANOR0hfo+BAs9Ys7YO0SxWUAjdBsNvnpMi0F+A2dgL/tQ
	9dohEKZUwlN6b3GaC0pTw0zwPthM8L/Ad4wRtUf4cfswm5FL6AX2B+HNXMxafDuSZkBmsxm+MgM
	CySjaNGV3QEr6sAHwgS058PJ4G1LG5mDgVx3+zmBCzKI+hNeqxnJ9UUIHHE3ArlTzjAubw2GdjR
	GfIy9awN8qHLOPSyOmWBlL/cZbXr40wPCCQEILi976J3ybXJH1Y64Y3OFfrtFJFS8vNI6C/dtU2
	SlU0CTX+6T1oKSxjorciGZIlugrOAlwXU6j9ScWdap8wLz2SHHa69Ofiv2+NR8KKJtBZgOIZ8Mm
	caoVgT+pdQnBYY7Mk7GoI/kBrAtGvqvR6mhObEsY1QV7+7xPJgxzpCbMeGIeVAf
X-Received: by 2002:a05:6a20:938e:b0:3e1:1b65:fff5 with SMTP id adf61e73a8af0-400aec10969mr2045705637.47.1795132837884;
        Thu, 19 Nov 2026 16:00:37 -0800 (PST)
Received: from [172.17.0.2] ([20.120.222.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06503dsm402731a12.27.2026.11.19.16.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 16:00:37 -0800 (PST)
Message-ID: <6aff8da5.838da7ce.ffbfb.89a7@mx.google.com>
Date: Thu, 19 Nov 2026 16:00:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4019291944063802217=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Add support for paging over DRAM
In-Reply-To: <20261119174149.3355356-1-chandrashekar.devegowda@intel.com>
References: <20261119174149.3355356-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4019291944063802217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1216477/

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
VerifyFixes                   PASS      0.06 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.16 seconds
CheckAllWarning               PASS      26.12 seconds
CheckSparse                   PASS      28.55 seconds
BuildKernel32                 PASS      23.00 seconds
CheckKernelLLVM               PASS      23.74 seconds
TestRunnerSetup               PASS      544.09 seconds
IncrementalBuild              PASS      21.40 seconds



https://github.com/bluez/bluetooth-next/pull/1161

---
Regards,
Linux Bluetooth


--===============4019291944063802217==--
