Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD525D1E9
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169429; cv=none; b=MbahB6cfcv+fn6SUL4YMz4lXguxxvCPkb+YPUEz/GhWVCf9rQym2KoPGyhLSOU2bswh1YElX1UI8S4NWXa64Bqrqq354vRETFXMlYhIv78Rt+9uLZWzJxVPTZGzXaC197n1VvjOdiTaM4IoFU2vQMQOOvQud2lLMeTwXGjTe9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169429; c=relaxed/simple;
	bh=9qqiB5075JLDugLZzEjbi9/HNZDyWpStc5H/wjK42lA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gWDJZQnYsWsIgwwttalyNcMyv1xu1t94s34wC45SFrEk5Jqr7ZmXYZ227tkacq/OM9IIZsOUCQ/LmgGxY4+hQcJ0yhSJa7G9UTvrhro4o0YxfXdC+M00DJ22LuruyYq+wJNsq0nJRNiJgXLvGr7krlwrept5GlqGAdeyasMyA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4EkRa3/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4EkRa3/"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so140246a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Aug 2026 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786169427; x=1786774227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IGTvDRRjgXJgL4vIMs7yfNTQXHm2Gqm+OwvlH3v6wRM=;
        b=o4EkRa3/NuTogByHRfXl8PTUXmiNpVhaUlYxQ/VQuPCdStw41zAUa5kST0FnKxJH+l
         LjbinCpgu1ISDtZiieyuF6bZz7yjwDz99oQH2rgNDHGO6L0GzkOakWB5fWpN6lelyutl
         6GrP0aHkWok6VsEH9W/dxOCBn8BcRCpfJyQiWy+8SMfKAXHZPhf5pb+oM7MYYiwM1Z71
         CbopdteFnWwsJ36Z/jEEb2TQYUlzivC+gcQ1xFtoxyv4Q4MZ+j6ZZ5XnxNN0BOnmxtZb
         gu3iOHY0wAZH2+LJn8P5z3MlTqOXSEVSUFArcBiPkZMJjJ6Co1H1zz+2VaOLB+GN0UL3
         adHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786169427; x=1786774227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IGTvDRRjgXJgL4vIMs7yfNTQXHm2Gqm+OwvlH3v6wRM=;
        b=jGCJKVIrgzHb+KhFadMm6Y5K1Rs+7jRmIkuriedCjfH1EM4cwhpfZR0m52Aiw+2kf3
         yMRuLqypGZw2DK0FdkfTKVDtHABdayhOd4k3RvjVSt0gDYW23imGm4zCyU9pb4cspgdV
         7snHYM82s80uR0ESvaBOOXrNnZvKEaSLNHayLv7H4/vAsGytyWs64gfTwW6R0vd39ApW
         Po/EHEib8e86eavbYoHnoXMvgR+CilI5yRHWBPjS5zhVsbsLMLxgTScUJZjXFd2Dyf6c
         SRQ2wWlWJKQ+Y1bK9G5QAvyVqcPlUthgqE+oVMpAZEQ7Sd9dIdSU9gfbLd1kAR+XNFy8
         MUlw==
X-Gm-Message-State: AOJu0YzMf9gBuBrd5X/ZKvXW5XqbnH4Yu7tkjplKreR2qM+jYnRPyqp0
	MAX/1Lmw0FHZ9OWYHQX3AqWYy8eN0a1l4vDkTKRaM6zsSKyWprlmTPEEfjaShw==
X-Gm-Gg: AR+sD10Z4zHK0tOuUchN0Piuol2MK9SrRHkwizrr/TtYyUofjDyCINWuCA4YjtyACc2
	xWZDkG2h2eWJU3sziXZJ0EMfyLlJZ9BnOGiTjUFnzvI1WdcYNv0xOFe/j/YkxCBCUDXsC4wxqsX
	/XhD8dJtSPJXUI4Ej26FJwFGapTPfp+ltxtK+ZNLJl022dRBcuCo1pSjWKh3IzzF7GV1gUpYqw/
	NE1B1V5N25pYF/GeYBBA779JnRZshopk6uvIt9vDbaoaSTpWbkTa+pxKuHp0JxQKTsjdPFmNLJ2
	32WhIbkiJksvryztSqhLjwFq2DQBjlaqf5lBE9eZEONN6+eDgYRsrQ7kRie4932J0846CP3Ws5g
	VXNZRvFwlkXWlpw3w5WFOVNiiKNLcuSBDNDPhZuM3K+kJa6s5IlduIx2uandJuHrjUUd0YVN6e1
	Mq5bhhdpeKkX4G7QXdmLqm6ndJGykM+3KJnL0ayWtR0ujZCSg1BqYR/JCmxCm8rRtw1xP4scshf
	D3E6FQ=
X-Received: by 2002:a05:6a20:3d1a:b0:3c3:719d:dfe2 with SMTP id adf61e73a8af0-3cb85f4e179mr31448196637.36.1786169427081;
        Fri, 07 Aug 2026 23:10:27 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88473sm13940747eec.17.2026.08.07.23.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:10:26 -0700 (PDT)
Message-ID: <6a76c852.881e6cae.4accd.b68b@mx.google.com>
Date: Fri, 07 Aug 2026 23:10:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6964388287668267346=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, proxy-alt@proxy-alt.dev
Subject: RE: [v2] shared/gatt-client: discover the CCC descriptor instead of assuming it
In-Reply-To: <20260808044531.71229-1-proxy-alt@proxy-alt.dev>
References: <20260808044531.71229-1-proxy-alt@proxy-alt.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6964388287668267346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142530

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      20.17 seconds
BluezMake                     PASS      532.41 seconds
MakeCheck                     PASS      19.72 seconds
MakeDistcheck                 PASS      152.93 seconds
CheckValgrind                 PASS      222.95 seconds
CheckSmatch                   PASS      294.26 seconds
bluezmakeextell               PASS      95.51 seconds
IncrementalBuild              PASS      532.08 seconds
ScanBuild                     PASS      864.11 seconds



https://github.com/bluez/bluez/pull/2388

---
Regards,
Linux Bluetooth


--===============6964388287668267346==--
