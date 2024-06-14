Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710D186282
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357728; cv=none; b=XoK9ZmziJsxLck1eynNc/3x1ltRnBfWd4jMBUWx/WHnj4RjTrwwVXZCGi77lrZ+Yy8msplg3pwC3UI4OKnBCEkHhnlpwK6t2oeBQb2L9SO5SwpnTaDRRWEqNBxRoO86v39nTqUUWlSl060RsIyD8fV3RUdV43eWrURxuxlK3BJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357728; c=relaxed/simple;
	bh=Ax6xZpLg68NeYGkt1bQOi8F3upS0zxv9ZzsIxdSxT8k=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tXSO/rd2FQDfHYNVW+o70nY9e99zzNHc9w3VCDWzyZO3azP0o6y1A+vba98LApq7qA97NBo3D938UrSvXEk52elXa3j/EvGbOLqvBRdzvrtOEF6lNazJuecRO7HDbux+kgX3nTYThJCJAJHRqFIKN9EdtejF8t9gi+hnhmIrAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCzNyDap; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCzNyDap"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-440530cadc7so12164111cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jun 2024 02:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357726; x=1718962526; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etzTSCU1uisr3/ajGaZb/9WUYgpinUNo3lBLbcHVCNA=;
        b=TCzNyDappgBFrycjnE+oebCLF8HsiDs9jlaViKgGkuo36r6PPB5VPubRKeYp9WyI8k
         gRSNzmJb1Remh0ARHr1UFQh/o9SdNsWu/Yq8HtcK0P0mpSxKBN/4lwidcZmFeZJcmt0Q
         sgq+xC3Ku/1FVNYIcuhr1P5k2qwGk+epd0cztDkCgpJppLgb8uqbbxGVDwf62+stkrSg
         uING0LppWrLy4RjW+Gmh8MBIvFpSQz/n9kulaK3CtewDl6lGTTM6z5i+kFGlVYE+vTRE
         0cu8Utc81QBf1DaYam8czHn5DOObvHzcz5F7Y+N7uOoJztMRJnceVOLLs0KqKpb6nae5
         kdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357726; x=1718962526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etzTSCU1uisr3/ajGaZb/9WUYgpinUNo3lBLbcHVCNA=;
        b=IRyAcoSClgVuZqpkKWWnm5rHkPANHDUpate4w2nFKP70Eqt17sJC8Fd/kkLYKKMx8L
         2rAL2vwBiaCnABcTZu54uYbM79xmUFebiRXmXHHtqmYbB72tM9tLdVF4T456Z6aO86Np
         CNwUUco9GZL0qWfccgVJSbgM3dnUq+LN46ZtzOsuWG1eihFj4ZE25C7PfU9D4i1Zep9t
         h0rO22JCJGxXXbdS/Y4qjQjGBTvJnKMxv4NN2c9GJGHFDDj4vykM0k0Owz1j5291LhvR
         ybc/do9r9nSF5IjofAipLI0Me3LPAGEiSTQjebd1M+3Zj3j4u35wBL+eVBIn1mCDklB7
         Xsdg==
X-Gm-Message-State: AOJu0YyZjt1favxv3YYSvRXrd06ATet1NGqAjxMLMCLSEUG9kNZixhv1
	mtopmOhnnPCWBo8nR+SaN+IbcGjgdD+HbvuDwNhlzncq8pyQVC1u/WPnJg==
X-Google-Smtp-Source: AGHT+IE2I0n0aV8sG52Zd3QoWzxWgJ+vb/tRLAlBkZnnGXCNR7akOFgKobTkSPru4YWbv7O3dPdEcQ==
X-Received: by 2002:ac8:5acc:0:b0:43b:7ac:ac79 with SMTP id d75a77b69052e-44216b03086mr16672981cf.21.1718357725872;
        Fri, 14 Jun 2024 02:35:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.117.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44212edd20bsm10637821cf.57.2024.06.14.02.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 02:35:25 -0700 (PDT)
Message-ID: <666c0edd.050a0220.4a944.464e@mx.google.com>
Date: Fri, 14 Jun 2024 02:35:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5703273134962742065=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Bluetooth: btnxpuart: Update firmware names
In-Reply-To: <20240614084941.6832-2-neeraj.sanjaykale@nxp.com>
References: <20240614084941.6832-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5703273134962742065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861981

---Test result---

Test Summary:
CheckPatch                    PASS      1.81 seconds
GitLint                       PASS      0.65 seconds
SubjectPrefix                 FAIL      0.50 seconds
BuildKernel                   PASS      29.42 seconds
CheckAllWarning               PASS      32.42 seconds
CheckSparse                   PASS      37.90 seconds
CheckSmatch                   PASS      109.66 seconds
BuildKernel32                 PASS      28.65 seconds
TestRunnerSetup               PASS      529.34 seconds
TestRunner_l2cap-tester       PASS      18.91 seconds
TestRunner_iso-tester         PASS      33.54 seconds
TestRunner_bnep-tester        PASS      4.97 seconds
TestRunner_mgmt-tester        FAIL      115.22 seconds
TestRunner_rfcomm-tester      PASS      7.70 seconds
TestRunner_sco-tester         PASS      15.43 seconds
TestRunner_ioctl-tester       PASS      8.29 seconds
TestRunner_mesh-tester        PASS      6.08 seconds
TestRunner_smp-tester         PASS      7.03 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      34.24 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.162 seconds
LL Privacy - Add Device 6 (RL is full)               Failed       0.198 seconds


---
Regards,
Linux Bluetooth


--===============5703273134962742065==--
