Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CD3264C8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720069; cv=none; b=YFqYdPeGu1E24kcEQ4FsEx44o78Iaafao4EAtTL9xVLHoYeTOeAiHTDemxwJg7N+ElxjhS5qhGgMTHZBUehzbZaLnjniiS6zs38ywf+cAodeRDQZ7JrN5vdj984rxwPWC6NV4o2D0hG1OVY5P8x+pV+ZsmdQTF2BpTG+Ci/JP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720069; c=relaxed/simple;
	bh=48YWPnDRk4rGD0eL+kMuLcYmM6ujuXl+MsvFQX0PC/U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XC5/iZJ5QdG2YHEHdLojybvm+B+M8Q/M85UzW/Ox1a78XN2aZgKaVCbyhGL+hjvgmR/RX8Oaym2xm0nc82YDppnrNjTs8kUK99DoHNkq/OWhRwIgGB74hm9tXp1m2H3YLeTMms/Dq7bGmXUZIZ9hLZjfbnY3CYu+wOhKpxhayXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg0GXtcB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg0GXtcB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811074a8c5so1245640a91.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783720067; x=1784324867; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SPojumrAkrSayPVBfJG95NirN+Hnk701sgTRjvALOiA=;
        b=bg0GXtcBzIc1dT+1+ntapdFoiaO/128SHtgLQS4Vk1EViYWsO7dIxfWb6G1xWLVUoc
         Lc/8qUXNPDycC70aq2HpEOpgK0WhGm8CC5zyC2+UPSiWgYt8h4pcOifUR/6jv2/QEnNu
         VG07l7FyP3rZo8SzBWcJ7n/KKSU4adnpJAGNTgTK1jObVZFhz+gct/B9SuHXkNQu5Mcx
         64RqFUDbUxrf3VTQ7JqLRXrRZNKfCLUMaCpLEsGNm0JIqFy+PvTJYvZynczRhK2tkqV1
         QCpBs8OqVN6GmJyqyAJKrC93/aOTJbb99/Uvcu+j50E7pxux1qA/74FTROGkEkDWDl7A
         X6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720067; x=1784324867;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SPojumrAkrSayPVBfJG95NirN+Hnk701sgTRjvALOiA=;
        b=JXqnbBXi0cHpkFlTgL5piBITpaBhKsUoawWic5lKhPlceSwjElHXr+0fv682NudL7a
         VcRJerR4vWZ4U/t1Ek68DpNL4+HQwWsmRrQJlG9CP6wZ+vwm6g9moSDy9aBKSp3QN73v
         NkCVnPIsp7dEgJ2IzG4HQ+K7XjwWXci8ubHMs1ddhTp+rby0jHGGYR76RFOaQZBUYhMo
         KHAGa+a6OTUC2rrcBUX7tyx40BNPD+W8m6s51RB24H7EokkRCoAQOqaGQk0wARHsfGSF
         EMtAy1fDgLUanjZkcue2toln9ynOFi3dRfANfZqK8wciBWJFzcoVpL2MRpz3cwNdSSRP
         1XNA==
X-Gm-Message-State: AOJu0Yz2WwWhVUzpqexzRLuCC8et+ZdUogB4304YnbL1S8ZOBKQhyAoP
	23ClUN7cypA6u4hnXahKpOwt9Nc5vrdWCHMaUCaxCGcn+HFu2HjPfrjFpWRDyA==
X-Gm-Gg: AfdE7cmBlp3WHziB8RShdV/GmG0NsLI9m5tpuLlOiuAVdEAyE+RFkL6GDlVOdPFhvsI
	LaghBB1aapOLSWlheqCU90mfxg4U/p899daao0hczBYvdsXyqZ1pQl1kbRpx5ZqaB1/A8YM6Cqh
	3qccR6wG/mOfSzgzCNijWj+9IxQ9IAc7ceecWnzlGdtabMFC5fPMRfHUZpKwvFPBiXqCSpRK5hj
	0hJIP0FFuo/Gf/P5953QuFDNF1FaKq8P28/56vJN/B9R/RDvBjuXxxRxcQrbFriCT5CUvzYQYbr
	16UHYkixJE6jBzRci0nEcQeFYOHX3+387owBTnyi2klQoeNr0Tr926aGGW2YqKIhGEn9PHfZLVj
	EiG3cNCJsVzt9T3jSjYLOf0iSHv8A3pysORsvvDy45zwWIHz9JlhVVtkCT2gMhaZkZujqdWDmFH
	fNnZQtFT2j7Pq+NGsYHFY=
X-Received: by 2002:a17:90b:3943:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-38dc7777c02mr674592a91.27.1783720067437;
        Fri, 10 Jul 2026 14:47:47 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.212.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm49133601eec.19.2026.07.10.14.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:47:46 -0700 (PDT)
Message-ID: <6a516882.f1c1923d.991d1.3d22@mx.google.com>
Date: Fri, 10 Jul 2026 14:47:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3647509963544296242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ingyujang25@korea.ac.kr
Subject: RE: Bluetooth: btintel: Drop dead !skb check in btintel_read_version()
In-Reply-To: <20260710203029.2423768-1-ingyujang25@korea.ac.kr>
References: <20260710203029.2423768-1-ingyujang25@korea.ac.kr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3647509963544296242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1125611

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      4.42 seconds
BuildKernel                   PASS      27.18 seconds
CheckAllWarning               PASS      29.72 seconds
CheckSparse                   PASS      27.70 seconds
BuildKernel32                 PASS      25.90 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      497.62 seconds
IncrementalBuild              PASS      33.22 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/424

---
Regards,
Linux Bluetooth


--===============3647509963544296242==--
