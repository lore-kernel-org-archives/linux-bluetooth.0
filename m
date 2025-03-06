Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFD25CC85
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287840; cv=none; b=iwyzDJBTYe0T7MNlD4Shx1kbK8rD6fjAHL7PwMhfE4Un6C79YvasgDAuP2Ziahhv56h2MF8j26YjmwJ3zPERdycuWRmPVL/8giOGc3K55QvrmbLK3Jn0N3zxVyuu2afHbW4wRKN+X+oUWJuwPQYgTXfGAcuhq/2O1fOwzbkUDOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287840; c=relaxed/simple;
	bh=0lnsIGqgepCFOroHheFuzi1Yp5ToLqIMuRjd9FWh5CI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TRtL6cOrnNs/7ULmjFkvVQgPlRTfo8Z+8Yiv9FEl2rODobjmpDWUVz/l+lCQgHUB5/U3stT2mwUFHpXJWu5WIndFARyBrUdqr/u0VyDVFTtgLKakWIwr+oaR0zUTgRGyWsUk6Pm8xqmljt43zoNpiERwPv/7gfkBDPgp5jvOFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aipBpfS6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aipBpfS6"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22355618fd9so19914865ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 11:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741287837; x=1741892637; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh8b9x7G4QcKaPjpJ6HswfdiFtlR5AA00kEf8yP1jQ8=;
        b=aipBpfS6O70pkwJQpu+vy0K6yNuFz+/OUZMhRlO2dnjkZR3qDugW8VYXGV2oI4WhKX
         0NYvE7+hq8cHMyka5rGyuNN/9qiW5carvDzXV2Cn4CCUmql7T+SlWSy/XpF4b7wFoV0o
         5+p++2b/QFlM0RYVUavoQwCt235jXbX3czxtkEjPbHfbxja5Jv5g6dHttgaBpjcSequJ
         83fCWhaeqeTV/rG3NRGQL2vxQjWdX0jNASjwFPeMikAidz8UKrKIuAl42zCKRujxVEgZ
         jeZGi3cuwDjNdIlRS1oqs485ndT1kXU3YheJDaerx9JuLW5CrXE2jI97TfQme32Rx4bE
         cIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741287837; x=1741892637;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yh8b9x7G4QcKaPjpJ6HswfdiFtlR5AA00kEf8yP1jQ8=;
        b=r8ku3KeY4SElp3eZhnBmJTo7+MvdEB2yuIYfCh5ZQqjL7xfyP8K4fr+qtPjQqJKY99
         44ijc5+YDZB7KGw04PHm5AN/hvZwaTLiVeoW9K7ZHNTCr6OnCWVQUQC0aiCTT7v3w3V7
         o3CuIpt7uxsYBD6Ckrx43FZW+B5zR/8/IOWY3/OnyRaN5ofHPXlN15vXBJqRsNQ3iF00
         3L6jVu94R74G5nNFrmZzR8rgntp1LWUBycqZXXLtklDM6AHTfyFX39eGrX9TCLaz494N
         VHn+lv3tT5zQ3KGWmeYrfzSZNn5WnmQnrV6nahdPTZj+jlsHB8C+VoKsBjgDT1/dx0Bb
         hAOw==
X-Gm-Message-State: AOJu0Yxrz+2GHrEyN4Q0y/+A1RNCKn5Jdp7x+5TfKzlFp1saiiivJu28
	afb8EUL/LdtytsoSemaCJ3A4ixW8FksldLblGUAIPEp3ItsGPzE90xxB/Q==
X-Gm-Gg: ASbGncueWdV8hheD9JpgY1B/pSy815wMPdeE+xGz7HIePJ2PUzR+Rec9GKegdnU9lT9
	tq+UfH2eyREJruErGs6iKTGUTCYyfgH74EpZtaB/W67wumfjK4oRv4gfDDJ5/atJXdrQofrekiS
	KuvKmoLXFlrFLEY3bgC0titrWN7IfVgojK0xfxbAXOqEHfCoNPH3rU/z0aac6xtDszkS0iFsqby
	L6Mr2KbQrtjzvSFA92+RHxfS462oy21xjhTG4mmnv14Ay0SCvYBchC7BCEun49G6XuPCxK1y5xo
	+mxGR5HD9EGU08tYcrULBYBmic/qPp4nxJMRDVQ0LWl75QxCVw==
X-Google-Smtp-Source: AGHT+IH67Jdf0wV6ZHppMuIrj9rwK5IlMQ9IE9AMefFcL3elVBIImscYa1KHRhSWb80aSmODPvCT3w==
X-Received: by 2002:a05:6a00:cc2:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-736aab160dcmr638896b3a.23.1741287837018;
        Thu, 06 Mar 2025 11:03:57 -0800 (PST)
Received: from [172.17.0.2] ([52.234.5.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369844ce06sm1714829b3a.73.2025.03.06.11.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:03:56 -0800 (PST)
Message-ID: <67c9f19c.050a0220.179374.3bb1@mx.google.com>
Date: Thu, 06 Mar 2025 11:03:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5968765547399130451=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2,1/3] Bluetooth: btnxpuart: Add correct bootloader error codes
In-Reply-To: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
References: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5968765547399130451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=941160

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.31 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      24.08 seconds
CheckAllWarning               PASS      26.34 seconds
CheckSparse                   PASS      30.76 seconds
BuildKernel32                 PASS      23.83 seconds
TestRunnerSetup               PASS      427.39 seconds
TestRunner_l2cap-tester       PASS      21.17 seconds
TestRunner_iso-tester         PASS      40.82 seconds
TestRunner_bnep-tester        PASS      4.74 seconds
TestRunner_mgmt-tester        FAIL      124.72 seconds
TestRunner_rfcomm-tester      PASS      7.86 seconds
TestRunner_sco-tester         PASS      11.67 seconds
TestRunner_ioctl-tester       PASS      8.31 seconds
TestRunner_mesh-tester        PASS      5.98 seconds
TestRunner_smp-tester         PASS      7.15 seconds
TestRunner_userchan-tester    PASS      4.92 seconds
IncrementalBuild              PENDING   0.55 seconds

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
LL Privacy - Start Discovery 1 (Disable RL)          Failed       0.178 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.197 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5968765547399130451==--
