Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767F1E8326
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694035; cv=none; b=BBaVER67DXk87d4QdAQal6OzbJMuNpQJ/0LLmzqdBdFbL7NHDeSiLzfwvje70D6uptGi4bhqaiY2u+vXInNdpQ67K131CD23gFvrY15fv9ElsoKiCj9Z15618vzHdNS3LxH0lVDvuAlkITzj0TxOMyCaQWTX1RKM+P01ypo+nXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694035; c=relaxed/simple;
	bh=/SMX0UaNPGwYIte7QyxSwttoNLE9bYuXxbSncHXC7IY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hGVgBkUlnceX+OGAdUJwJGmSkm844m9kwmRSLymYmmwtuXZv9NyxvcN+Jw83HvSbPowc4mrOls1rKpyGHo9eAY//5B33kcy/CzGYpmmKJJi34KEd5DrkJ7bFSB4mAIeSD3KWyBwlOQzBRcTSRnH111fEHPofyvKervPE311u1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du9zWWdN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du9zWWdN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-75ce8f8a3a1so2376475b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753694033; x=1754298833; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=59REW5CEcrE1TMELnb9oa2Q2HRFigvc0Q68nLscxzWE=;
        b=Du9zWWdNmgeOPsfQqVWzRswZDplW4bAiWLr8h8ADRPvTwc6aBo14GsT0iVa9P/Ea8Y
         JO5QILvxDTpIgCVyfMFvl7nVb0BjQPeBc/8SWUiiU+zmvQJG/oBUL2Q8UoO3fc6Eu4WD
         ykHKR5hnjEMoGzMrPoJ5rOOMpfSAJ/YyMpDXMEgQfcPQZADfOQpR3T03NgyAImerhRF9
         dSOZuH9ecNuZolvaAtVQuBca4Wk7HmBzyV80o6jzcc7BDNDaIUCmlTE9K7CwtTmh8Ar8
         spZeLk/xX66itePaz99nzVOiy1T3FoktqHw4p0Da0+mOvry/vi1J8sKbHgmX8r8W6lOp
         kCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753694033; x=1754298833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59REW5CEcrE1TMELnb9oa2Q2HRFigvc0Q68nLscxzWE=;
        b=UOQnpSnroDp3dRPsgy+vd9YCrW0KjYUAY6atV841uOpdT0SRH0W3DYeiP4UFbx2Ie/
         pfekHoOUClxM8IU90eFbC3l8+lbDkfN1lZqpsRE91Ri9KR0fmRxfIZYiTbN9U3rBkH9j
         im6yIa9d6mlqpQ7kNwoMyqBw8f6LgMe6qo6OXH3nRUXHIROyU+JGQpBOcFQ0t3EM14GL
         SKs4KR07XdqCONjAhcpo+5hW6gUCwEsvUl/GIxpcfeOjweNvIQfOKX2Nu9cq56SOZu4l
         iNSXovir+eGSFRVpsDx4dWF1AczBxD0W4Eo511THTGzOX6Zgtx5zW9GMCQ238voJofNA
         hlhQ==
X-Gm-Message-State: AOJu0YzdqEe3FiUwYB/gg9YWaAcxkrwx4Cq/C2ZTN2yeqQogFyi62EVI
	/Q03H6/B04Jf+DLTmhSuSE6onlBlmHNiLyZgiWhrn4Ug4fUB8k08rGAoOmyAuQ==
X-Gm-Gg: ASbGncv/q8bwBI8Gv7Rd02je3i/IT08B3ZYINJnMVOO9P4UbfvA2nd6hgCNx+UgpqpT
	vkjVsv3OkzsMucwYgfZfmWDJCnjYsADkCvToNdAXmAIskJzeiTNxTp860DG0Xeo0GqbevB8Tos0
	4hEDJJQSNykujm9WXgsVhoe3TiFCszmSA3JWw5THVzJQqNV3Yahj8tPglEJozx4Gm6bhNw7z6Jz
	UOUjZcEYVBAQlkr+a7tRITNMWuGecYDIlhe04qHS6waphQfCVyBQAJMtO9azZHU9t9X8l7hgP+V
	S2h6Hsp/dYFL5JrZ1j6kd7L4UCqB+pQmjx4cKdlSxjv1kjAeMH0KphQcNHaIR8285oZdnFaT9WG
	x8Q9c3KMuZ3ZtPh1hwEXFjTvj7TatwA==
X-Google-Smtp-Source: AGHT+IGrTJ/mrCRpNw0BPVtf81p/yKWdiuroLOVCFZcJcTjs/QVjnrWcBeBkHmk6FpVwhSxesybDnA==
X-Received: by 2002:a05:6a00:4b0d:b0:748:fb2c:6b95 with SMTP id d2e1a72fcca58-763389acaa7mr16858945b3a.18.1753694032716;
        Mon, 28 Jul 2025 02:13:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa7f74sm4678398b3a.133.2025.07.28.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:13:52 -0700 (PDT)
Message-ID: <68873f50.050a0220.2170e7.dcc2@mx.google.com>
Date: Mon, 28 Jul 2025 02:13:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0194081472581278595=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v2,1/2] Bluetooth: btintel_pcie: Add Bluetooth core/platform as commnents
In-Reply-To: <20250728090554.1425120-1-kiran.k@intel.com>
References: <20250728090554.1425120-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0194081472581278595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986350

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.37 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      24.12 seconds
CheckAllWarning               PASS      26.66 seconds
CheckSparse                   PASS      30.42 seconds
BuildKernel32                 PASS      24.81 seconds
TestRunnerSetup               PASS      477.17 seconds
TestRunner_l2cap-tester       PASS      24.94 seconds
TestRunner_iso-tester         PASS      35.59 seconds
TestRunner_bnep-tester        PASS      5.99 seconds
TestRunner_mgmt-tester        FAIL      128.24 seconds
TestRunner_rfcomm-tester      PASS      11.75 seconds
TestRunner_sco-tester         PASS      15.09 seconds
TestRunner_ioctl-tester       PASS      10.21 seconds
TestRunner_mesh-tester        FAIL      11.49 seconds
TestRunner_smp-tester         PASS      8.69 seconds
TestRunner_userchan-tester    PASS      6.44 seconds
IncrementalBuild              PENDING   1.02 seconds

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
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 1 (Add to RL)                 Failed       0.161 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.900 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0194081472581278595==--
