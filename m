Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213742;
	b=LvKrB5s6yIwT0yMA7KFYolgQ0UluN9IKk8hf7c+ZJRMWgh83ZdukKJh+Zwt1/nbtWVWE
	 G8N3KkA6qZfFALmYnBqufnG1x5oK2C/f0zRXWkk2IgGmKF7V66W6ANQaNnFwdc6qF3fDq
	 xAzpxzVYST1ghlG91i4XCF/41WOttIRrTgKJZqGNsuSbQdmJC6GmbsjR6kyo6dN80B5TJ
	 5JLu3rw8gPfU/jqPVdbN3OxcCkP6Zl9MSP/262Do+lnI9ZG/utzXm0rpUCKacJWS/fK/I
	 UlbkIOuaikarDhQH+vmFbgMHqPKPQHf66F5kQh1RfhS/5xagcHi5vCfKGTjGNA3DacA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=oQXSHTU8vPBr/YEDnGT4dsArQ3LNNkc186wzvozgyok=;
	b=ojd9fiJUsHSAkK4XUL+NYlo68WI2i/xXXyTdhz7vZ/Mlzu3/Cm0CTUlXa+15Bngb6kq2
	 IygiXWrFqc6dzFsANpC7heIimKGlXTyQOxdWkv0livhyMQldEOPlchShy5YmI+4iNNaB/
	 YsdeZTgmDtiy+P5ca4qDeH4xxBgc46UrPBduC8hQtNu9JSkVQEZCPaia9n1PwP7s9lrIk
	 jg5ET6VUFLBDKRNdufcTgKHXzYrMRhgByxPxGQho/v1KawZpOWZs9ajvGDjDlTslIidpH
	 tZKJGcfDFS5smp3FAh675e7GzSzXZBDKGlZRoyqk8gYT8JrcRNHV7OTSaChHTrlxYuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTlO9OJv;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489F606A6A2
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0489F606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OTlO9OJv
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-475920b9ca2so494071fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795213738; x=1795818538; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oQXSHTU8vPBr/YEDnGT4dsArQ3LNNkc186wzvozgyok=;
        b=OTlO9OJvPJTKSUJyw5moU0QGaoJz54cFrVDfAI6xdbRA5xuy8rksuMfG97ZhyVwUG8
         +jPw+75H9AVvw4AkWN7jpnGWF3yLJQktPbx20J9Dh+da0uURnVx9hBNyt2BS04N/abKY
         TRUqosXy3jXRdJMs0/YWQY0GA77ujLYvBAIi+XYtWsLfHJL4hFJH6i7xYIxxhadLzqo1
         ApyuPlcCOCV5CMowuks0rwKOMyxtLhW1boU/YBVcp26FbDPFHCsi65JkmHk48MyUuIeU
         iPh9nwCSHI1wCwkBquczkdmm/f87VugSAHtTifvMJWtBJAkszDCVOIn8mKIAtntpCuf6
         Oqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213738; x=1795818538;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oQXSHTU8vPBr/YEDnGT4dsArQ3LNNkc186wzvozgyok=;
        b=tJwR/RLQDS4KsOBNe6OJO0/09RPHBcpc8j+bfm37SlNWM0S4pvw3ntvVUQMkraDIZO
         gzFjsdCH1CeZ6mKNpZu3dpU7xUTTa6A7aruaLU9fnkWfp0t8zCt9HhrRBHjxoglWC7GW
         hDOPO/ThepeIHD5bysKLbnh2g6eV2Ulo/xytXgIqSruT4RfcTOwLx/bdDZ7ZA+aX6Qnw
         s1f9BkT9HbR1xJjAsGGSKWGdNSLRyo2QnR6Jx/rCc4ZbCNUCCbMkWKuhN75mC1eVN+2G
         fueEuabHLVKK5a7qLI3G3ZABKP/iC6BuqDyTpVmSRmwKjqs9dnIcyCfVwfsVoO3Q6x8t
         G8vA==
X-Gm-Message-State: APuU4Z/0R4KNAPovMZDzWKALomTDJaeqly6wApt96PDlr5EKbrVnL3lR
	2i1TX9JPplx2Wn8zmHATfnYQH6yWHsj8eWs/3ocjqgLpA+b8yx6eij5GBRz3IA==
X-Gm-Gg: AZFdTZdvc3mMJAOX3nXBf65jT8v2HcxgNrZTK3UJyq3MW3nRxe/zHHwXzs1qidL+fWb
	9LOH8wNsjYCsT0cGFiOsH9p2BIbItgyMLWkbfoY6Kww/ORfTtLafuHyjVUEbhrB8rDfGWBQZv53
	bbUo7n20Wt4U41/egdiV+haWy777xC0Kv1g+rW6EY/lCn55xje8ncCpt6XsZW7l+y4T/FMkgVL4
	Ir+Grk2fumYnt7eIAXobCXGUor9z9arSqxePAhyq8dBb2iK2r35EUgk5b6ENFOpRFfnEH5O/09Q
	E7038kPIt0yeUH8XMceum7dq5p07VtFknxM7a4VKRx3vGsy+SHN6H3FqMInmUa5tedWrFd9VYEc
	AQMnQVyQlpbHjUogu1lw5HwAALsAgZancZ+kVgLmGzqAYzRNnm1lBKCpgeQXjCmkjOUJilL+Z4f
	xy5YYw+MneOFVy5nryEsqtxRsGBUPqYtuzNLMOYJ+5AhU7d+7+Om7mA17WqX4uVKOsiA2UWFRlD
	lKb5Ci6k78bXvtwAjmPmBb0Z3vZ+QOWlPgTFmzrKJuObXQzLluzshlwLkYHRf8=
X-Received: by 2002:a05:6870:1415:b0:457:4470:96e2 with SMTP id 586e51a60fabf-4bc821920d4mr5034327fac.12.1795213737917;
        Fri, 20 Nov 2026 14:28:57 -0800 (PST)
Received: from [172.17.0.2] ([20.64.107.193])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60491337sm3925583fac.12.2026.11.20.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:28:57 -0800 (PST)
Message-ID: <6b00c9a9.7724c133.1c6204.87c1@mx.google.com>
Date: Fri, 20 Nov 2026 14:28:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8639836586082561933=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add tests for security of deferred setup
In-Reply-To: <20261120154750.1745643-2-luiz.dentz@gmail.com>
References: <20261120154750.1745643-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8639836586082561933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217494/

---Test result---

Test Summary:
CheckPatch                    PASS      2.20 seconds
GitLint                       PASS      1.33 seconds
BuildEll                      PASS      15.89 seconds
BluezMake                     PASS      229.33 seconds
CheckSmatch                   WARNING   235.46 seconds
bluezmakeextell               PASS      75.15 seconds
TestFunctional                PASS      1003.87 seconds
IncrementalBuild              PASS      259.99 seconds
ScanBuild                     PASS      839.30 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:713:28: warning: Variable length array is used.emulator/bthost.c:714:32: warning: Variable length array is used.emulator/bthost.c:967:28: warning: Variable length array is used.emulator/bthost.c:1001:28: warning: Variable length array is used.emulator/bthost.c:1002:32: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2859

---
Regards,
Linux Bluetooth


--===============8639836586082561933==--
