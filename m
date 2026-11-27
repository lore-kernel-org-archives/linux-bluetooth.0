Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795753471;
	b=r0p7n3oDF4G+sX8XJ7tw+G9K/iljyj55yZPd+5Gfk2Y1GCTe21xe6SbOtA53NFHYOzvE
	 srToOClM6FGUXi2i+3kmIuQaA310oLLo4hYfFSS2wtVkGt3+QpHq5j+JdhbSo++XoKShf
	 QlPV8ONpxunqzovsPBXnbNl1D/H6k/hgQ3E7y0aJ6R9nOMhgyr/Fa/6B2vjdxq5pOw3sT
	 Y+astj+g6f5y6xXriWwMygmzO7qjDXLGufnLFZSRhDa3oWjLxN4AQSEwiejOTv8LLrG5O
	 ngUmlfMKyAvCVocq2LbVGNLXMCUAjWvhcLpKm0ZDrYKlOdG0jFngHqLsbOxvLHSyqDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795753471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=k6QqZxVk1UE8IfyC7Va26Fbrww9MkqnIIpJwKkC6WyI=;
	b=Om/kcELJI3+0nYpVUKKvBsvG3qH8QPnanfS9x6E/xUSsJhx1o5P/qi6W9GqVUuYnQGcv
	 ZtvHhIEDJR/1AbPWih7uFq8c7aQdlID9qht7I8kX4VDtTgmyquHK+dFvYO/VHHfGszI5I
	 1Q1XO2hlg12+Nv0kSzmduR7vTmETk9QCOHeNIB5Qk5uAZd8Rih+xj9koqdtZ46peyBIGO
	 1xQbPBtHEHlH4D0DnfbHHk2KsmqL0eHayZ+xWYti+1ZYwUhF9OKYIzUp5QrAlIdo3U7SO
	 CLgSew5LvrqJp/DxyhFBeapg+1ONBAt4FMfTVriU8TeU2bMg/6jVW8nwCI/2Gzkfjxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2fpCjCn;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D391606A338
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 04:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D391606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2fpCjCn
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d68de53053so5626732eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 20:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795753467; x=1796358267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k6QqZxVk1UE8IfyC7Va26Fbrww9MkqnIIpJwKkC6WyI=;
        b=B2fpCjCnQZzaD756hatBG3NGq9vk1T1ush8c16kEKtZeMAcGl5VpOZtSwApbETDmSI
         aTaGekkCOYJU53fleLL58JMPyTug6ST2qcWd4zLIkCZfztyP7JCZiZZlYepenS+gw2iH
         PJi54AQYVPNwbhsAI05DeaQEFbH/MjcVRDZeJSmXiLcAP1dURNBMJTGTdc5IF3zi7gIZ
         5yKeD3pQ9TVCKawdAzVx/D66ZHvSciDXJuj+Pigq2v36XR7/XgGIQrhsk8N9puewSvHx
         mUfWStg+n869rTbhcw49/MxHE6Erp+Zd7o5Q++3+0IKl/pdEiOBFRsqyzkdcyuqLqzE4
         I+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795753467; x=1796358267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k6QqZxVk1UE8IfyC7Va26Fbrww9MkqnIIpJwKkC6WyI=;
        b=e2OYibPz9eLtCz3TXAmp46+JMCE9yOi+NNLnGll7JucPMXYrzfESdfxuVXrakaNJra
         jAyi7GuGHqqp6TyqexzWZNV/6P74PgeArs7QvXeP+TXr9tNOAQ+AfjlIVgRCzFAnCS7C
         qwVCTExyfAmovJ3UfExMq4gDNai7DyTvN99teJ/lfqtIFCRwNk6cef9sK/7+tUCb8XlR
         izvqu1VwJPH+20elZ5FrH5RAMV2D/KXqgODk9lwi9NaApGuZ84De+FVMw8hzPw+hBv1B
         WQ8UiCT382Y5fAnV7iY9t8moLYLqJTMmBIvrGdAxWhiVQbqMBdV1bMEEEg+KRAB+/BWM
         RrDw==
