Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DEE382F1E
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745346; cv=none; b=dMWRArTWqhj+p3b4HjbS4exRs8y4KI77RGpcMbDLFRWCWQOCLlKEIGwpqbHWYAmj02hsCfAbqDNM/oYXWPNO2YKb5hMCa2ZEUIVT06AQt0pXtmtSWFPgYCwMmzjXDsn7ktKMUDbspRPA8JPkReRX7eUTHsA2SI4tqLMqmevP45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745346; c=relaxed/simple;
	bh=Z98xFWhxto3RSdDemB5g33YHMdyoxclqHHpzBpc+SK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NulxpwizW0mHTvi2R11jpGUkpn/yS/gtCTLR9/6FMAb9aNfOtsds2wNeZRadqctteNON4jXJbCQ5jQ4itreYxWi7PZv1P0n+PD244DWO30HmiYZm5FN6DjSJN9f64/TS+B9jscoNb6KreL/MQXucSAiRGLHOLmPtZ1wsDlzKka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMOwXs1a; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMOwXs1a"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92f0b5ed131so71947685a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 04:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787745344; x=1788350144; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fcrcAZKf07rWk5aMhZyqeR8m0yLJZPegZyh5goG+bNc=;
        b=bMOwXs1ayt9D2Vz3oW9edUVNQpYptB/+Dg1OqCTzd+dXrKXlgGsojJsQ5Bg9778w4W
         7gFdZKAAek2QHamdHDiigrwDq4Iz2vRtz1iu6sDmHzBzRH025z0CxTCQP3RxA3KaexRO
         4eS2v0UbvF/xvy6Y7Dj7h+4gQrBgdpHn0QWJ8maMj0K3cmk8kkhN4HUmuJCpeeI4O32r
         P9UJ+CGUtpamAsW1Hhc+85s2y2ZoDR6i7nQWD+TnlC7YBhy6G6tGB30oh7OU9fuKR8/Y
         PMHT0IC7Rb/s1BdNDtRW4F++87XlH0H5j9/YCSKurclLxijetetTq1opptCP+M86Leue
         E61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745344; x=1788350144;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fcrcAZKf07rWk5aMhZyqeR8m0yLJZPegZyh5goG+bNc=;
        b=PZ7jpPhA4bdse6wLpeSiZ19hcdk+33B6ZeSovXBMVcao0jnBwy2Q5nbenCb+4Dgh7d
         DkZOFR2eKKghPlqNbTOrhJOS+BPoktuQg10GsCKskupqxfVsbyg9QcAw2G7ULjlwARbE
         MWLeFPHdAsEty55LbeKeQe7jqc4bi/m/0TqqZODxISXSQ1hhhSFF2s/snIfRRrZSmmlz
         p3n3CsgMUoTkRU2zVinKeF68/iqk10XAcVA8A89bfmtILftFc+gsJunmCBhSVvfr0VNL
         Mv5EvsuRVQo6GaIVtCtstUBwzdjTw+orXBR64u9vQsarwXbdH6MlnzkSDfqn2RTTK4SO
         ghsA==
X-Gm-Message-State: AFuF++kysiH9tE274r2Ux0Ykkqy5JcIa4HucYOmvJwZS1CaFI9aar0Vk
	hpsk1yEO3ehhxbSjeDlEff5ZtKjBjmENLkzJ40I04WNn6bnaJ0QSVhsSmtVTag==
X-Gm-Gg: AR+sD12x97/k8ep0yFMoz27s4KVHIMODQZjHCaRQzZUdDpKRtdTGUxDoWx/j6X9uV0Y
	ljkGmai123rfmmBMgZ7oR0KAx0yu8aA27E5+/1Lfw7ND4x5+qMDMKHrlNED+o7Nqqoeat7AkTMp
	DOzZHIRMhsARsw6VD4pL3Y4WCCz1QEUTmyx3Q8sPGlqJSKIYNi6sWZgC2JYfeMBBrKN8K+A6XF8
	J9e4VGZPAFukypcYFOwSEGjVdOng4AimF8QZnr3CbSu2JbtXg921+A/85WS292+3sWUAJGiYgWn
	extc6qTbq4OWWD/pzkIE80VUyrIUrRilxEZzvv9/KN0FxHdkZH414Hr8DWMZ1wsMkgz1HgVIyJD
	JcSBnox8iGKvYh1+Rhvyu6qAIX6QKEu2QGJRmsxa+GO4CTciOSJKhDFfDC3T8i78d3MFJWZHko5
	ZT4owzJtT1J4+mxZmeUuxe2xtyudwpNFJQFvi/FEDOGlfGgNQ+jb6RYRf+spN/Sl0WRoClAy/Xx
	hVQr3o=
X-Received: by 2002:a05:620a:2cc7:b0:92e:fc45:3472 with SMTP id af79cd13be357-93780474d7dmr371843085a.29.1787745344227;
        Wed, 26 Aug 2026 04:55:44 -0700 (PDT)
Received: from [172.17.0.2] ([48.211.212.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e6c2eefsm187789885a.46.2026.08.26.04.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:55:43 -0700 (PDT)
Message-ID: <6a8ed43f.04a468da.32591b.8d79@mx.google.com>
Date: Wed, 26 Aug 2026 04:55:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6842328103440205939=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Route firmware debug event to the diag channel
In-Reply-To: <20260826111617.1175698-1-chris.lu@mediatek.com>
References: <20260826111617.1175698-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6842328103440205939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152025

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.15 seconds
CheckAllWarning               PASS      29.55 seconds
CheckSparse                   PASS      27.91 seconds
BuildKernel32                 PASS      25.85 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      469.93 seconds
IncrementalBuild              PASS      24.85 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/655

---
Regards,
Linux Bluetooth


--===============6842328103440205939==--
