Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED9235BEE
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676822; cv=none; b=icMnKqAgZZTRTwbLeKXIALbdhIRmKSjWknnT/WcDTeVOaBi9+fd+K/LxqZPjsj6VlFfiucOCqPG10P9+ilNOK/wMquGJl2jQY2JqbjimHdPY8ucOSF3mfa5zTpnhzE/u6wn0EqmFO9i+ikpuF/2P40BxIovuv/RZuLKUktNLeFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676822; c=relaxed/simple;
	bh=8zC0Bh6y6hXfkXrnYiJwKMmFnZ4xx2ZbPghHUH+4i6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cCyCXZL0utP9TL1BapcLWTLM5w35FpH7b5ADbYjnFZCXGnNvCNQnUH1RZjtZEEH2prhQiVjCpmMYadQ+AvQko7qquTsYN37eBLeGNiM9UeouY7lCkPVC7wf5qyjJ+ue+TC1Nlr6IOlSGElsPOz0fy+1G0i+KQC1VH+W0EKGa874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsHVFTpj; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsHVFTpj"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6faf66905baso62111636d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750676819; x=1751281619; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qcNSo/NdbNWsZQ4ryDcnLhxJdcv0QbL7uha9jQokN3k=;
        b=DsHVFTpjOKrCbTY+3nB/o7COEgmcPIMW6JEym7yYRs/KVQbk+d5MsAe26qqS8ngHgw
         vBk3e232pIIRFMlBb179mmTAbP8RT4EcecIqpliKrbV392pKf3VBWBPUuYbdLpsLEnlO
         7u2w6SI1So/SlbdndSrcu3lVgJvpYclaQz/fMB4PpLBK0vq6krw2N5Wllo33P7SZ7VOC
         0DQRewnvoGqoGlgkUNMxTotr2F7BmSh11oozGhkhq3tLb3OW73Ydw6uK3DL6bKa/Q70Z
         B3SNuq3sN4aPUGMrsVYn+HlVHoxdS+KKHQQI7mV7scIrjwGb9VQxkX33BMpD9FL61fjO
         95Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750676819; x=1751281619;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcNSo/NdbNWsZQ4ryDcnLhxJdcv0QbL7uha9jQokN3k=;
        b=GYOFlU3LeYgoUJEJf1wfc8yROoCJKXxIkLLwppbGzbSe18LR6rhbHTrFoybk+k2e9H
         rOjBG+6tqFbHo70jdSAAjsNLIQmwBj6ft/NU9hcMyjZJYTjhFudp8t1YpgC8+K4imlPd
         YltGQShvOekkuWRY4A4MR5FBuDh/ZzDk+zi+8dMUFqVUZhYpFz4vfFSofKI3VddoQmwJ
         0ALB67cReI0gDC0QbsOm4y22UfxfIKFSdaup6dH5m9iV99Do4QralcuS0Ik39AyaziXF
         wI+vKSRZ2AJnThMdiohxTXeSMrNct0MUC6u+ilI0pvMsra7dIut3KpKLXW1dpPDN0Tcf
         rdJA==
X-Gm-Message-State: AOJu0Yzu/Xsof2GrY5oVuQ2RgOWj4FM+nbNvr6eYOElb9MfY0Xga6Qiy
	rPYgCemMmFUdxFey78AQj6I12eb/7JofK1mjkmjIe/CjUouC+iKmkOuV7ZFjgg==
X-Gm-Gg: ASbGncvUPlzequouAtKdLKAJqDMtHMF5dyKkoT01xf1keDPhJ3wgu/DyY4N4QUNVt79
	Uigltb+x4b8uM8d3+H2xH97BXeXfebMUAIi26cXsf94KCpQiZMHaqpJj20nSBtwaUj9DV7lcHXD
	09vPB1MnWbLLNt1rZpceQjfCqKAgS7sRJGN5JFLDke+SOG3XsPy6ML5AiVywrfA1wi6yZCAW5tA
	1HoTCGjhCKyv16wi2VyGOM11tvgpgabcvHJrnmRMyImTsLu2w8S48U5BDrbZeZG28MuzLaAs0o9
	JxAqnIG2Tonex7vsuaLeEj95bmySkChYKsfPdfWVetQRe1ksHAAKWhIz6CiQocFinoc=
X-Google-Smtp-Source: AGHT+IH8qDOBgCT/3pIwAbBSb+L5sqkrrz2mOpDWhMYdA9H/IfmcE0MFItckncN8KByVSPk+U01bVA==
X-Received: by 2002:a05:6214:5bc1:b0:6fa:cc39:67 with SMTP id 6a1803df08f44-6fd0a534a4dmr209138246d6.22.1750676819506;
        Mon, 23 Jun 2025 04:06:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.15.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095381dfsm43434106d6.56.2025.06.23.04.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 04:06:59 -0700 (PDT)
Message-ID: <68593553.d40a0220.1b15e7.d960@mx.google.com>
Date: Mon, 23 Jun 2025 04:06:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8698354328942636103=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ot_zhangchao.zhang@mediatek.com
Subject: RE: Bluetooth: mediatek: add gpio pin to reset bt
In-Reply-To: <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com>
References: <20250623102359.2684-2-ot_zhangchao.zhang@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8698354328942636103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=974767

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      25.10 seconds
CheckAllWarning               PASS      27.13 seconds
CheckSparse                   PASS      30.74 seconds
BuildKernel32                 PASS      24.40 seconds
TestRunnerSetup               PASS      477.26 seconds
TestRunner_l2cap-tester       PASS      25.48 seconds
TestRunner_iso-tester         PASS      73.24 seconds
TestRunner_bnep-tester        PASS      5.93 seconds
TestRunner_mgmt-tester        FAIL      135.13 seconds
TestRunner_rfcomm-tester      PASS      9.34 seconds
TestRunner_sco-tester         PASS      14.72 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        PASS      7.43 seconds
TestRunner_smp-tester         PASS      8.60 seconds
TestRunner_userchan-tester    PASS      6.21 seconds
IncrementalBuild              PENDING   0.83 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.205 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.171 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8698354328942636103==--
