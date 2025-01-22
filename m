Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A31C5D74
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582823; cv=none; b=pv/d11yZfNGUNPPiNx2tyr958MCyHk0BJllOYHU6dbFUBTTDiU2bwtQM/kX8OetUtfEGAIvjnG//LDU84wHHeJ7QcRxqe9koBNun7DJksN+VEzvITn9ZKQkIBawuYsp9IalUbam/s72PuIoeqJsomXuVnxsnSpCoTnhfnvu6a6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582823; c=relaxed/simple;
	bh=xz5WIaVVdbyZpk0itcVUuSYXCWgiR9akG15fiIsi0Kg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YVjPuvoplLX+1xNKHVwby9lFQnjSJmCsU+8fH7Uhmwrc7Bz19jwHZacOy+v16HvZdHOCePDsmKDmNN201b7Lo1RxNvCffvdxocnDFK5iZQDCwH3/D+LrsAOBGkWprWVBX9CULLySvSHHiaw51gB5IxCkxq9XRhByEOtuxSAsW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXx5zDeq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXx5zDeq"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso3728626d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737582821; x=1738187621; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ0+8rOGIfhEroQ3HTFiVNTw0MHhvvnvhUymyhohBD4=;
        b=hXx5zDeqBCPwAEY6E0OIU8FxtfRDTQzKfHnDcDE/huFI0zSPaDL4xMcumJzvAeL8xD
         kbOAb444CzvQwkeIaYQkns21gWjFSyxs8zbcMTSGm2MsZtA/mk2gXHDIRSn9RpzeBpvR
         EKI/ae6a4iwzR/SY/n2lJA+udTlEM8t8QP/+yjMbEjOtTdPjPF69+Y7AoPS0UuuFJbc/
         7xLPf/tR67kDCBguY15KPNJMaGQcKeq+v68szG9ySCL8dPyLVvKxgG5s4RTgvoptZUl2
         iYUzR4WTskUdZX7sZHJ8+1Yd5SbH1XVSER8SEEMK1pJmJyLKTackilu8M/xgG7Fi5rzh
         yThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737582821; x=1738187621;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZ0+8rOGIfhEroQ3HTFiVNTw0MHhvvnvhUymyhohBD4=;
        b=drziKNfFXOhOmBiOwfbJT0VRi3RpGmgZBkRpvN5PvJUrmhvRLWCOF8zXy73zI95YAV
         IziQd3xDo5onp7ImBK0kbOsWbSqLWKETgpzjEA5phvtXIqqX/75kFTnKOPOLABsfG9pa
         r76AksLm1OB68bRvEyXLE0DUDoDCzQEn0P94tdfT3GTUjs4JhC4zfpLnCwaIsLYCLMjy
         PUgbiZlZpfPBbYvrCtnvhj8gx0lytKmgS0OKrqol06KnLKrT6XV3awBTm8x67NvQr8T9
         XVQq6rD19bUDZ55LBp8Tu2/+keWib5d8ZLZNt8a8MfnzcQQvTK1dFJ5pVavzR2SB+gpX
         RctQ==
X-Gm-Message-State: AOJu0Yy4TK4JVm+a0P3Bi3MQlWtYp8uyrUBZLcSxcVYW2KTBCTUXVIxK
	UZZzaLX7pNWkbxgVwTu8YBSLr3uooGEDyx65V3IZxkVfMDPcD8g5S0Z8EQ==
X-Gm-Gg: ASbGncvyX3QoFguF4RvhwLDbL8kyd+aiqW6eDpJWLVvJ06xcLxqL1eLBG179KEcIOIG
	VRbz/vxhmleQ3Ybm/ujYuUhyT8YjFSQ5hrwBR1+ViXsXte1Nml8rmjPMfJqVd0D2lJ2NgJzdrEQ
	7DUYV8QhnPZ94ErVo8cm04aMvu6GtXPyE1We96gFTo2uOaA8xQ9z6RrA6GGztGIAafP88+kk4eY
	f2BuU0CyxEBRNmu1MOnK7V2FtCM+S0tKvBA1ZKMDyLBd85aYcmBpVUzeaX4vXFbaRi4LPOHJpmd
	AFY=
X-Google-Smtp-Source: AGHT+IEDoDKIvSPeLJvPdqNbvHHLfECKzDDM+rTy6od7jZBOekK95flWlbIrnbJUZ1Z8g1TEpVD5vg==
X-Received: by 2002:ad4:5c63:0:b0:6d8:7ed4:3367 with SMTP id 6a1803df08f44-6e1b218f0b9mr421220386d6.19.1737582821058;
        Wed, 22 Jan 2025 13:53:41 -0800 (PST)
Received: from [172.17.0.2] ([172.183.175.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afbf37e0sm65046476d6.12.2025.01.22.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:53:40 -0800 (PST)
Message-ID: <679168e4.d40a0220.13bd3.bce0@mx.google.com>
Date: Wed, 22 Jan 2025 13:53:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8083789863464118169=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v6] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250122212514.164262-1-luiz.dentz@gmail.com>
References: <20250122212514.164262-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8083789863464118169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=927650

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      24.38 seconds
CheckAllWarning               PASS      26.83 seconds
CheckSparse                   PASS      30.63 seconds
BuildKernel32                 PASS      23.57 seconds
TestRunnerSetup               PASS      424.22 seconds
TestRunner_l2cap-tester       PASS      20.19 seconds
TestRunner_iso-tester         PASS      27.28 seconds
TestRunner_bnep-tester        PASS      8.33 seconds
TestRunner_mgmt-tester        FAIL      117.66 seconds
TestRunner_rfcomm-tester      PASS      7.61 seconds
TestRunner_sco-tester         PASS      9.66 seconds
TestRunner_ioctl-tester       PASS      8.16 seconds
TestRunner_mesh-tester        PASS      5.92 seconds
TestRunner_smp-tester         PASS      6.99 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.46 seconds

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
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.170 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.184 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8083789863464118169==--
