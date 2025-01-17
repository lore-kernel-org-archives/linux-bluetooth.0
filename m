Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043821A76BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142198; cv=none; b=lYT4VI+27GhNNYdAjMj4LZgm3+KXUsX/RSexcrovARqCrR4U2ZGDJmFuzvpjcuBqWNh9aDRm554tYO8hQ25gHiZ1dnX8sReY5xSPS9Eb7Gz+nDZza0WPWGi9snBqfSvmsSqxNw9pJabIibQ+L7UQ1Fu1eIMheboo8wjo4uyhYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142198; c=relaxed/simple;
	bh=W0rsocIQgPZ/PHxjTt4jGdmsmz3eL7+0SJlSjaMPtUg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B0znVxAWzLF/JB+ONskzSRz8fF7hpMcqlsVJCLJoZUd3HPaxw8xJYJge85Fl+Vc9ML+AoufXJjHZB3ThZtGBq4BU4h3E9GWfHsP4VOKLrREHGoStflQuNntHPj9JSeEH7V9pMKR5gTSwaJaVt/hJIS56zMhCxddyjfAOhwxMNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXMOfMXz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXMOfMXz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so45629765ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 11:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737142196; x=1737746996; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LU+/yFSMOoakSfm/b7NQcPzkuhZc3lg/L2nWCAiEMVk=;
        b=QXMOfMXzvQr7RDsYU1aBBT7KOfz+ai4T512HOxIQI5s20qqx9x+YM4b+gqIpu4pjtu
         EZOg+C4WkbZwkgZXBvM7amRFLaNvu3IEdTfeK15B2+26RWY4BVWtn834PZrU8IjjRdBW
         HjQlyoVeSq/g3Wk/jwpRntStEYEZ8w6qeKsFfZ91bsYLM4lZgfW6Z7+s5WiAuwYJh/6w
         25wy/okkq+kK+VNLPtVsGXUPjpfn+b61fNJyqeZhPQmhT6WKNilK3L81VIMynKEkUY1S
         AikUFGk0ogH2aNmi7mhksZA2NraNdb93hWfH70QN9/Jl0ykWMKIgtKS77UXLcfT4uj1Z
         R16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737142196; x=1737746996;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LU+/yFSMOoakSfm/b7NQcPzkuhZc3lg/L2nWCAiEMVk=;
        b=Pp4KJ9wBi0kZ9docgKsGoK++oQ9FzcVT+RIktM6RqUuueZqXQrQLUy6Oo+J9/ynlG+
         BvtzvGJKHtIBnvHI2ueMmftdozbhMIPJ+bzjd8E3Bur4wiP/q5s8tpkceT9iZ2IhOBYl
         zFP0o0QeN2F+i+1g5unq1jqF+p0ve03qy68bwTSBxZxy4+hpamKpcCw8MkA9ojVnd1V1
         BJUolwV+IhCOXOtV1CnVNx5o78Phym3S89t4sEdGl8H79sWkeAX2wOUkbK3MMISztDVj
         MkO45L0EeBpYeIsHmPZ+76yjf/qTieEDyw2VNx7KskZrZOPiGMGseU5bWC/OIH6CwS56
         wPzw==
X-Gm-Message-State: AOJu0YwKQeavr5pXmCfynHbPF3YE18BaQhTIU07TdCR0R59KQ0kuvtGt
	h8YZOkloNE+S2jBBwLtlw7fsTuFxrLZZxTTG6uVSSML1JIQEi5xe+fDB9g==
X-Gm-Gg: ASbGncst3q8pZX1DtB+Pr5RNrSfx0Zhficll5v+S9W6mthsd0kuT3gwYe0xgDA/3WQO
	Z8Wt6c3wWrPyLV43ITpF3R9bFw0NDIiwpaic+hHDg0NVvgj4zwsKMRjDyAGxmokWGZNowF1U6nA
	eXk5Bz08wfZA4IDcjCJEzR2cN97WjvcQl6OdTy3YeQkHsRkA/3cwseRCGw4PR72M4AlKhJD2BGi
	vcdt6Bct7woUhFx25SQrjOrXq6/zmDPHwbjxFr4LoRi3x/lgpk7/gisPDFHeCwW
X-Google-Smtp-Source: AGHT+IEkFB5HafHzRzay5Eyc8XHstF7NdgO/j8huMyKMGeQoLLy1u8uuuJXMkagPHAFAO1iV9Zd25w==
X-Received: by 2002:a17:90b:2c85:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2f782d30ecamr5956601a91.24.1737142194470;
        Fri, 17 Jan 2025 11:29:54 -0800 (PST)
Received: from [172.17.0.2] ([52.160.165.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77629ac0dsm2686601a91.34.2025.01.17.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 11:29:53 -0800 (PST)
Message-ID: <678aafb1.170a0220.38fb32.c123@mx.google.com>
Date: Fri, 17 Jan 2025 11:29:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4434078456579711513=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v4] Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
In-Reply-To: <20250117184202.3895460-1-luiz.dentz@gmail.com>
References: <20250117184202.3895460-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4434078456579711513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=926566

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      24.99 seconds
CheckAllWarning               PASS      27.40 seconds
CheckSparse                   PASS      30.47 seconds
BuildKernel32                 PASS      24.53 seconds
TestRunnerSetup               PASS      435.76 seconds
TestRunner_l2cap-tester       PASS      21.04 seconds
TestRunner_iso-tester         PASS      30.19 seconds
TestRunner_bnep-tester        PASS      4.86 seconds
TestRunner_mgmt-tester        FAIL      118.99 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      9.44 seconds
TestRunner_ioctl-tester       PASS      8.04 seconds
TestRunner_mesh-tester        PASS      6.00 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.01 seconds
IncrementalBuild              PENDING   0.65 seconds

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
LL Privacy - Add Device 3 (AL is full)               Failed       0.210 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.179 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4434078456579711513==--
