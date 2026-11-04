Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810062;
	b=TLYG93T0OXTyO8tRlPlpaxXeX0vdUXQzCDjjWH3ef8aG3unmS2jqs0D/hzb7M/mB/Xoi
	 0Y0tHZXYZ/+nP/DntiDA/wG6ylfi8xZn2kJUWehTjxMZidwpMH1MHIMOvB4iUwF7+03aO
	 sotetRBxVri3eAM5ZOzd3zSjsvaLL+wmEUcEgyM1HVyTXgnt57S5UHcrfObYHEerzPs/H
	 erum645OFVP4nGbpRCjywKxPRx01U/CXVwMtZIFsd7oVeRNEkhHRxX1TaVR+BFuQYeEMn
	 sRmmU6oErz9Se5WJBfFqQNUYjTkrkzkmKklcqbfKvxklmaazwaAt2Uy2urugWz1F2Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=kfqYol6Ex0k5f0aDYK30rU/TBEbes4X7q5dVHyE5V3c=;
	b=dNKMRZWgBegcXAzt4qqMNIs9Yns/ipa8foDl7P1lN0ysk6Ebtr4zMTjyqK8Mn61cDWzx
	 Tm2TBanbt/9oxpjVcA8XQ1CxL9ckqJOWRveZxCCqEkXsaqUHmgtJr1sWEkNGZR3JNIEod
	 JSPkHGXqQHra3KU2esuwAjrYLk2n5gZx+Y4MUVSPXV1c7OJg4kqxqp2DX12bqbYnIusEb
	 KZsiZzXNu3aj3B/LyNoqUbkXNro8TAImTBpYuyYv968Q2PyCRCl3E574O6pVj1c8xT2Gq
	 QT6Wq72qUT3FCfndIyOUwIYkZRwxkbFmB+eOrw+Ie9nFx9K6KRZIVqmX4JR+J4j1YTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iGPL/Y+y";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0597A606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0597A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGPL/Y+y
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dbde64409so249611eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 08:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810061; x=1794414861; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kfqYol6Ex0k5f0aDYK30rU/TBEbes4X7q5dVHyE5V3c=;
        b=iGPL/Y+yzANKBRQP9wQvL5O58zaNt4d9G81qGUi59w8+IEXJShtg02/j1IyL7H/tOC
         Qmcz9J3m7dUnW6XmvtvY34QcjjHK9dqOQfTnTlJuBq3twoWCZjdieOTFVUzI5OqAce57
         U/DpPFauF9MTCNa2u88BhW+8Jd1+Rv+OfzYrtcX7CgeuNIsLwyeDOcu6wey8nVQuv0sw
         9jOYS7T2f8l5gnj1p90oFK5e/ZYojB1mtQPBc9jhwE8XQgZlfZrvoUpVDoyTw0OlJ17Z
         iNlY1JrOKP+/HO/Xjs6DF+ztb6w4M0hc7x8Ma+389Hzd/MSoVJq7sPj4GWKqqAzF/Frs
         Im+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810061; x=1794414861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kfqYol6Ex0k5f0aDYK30rU/TBEbes4X7q5dVHyE5V3c=;
        b=1VfWt9J/VYgeuW2EuWkV0egzCYnTaEGI/ysNn3YP2UVLutnBKWPfgV7pyNSSLXW9OM
         Dr1NT5HwjGH0nlpbuKx1a65sgGYaJpsnL/+dEy6wkQsnQ4FoAWgwDeWINNWHhRZxS8TX
         M/4Ztl0Zg+7Odi5A5+IE2OyZF/HZHVfmwnTETAW1xGN9dRxory05KbOFj3LyaeBTZE7i
         cIZPtFk2dQda5XdwurmvQ/ld0tIvXZ1vb5AG1ZKIVTVaCVIl9Odftq1AERmyzd9oVYA2
         m0xmHS/bBFb6JwQl8Im/lTWRzfNED24vYXHM+dkws+uKpsuu7cOHdBsFVg/xVB8azGWF
         A6jA==
X-Gm-Message-State: APuU4Z8Uu7vpQi8/pgOGtM9z8oKUx1rwRDJC4H444k2IlufQ2+bWe0/z
	WwwHH0IC4xq87g5h1lO1P75+qUL7Ud8Gm5tUEidmOlId1svFmkX8FuSgPhlhhg==
X-Gm-Gg: AYBFou1h3Ii2wWZaX02vuCBrgJ0OXpaPUBCcLiqMl5Umkm1ZsGsIdCLC07SnvytnQGA
	Jaz75GUK/nfsc3+zEsGHpEzkEr4H/ALaBW5lltDwZAeyZH4G9niH+pFNVpsYgzwW/GO1eCFzsT3
	UDZv/obPp+K6Y/oM2XbWxTSHbteeQ8U2nHc6G9rtL8rSlN2jPo3b3KqcYzrIlEQnjKGOS4D2TBC
	h0zoJSgHbAd5qvXY1rOn7avu0CQOZXIBwP0Pro8cTHhll46MzOv7GRQ2jOsZdwG3EDavaFqrRfu
	Fv+pTqcijHxJgGomZMCzbMMgsi1IkzEdu6tkc5A/K+mN5+zYbThQiSXIn2nippN4Vuu/h3aq4iH
	l5G3iuzjn+woXc6cZ+tsuKySNTEn8ftowIP6t4b8JSRaO+hBSTBfAv8QxxKKr+sP0Z7ASGgoOUz
	7MS5a6N8RbfYEqEsgsms1cJMKNpFGJtERKMvzWn+YH1ZfDH87KFDLcIgrJwBE+kFenHVAkTJdkK
	w+AQ0uSqdJzBgYC2rQTYVFqUjy9bGmkWQgQ4QcTlPyDUpp9aYQr2B98HoPhaQ==
X-Received: by 2002:a05:7300:3b0c:b0:36a:238:1485 with SMTP id 5a478bee46e88-36a4244276cmr34974358eec.37.1793810060763;
        Wed, 04 Nov 2026 08:34:20 -0800 (PST)
Received: from [172.17.0.2] ([20.163.63.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3785430sm13019299eec.3.2026.11.04.08.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:34:19 -0800 (PST)
Message-ID: <6aeb5e8b.a5690e37.29c150.f94f@mx.google.com>
Date: Wed, 04 Nov 2026 08:34:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3718266387244857664=="
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
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: WCN3988: Drop baudrate change vendor event
In-Reply-To: <20261104095026.3414666-1-shuai.zhang@oss.qualcomm.com>
References: <20261104095026.3414666-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3718266387244857664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1201567/

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
VerifyFixes                   PASS      9.97 seconds
VerifySignedoff               PASS      0.89 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      20.82 seconds
CheckAllWarning               PASS      22.08 seconds
CheckSparse                   PASS      40.39 seconds
BuildKernel32                 PASS      27.41 seconds
CheckKernelLLVM               PASS      23.09 seconds
TestRunnerSetup               PASS      456.78 seconds
IncrementalBuild              PASS      20.88 seconds



https://github.com/bluez/bluetooth-next/pull/1062

---
Regards,
Linux Bluetooth


--===============3718266387244857664==--
