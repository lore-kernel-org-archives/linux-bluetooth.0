Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217F18FC80
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505165; cv=none; b=k9MPpnpb7Fj3lCOBnN8soi5DXT/KOjWIP0ybFmOPfTJHBSj9dxTKrjmOHFFQJmn16IOW7B+Rm6hMRSWjaG7m4YFP3X8+PUnZuYNF8Bmbj/ycmmTVtpFHRq5AWmDZnUNmgPnkROfyvg5CTCwx1gjQ9JPzKadK9XnJWcTOPyxjyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505165; c=relaxed/simple;
	bh=flGtGDQ5AIt4lor2KMlMJbA90kjde4fcnguUMs/qIiY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JF/i1Tiv0OCQxmFAmGcGjQEGI5/kIanI9ByiiXfFUH6fs2T+NrObjbK6tkpjtRTAP8uZP+dS7wKldJXBsBDy9vE6XInEbgVjhxJvQ52n9b9J1JTjDGdHcKYc7m7Wg+1dkuZYSIjVk+Hf8CgnGqaAUy6Ct+KigOtK/t307cB7nGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJX8j32E; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJX8j32E"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6df83fd01cbso7938966d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2025 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736505163; x=1737109963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cQ2NwmU7+IV2GeDs79LzuloXVNz6snGmCBRQIzB45Ic=;
        b=YJX8j32EvhVJnKNMwlkhctnrVTR+J/s0Yy0hajIhSub4ixTBNC8ep1eTFSlPQJTOry
         avHcg2CRWRLFpEP7rS8R53hR0OxCW5Bd87zNCEQvJ5KNVpxE11QSbuTC17sLO0oMEA+9
         1l468oPpu/y4q6o9VgvYSEnAHVdCvYNzNK8Qgb8h4ZuUW8XYAnyr0EPEEnT7Hpx4ioKD
         6CXkzDTJuOWfnbscul8neRM9XGN+MNqBjnq+VAtPctDz1EKv2vgV2eLAcp5HTFq4RyjG
         4PInY0DuiOn+BUGNmPMRB48MDC8OWpl9w0V9U+L/c3eZ4v+dAKfpB6wBoC7t8IcD8HF0
         5pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736505163; x=1737109963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQ2NwmU7+IV2GeDs79LzuloXVNz6snGmCBRQIzB45Ic=;
        b=YrocawXCFoGA3bJkp2EIjEKsPHvdVoRCCt5n5MLfTr87E089KwSxVNCs2mVs3O9tUS
         n2teisS6zZdTRcJJwxS1eRbzuo9MvbJdoHVEKOf8tiRFkCwDcfLj0NmRh55jEhqlV0Pc
         q31GNZ3ITegbo+6JWtKtIkFWW8RhOsoShGhqMpNBuZDBbJAFapClob07WB75RQ+SWBh3
         PWN1TZabMVGyVHu/OHdeNcKwREfLaH7vNw+344LYIOZMzdpGd5sTQv/ZID3Wl52Xbb+v
         Ps5Zr4qhzQUTblJFo042oTweQkjT7l1HPBrSmeg+vi9GYq62CwRZUx616m0HALZXSUiS
         44tw==
X-Gm-Message-State: AOJu0Ywc5duzLzrc6nQ/zHcAn31WPy+04gRzXE9HT3pEIF+Z6CNF7fSN
	Rx7DFmexmdHecItEfSVY2p9JmazoGI/0GEurqm4O4jKlgpRmHseyyQaK/w==
X-Gm-Gg: ASbGncvlZkgNX1AV18q+dwnjgJb0CPbKvNugZC0wwFqhn7Z6Vp/4fAOPPRL+lTf+4yz
	sHm4dnlc3CIOUoLWCbrszg0/+cmefFfXTtHOgfnBanR9vjCMGCulxuAAKtik152Yr9K0dFT034k
	+jpA/+tXGZ/NEbQiJKAHTg3cqKlZ7SkzoNtsGgUgC5jp7DSy8yZbT1emyb7Q8NgsmR9gehWuw26
	H5u4azcDXfTm7maFpXIFyuWL01NtTxHb+EIrp4XD/NznSEUO//ktwJ6ngC4o2c=
X-Google-Smtp-Source: AGHT+IHgjb2ROEpYATC4aMAlIAMI3ZUYHVJvX9G4C8n+txCYqameFGC8R/RYR/W4wOnppGOgV+KbKA==
X-Received: by 2002:a05:6214:48b:b0:6d8:aba8:8380 with SMTP id 6a1803df08f44-6df9b2e56cfmr180552276d6.42.1736505162829;
        Fri, 10 Jan 2025 02:32:42 -0800 (PST)
Received: from [172.17.0.2] ([68.154.31.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad880c97sm7874126d6.36.2025.01.10.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:32:42 -0800 (PST)
Message-ID: <6780f74a.050a0220.24a354.288d@mx.google.com>
Date: Fri, 10 Jan 2025 02:32:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5810802490136465998=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hao.qin@mediatek.com
Subject: RE: Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
In-Reply-To: <20250110095548.12761-1-hao.qin@mediatek.com>
References: <20250110095548.12761-1-hao.qin@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5810802490136465998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=924104

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.20 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      23.90 seconds
CheckAllWarning               PASS      26.62 seconds
CheckSparse                   PASS      29.88 seconds
BuildKernel32                 PASS      23.82 seconds
TestRunnerSetup               PASS      423.49 seconds
TestRunner_l2cap-tester       PASS      20.77 seconds
TestRunner_iso-tester         PASS      34.21 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      119.53 seconds
TestRunner_rfcomm-tester      PASS      47.98 seconds
TestRunner_sco-tester         PASS      9.47 seconds
TestRunner_ioctl-tester       PASS      8.18 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      7.10 seconds
TestRunner_userchan-tester    PASS      5.08 seconds
IncrementalBuild              PENDING   0.58 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5810802490136465998==--
