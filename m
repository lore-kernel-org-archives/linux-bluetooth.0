Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63133939B
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282522; cv=none; b=oNfPtF6LP+Ess/4d/aay3yBHBCcmrFlfkpHRqYyOVYkudRCnv60//ddJKapHH0F7le/Zk5FZtDQI0C63n8IGTXpR/3AUdlLTFVF/4MplXggc26K8HW4Tk96ez1zCw1bJIDjiAztAqJfZmkLBcC2LrvnlCJ1AyhWNY4g30c2sWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282522; c=relaxed/simple;
	bh=+66uiTo4h1dNkvLFZ/O56xbWsZqpYb0BLbp/hAl509w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rBdkp3GHfpTeLRW+gmW2zZfFrzKdQHZKV+u55aI6UjQec49N0NM0opqOzOHwUM+KIdwHFt9Ln9+mZXhp4U4Pfy6S6vXCSP8N2hsgxqsqgGowU2nozrr9OOLd2wEA4whlSt/2KgTbzscEfcBBog9KbQ/SlNQYSCNwvyA3pXPtV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcZ2yd/T; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcZ2yd/T"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067fso136342985a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789282520; x=1789887320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Om9+42F2ypCyIG421IdoL9BL9LXcf9kUAsP6m78JTpc=;
        b=LcZ2yd/TvTv4eYjZQV/NOFySnJ9CjIWjYeJgDWypSzQCtpbgFLuMPD1kJERMNGMnan
         kb/VNPUqOG6i38Swrp7v/9TR0Em015V+yMi9qDgvXGT2ltLHPUW4cOUQxgJWMHZ5PyQW
         DshzvfJvcyh3qjswulRPq8Ed5wnbA3ZKVq4h7mdBdCa3K7a2PgHPFpXs+EuVvXaotNdh
         0nsVxt8XRbtUA3J2T2XxGbOWuviLkCqg1q1Tji7VCDTOL304GQwFGBv80bIlyt6Vy0YM
         9IjdbQiRMKUgZObIlww3jGd26syUyOZNLC3hIaG9vg748k1z+sZ8ZI27vDH2Izy4GEAG
         YExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789282520; x=1789887320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Om9+42F2ypCyIG421IdoL9BL9LXcf9kUAsP6m78JTpc=;
        b=L+jOxtxRd16efB2kiDHlxFNiLn+2R+ZkThdcmGu9kmyl0HHgzR8sSKNlQ2pAB6JSGn
         ck2quu+yY/3nukvqRQmj2E/PbX788DD3X586+2AOvKWkVjFGQlaswlbYj6HM9fRvrDn1
         86apB7U0GG25ARNXsNWLGUTKP9eb0muraK1R1JcvhusJaH9Ex2u6161/DVWPOS73pMjW
         r19Bw39a64nb9+HwVeSUkvszKuhOYzwh5D27vPc3RVrrO+LuGVPV9baR+jHvsg0Y6qL0
         2ekEdyghB395yipHq8td4Ez5sMgLkRl6UInZ5sPMKxRbIBoY+dxANdeC/zCPVU5EjWD6
         ojEA==
X-Gm-Message-State: AFuF++k1dxlsSXAWsBKuGpFtKV9+rW+quu9ybwIA+8TPe7gLkv4mguKS
	0ONlcL3LmMYFmANNE2InP63HNTUsAlxWTWxSH0wlvIedCms48n+qTjNsfWXcCA==
X-Gm-Gg: AYBFou041nPONAROPY+U9+3vAaY1R1auKkNU6mx7h1X38pXAPgYjjI8H2NfNItwk+Rv
	kMe3LnS7hn3wLlnTAnFVtHKcTbsxhjBX8Enx4rZ1BfoS3FHI8P3CWQMZ5puOrkIHYt/1RRiekcN
	wLLZ9LYfv/KzUAIZDEvvyzmcf/RHWvx2BP5VmLj04IokE8gT4LVhGehCN2juKk9Pvht7534QuJl
	VxTAK7vv4dkehT3Q5q5/67fHZ8YrWPCMt/XOBbrmRQth/mE5cwNNLo13+AQIbGHtxr4UXRTkAPu
	y1y4wPhAKM3Pa+hKYagUSkq92fT55hI+P8rlOXAIq1XPgpYwco3lGuudbvJr2B5EvSpefF19g7C
	P7QdQ4KIFZJvJ/9KnhiK8G9NThuZluZyO5N6JwHLPHBAEc/pJ95PL9YPjwN+zBnVmt3b8MnKHjk
	+6oASfOzHZLTfXtZo6mITSSw0AGjTylAbX6JAmTSYlXKQaAkYqjRPvR4znCPaa2v33S9X1UrMVl
	Hm6Mg==
X-Received: by 2002:a05:620a:7104:b0:939:8bfc:471a with SMTP id af79cd13be357-93a038d748emr873057085a.49.1789282519865;
        Sat, 12 Sep 2026 23:55:19 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.159.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f1da12sm685940785a.9.2026.09.12.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 23:55:19 -0700 (PDT)
Message-ID: <6aa648d7.c265db82.5dad4.67db@mx.google.com>
Date: Sat, 12 Sep 2026 23:55:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5702330389804684476=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jcperdomo100@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup
In-Reply-To: <20260913030945.4011-1-jcperdomo100@gmail.com>
References: <20260913030945.4011-1-jcperdomo100@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5702330389804684476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163670/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.61 seconds
CheckAllWarning               PASS      32.86 seconds
CheckSparse                   PASS      35.62 seconds
BuildKernel32                 PASS      28.84 seconds
CheckKernelLLVM               PASS      32.76 seconds
TestRunnerSetup               PASS      778.63 seconds
TestRunner_rfcomm-tester      PASS      16.86 seconds
IncrementalBuild              PASS      27.40 seconds



https://github.com/bluez/bluetooth-next/pull/758

---
Regards,
Linux Bluetooth


--===============5702330389804684476==--
