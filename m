Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281143;
	b=TFIIOnv5HtC1h2iLHqMJUB8sLkO/Y9sV/5RyHDI31zxwttRN7d8gecenNp9SeSzzsog8
	 zdSOvDcJsvlqluebhks86whP51fCkYVYaexxLAiKCEvODibn5uiv0R6P+eDfiNgvmbHIM
	 5Yv0z9IH9PdsCRP+XsXOtwPNlZ3GDFnd13YpiZDCe37joXQ/adL1Vr42+1Mm4owYwUMLH
	 0NLqMAPWIe3qnDSoJqcDwwfOSHBHg1E7zUYcBJuSY2xjyY5AX/rTAdN/h7yZ/FxiWVrA2
	 Njw5cJeUqKXIxtVcSU1Wv5sU6HiOlX2z6VuSQHqKIYi90iURf/zFjmMc9a7GobARdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=DxwFADrvqB1y3zlllLGz30XmoWr1efr1U7NG+ic2RPk=;
	b=FVE6qPKB0MarFXQPahA0syMGGXTAY0N1gfEHsGmwgHbv0546ZSRd4Be3Df5QAmfKU5/Z
	 kXP3ByfC28nn8YPlzoWM3Uf134+e53FWwjRK9JdaJ4KTwL2VYQYS+fzzK/9WUIG3gC3qU
	 Zt5C0KTxDEbbpsketTrxsPIBMXuhAgaSeTYR2ebAfgZyKqNkb2mwFgNfcd9otVBkckQCa
	 DO//9e/8S7f776VobTFkJ351n/gX2JKKIggK7ZM1otqRC+NANCjsXwCk+ltsKsJ8gU+mJ
	 RKcTqgqJUoSE3gSzKxfldM4t90uDPmSuFf5QlWhR0DE3mhDhbv7EkeIctJZjR3/ENbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0I30cl0;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86585606A32A
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 17:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86585606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X0I30cl0
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so1264071a91.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281143; x=1795885943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DxwFADrvqB1y3zlllLGz30XmoWr1efr1U7NG+ic2RPk=;
        b=X0I30cl0zXfCQNBSWlJZjbgg6c021PGDPwnaP2qaIDYZ9exZ4saV1hlV+j0max98hO
         Yx2lQns/k63CDy/ttk/4Uj8sE32FDbcX4zYKqZidFSl3oZ8poM5nPsZxVF5Fdayp0Wj+
         47IG9sualo8lcrWgedb9crkyQ++6Xh35erZeiXgpxiRX77VQnb6B0w5VbgCnSFAZg+L9
         q+MSGTtLsUB/Uta96exNyePtUuPV2F4AdSfGl50b4sR87au2LYjVuD86+I6f3/mKNL6r
         oXJWPdoiBkHcAfFBO7/XJcUblFgRELwHEsO13XknDmDzNmzYf1l7wQALO1wdhU0Yx6k6
         uE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281143; x=1795885943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DxwFADrvqB1y3zlllLGz30XmoWr1efr1U7NG+ic2RPk=;
        b=W6kjb8Q1NpNyXS7u6jPqHuNmObWfknlMHpD4T459k7cKXHLAMaK2iLUH2JeBnY3zWL
         B9xXWg2bZX3ItrKg5xhFZrkwS59L/2/dvYFOm4653jxqb8hQL1ZJwHokN1BuKmunH6/C
         UfBrVRl+TeYsjLmnapF4FAYOBhnbOl59Hx37jMWyDpLPPg+CA0S+hEybrpZf352kLlMh
         UTzeUYEvvIWjOUVuznC/+FjbtGHdSGp5O8dMOSkqxmvmSFICJRr+lmJAucfvr80Wri8y
         e8XximVBR7j5B6dzWjgJEIvdbxks4wbkkmuz7nYhI6l1QFN6sxrqyakVgeT1pYdx+QRH
         dc9Q==
X-Gm-Message-State: APuU4Z+a5lWxkAQ1CvCvZzsBWSicrzBQ5lKcWj8H/W3HhVlI9kSiQ0Dc
	LWRdhpQrfCfaRDIwdVdhdOsnXzKbq5aOI8gGIcPcY3mMICq7+IJ2szvkruCW+g==
X-Gm-Gg: AZFdTZcU+Ystn45Q61kmsxEoKYTYfh7nvvtsfkXGMfa7iyzvKPklh3AIbDsCZa5Up8g
	4ZiZXz3oUxXHLoTO3hOVgVWNkDFqWjafeuRq+Hq6EcM3V6hImSaZxK+6pnt0pa8CWQeZNKQBCoU
	9tUxQpFbIuyle0msc8znZzVgbgtiRZsLKK56TYheG+p0jQO1HrF1crWmm8Y+TFm4XyqBsrgiHzU
	gBlp19gU4DAEPgvqi/1jDXA1KzY/Wtc5/lGNSEmLQ/mMWKkBaIrcyHrcpA5tP7x+FCwczsBXuRW
	b6XANaJaPDl5SoJJRkeDxvcPeLPJvN9eF4tdBeCI4yq8HYNaqITiKjrmMLZWto9Dll56Mb24pIS
	4BGQdZ9UthYpgpVJNVOz1+dVbu7/azzpvT20UjQ3R7r8akC/CAFaBhLPxgPakJp9ceLeaxfPO2D
	oWWTkzhO8ALLE1M6xcD/5j9CLAqXnndCC2PfC/6MrGXqejA1YAg74zV3/ofgZ4mSXa73GxdOHvI
	hNhExogbBgohCnuaLNkJxHUzjoBF13QOq+kLL/jmZX95FDYYikWjlsZW0erNcNU3/w0H3vesWP1
	q9XYnAQR
X-Received: by 2002:a17:90b:288e:b0:3b3:ec88:72a6 with SMTP id 98e67ed59e1d1-3b41c85284amr6082469a91.3.1795281142821;
        Sat, 21 Nov 2026 09:12:22 -0800 (PST)
Received: from [172.17.0.2] ([4.246.119.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40548711esm12718339a91.0.2026.11.21.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:12:22 -0800 (PST)
Message-ID: <6b01d0f6.8505731d.1ce14a.33d3@mx.google.com>
Date: Sat, 21 Nov 2026 09:12:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8424442829542768084=="
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
To: linux-bluetooth@vger.kernel.org, enderaoelyther@gmail.com
Subject: RE: [v3] Bluetooth: hci_serdev: stop write_work before closing the port
In-Reply-To: <20261121155648.1151-1-enderaoelyther@gmail.com>
References: <20261121155648.1151-1-enderaoelyther@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8424442829542768084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218159/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      23.85 seconds
CheckAllWarning               PASS      28.10 seconds
CheckSparse                   PASS      29.14 seconds
BuildKernel32                 PASS      23.82 seconds
CheckKernelLLVM               PASS      24.31 seconds
TestRunnerSetup               PASS      573.03 seconds
IncrementalBuild              PASS      23.74 seconds



https://github.com/bluez/bluetooth-next/pull/1177

---
Regards,
Linux Bluetooth


--===============8424442829542768084==--
