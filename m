Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2764F052F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892427; cv=none; b=LHbtGtPaZefUDP4jL4ri5xM6aZuu1PWi9qLBZgbcdYq6mQyAxN++oE8upH2dYG3sad1Q8fsgSHxGFHv0/6LTtaRPbkE8eAXJU0Ap2ITMDFlCMqMRGXKwwQLOtlV3A9Ouf8dBZxzj0R1sH1vOFcvVwTlPZ3MoQv42mu40zUrUndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892427; c=relaxed/simple;
	bh=oJr/vOVSA1kcvye5aSuv46Ty4Ak/7D1wOGVT9m+XAOI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jpgcmk4n0uIDd4B/IItmNslqmVrTemmojxzW2NwI8/or5/57qLpDcap2SckJp99fgZMy7jnz3qXF0Y/fme24hOwdE9C5wmN2MO4DvxjItkN3Ng2Eq3Ea/7kGj7Ar6KKdnLv29o4IhfrBmKqUt0yIuSUFy7l71ZFd/3HD2K5Uqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA7iKU5L; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA7iKU5L"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-823e4047037so2303247a34.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892425; x=1792497225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1lcJoE/P4Ul557XxjqPeRiK6Ij8VJW1ozf5XdwABX20=;
        b=AA7iKU5La6C3KottXc9SdVNdtpFd8zVmOnBpVw+4DnJ5as07TUSoWduL9Ty8M2+78/
         LgHSgSsFartxOeJxz3F1TrkioNafwL2JguC4k3L24mNzm4d/3r/LKa+o4hojLibIKHpW
         +N3v66TwPH7UJPyEs2tp0/l6QlnFqnxcd3Ej1ZxX+tvzTbjitCFjeWQFYcLqVt4ehSWn
         7xbfG0PYvgNHb9aNaX0j4lgbUHknZVEsaWOM21UfoBfty14u/r2q5Vn0QY1HsoAXdmwE
         lgV2qCQvRp1U1UtF6rNKo/a+3QdBcJg5TveMI9mzfkAKjBnlocbHEcqS3BHrLFUriQ2B
         bjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892425; x=1792497225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lcJoE/P4Ul557XxjqPeRiK6Ij8VJW1ozf5XdwABX20=;
        b=qdSoI6abUNXeyBa9/Ane3+Hc6fOiWbVjXs4fwQhNVOzXZCj7Y2iiywVeAkdHUHDoYR
         UZAVoPJ2sIsaV6th+3Hfg50wvzVEQ1IzcOhvOAXLP31TtypR+gyC554qUzDaO6Uiiswv
         mY7LMXQlEnnaKzc6wR1ls2elDaD1eT0K8qwgA7jNnsO1sH0yuKmQ21fPjzCLtdHC8xUD
         SUlheONAkJF0bpFG0y4eImT4gfEsFIYpikquMHn2m6XMpVywQHVfvAXDE0yYwl/jdYnA
         AtRpI9eQjs3K4wtRo9KurkEuAbnVTpbwszQFBSVo9px3AtOAXM/zID8JTwf4u2iiZ72p
         D8Yw==
X-Gm-Message-State: AFq9FYKOSrYDBpUrVBE8nj6OqvIvxUs9X7tf7dRuHIbLwpSwejwfXtX+
	iu6sMVUZaBOIDC3v0Ep2sAw+17BqFDz4FacXT9jbO9E3qprG5vETPy7K2eKAwQ==
X-Gm-Gg: AYBFou2k8LgcRgAYiXjgkWOulQS+ikK8/VyDYBueAc5ztvdM7RuVFqklhB7aEbCNjiP
	lTdC0+xqr0fwXaZ27SkSK1b6qjL7blqGFv/qvpXi/0edR6f7LlkgKbTLM1uJYI1j8wvZVxaEOC2
	1WK2pyQPNDIV0cVXXAR1XzQ083/sHk8yna1rkKc0yyI5E0J0GjOxqJLlN1lViRwb4np8f6pOzFP
	M2BYMRnUUaZcXeYBMTxp7kRI9jIGSihN7F/FihPHx/5S4DrdzwB+nn5spTLhIqrE9ynTxTu5te4
	IxL9AzjUKQkAmoEm97ARcgcZzKDNs+LDfmflMWwZY56gbWxJ0vzL1gyZWLRuRORhkQA7khNwdWH
	g9ewqKOuoVyQb5WmYamZ/GnzqkCbPoGmnwdyNxIM2SItxl06zJYTBpz0ztg89Lo6QNVTxUDo+8j
	ivcfxXSlo67EUYLJ66IZLLJNq+nAklFXTa3phFi+QqqSdN52+fFQyLih7+HsaIcPCO71sb8sod5
	hFRjw==
X-Received: by 2002:a05:6830:6b06:b0:821:c75e:5309 with SMTP id 46e09a7af769-83095164fe8mr11507819a34.7.1791892425027;
        Tue, 13 Oct 2026 04:53:45 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.144.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83618a94fb0sm6640825a34.24.2026.10.13.04.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:53:44 -0700 (PDT)
Message-ID: <6ace1bc8.674ba918.2bd6b2.1bcc@mx.google.com>
Date: Tue, 13 Oct 2026 04:53:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4336154465843789889=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: fix ISO data reception
In-Reply-To: <20261013081823.817996-2-chris.lu@mediatek.com>
References: <20261013081823.817996-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4336154465843789889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184506/

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      27.73 seconds
CheckAllWarning               PASS      31.68 seconds
CheckSparse                   PASS      34.89 seconds
BuildKernel32                 PASS      28.14 seconds
CheckKernelLLVM               PASS      31.53 seconds
TestRunnerSetup               PASS      653.17 seconds
IncrementalBuild              PASS      28.03 seconds



https://github.com/bluez/bluetooth-next/pull/913

---
Regards,
Linux Bluetooth


--===============4336154465843789889==--
