Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858294;
	b=RLkgSvQh/U0vY6Qa5Ax2f1vMCItbZIrInAOKxgdipxGwCb2z2jk+xrFPNsRAl6lYa9vO
	 LkOdcS97DJbjaH4+izkKMM+MBMAg9AfGGnFPrrOV4DoUY6zjK7Bhx8TiULYDxOwa26+7T
	 rGvCMKy9RKz+E2NJI1BHh0XewJBLGwWDqDd3INFyS2zlsYfPfA6INV1GsOJikjQNj2mQJ
	 b7iksxuHw0SuW+olFwr/EbP8GWgy15eSquD23boYd8SgxTSGkBfw8+GTsDrZ7vgZPauAc
	 No4a4lWD0m3aithV37iqAfrMbY3m86rEkTN1GFsRMmd73B7hnamYmh6k6KVaIzrsrMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=v8P27J5FjCMx0QdV/oOuQqR2e35s/XgN/lbq9Tsi8TM=;
	b=wto+Nn5pYoRAVi5oO4kXBkmb/PhSNtSm9guIWvo47gPfkN1dLmQxdmVWn/QIkccEfkuP
	 odJwvOOEPlNrc8uO9cQScW0Md+4auIzX9efmpKBvv5GGAmJl1iWdjvk7ViBEE4QjVbUUT
	 KRGsMFik9Ibs2+KCLrW2YX/k0MUxP9G0RKRJ9jSTeGm+3umczD7k2V7FUUSkI+IcrjEFq
	 cyqc8FpMc8wstzONKB5o2AnCMhNbBw0i3JRRNDDONwzNHhK++4sSADzPL2drmAEiIWSbI
	 ldqiKeWJnvF2CgyZzwQFukb8l3X9fBC0UNrF+ZddgiTp3TI6r5hGDb2y2h8hhjbVVXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MS8O3amM;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDD60A2611
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 19:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EDD60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MS8O3amM
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-930c0f9c1b1so470023185a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858293; x=1795463093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v8P27J5FjCMx0QdV/oOuQqR2e35s/XgN/lbq9Tsi8TM=;
        b=MS8O3amMbFXFfdjM/AuayLw7A6xbguwwFI5jwADGekFWucw+JMrQcS82ONf9Agosjp
         smaSgeBcwu1gnsURiO4S2OsFRqyrq3mW6JtoJPZClLLQIi3TbB/hhRH0s4sdHozkphHf
         TaVATFr14rA0Ft9cUkk0w4kB8qXWouD58K5umuei4ghHj4EEI7pDpCRxf445hdDyvnvI
         fkfGVQSVhShpRfOZiAi/esKve8pcweYVhvn1HUwUhGTgrnK7UNAf74ozEPlIFxaIVKgE
         pca3ziEXKIBSBWrPdQAndbEUZLQyzw9U2xJTrINiyJD1SOl+NMF5qXNWuxow321yFvN7
         j/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858293; x=1795463093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v8P27J5FjCMx0QdV/oOuQqR2e35s/XgN/lbq9Tsi8TM=;
        b=l/TUUhgz2mdlTdDC2Nme0RuW8Pl6kESGnU6LRberO6TQjg2NKpqNhKtdKwq65oivJ8
         GLn4ST3wU3VV/sVBFWcQOnwmzYNAJfT4ue3aTtzaxwJl39F2XSMN+Cz/t4JXMzhjPwfG
         pVz8ne9fE0HbRlcjej87WkDCcEjYjewioqnREripEBvDUbLLwinS2VdkCjO5hnOJBqxY
         CmmLNERIuVCmLAvSoV2yTPFttv/XjrGNPNrX8XkG7kXLNR9VXcEsZsY/Xw2bKKROyQ6G
         3geEB9j1YWzCd9PWqtjpXHrv91t6MItZu8uIDcxrJo6aP2liIaveEvja5Uu/RRF70RkZ
         YO8Q==
X-Gm-Message-State: APuU4Z/MVOya6/E1dPxot+worUU56OprJY/Qa8wiwoqDvl6Zfut9YfdZ
	EjK9+yVVsCIpjJC+iCMwwYW31w1hlNgoyCFtxIGBaUjrxWWwucZxgREIgc/d1g==
X-Gm-Gg: AYBFou1gtmnZrZIbBmCbNPzEuLWwk6PlVGJuXoQDELELpmeJheQ1OELuTkSWAFmXZBq
	/9TS7jvCnn+kyo8pBY3goMUMRvHeLBK2IYnVKB+8oo0ydCBX1mb7as53JzqOjtj5u7UfbiID9te
	xHzoRC1Gb4CyNA6jJMT4+ry3zu9xAq8iSLpiN5Ohw11L/PH1utjmhRJoA/c7UZ3FpTWNfW8WKYX
	xnbM3KaK/UXQ5wcBj1HuGK4dUUXHkx9kmt5NXPwqkYINWt8D3G+PfZy9iZPBUj2Z7Ndni6tGxsB
	W6pzkXh8LYKHts/vvIsukI6XkDV8HzKi1qVKPvsgiBJSXVOD178m4u/dhnoJ8CvoSNKW43rvAd2
	QcRXVKjmIYjGQOF3Vz0K17qjUmsrkbsHn9Q0OlWXZ/XSjkWgS/d2phtKShL3fsXmK9S7B/CyzBq
	dBnE1yvVojsd3kYwd9pVkFD7ab0JLksRDPXYimmq7HG8OJJoT0bcem+kp0OJdShf+AvG2jhhLQ6
	I0HlPWIuVI0ScmiGM4ZOmwLPgRFJ6Ez4kT4ttiPche0FtAnWHudlEykq/6lGlPonQ==
X-Received: by 2002:a05:620a:4048:b0:93c:6ded:4665 with SMTP id af79cd13be357-9494ba4b5d7mr1789556285a.1.1794858292741;
        Mon, 16 Nov 2026 11:44:52 -0800 (PST)
Received: from [172.17.0.2] ([145.132.100.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94978ae5483sm393155685a.12.2026.11.16.11.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:44:52 -0800 (PST)
Message-ID: <6afb5d34.ced8aaa0.2426d5.f3a2@mx.google.com>
Date: Mon, 16 Nov 2026 11:44:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1472343997455473717=="
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
To: linux-bluetooth@vger.kernel.org, me@michaelmcallister.org
Subject: RE: Bluetooth: qca: Power off WCN3950
In-Reply-To: <179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org>
References: <179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1472343997455473717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212987/

---Test result---

Test Summary:
CheckPatch                    PASS      4.47 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      1.73 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      31.85 seconds
CheckAllWarning               PASS      35.32 seconds
CheckSparse                   PASS      38.65 seconds
BuildKernel32                 PASS      30.77 seconds
CheckKernelLLVM               PASS      34.54 seconds
TestRunnerSetup               PASS      747.60 seconds
IncrementalBuild              PASS      41.10 seconds



https://github.com/bluez/bluetooth-next/pull/1140

---
Regards,
Linux Bluetooth


--===============1472343997455473717==--
