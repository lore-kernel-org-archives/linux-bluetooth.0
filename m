Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31822DC341
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472123; cv=none; b=WS5uPFWYH1OYc60bqh7P10IbzTf5BxeorpynD0/Rdzw69D/xieXj/CdYnPco+trCl5zZL0Nmqdz7+TF2Vh/QfbA2W8wYgZ1ZFdCeFGiXaCDoneau72583flDdkXGp3aRWgeNwcGbPWmjo763NGGAvXRtxSQbcM8MF8kcjkzT2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472123; c=relaxed/simple;
	bh=bgA8ET24aKtCb4aGRRA5WnM6IGahNVLuF4agh4hpS/Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SGLZOyvuRpjetHyK4Rhz+yTleUcMnN8+aoJxSU0TPk/bALGsb5lj3Ctq9tF4/Ekwv3VfL6g3mhUZy2cPGX050tHAZWtbQgcaIpi+LtKjs+YkIlI28p5OQEQAQDs/QF9SRjYwK8bo0Rc5IbZ/eMeEWNv8bj7xHGhZ9ZnVx59BeMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz8h4ihm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz8h4ihm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso149990a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Nov 2025 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762472121; x=1763076921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM63VZaunP1E4pCucy+cPJf1N4Hl7hwAqZcFOF34U8E=;
        b=Mz8h4ihmvgLZj89hd2CcZkIaFD5g722kIPqkkACTpqDZGIxsg4OYC8IvL0JJ5Ju9Bh
         CSekexvpS/lpt2am6Rp2GE0DW4s/Ejs5gEBW5qFjVLVFqjzswnWehwTYs/gggNXy3jol
         viiPo7HNshVoIFMf+VKYOJZ9P2HaeWA8ejVeyCl/LKNNxaWeuTR6QbIOB8OAUIEJ2x9m
         vXytr9eL72hV/0jOwPpgCVXtcdQu3lKm6mPN91tSEuGdDTuViZp59S/7r/HVwTzQwuOs
         /fNy1LlGZOFw/BQToQMMnsv4ijTSuDMREfGQ8aWmngaLnxPzq5PydcUvqM8JTu0yX5Nw
         JKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472121; x=1763076921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM63VZaunP1E4pCucy+cPJf1N4Hl7hwAqZcFOF34U8E=;
        b=JFWQROCRYb5W1xQPpuH8EgXsRdorkmD33QggpsIvYFWnJINptDXUS3Ddd50S+8AZkf
         rZuJjm9S2xK4krfCYf2qrH//YQ0VTP4GYS+KTWxomocadmaeswN+cozsEx/J5R5TnHI9
         WfiNPOS5R1qi7j8EWwZq6ym5LfoyDgBYNeVPrqX1Fdn+3xSa9ccpebYctvwkvFWbas0x
         Np3DH5VwjKpJ5Nnr9GrEBM/rTUDyAQveY9YB97XbhCgtDbttkWzPrGzgyimVBTYil4Ic
         /iX2pkYKQXZpH98uV1HSpLGXA1unp2qG3BBymWlmUBDosHbjFY1fGXUvzOcu0OQc2xL0
         lFgg==
X-Gm-Message-State: AOJu0Yx2jefqOIfNOjyPvtR/RbQe1VR1mOg/qLegm/0U/Zydp069zBLi
	Kiq5CkKIoLUAWvF44sPxGgYGaoqJ8N3niL3CPJuf97yQwy8iADV1NAxOo7RkcQ==
X-Gm-Gg: ASbGnctlozylWhQF0QziMFUny/tsXJaQpxuoLXZyh8JTKaciAmPZ/vicSaUWKphjHG+
	lTszKR+INg8bMkuNPm/kYpbpU/Qesh6LkHWejn0ofL0x+9k6c/HSFKw14ya2bPpaerYtYKyzLEP
	riLBIdItzLkBLutgSqovFHQEbPXnn4Kk9hkua5Th1SgrAPBj0A5JmMd+IW6SVLXJyYPCIO7qWfc
	C8iDbSE++N4KNtx8b+OlF9hn0iTr9TekeY4UQmS5qVJ8iJUIGQftErKwt2A7al1y0PoKJLeZtmk
	czjtQW+q2n2W8loViXYp2v8hR4CmhWB7IeDC3mmJszs8ctgMop+ScfGtSruBgarFSKAoSiaLvGA
	3x0pMriE1cnkeWoTiZkPhKyHuy6SrZ0nXR3frN+9XrK4Qf36bCooQElGKOycd4Tkq0hiFcw8m6N
	kZipIYOA==
X-Google-Smtp-Source: AGHT+IFfMo7kQRT8H+StVOYDtshM/Ja245Y8D0LWctpFFBOv/WpL4VVVRzwCzG/9AufAC44oRnZZAg==
X-Received: by 2002:a17:90a:d44c:b0:339:d1f0:c735 with SMTP id 98e67ed59e1d1-3434c572e5amr1068043a91.28.1762472120688;
        Thu, 06 Nov 2025 15:35:20 -0800 (PST)
Received: from [172.17.0.2] ([68.220.58.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d121cc68sm1494437a91.9.2025.11.06.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:35:20 -0800 (PST)
Message-ID: <690d30b8.170a0220.360ec5.75a9@mx.google.com>
Date: Thu, 06 Nov 2025 15:35:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2331490632496573894=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: hci_conn: Fix not cleaning up PA_LINK connections
In-Reply-To: <20251106230943.877242-1-luiz.dentz@gmail.com>
References: <20251106230943.877242-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2331490632496573894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1020668

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.40 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.77 seconds
CheckAllWarning               PASS      27.21 seconds
CheckSparse                   WARNING   30.92 seconds
BuildKernel32                 PASS      25.23 seconds
TestRunnerSetup               PASS      495.55 seconds
TestRunner_l2cap-tester       PASS      23.73 seconds
TestRunner_iso-tester         PASS      88.23 seconds
TestRunner_bnep-tester        PASS      6.17 seconds
TestRunner_mgmt-tester        FAIL      113.75 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      14.25 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        FAIL      11.65 seconds
TestRunner_smp-tester         PASS      8.45 seconds
TestRunner_userchan-tester    PASS      6.48 seconds
IncrementalBuild              PENDING   1.01 seconds

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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c:5850:22: warning: cast to restricted __le16net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c:5850:22: warning: cast to restricted __le16net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.104 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.038 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2331490632496573894==--
