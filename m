Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736653;
	b=pHJC5WVgD81v0QDqeTCatNFwLD5gmiXL1JNhfz3V2eT/M7LDw7X+ftVW18JcWgIDfX0b
	 qR/iPb+SmBQwUv6zk/ncZmv7lxAwfChBwSyc7zvbz+UPJieJP2oYu1ppjxNovWakyfZYn
	 dQ0GOq1MwztfXy5PYPW+2LuzMWG4DaFm8JD1Z6Kb9TVVJJW/6O64ifPo4U9eqWnW2seEc
	 GgR1dWbaNVod+0uJUGlsYZIA1b6H2EaA9Q+tGX0dy9ccOtYsnVAeJVPXAYPWNRcT8MPFA
	 rWhmSJ1dl5Y/kju+Aa/Y6TTyppSdLujwVfjvIdGEhPhFfVOgoxfXQJaOWNfmc8hkFTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2rawxc9xTyyuu73yUVpYl2I+i4rTfDk5H3dN8cLE96Y=;
	b=111h4Y1IVOjAFQ7YUmnzxS9kg1RiCs2OAWQb+LeOQU9GFeMnHEH5KMCwzfBdoBIHeqdq
	 a4V7RbeE2KNyfXrtSnxYQyFUK6ynE3ROlH957s1re4yxDoG3F2uqnrBWoX8BgoUBHBl1S
	 4P4h9RvPVgTsp0Xn3CtINJFK7TYqiABkRtx60Quv2hKI4dEHEHbzQXL7YIDfKN0TDUyu4
	 uoVpHp09shFQtWFHQuxsWhju93MJwRTonYewZUn5htzFVtjBcfVwR8d5mHCPdU1/F395D
	 wUTKe2carCu4AYnChHYHbsfHWD2uvvsCEai4lrH/ur06m4cssLIDBIB03IBjZdiJskw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A91N3v6U;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C2606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 23:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A91N3v6U
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso5336851eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736652; x=1796341452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2rawxc9xTyyuu73yUVpYl2I+i4rTfDk5H3dN8cLE96Y=;
        b=A91N3v6Ugk1RTfzYBxx4jatf6BiaDcH3DMW8Q5ohdNcobGtrlyXK9ZJZFzkmCCM4e+
         YsbQplZ6H8NQhqiDhfxFUdeBiAgZLPgp4Z9pGMa7NgQXwnI3KLto5QFXiWNEV2EplGzS
         i5ET1UvRQjctCwlYIkdInIEBtN5eGih7xsM4bRSuNoLbGhrng8Fy+sasIpccFBoCdIB8
         0uk5NnErr/6FmtvseJiarSKddVIFzY5MV+85i0s1oHZ3oKKdpKsW+1c0Rtw2fUZeIa/h
         A6MCgqJUWL652GB3ty4GSRRP4mXm5AW60eMBGx222Jz83mAhXOuFrycUJPFiJuD4fSZ8
         Hybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736652; x=1796341452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2rawxc9xTyyuu73yUVpYl2I+i4rTfDk5H3dN8cLE96Y=;
        b=vSCJG4avhpX4BCBVP9y048xOBoCq5GxBNu5OV0wve9w4+p/9ZfXiEFYx57u0WPsi7n
         CIa6k02l6UCLtUxykbuDj4Q2l5G8eNXV2fKuE47feeYzSCvV7vtOjsG+Q7D2xg/HQsT0
         A9pz65yD6bXE43Lf6AQJvpwwTPKaBmjeBNbQvA6vbIADJzyE80hP8ZErsQAh4D8PZjXS
         emUMYMxesIwEY0E4W0OcZ4jCGq3QeRM2Ixwenkgwk8yA4R3JUqnRTZW5fLXkrQAAK2eu
         zJzZZOk21XpNuiUP/N6DB3aJACnJLHtE3oT4REkMBdnq9nSvcDsNDABnWmOwjZrKe1Od
         yc8A==
X-Gm-Message-State: APuU4Z+wWmknVrwhYZ6NU7TeGYcMnH9IS+PTmXRst+nfQCr5QUvx9tYS
	TJC1scyS0FzRfccRJivDw+IOPXNHkcUOLUb75hATdQefHGrD1dvz6JFbnA6h/Q==
X-Gm-Gg: AZFdTZeE5kID7YCnI2N2Znm8j7hU302rXt6TN2oG06+DAW6aBgJUd5DYpx+MPR3NR80
	eEGUDWxWbHaOzwiJKscwVg32yWgGx8/WsbQTg6chD/KaeVDn6XrnjuJ4ek42V6EaDF9eF1znYKa
	0t40GF/7qrf3vyk98fgmI4Z/hEi3gBSjD5ZxH9OWe4XcXPicv0C9gUFwC1fIuTkGuaOqeUZ/8uw
	bn1DFbJBBA9Y2haATr6Ucpp3uhtOVEhO3EgdrL1GELcgYVUPqVTjh+mM4S07cghusBBQEtIw4CE
	muftT3s+CgmzKj1WWMXRqJSIIfPtwDn5s8pfF+Bxl6joq6XdDPTmRGFOgx//oXrX2CQdq2D9gM7
	olxZUPNjk/IKWlfcFBbWUc5sSbERmVh73hap1S9mWjxKUBFoISmvkGJFOdw+GBGG+ZT7omGkfUX
	U2JGhir2M2MrDv2o6xt3GfPjazAN2LAJwSBTGbIT5JvFbo49JYRmlB7cyYaAqqABKGkGhYJRAZQ
	pUqT2W3bE6gOe59R4qrOYx9drRkD/jLthIUANjzWLsSCXLgV6mG4As/E60S
X-Received: by 2002:a05:7300:6da7:b0:384:5885:2f81 with SMTP id 5a478bee46e88-3856c0c7c06mr6596716eec.5.1795736652287;
        Thu, 26 Nov 2026 15:44:12 -0800 (PST)
Received: from [172.17.0.2] ([4.236.94.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm70960898eec.22.2026.11.26.15.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:44:11 -0800 (PST)
Message-ID: <6b08c44b.f2c05935.370be6.ae91@mx.google.com>
Date: Thu, 26 Nov 2026 15:44:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3873229604976240159=="
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
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Test a lone advertising instance 2
In-Reply-To: <20261126223610.1073605-1-yaroslav.voytovych@gmail.com>
References: <20261126223610.1073605-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3873229604976240159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223785/

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      13.78 seconds
BluezMake                     PASS      185.41 seconds
CheckSmatch                   PASS      181.72 seconds
bluezmakeextell               PASS      61.68 seconds
TestFunctional                PASS      868.60 seconds
IncrementalBuild              PASS      183.77 seconds
ScanBuild                     PASS      667.12 seconds



https://github.com/bluez/bluez/pull/2935

---
Regards,
Linux Bluetooth


--===============3873229604976240159==--
