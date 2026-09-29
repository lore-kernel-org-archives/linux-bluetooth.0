Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86726331202
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689120; cv=none; b=GfAGlIYkZKIhfEEK5MsNX/CalaDlseXXwPtIFJAgMLo5Q20MPoHYn2PP/NX3DSidUcyWt0PBShFPOmvFC5jdq0UbKr3TKgBeXCSCV9rSOptRt2RCzzd50EavrE7Fy4eAEIVPEuLiuwqOJHv3IS95W0FXKVflrIFvWVDVZBApUYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689120; c=relaxed/simple;
	bh=FEVzLnXoQLp1D0D47e2lkLwVtBWTYzYprQ5koI+KUYs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=COOd8E83qNjrWMfyoWCyHb1XQ8X4HPsYpHjGlZnw9Is/QLSCoDokuig6jpfxOUZ87bjdCxMqCBP5aSfa3obpRGDbcNSdvsbU9acxJlkaft/hFdJoDrn7CP4toHLICBb+p2BoFreWhgizWH4lZlRrOw9DzV71u97fbCWe22qo4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHWkOXgB; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHWkOXgB"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b026208d8so1380288a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790689118; x=1791293918; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mFaXufqFnHzlVxeE8nHJL1eUVg+PC6yV5U07cyj2MUo=;
        b=lHWkOXgBQsVJr0KmZqxeF/Y+sLTVQ//iB/S2Em5t1Jn+yl7Qc8XBz735Z8GXmkmgz3
         5Df20uSEbbejddbyRo8ovD8i000OZIo01T9HotE1cfGmoWuiTk7GLcVT3Jlm/nQjPv7z
         a1emn0icK0bOIHawfF7r1jjKTqGRN3JkRCYPkItgwQJpe0nM0AIz3zHLx84txUUE7r+x
         CYfaVYlCebBYLdGh1ghXg8hnT0UoqmM7PUfg/anL30HtnyL2ata90LCeXLzxXUCAT1kI
         VAYw/Umy6qNcN/sngQDIxHQ25ai+U0+RmMVGKOaWNTjN1Xd6PJ5ISQ9El//1JzSb02kO
         NcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790689118; x=1791293918;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mFaXufqFnHzlVxeE8nHJL1eUVg+PC6yV5U07cyj2MUo=;
        b=zuAoFiJvfHhMDHeiLod+nZtOv5SPSOXnIPBAl68gY8kmMPW8rBjyEroC5JeF4yIaZR
         qcPjITT4gGzcuTr5w8h4SgbYMO0uO7WeZEXlBmjBxGCtWq7asn7f/2pPGdvTf1Geu3Sv
         ONVaugJISp+9+FO1EgwhogI/odqVjSXCVazKhSbGUOwBjy6knDW/SFn0BbjCiZyWxwGo
         +iuBgXybvRefJR+YATLr4f5Jd9aJP/D/acAgXa8DTJINUqYbn8RvuGmHvdc+xnKfSDma
         63yVYaP9WeaJ68z3zgutrL2UVRjyLKMv45jSHle7TAUA7o/eQohTJrkGU26NpSD/Wxt9
         xF+g==
X-Gm-Message-State: AFuF++lbQcgv48pLxNFyqMRvOmPAgRwrP2k/TidIZU/McMFEu+J/e84I
	TMymrzf8fcvksA9SdIJ28yKVa0d9+tYBDUN737a0m+aatSSpAKB4DauQWroj1A==
X-Gm-Gg: AYBFou2f879qSglWip53d3vN5OeITkJ+iyPLH8vf5i2PSwLGCFpAtangDwKmoFubSp+
	nnl5mMl2RU+0TtYEZMBwmc4UvkJupWHW8sg1GDsvm7p/jPCM+gBDBNbpBYvLyrEF/pkuMO/A1nx
	5U7xoqukEFgRhHWuaXSiw1Qye0c83WaiTrxbVbPTP0vAT+3/1k4awcQ5IcEuHqjC90s7PI6GeRl
	0ffkmA1Jf1UMfaMxVT8DZqHv/Mp8tfvuCEDOf3lSqAbieIeRswRy+I7tQviGYQOzvphBz1lqJ9e
	gk5C4q2TWxvevGgB7aQVHDrrlgXa48HsNmxmG3fkdVoPbH2a8L1dO/4gc9ZSR5afLqlCD2opxB+
	fN7Hmy8sVELP0zbS8lTIPIca48ip8r1K293lP60nrXGghudLrNyuIStbpfUlsRTySDkdDvIzDHC
	D8mcsFPPMvNaSdanvMQ6j99fxE+deHZ78OfBeBnhUmT4miG+66jkn/n8m9G0IDsmRNoI258dMbL
	OHCZ1I=
X-Received: by 2002:a05:6830:6739:b0:81e:bb3a:7ebc with SMTP id 46e09a7af769-81ebb3a8024mr1769055a34.26.1790689118247;
        Tue, 29 Sep 2026 06:38:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.138.187])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d584f53e7sm4633974a34.14.2026.09.29.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:38:37 -0700 (PDT)
Message-ID: <6abbbf5d.8dbb2bff.56044.ab88@mx.google.com>
Date: Tue, 29 Sep 2026 06:38:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2876668513366412832=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btusb: Preserve event and ACL packet ordering
In-Reply-To: <20260929064556.1461915-1-kiran.k@intel.com>
References: <20260929064556.1461915-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2876668513366412832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1175800/

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      29.29 seconds
CheckAllWarning               PASS      33.41 seconds
CheckSparse                   PASS      36.09 seconds
BuildKernel32                 PASS      29.29 seconds
CheckKernelLLVM               PASS      37.93 seconds
TestRunnerSetup               PASS      788.66 seconds
IncrementalBuild              PASS      34.38 seconds



https://github.com/bluez/bluetooth-next/pull/838

---
Regards,
Linux Bluetooth


--===============2876668513366412832==--
