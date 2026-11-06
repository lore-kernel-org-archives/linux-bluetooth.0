Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987114;
	b=WZ30Q/HTB6BOM+QiHrXRTEQ0BoIwGipWHImWMGuerMLoCgzFsCppV7Zaz6AXMEVmAO8I
	 Cp64Izpl7fI2FdN3FB2y0PSbQY+HcPTSjBr6hWJET1FqHCMKdsaIUhY0w/N9QA9yokXYt
	 796n+myrvxMyphz7WHcGXE9Vjqc/KnKWhdHAvdejp1S+Q+31ux7mVaugFSAESX/tx36Cl
	 +8LO3Oaexy93126e8XazRa6PGBmXFwOIXkPauturhI+6EETma5tZDBNxCPlSUzLUDfI3l
	 RyQFsApC3tuFM1lFYnOf5vAu5Az1JYtzyHpoRa3pDFCRHUl4wVVyQub8XIlO1gOemWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NpPr3T6GVD7LuPJn/uIbloXXZRbi2fJ74xUO0FNnVwE=;
	b=GgHZBYgh1PNZuij8hbhwuUayC5O2iv3P9mUkMgpudw7D7bEjo9RcJVJ0F1iYfdx8xMjz
	 nvVeoV0SmsfSHQO5LmoUKya7Dg/FcFl0EtPBpIFb+Zj95uspXGSS4Z0sRBgtDYo7oN/Fb
	 NI+seEuXfHqu+hm5qh4NKgVUE6UqZnKbyWypwM6oxLw00o2AF10fqag6wp/NvKYybXXHT
	 fax4HRSjLZp5t1KdUUIlQu+hCtRdjB3RUFtb7L7v+/kayQKTVAd+l4d8g99ePlyJs4gr1
	 cdTwlWsJweez6nvVOlX2mtIxe0StEVUFUet+ECxHXIZlppD8qaG/klPUO7jsoTqoLMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk0Q4IBG;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C3606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 17:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 909C3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk0Q4IBG
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a8cc11ac42so908222c88.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793987114; x=1794591914; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NpPr3T6GVD7LuPJn/uIbloXXZRbi2fJ74xUO0FNnVwE=;
        b=Dk0Q4IBGPdFmLtxl7wDnymgV2KPAp/bo6KOQss7f4x96y7aW0+YwlsvQ7ih8ziPpU2
         MGJsykD592itcZFtMCf8giG7eUuTA5Yv5w7EUqwUSVPF1ZsA1EEQ0vXsyCsOx4evDqMm
         yuZ1QOS/5h57u6C72BjC9qaFQd4Dm5PExSsLB4gJvtDQ8GD4Vg8nbfzoLpLqFTALjkZt
         pM4hnMpl4Kf7Y/EJK1HaM1tTQcb7+rcAk52Aeoc0nREU4exEwTXNl6dYrFh5nNeRoXeu
         7tWuJ078b17C/C+6GTpXQPaqMZw2X2dIXqgw/PqIj9wwXkTlpL62gzLgMV6cur2o/Bio
         /NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987114; x=1794591914;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NpPr3T6GVD7LuPJn/uIbloXXZRbi2fJ74xUO0FNnVwE=;
        b=msHB8QXzgRSVYXcFDVTSpr7F+hj7OVStNayfjH5lkJnAKUQVp5NEL1xYDozpGjktq4
         ZH68KTZcKyQH62+8aY7WMYdaOg3dCiW4f1AET5qJZM2qkvgnjhNWFmFHz0qgReh1EY4B
         +VwrXZRGdgDUArY1au0NIKbzsSCsLciNmDQ2LZJ+hgVD5UDuETGHUO6KeVzh+hkVRae8
         gmPs5RLyLZnaNMqaJralXyFfUdCQ82d0CS2rLJQGdE48eLpX1hC+vlLMb3fNILJvASOD
         So58xUPObFwVhuUDLmN0j5aTORtSb55tK5dG0njYXLe5eblyhRC8hUUeUW9RSsLzqU7A
         Y6vQ==
X-Gm-Message-State: APuU4Z+QkvjIfofolDbNnspdidAnRsATFRQAGGCGcS5OTNm8luKuQldP
	c42zFv7XT86KsATrEuMPynO9v7o9Y5unTw3A/lAAryLRcMh/5f7W4/GjorkJrw==
X-Gm-Gg: AYBFou3Y8zrrHXAjgaU1hZYvMVnPlTZ+BOluGlFsy3P+1dKH6q78zvnIVy8I3DQ+VVG
	WzsKDmN2pdQv+FRn5gpFiVngVClDr8r2Fvi2IiOgOLJKn8dh3MPE3Yfg8UNUfRup1+nqrEC1amA
	5UdmMQlpaibAbi+6MRMoH3viJcUWJqRkwYzkq9DfNZOaSQl+2AUv9zBhL6zNSz16e4JRcTvqvC+
	/hxYiB0LWBv4v1koA7jmQ3PjXWbPC7X4s8lMtapmSqWZ/sny+Y9bQJfZAWuCR1P3x5gS9PxdaKO
	/8lmv5LIde6AtF8OEYP6jZR8PF4ibtHmU09dnSR447FhqiABZXdOH60o9xkprBGYzW3cIy00uaP
	+k0yPcsGXd7uo0ZgyJrSMBkLQbTiuWMj5u7y2fP0iFgV6wGpA2xSMMJ52Jao/TqrFbxQqrANFG4
	l+3jwXNiOUBJC0EFFXyCEPUY+fcUqS5Ukuc6D8KKeqT7XEAS5YX7tmFtjMLna2Id8/UTv/0ashy
	whq5fCM4lNapJen6Pl5xOP0b5OUPV4H3+cJ/O5A2XHC/5fZxoOVqnso2RAf
X-Received: by 2002:a05:701b:2916:b0:198:b1e:90d9 with SMTP id a92af1059eb24-1b25d315409mr3284928c88.10.1793987113419;
        Fri, 06 Nov 2026 09:45:13 -0800 (PST)
Received: from [172.17.0.2] ([4.242.196.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e407bb5sm7383826c88.1.2026.11.06.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:45:12 -0800 (PST)
Message-ID: <6aee1228.54e42a5c.237973.f28c@mx.google.com>
Date: Fri, 06 Nov 2026 09:45:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1557189500076119191=="
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
To: linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v9] Bluetooth: btrtl: Add firmware format v3 support
In-Reply-To: <20261106100747.3380098-1-hildawu@realtek.com>
References: <20261106100747.3380098-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1557189500076119191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204022/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.39 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      25.11 seconds
CheckAllWarning               PASS      27.94 seconds
CheckSparse                   PASS      30.44 seconds
BuildKernel32                 PASS      24.12 seconds
CheckKernelLLVM               PASS      24.32 seconds
TestRunnerSetup               PASS      564.97 seconds
IncrementalBuild              PASS      29.28 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v9] Bluetooth: btrtl: Add firmware format v3 support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#883: 
new file mode 100644

total: 0 errors, 1 warnings, 1440 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14957122.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluetooth-next/pull/1078

---
Regards,
Linux Bluetooth


--===============1557189500076119191==--
