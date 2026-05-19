Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03116F288
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156035; cv=none; b=odeaKeoHZjBLQh1DIa7FXsdi+KazDeBt/h34595qi6IpVEQjI01DoSQD1P4fgK1y2KRXirJrMx/tkiqhdsfdMFC2lsap4kb2M94h7D+N0JWFH44gD0gRd4Tep0s7Jfo/pRsGEBni5IJElyHmvMtlV4gvscovWbE1F18SP/SRb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156035; c=relaxed/simple;
	bh=wDq/KXpTZ9zdc6JYLD0WKDa84OWx2Sta1sbpAAaD8S0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gattt6sYjjXkfsHTWQf+4FaLpmo/p/iY2FrjIRLVSFtQkCpqG8Lful4LVk7hAtsvzxvp+9WZUm1/Hf3E11SI6I01cm9ZSJFdO8SMvt2GqsY3u+RNVaG21jJjGkuu8LjltFCwVZPatdieiYDBLR0bRE27guNbHt66kw3S0+cnHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0iKiohb; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0iKiohb"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-303dbfbec77so2332023eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 19:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779156033; x=1779760833; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39LWdyW2I/h3YSSWZFxyKcQm393AMzIv77gb7A868yE=;
        b=B0iKiohb21H4wjuW40KnItqFRWl8xlQgSoNip2O0kwHhCg7kGjy1x9R53ewAHz78GL
         omeiVAi2ShoZ5VL2xvNdGlO+z5ofM10BohCrbjfqmWAzDwrGHUNfM1cxYve5OJ4bXdcS
         1CdG4iq0oFwc8jMqaYEtopRqpCbyUUWaDInIcfDg3/xAkF2vFH3xAL9QWNHNp9RevY/B
         lNII9OA6QxoBUTRNSK4R9Rxg81LEdhCg08WFYeW6dvdOsdwUsGThVMaxROvKQ79lg0EU
         CbVCrJTAg9UrmsZiDkzkNySqcfkOG3L0qkWm7I34jrJPBQfuXw0+IOj8PbUtAqfd9/fs
         gBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779156033; x=1779760833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39LWdyW2I/h3YSSWZFxyKcQm393AMzIv77gb7A868yE=;
        b=ZFERHAdX3GVoPlOuHDTIqJcGNgsMTf2U1MLP7BNI8CuRXtoL2XjfT5hh9LrnpI4SRd
         f17TixdpP1hc2YbCmePIO5XPNhfwY4PoGkOEf6b1M5Hm+kNXiK44wu0Xxaid7NOzhnxr
         SQY65b1TE6Nj4Dg8lcZGRCTydvsUQNWEFQbOJA0B2RtKZqc5qlBzi43MHSKI9tTjcEuH
         KnLM5QZDOKJRPjyDTHUlE/eWs2XGfbSGJGYlgY66rA3mre/9Dv1zZj86GwHCn9xyTi92
         rNI5/8S/ayfXilgllgf1PUKyM0aXiIJN9f+dKjQmV2qi1vvQHQONSRCc9/HBUqwrsyJk
         dUQA==
X-Gm-Message-State: AOJu0YztdacK4Mg6MG45YEX1P6YF7IiEq8Pz/qghQbQi9fneRHDmSsv0
	fNEMGZoJi44KYQEGizReuhQqFFJZLYqrY/uns0xtERHzVCSbd+/7Ab8ojiaoLQ==
X-Gm-Gg: Acq92OHBQBACyeiAfthhkX0FnQb3rBUeosGTUKaEDiBAGowNcYOjK7Nvys5whm5Uqu6
	BpwlojXB/N6FZQiemusP1Jdm/TP2slB/8xIfsZdMmQpDVo2WTJTRTakSJD8tXl0KK6XY57sJTAq
	CONKgeT3LkKZv37H/pIf3JSuNfG3VhIzxvSUxj4wokfc5yx/aq7q8d6SEpfSgKb8Uy+LvC9h5s8
	6dXM2Z2n2POW3clyZVolYLU55Lr5m1v1LmFgebOf78euHk+TghhwHt/9k2K0MBJEUG7mejVFahd
	Z64ovr2gbrcHVzJi63vS/rPm07/kdZA+gTXm/2iam8b4X9zTG6gA8ictTqYdB8aHkG5ueCF2cx/
	vlaIIOY7LGNUxX2RN2Qgo40miYDgR8b5tk8bOd6fcorTHM50bT0ssP3Rk6OsbuECdRjgJh/PKYc
	nGoJQJMSyHyh/uQx1opGbPdUPeQ9VZ
X-Received: by 2002:a05:7301:6447:b0:2e2:d94d:6175 with SMTP id 5a478bee46e88-3039816a6b8mr7846703eec.12.1779156032804;
        Mon, 18 May 2026 19:00:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.40.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm15070612eec.13.2026.05.18.19.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:00:32 -0700 (PDT)
Message-ID: <6a0bc440.d7da0740.26af4f.6a0a@mx.google.com>
Date: Mon, 18 May 2026 19:00:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4897883968802007897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, meatuni001@gmail.com
Subject: RE: [v2] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
In-Reply-To: <20260519001437.156400-1-meatuni001@gmail.com>
References: <20260519001437.156400-1-meatuni001@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4897883968802007897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1096915

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.20 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.48 seconds
CheckAllWarning               PASS      29.04 seconds
CheckSparse                   PASS      27.45 seconds
BuildKernel32                 PASS      25.80 seconds
TestRunnerSetup               PASS      568.32 seconds
TestRunner_smp-tester         PASS      17.82 seconds
IncrementalBuild              PASS      26.03 seconds



https://github.com/bluez/bluetooth-next/pull/212

---
Regards,
Linux Bluetooth


--===============4897883968802007897==--