X-Gm-Message-State: APuU4Z98FhcmbBQ6YeLe3EK44XuSv3YuEKqCzXIyRB5qin6EYr+xNmkx
	14AlPFH2N5TmhjVvl8Wvj8zjlyn+aZPhiQMXJR/FuhZGneRwEKomRRt6DlonCw==
X-Gm-Gg: AZFdTZfpEdKTriVMsNScX6gqzbz/rQ5v3uHsp0D9wcebUN7a4s0onSqzfo0/rQC8rwd
	6WVSYYPO4KdpTmBxVOvOmSWZNwLps2GMGCG4F6sBUv9pvyfSMdDO/nia9Drt9i7zpGl9gSvsC6b
	8R0/h/OLWq15LgVAIx5wdBcxbKwSzvPPhf48061jgafCMDSx8kWPpkMo2tu/vcNd8uMwXJSwzp0
	IhWQ2H9+UY8cGBhNDBeMVipY6rFzfXdNvN6bYlyjrzW0M4liizsCXatj5poFS6NyGaCVLE+OgMH
	eWGkgQHjNKhx6vH0hRl2yMET7Vc7U0GJPPmLcBoLBfHWO16Q04C+z5Eo1f9tiiGLU7nJgzpRakz
	pVEAzr8i9ItVES+oEukxoFhzYIi0Ipg88JOaOPC0Pyv2iA771kBG/IRODQV/LYNAhbCaf3JlVkc
	Exv2vxqy+sbAKlqTa3RRw+CbIqzMJkneUVtxJ2gGCVSXdE8n5L560Tvzomsc27VAQea1e3uc0Rn
	NYqZNmT0ES+/OyAuC/bfr7tEghvy76C1ujmklM9dDCB5oGxFfarKlEYU/72/elZwg==
X-Received: by 2002:a05:6820:c44e:20b0:6ca:4a52:797b with SMTP id 006d021491bc7-71b394d601amr12466190eaf.50.1795753466906;
        Thu, 26 Nov 2026 20:24:26 -0800 (PST)
Received: from [172.17.0.2] ([52.154.133.155])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380b6f82sm14051971eaf.10.2026.11.26.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:24:26 -0800 (PST)
Message-ID: <6b0905fa.51100f89.32076e.ed46@mx.google.com>
Date: Thu, 26 Nov 2026 20:24:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0644552256171795934=="
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
To: linux-bluetooth@vger.kernel.org, zhouer@gmail.com
Subject: RE: Bluetooth: hci_conn: Don't leak hci_conn when dequeuing its create command
In-Reply-To: <20261126234701.215190-1-zhouer@gmail.com>
References: <20261126234701.215190-1-zhouer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0644552256171795934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1223800/

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      18.33 seconds
CheckAllWarning               PASS      20.81 seconds
CheckSparse                   PASS      22.02 seconds
BuildKernel32                 PASS      18.54 seconds
CheckKernelLLVM               PASS      18.27 seconds
TestRunnerSetup               PASS      406.22 seconds
TestRunner_l2cap-tester       PASS      14.45 seconds
TestRunner_iso-tester         PASS      10.20 seconds
TestRunner_bnep-tester        PASS      2.73 seconds
TestRunner_mgmt-tester        PASS      81.95 seconds
TestRunner_rfcomm-tester      PASS      3.95 seconds
TestRunner_sco-tester         PASS      4.92 seconds
TestRunner_ioctl-tester       PASS      4.01 seconds
TestRunner_mesh-tester        PASS      3.97 seconds
TestRunner_smp-tester         PASS      3.89 seconds
TestRunner_userchan-tester    PASS      2.79 seconds
TestRunner_6lowpan-tester     PASS      3.94 seconds
IncrementalBuild              PASS      17.15 seconds



https://github.com/bluez/bluetooth-next/pull/1236

---
Regards,
Linux Bluetooth


--===============0644552256171795934==--
