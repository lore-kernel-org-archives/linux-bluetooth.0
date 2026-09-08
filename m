Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113F569F22
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882546; cv=none; b=uW7E3YvIh4bQbtCOy0822uRWqaSxJtO7lf8iFaNeVtW+u0qJJpt7K6XjEdHw62wvDWKJ0KpSHivL9T+FU5cxEXndqUVU+zsfAbmp9fEWvZUvTP0yRmXkinF/iLzQ1mr3Hv8uejOodcXD6JmbUTl5dT0o+ErJOr/TqcvKGgXwMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882546; c=relaxed/simple;
	bh=PtUTtk9VLkqi+t/GzYkM+3QhJHhNR6vc2fBkpJXgpag=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t4/n9KwqFQX5/37dwBf891YJbXiV7clyUB1O6trkNtWFEWNToQMz71qB6Bi9cwWbYcRtMUiB8VcHAJ8XV1rqZZJyvacaBv23CsIHhl3xwb0P4y5394Ys3HSW7sadAUyv/I62CavWQOawz4oVMJsLSIYD/+ALp8Qai/u5026T7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9LrB1C6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9LrB1C6"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7f4df360cc9so5291694a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882543; x=1789487343; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c3ydEce78iEQTtRyGOp0YjpjqoCQZ/7g9aIlR0thLm4=;
        b=C9LrB1C6N/BpVZwmw+sBRw/X7A0aChoNeyxYKGuMbHuMXxfvnOMZojv9nnTz4B3JOE
         uU6nw7ZYfOLMioAi1/iB8qdz1Op123yoUywUAGleFM4XzpBMoeFylcyCo0ByutPwTPAN
         uHZdLYZiC7jAN6HTBWlYQh94YUwBe0w603GyqqYNzJEWYBr+iHZLs+UEzssrvI0WuS4N
         4za96EMH7Ffsf8RLXfWwKaV5XanDxLzd2UcRenht2FkLJaghY+De5a7QFRT5jUXmwHWC
         9ch7LgHvkiyvKrv2x46MypwAg8vcjss2TauMMukhrNDQaJANYUy64avc9tj0OJoC/2V6
         ay8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882543; x=1789487343;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c3ydEce78iEQTtRyGOp0YjpjqoCQZ/7g9aIlR0thLm4=;
        b=B4XojteED6ZKVNYHe7bnXKsyT9s8kbDdp3WrWON421ZjYu1DV+ytAk4sL4lB6v6TIg
         MMeD8nIv0ie6o3LLUiPppPI5eHILN+fb+Ds5Vqn4nLPGVoUdS3LiZghSxHk56Yu6GI3L
         oSBl4Z8EUOUqi+dxCSYmjoHk+y3enqTxLuihlnNxBkqT4lJKnp/Sl6s2pabMq1lyzsqT
         Wvb3dQgrgsZuuWQykQT9mIcdpeHj74ZFxL4UeO2+l/UGSP90IaHzRJxqqwbU3F9byKUO
         BOJhLJ0oXwsIMQogmHCqtSfqNeJnfksWaZO1v8sXG+Q+oqI9VNlq4qm1XMnnnwstkxMs
         dQUw==
X-Gm-Message-State: AFuF++mus3SeGiruspsiknnPHg18ubauC4Rg+1QvrQhDIkvcrIZwOOOb
	Ox0fwixhAeZ6FQ3Iog6z326L3xTbklIT54g2/Kx9W4IhA+wTlmzj6n29yZHLOA==
X-Gm-Gg: AYBFou2eFCqbCMs4BH0jheBTy4c8Ke8VwgxBX6fwTel/1BpoFQBkw13kdH3sEj+pICf
	RLlbE1pyfUPRZU/Qp9tLIK0Lh/XaP4aUaHhLq6mR09uF1mbZKjRGN5tPGldLvVejt0jiFh0FNWP
	F9eITaZe/QDPRuV0jIFoSlasei9dOPokwpXK4tmdgIX1xf7Fpj8sY10VSeoTJBYLAx0l0ggQxxL
	GjqVIDaazbRs/WIuToV1MktEDbAH8fhfJv3LTioZUZEZov0Mcjz9gbkYPeQnnd//OT+QLNI0a3i
	31YVrCviZNaeLF1APLmF+hAvpRfT8OdazBewf1YEl5i9gEPSzQMdpGNJcJ0mnL5YjEbblumFjcr
	8FbozXmXzMRfytCqvML/1pP945u3T93papiY32a/EzinN6Qvvk8YFdtT0WMBR42P9UykaXFwm8+
	4eJgtr9dwN2pR6+eekGEtDjQuGXCu1+Wgt9CY+7jSzky9IcoBnI8IKShNbYTPytmufxaj8
X-Received: by 2002:a05:6830:1094:b0:7f4:34a9:4a80 with SMTP id 46e09a7af769-7f89a47707fmr12084817a34.6.1788882543551;
        Tue, 08 Sep 2026 08:49:03 -0700 (PDT)
Received: from [172.17.0.2] ([132.196.35.128])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7aef680sm15159458a34.26.2026.09.08.08.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:49:03 -0700 (PDT)
Message-ID: <6aa02e6f.6b931ad5.8783.f537@mx.google.com>
Date: Tue, 08 Sep 2026 08:49:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7730008099239642150=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: validate TX skb length in send_sync
In-Reply-To: <20260908095658.729390-1-chandrashekar.devegowda@intel.com>
References: <20260908095658.729390-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7730008099239642150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1160388/

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      19.20 seconds
CheckAllWarning               PASS      20.92 seconds
CheckSparse                   PASS      20.14 seconds
BuildKernel32                 PASS      17.92 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      310.65 seconds
IncrementalBuild              PASS      17.22 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/722

---
Regards,
Linux Bluetooth


--===============7730008099239642150==--
